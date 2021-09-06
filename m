Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470B8C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163DC60187
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 22:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhIFWhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 18:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIFWhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 18:37:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76379C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 15:35:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id x11so15989298ejv.0
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Xjb6OfRFZ/HkFQ5HsfTf9OkW+zxZlTw+ikfAic7phIk=;
        b=egqGOHVGcjc//RglgWjJ/DQ6s7M1we3lS8SGFNAeaEaSF4sJa1QFjKzwqX9K7iTxR7
         Oxg8zeuPIjuQgxwS6UvF+t1WVD0OenGQaSVG4OiqzpImd5ghWNKUgrf3XjFcbLMpX463
         A+DCAsW4JCe6ncpCAXytQPeVJ7t7m6igy2o/xikqrhQ9wkFHE/vpjhn59LKK3O4UOAqD
         mWHgqh1Ai9BoPXFUtE65Neypv1fgKTBxNsKPuqYYjO+OEmR5uJHx41UN6aBLIRiEpTff
         y2KhdvOJ8yV062tQqFmKsrhv3jFNGZn/PAiYUJIdAy4ZDCiFZV98/67vYY9IxchG9ZsZ
         MfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Xjb6OfRFZ/HkFQ5HsfTf9OkW+zxZlTw+ikfAic7phIk=;
        b=XiwhO3RlyzTT7qkRLyc+2MxfQ3AySipFn9Q27wf9RcsAByNA5+tL/71Qe6vV7L/AmA
         t5mKrYJuNrJBwYgHa2Pp4GnCLX2PlsF8NJEqueOdIoLg2jq67VKKONAcYG6CM9BU1XCj
         Xyq7xi5Xv+lcUvIV4TODaAsH2J2Ku1+GW7Bb0OxhfTwwwwVdFxCQdj2f9eYDfArXe2AL
         3edr2h0+nTOuj5I0IHHSQexAWx6/xV2t+vMdz1HZcRRY475fufYgNla7bs4mvX+Lts+U
         VMF52nhi3JdPulZRNuvjQS2A9K255BTwEzP/FS+I4Cz2TLEv/kBabXCpDz4O2tvxhdlv
         gU1w==
X-Gm-Message-State: AOAM532MEdxVCBoNniQ/Vcl1H38p0MlIADqivTXnFzBT0+mQzYqdcfCP
        UKV6uGIJlb9XV7+D3utLmAnQxou4typZbw==
X-Google-Smtp-Source: ABdhPJz/z8GvAXs6PtPmCYpNY9NNl6GJv2dUNfaxTfYLnPx+DWVcm58Cnw/LQ/tLTyl/FSTxIeT8pw==
X-Received: by 2002:a17:906:3486:: with SMTP id g6mr16074085ejb.71.1630967755764;
        Mon, 06 Sep 2021 15:35:55 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n15sm5330748edw.70.2021.09.06.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 15:35:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 2/5] test-ref-store: tweaks to for-each-reflog-ent
 format
Date:   Tue, 07 Sep 2021 00:34:43 +0200
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
 <11b296a55e9e450575c64ade1a2cb93a1886b9da.1630947142.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <11b296a55e9e450575c64ade1a2cb93a1886b9da.1630947142.git.gitgitgadget@gmail.com>
Message-ID: <878s09nxh1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 06 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Follow the reflog format more closely, so it can be used for comparing
> reflogs in tests without using inspecting files under .git/logs/
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/helper/test-ref-store.c | 5 ++---
>  t/t1405-main-ref-store.sh | 1 +
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index b314b81a45b..0fcad9b3812 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -151,9 +151,8 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
>  		       const char *committer, timestamp_t timestamp,
>  		       int tz, const char *msg, void *cb_data)
>  {
> -	printf("%s %s %s %"PRItime" %d %s\n",
> -	       oid_to_hex(old_oid), oid_to_hex(new_oid),
> -	       committer, timestamp, tz, msg);
> +	printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid),
> +	       oid_to_hex(new_oid), committer, timestamp, tz, msg);

Nit: Would be a more readable diff if this wasn't a
line-wrap-while-at-it change in addition to changing the format string.

I.e. the last 4x parameters aren't changed, so leaving them on their own
line & just changing the string & the two oid_to_hex()...
