Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82293C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 00:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335C623A9D
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 00:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbhAOATq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 19:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbhAOATq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 19:19:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A48C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 16:19:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jx16so10840231ejb.10
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 16:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Je4wrGdELpjmb8vMO3JI1ORa8ewuo+2WHV+/OmnVbf4=;
        b=AfrtOCH06sTEngn0wBc5dTv/iPa66o/i72MlfIJKRwQ99JUqk0cEFE7kZDydCd1tMU
         pU7S//CzmiQa8iPRNIMDSvKrxBcU4N9ToUj0LT5Qn7jLRLNYvFwV+7G3/aOiJddAcClz
         a/lLN86odfBbcTbP5ayjdVRv3ADm6V1FDiO29btUivsYNpAeCTAIngfNqv7ERTFxeNF2
         Kiw0d5OGk9x5OOrLmc6hd+DYkDJ0HM0kyHrAk2Qriaup6I2oPypM1yGQcgwFRbl3xzCG
         WhajcElh3faDqgZE7dWtHaushs43GU9JLpC7XFiA2aDenTZ5JuHFqgGj8yvUC6pw85Rr
         BpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Je4wrGdELpjmb8vMO3JI1ORa8ewuo+2WHV+/OmnVbf4=;
        b=t4g8j/462/F4W11f3oO7jbGseoLyCIua8/lOKmQazVUAyfwEepuG42rx1Ki/MBFXPP
         urRPlw6Tr9vjEs5eRZELnNs2XER9k9Lf9mKQz++fxtOq9bLdL/9eq3iVxBHvUz6xtX2/
         3rB3SdBXZkmPEJevx7C1QWi2VT25RnCOp/QWQqH7cLidVpidygmXBA8E05vzTC/7zuee
         5mkgxfT2A0fW/YEn6+lcfv5+zi25ahg0NJrgwMwTRvV1ikgYScW+2vmebsAjt+todPBm
         eqj5bkZpbmT+67ONv+BGCntaSJGtfXmMlv8IyV/MeByabaeVIzL4cXB7atBrJPrVD5id
         1cPA==
X-Gm-Message-State: AOAM5317EZO+Gj0nrsEo2z4l+uSeOwLTVJEhRaBqQYpwj4tWM4gphTF5
        Nb9xIbmCjlxm99SZFqYBx2c=
X-Google-Smtp-Source: ABdhPJypILOtuYwObm7PZ3kv8zhhFNfkxB85tq+OIsg15y8EY/E90FrCfEJZ0bQXtT64oh3OUp1tmg==
X-Received: by 2002:a17:906:705:: with SMTP id y5mr2923816ejb.83.1610669944386;
        Thu, 14 Jan 2021 16:19:04 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id q22sm1068246ejx.3.2021.01.14.16.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 16:19:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] test-lib-functions.sh: fix usage for test_commit()
References: <20210112201806.13284-1-avarab@gmail.com>
 <cover.1610665323.git.liu.denton@gmail.com>
 <e9add5f066cb0209ff9f6a0ef71584b54afd04d7.1610665323.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <e9add5f066cb0209ff9f6a0ef71584b54afd04d7.1610665323.git.liu.denton@gmail.com>
Date:   Fri, 15 Jan 2021 01:19:02 +0100
Message-ID: <87wnwf3vd5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 15 2021, Denton Liu wrote:

> The usage comment for test_commit() shows that the --author option
> should be given as `--author=<author>`. However, this is incorrect as it
> only works when given as `--author <author>`. Correct this erroneous
> text.
>
> Also, for the sake of correctness, fix the description as well since we
> invoke `git commit` with `--author <author>`, not `--author=<author>`.

LGTM. Thanks for fixing this.

FWIW I was planning to make it just support --author=*, the
test_commit_bulk() function just below that does that, I think I copied
its doc template, but then used test_commit's existing pattern for
options parsing.

But this works just as well, and is easier :)

>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/test-lib-functions.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b0a5d74dc7..cea73cb8f0 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -188,8 +188,8 @@ debug () {
>  #	"<file>"
>  #   --signoff
>  #	Invoke "git commit" with --signoff
> -#   --author=<author>
> -#	Invoke "git commit" with --author=<author>
> +#   --author <author>
> +#	Invoke "git commit" with --author <author>
>  #
>  # This will commit a file with the given contents and the given commit
>  # message, and tag the resulting commit with the given tag name.

