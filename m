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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD90C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69076128B
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFOThQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFOThN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 15:37:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECEAC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:35:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k25so24406088eja.9
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CQQqEaDOFF8jxvqqoBeeGaZ/iUJ8w3SXmcG2/VM5Rxs=;
        b=fbJJOTjLfj62OcFGxzJiG+1tk2PeC79jDhVcXJQp5d3JHELkmfUR9wVihrHQbi/uly
         3hcEF6LCij311yHOhdupQIIFnon2xLbI9NiNHHEBQ1CUjX68iQ7Pz2v+Fj5sU5bW554o
         TMNGUA8SS6OuveIoZeqqucvAnC4BrkST5PNlQG/1wrVeSgIFpme/s5C0ME0i/+9xWrkm
         9ASdtTAvqZ0+ocwTRejgEQhc9WxYKPqJMkcXCaSZat7JsQdQeMLioJkgZsOioxWY9Veo
         vJTKSFlg1UkHsaWYy4dXrvEuxI6+jazUtBgbT4fxNKjBFW2wzaf6W/pCN2HpfVOEmkti
         De7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CQQqEaDOFF8jxvqqoBeeGaZ/iUJ8w3SXmcG2/VM5Rxs=;
        b=Rm98g3oWKWRIeVcaBq+4oRZtAGRXTgZy6ZYeo1PrH5/Sjz5uUr8cpBQM/kqRFpYVLz
         5O66I/x+djF4h6Cpq0PFJWA9mczGJ4CqvUNtDG2KlY5N9PPCghecJiv2NOsKBiNCjXTc
         ZHVciNkT2Ddz1A8Hqe37izt1x8owfWsuIo4tOf5ho9HYGjJcErdLv9LXCsXNwZ79OrVn
         0GntqdU057h2Mc5u5z97KBjKu/iDbOBrtZ+r8dnBFV6m9eoCuTahIDOwNuw/HAJ+NCTI
         elwbD0BUHcqHNNw4Vjoi/dwhYqJnbtTBWAf2/VLytvvNgoz9oU6O7TOdZIYVUDd1P8BC
         YQTQ==
X-Gm-Message-State: AOAM532lxxVyMO61gJX0inKGGVmikACIsQQYQDpZrN/btybnkAQ1JnJb
        Js6OR93cXA0iuCknPZFD7O8=
X-Google-Smtp-Source: ABdhPJxPt3i2XAliIfG0eIMv9KdoGe6rquYBh5fVvsfifaUx5XQeLefuhp9NHEk1mCIXaaFnwMcXgA==
X-Received: by 2002:a17:907:3da4:: with SMTP id he36mr1300180ejc.108.1623785706515;
        Tue, 15 Jun 2021 12:35:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y10sm10694512ejm.76.2021.06.15.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:35:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] merge: simplify initialization
Date:   Tue, 15 Jun 2021 21:27:56 +0200
References: <20210613225836.1009569-1-felipe.contreras@gmail.com>
 <20210613225836.1009569-2-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210613225836.1009569-2-felipe.contreras@gmail.com>
Message-ID: <87sg1iyl92.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 13 2021, Felipe Contreras wrote:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/merge-file.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 06a2f90c48..0186f4156a 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -28,7 +28,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>  	const char *names[3] = { NULL, NULL, NULL };
>  	mmfile_t mmfs[3];
>  	mmbuffer_t result = {NULL, 0};
> -	xmparam_t xmp = {{0}};
> +	xmparam_t xmp = { .level = XDL_MERGE_ZEALOUS_ALNUM };
>  	int ret = 0, i = 0, to_stdout = 0;
>  	int quiet = 0;
>  	struct option options[] = {
> @@ -48,10 +48,6 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>  		OPT_END(),
>  	};
>  
> -	xmp.level = XDL_MERGE_ZEALOUS_ALNUM;
> -	xmp.style = 0;
> -	xmp.favor = 0;
> -
>  	if (startup_info->have_repository) {
>  		/* Read the configuration file */
>  		git_config(git_xmerge_config, NULL);

Looks good, maybe we can fix the similar code in ll_xdl_merge() while
we're at it?

Also, not a problem in your commit, but we check for that constant in
only one place, as:

    XDL_MERGE_ZEALOUS < level

Urgh, do you know if there's some reason we're not doing level ==
XDL_MERGE_ZEALOUS_ALNUM, or at least level >= XDL_MERGE_ZEALOUS_ALNUM
there?
