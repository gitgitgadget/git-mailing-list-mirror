Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2D1C7113B
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 19:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbjHWThZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbjHWThT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 15:37:19 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18404E6E
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:37:13 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58419517920so63582617b3.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692819432; x=1693424232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIfUwLbqM+NBoseaU60ph5pCSPLZKvjWco08b0OEEYY=;
        b=Q3WczLmFJfvazQOhzKzNuC3FlidI99chLFTF3DHelMJOOJuMSDdzsBqCzUcm3cVm1z
         uG1+XAQskjy5ct5Shu5fleH3aZL4+/3KTsJo01/Ua2Vzem2EECYYOtOLFrZh9rWSOZfB
         93m09MfZNfZg1owNDnKm18GZrHgn0ofbGkMGVz7ombbcn4GvmjvaE40Ww6DE624fwEHa
         dULATsPqFDi3Rkb9+NGWY5I+8nQHi52983vFSt5AWpIIkcgSrhA7UJNbpcY15vNu56su
         Aoh1Bf//vwOR9QARiR2x2FLHZj1g0GKV3zA9hP1DTB6pn10AfzCDxmmIfEkknIXmwGfK
         NlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819432; x=1693424232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIfUwLbqM+NBoseaU60ph5pCSPLZKvjWco08b0OEEYY=;
        b=dfHyW6z8CW4u7tVUqmckwpdH09L3QWPQhtAPEd3lXY6kzVR6LU7B+7FEu3bwxxYYSz
         84S8/sOMRzVvkiHZcw3TdHV0uIcCLj6WuZf0W89PpUnc9T/qteSz/8bdl2FV8VcM/o8n
         YZ4WkhYGOl+3lM21GZgJpr1+GLq3SOzpUjxkhrzm7+f8SCVTugqJVhTDFIEbLxXK3xuV
         89p2YHHv9ILbgAxbFfMAIfD8GO1ux1L1qZ1Gncm7leEYAeLgxW9wcMZKn9Jf1btdBROt
         juaDh0gY0AgOQw4DY8A6dQIvVoS6/SMLt21k7NAZst4VGHRyak+8z3Q2/fcEWBgHa8Dg
         ECwQ==
X-Gm-Message-State: AOJu0Yxagi4osYEBGUSJA7t1jks4QQz1Kv4EuhsiN/JXcckO8Tst4Btg
        MHp3CweXvrxzqj38KqlX36nlUA==
X-Google-Smtp-Source: AGHT+IFnjmaZvRyLSHfzQqgRm5A1vCU2qp+wKjETQjFSSMB2AiGF2zejdd+Qjof/W1ha9FEVCj13xA==
X-Received: by 2002:a81:6ec6:0:b0:592:4fb1:be46 with SMTP id j189-20020a816ec6000000b005924fb1be46mr4649268ywc.39.1692819432211;
        Wed, 23 Aug 2023 12:37:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x123-20020a818781000000b0058d856efb31sm3521038ywf.98.2023.08.23.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:37:11 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:37:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
Subject: Re: [PATCH] submodule: deprecate --recurse-submodules=""
Message-ID: <ZOZf4/DYOKqQLjR+@nand.local>
References: <20230823032839.731375-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823032839.731375-1-alexhenrie24@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2023 at 09:28:37PM -0600, Alex Henrie wrote:
> The unusual syntax --recurse-submodules="" (that is,
> --recurse-submodules with an empty string argument) has been an
> undocumented synonym of --recurse-submodules without an argument since
> commit 8f0700dd33 (fetch/pull: Add the 'on-demand' value to the
> --recurse-submodules option, 2011-03-06). Deprecate that syntax to avoid
> confusion with the submodule.recurse config option, where
> submodule.recurse="" is equivalent to --no-recurse-submodules.
>
> The same thing was done for --rebase-merges="" in commit 33561f5170
> (rebase: deprecate --rebase-merges="", 2023-03-25).

Makes sense, and this is certainly in the same spirit as your
33561f5170.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  submodule-config.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 6a48fd12f6..8acb42744d 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -332,11 +332,17 @@ int option_fetch_parse_recurse_submodules(const struct option *opt,
>
>  	if (unset) {
>  		*v = RECURSE_SUBMODULES_OFF;
> +	} else if (!arg) {
> +		*v = RECURSE_SUBMODULES_ON;
>  	} else {
> -		if (arg)
> -			*v = parse_fetch_recurse_submodules_arg(opt->long_name, arg);
> -		else
> -			*v = RECURSE_SUBMODULES_ON;
> +		if (!*arg) {
> +			warning(_("--recurse-submodules with an empty string "
> +				  "argument is deprecated and will stop "
> +				  "working in a future version of Git. Use "
> +				  "--recurse-submodules without an argument "
> +				  "instead, which does the same thing."));

This advice says to use `--recurse-submodules` as a non-deprecated
synonym for `--recurse-submodules=""`, but I am not so sure that is
correct advice.

In the pre-image of this patch, having arg be set to the empty string
would cause us to fall into the path that executes

    *v = parse_fetch_recurse_submodules_arg(opt->long_name, arg);

which calls `parse_fetch_recurse()` -> `git_parse_maybe_bool()` ->
`git_parse_maybe_bool_text()` which given the empty string will return
0.

So here we'd be doing the equivalent of

    *v = RECURSE_SUBMODULES_OFF;

when trying to parse `--recurse-submodules=""`. Should this advice
instead say "[...] Use --no-recurse-submodules without an argument,
which does the same thing"?

Thanks,
Taylor
