Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3FEC4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0A760F5B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbhH3UYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhH3UYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:24:09 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABBDC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:23:13 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b4so17513459ilr.11
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L1qkgsrdSPYRB33uOdtqM8UAknqwZLw2Ztpn0ekHy58=;
        b=TOlA2jZyTzZ2Q4r80NGFPiBJ4oTfbX45hPV27oJ1d3R79hTLXYtGmpW6pXsAkK+pJg
         bYBkkNUbYAp2g+nwRbsGjOTZnG25iF/Jz407yiOsIPn7xi0Ut1z4HInO7/EK0oXni+DD
         1852EmDe3q11u/jOekKraeo6S6Wt21Goeywj1LNmlhERFYSFh22u/qnRXqwIZli2qEhm
         QltvLnDyQw5TiosbOBLvZkGOuLEKh+BWDiCeZw8bnAEh/DNQ03NovEhJ4bX6bunOxez7
         5pvnEsBeSsrjTYImUaeIZbrEwtabb3zUA6tRUtoTKq4okGpWAzbGDYdPIYdYpLeaBksW
         GO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L1qkgsrdSPYRB33uOdtqM8UAknqwZLw2Ztpn0ekHy58=;
        b=aD61rIQxA4ZEIMz0eWyOOokO5G383GyGTH4JktOsnhONWkuEJFGwPkgtxUsKeH+Zin
         z4xWp7stZIo+apYaax/aGaY81ffX5x0x0IPBsBqM2hxfOmiFeY1OAh/7NThwpVU3X9JO
         44ChRkFZpGrFGzwT7ZUyPVJBK2/Iz4qq6z3KZBb7BLuDHs4Fw1imESYXeyiYTb58AbqS
         Ui+CbsPXdoZvEHb2IsANUVpIvLL3aHSoUZVBX66kALL5BollJANmhuznOhGd9X0rHg4R
         XrjsRArB+0sgee6HFC1TtmFRrXgIKEAlTpp2hFRFdyuavXgidF/OoFgbe7bUp811tbJ9
         Q9sg==
X-Gm-Message-State: AOAM5308x0M3G9CFfJ/8ZOD6a47zM8TcfG5AhrT9f9OJdO+J8OmZpHV8
        v+rCdjWU4eWKaQHC/oKOggy/mD7UztLbrcV/
X-Google-Smtp-Source: ABdhPJzeccTv5vuEGn2h8xXX370c83z12cly6qx+1LRfq7fFvqQ5doLh6qfH6N0ZqwqXIJIiercMwQ==
X-Received: by 2002:a92:a04c:: with SMTP id b12mr17655829ilm.80.1630354993288;
        Mon, 30 Aug 2021 13:23:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x15sm8986559ilp.23.2021.08.30.13.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:23:12 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:23:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/4] test-ref-store: tweaks to for-each-reflog-ent format
Message-ID: <YS0+MHk3svGr7d4n@nand.local>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <d48207d6858502f04fd501a24ff7c2a80062dfbe.1630334929.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d48207d6858502f04fd501a24ff7c2a80062dfbe.1630334929.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 02:48:45PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Follow the reflog format more closely, so it can be used for comparing
> reflogs in tests without using inspecting files under .git/logs/
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/helper/test-ref-store.c      | 6 +++---
>  t/t1405-main-ref-store.sh      | 5 +++--
>  t/t1406-submodule-ref-store.sh | 4 ++--
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index b314b81a45b..d7bbb20e614 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -151,9 +151,9 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
>  		       const char *committer, timestamp_t timestamp,
>  		       int tz, const char *msg, void *cb_data)
>  {
> -	printf("%s %s %s %"PRItime" %d %s\n",
> -	       oid_to_hex(old_oid), oid_to_hex(new_oid),
> -	       committer, timestamp, tz, msg);
> +	const char *newline = strchr(msg, '\n') ? "" : "\n";
> +	printf("%s %s %s %" PRItime " %+05d\t%s%s", oid_to_hex(old_oid),
> +	       oid_to_hex(new_oid), committer, timestamp, tz, msg, newline);

Having read the rest of the series, I did scratch my head quite a bit
here, but I think the change is actually quite simple. In the files
backend, show_one_reflog_ent is parsing line-wise, and each line ends
with the LF.

Of course, we don't expect the reflog to have messages that actually
contain a newline because we cleanse them with copy_reflog_message()
before writing.

So really it seems like the files-backend should be calling rstrip on
the message before handing it to the callback. Either that, or we could
call rstrip ourselves (since the generic strchr() makes me think that
the LF could appear anywhere in the string, at least on first read).

Thanks,
Taylor
