Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76A6C47095
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED866105A
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFGR2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:28:41 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:45676 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFGR2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:28:41 -0400
Received: by mail-wm1-f50.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so104752wmg.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xyhhmvDL4Suz0pOWwir/ReEfhsF7iTXc6xmbQMnMDl8=;
        b=rJLO6YbuKwYAiyeZDsWX/NgL2Gs0p+BU9qgCc95eH9yToyafuigl80Qzc7Ywy/pc9X
         sxbLuE19n83NET+L8ukRmqQY1zKwxqrZxtxo48DDrkCvYkTbnq0Ozo4tuDhwmQ4GXK3D
         qLY1SWm+3g/1KERBO2GsUE3dTa9CQbO3dssh7P3g+lgXPxlnA/3wSGdaWsGcXO6M2rYg
         sp9l5vECM8aPouYM91XimLt4QYecHLlk09V3C2jZmWmJkCUGx+SLxIzI9T/TYZrfg7zn
         OGs0sMQuFL6SkgxLrdCXIE2dt2rukpiu7NHBFYoqI+BnSgbW8F/KE/Vn64KEOwrL36jo
         HfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xyhhmvDL4Suz0pOWwir/ReEfhsF7iTXc6xmbQMnMDl8=;
        b=RYmOuNnXKTy6lrGfXdor7XAj2wbzVlfLM6kCWrBm4+BaGXnRdcLlV/U1ADbEyS4o5Z
         S2TgvBmeP729tj5YeS6RbJlr5YyjhrfOem61DG+WIBYCNHgu8ZE4fmnKbcGi0MAFboI/
         tQW/kz4QsBCjMtxFnvp3pC57vugfwcuncv9EUGTpemf7pUqYvCOkGT03ZlSYIF1bGheZ
         wlZ0yHi60VKUgHF9pXNpBvNDBbMb8Nc8aj72IDGtLKwqJfOOD9mRh8AvqaH3yrZHa7Pn
         M7yFxtK59R5pTVn4WlovHgPAWOYyndNCyyksVvGqwU9XGXH5aq6izxGDw12eHPDoNAFu
         l3Dw==
X-Gm-Message-State: AOAM530GVUMNWJegA94A74BOC9DR3XXz2VSRthAWlzQVnjq1oCosDnle
        2fFOkwWLmEQBtl5r3RtTDJigVnc8iyE=
X-Google-Smtp-Source: ABdhPJytKmy5BFS0iOkxvJqu9aynmlOfAH+UOFmCc6RDFE9u0R/XSgHT9Oo00DnJLVGK01RfJEbBBQ==
X-Received: by 2002:a05:600c:5112:: with SMTP id o18mr10736064wms.15.1623086748923;
        Mon, 07 Jun 2021 10:25:48 -0700 (PDT)
Received: from szeder.dev (94-21-29-108.pool.digikabel.hu. [94.21.29.108])
        by smtp.gmail.com with ESMTPSA id n13sm18894692wrg.75.2021.06.07.10.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:25:48 -0700 (PDT)
Date:   Mon, 7 Jun 2021 19:25:42 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] SubmittingPatches: replace discussion of Travis
 with GitHub Actions
Message-ID: <20210607172542.GA6312@szeder.dev>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
 <patch-2.3-7d5d2854e3-20210607T110044Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.3-7d5d2854e3-20210607T110044Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 01:03:42PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Replace the discussion of Travis CI added in
> 0e5d028a7a0 (Documentation: add setup instructions for Travis CI,
> 2016-05-02) with something that covers the GitHub Actions added in
> 889cacb6897 (ci: configure GitHub Actions for CI/PR, 2020-04-11).
> 
> The setup is trivial compared to using Travis, and it even works on
> Windows (that "hopefully soon" comment was probably out-of-date on
> Travis as well).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/SubmittingPatches | 44 ++++++++++++---------------------
>  1 file changed, 16 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 2643062624..e372d17673 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -74,10 +74,9 @@ the feature triggers the new behavior when it should, and to show the
>  feature does not trigger when it shouldn't.  After any code change, make
>  sure that the entire test suite passes.
>  
> -If you have an account at GitHub (and you can get one for free to work
> -on open source projects), you can use their Travis CI integration to
> -test your changes on Linux, Mac (and hopefully soon Windows).  See
> -GitHub-Travis CI hints section for details.
> +Pushing to a fork of https://github.com/git/git will use their CI
> +integration to test your changes on Linux, Mac and Windows. See the
> +GitHub CI section for details.
>  
>  Do not forget to update the documentation to describe the updated
>  behavior and make sure that the resulting documentation set formats
> @@ -451,12 +450,12 @@ their trees themselves.
>    the status of various proposed changes.
>  
>  [[travis]]

What about this occurence of "travis"?

> -== GitHub-Travis CI hints
> +== GitHub CI
>  
> -With an account at GitHub (you can get one for free to work on open
> -source projects), you can use Travis CI to test your changes on Linux,
> -Mac (and hopefully soon Windows).  You can find a successful example
> -test build here: https://travis-ci.org/git/git/builds/120473209
> +With an account at GitHub, you can use GitHub CI to test your changes
> +on Linux, Mac and Windows. See
> +https://github.com/git/git/actions/workflows/main.yml for examples of
> +recent CI runs.
>  
>  Follow these steps for the initial setup:
>  
> @@ -464,31 +463,20 @@ Follow these steps for the initial setup:
>    You can find detailed instructions how to fork here:
>    https://help.github.com/articles/fork-a-repo/
>  
> -. Open the Travis CI website: https://travis-ci.org
> -
> -. Press the "Sign in with GitHub" button.
> -
> -. Grant Travis CI permissions to access your GitHub account.
> -  You can find more information about the required permissions here:
> -  https://docs.travis-ci.com/user/github-oauth-scopes
> -
> -. Open your Travis CI profile page: https://travis-ci.org/profile
> -
>  . Enable Travis CI builds for your Git fork.
>  
>  After the initial setup, Travis CI will run whenever you push new changes

And what about these two mentions of Travis CI in the context?

>  to your fork of Git on GitHub.  You can monitor the test state of all your
> -branches here: https://travis-ci.org/__<Your GitHub handle>__/git/branches
> +branches here: https://github.com/<Your GitHub handle>/git/actions/workflows/main.yml
