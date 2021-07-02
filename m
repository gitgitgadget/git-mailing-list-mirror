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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACEFC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711AB61427
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhGBNha (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhGBNha (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:37:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED90C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 06:34:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w13so13356408edc.0
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=o/bZ0iC5+Vd2wJvZbbxrhrXkKI6wQiSeYtHnyyIc56M=;
        b=mCrMwtmNZAxMMraSx5Vgq30ntu0uEu+Pt9UYKOnwVdKxyCAqr78opiFFuZCIhiS4Zj
         YleeNF5I9XqI5E1N7DytroV7NSJIdaIjxO3si3CdIIGuuVp5nyBlmGqAJG+JIf8ROWyS
         cIvRye1WI3xBdohRd88d7by6L3wSO09nqlM9EMliEetrAODzqAgwFwTTCrX684A02SZr
         db4dBBoK3ZShojl4ZYVbd3RcwB+GXkd5Th3+hDDFcEyThrLXxcJZd2CCD424wdzLM3Sh
         IaqaZ7QH2HXCEuOWNd4DD5v1YOMgq6Lt17BZsGg7zqnt05EOWFndlwGSrlFIggpZpGBh
         /PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=o/bZ0iC5+Vd2wJvZbbxrhrXkKI6wQiSeYtHnyyIc56M=;
        b=XM9f6ve5Pfbt0hKVPFL1YDHxj21cskXDpCbmYrks2v0POgMNwNOYdQK2KamdP3HhDv
         Dg4hXDbGdRniEoIYmN569fBLuwSUMNTh3+CsIzHQuIypoAPV6fqArKRupDrguyik0hrL
         5XPczzfXTdPrwgsV5ZSQ618wJE4waIW2LldhJGmzXoPH4htVM1G3GWGhv7uh3HtNaata
         4f23U3EmTmUVtsc44fsbN0PUoUavz8KRYj2X6jp4F+RzkatkyR7RGddJSzxkI0U9Egf9
         xhflsgXBBbaZf1pl963inCAXzdVXTeMI/oRk8osOgqLO/Wps9sth29zUwu4BJOVkZEAP
         1Juw==
X-Gm-Message-State: AOAM533CVmips9P1JKMypxIH3nyGCD3Y3pJMeF1gM33PF/4FIo5p3nvS
        FAzjedI9SMM1JiQ3Qx5uFM4UbKkifpdY8g==
X-Google-Smtp-Source: ABdhPJwWzkk2Ol8F9irN8sFjgKxRUrpCAySG2PoWOLcPqWvYYlnIYQLM6o+eaMpm5NgWGJvNtXyunQ==
X-Received: by 2002:a05:6402:498:: with SMTP id k24mr7047609edv.25.1625232896637;
        Fri, 02 Jul 2021 06:34:56 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x3sm1099687ejy.0.2021.07.02.06.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:34:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 10/15] [GSOC] cat-file: add has_object_file() check
Date:   Fri, 02 Jul 2021 15:34:19 +0200
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <18f38075b3c70748894ad6b2e1158f2b17460845.1625155693.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <18f38075b3c70748894ad6b2e1158f2b17460845.1625155693.git.gitgitgadget@gmail.com>
Message-ID: <87a6n4alfk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Use `has_object_file()` in `batch_one_object()` to check
> whether the input object exists. This can help us reject
> the missing oid when we let `cat-file --batch` use ref-filter
> logic later.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  builtin/cat-file.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 243fe6844bc..59a86412fd0 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -428,6 +428,13 @@ static void batch_one_object(const char *obj_name,
>  		return;
>  	}
>  
> +	if (!has_object_file(&data->oid)) {
> +		printf("%s missing\n",
> +		       obj_name ? obj_name : oid_to_hex(&data->oid));
> +		fflush(stdout);
> +		return;
> +	}
> +
>  	batch_object_write(obj_name, scratch, opt, data);
>  }

In 12/15 the old "missing" is removed, so is this strictly redundant to
what's in batch_object_write() for now, does it change anything?
