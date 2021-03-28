Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A65C433E2
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782EE619A0
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 03:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhC1DUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 23:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1DTy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 23:19:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CBC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 20:19:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w8so4388555pjf.4
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 20:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4lqOXceSWwy4RjWqiPHSJ57Kv7H7YsQT7pHlDrum5Gk=;
        b=hhG7VxDGRTcmWaXgPkCZFTHO3qPW0p3FaQlQDotazijmtfdDfjfmvCGSyA+UvHhPAY
         MbwnZzaSVA+Ita7Cav/c1wzbTzEQpLc6dSG0TcsNWk/ge1pX0ADt0pUEiZazMtK6Hv3e
         WkN2lPSVRtiFtvzyNhSthbi7GxvR6n9FvgVAB+Up2rncNBCYiSOJ848R3/u4xwohpsG+
         nUv0bvMwVuD/pngBoC+lZYW29Fp6D+ULJ8AjUWVsFT+mS2ZYPPCigHMAqQP5C3YbG7wn
         1wtHL8mZnPkwaTS5eLQG/frkaoOeFjhQrXpENvt2EKI5yxek6iako6MdLdBJJp4/vLbz
         W3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lqOXceSWwy4RjWqiPHSJ57Kv7H7YsQT7pHlDrum5Gk=;
        b=U8cUlSlu+7UesnY71hBLOn4QqHJN5wALQI+b7P67Q/LIGW/o7RkAWPdU7+KF0Eiapa
         kEXcP1MEppvd6GURUtpp//b9yL6DT2m6wm0qNsHR1+HtANpt5qPnRjxJ42WC8MfnW424
         C/KbikHRG33loyZZe9qFj0L1oBLQAwt8LpruFw0utEpsqTpU8A8sY4veM5R/cwzwO0f5
         zeIUCs01QrKkfSecRYHTvBZw30DxP9iayCNpiIHyccatRdamq7QJC3sbBxJOC8sveVLS
         gD+QxGt9+T/v7s9TjbJoDR/ct1JnDV8z0+Mgp+ld7nLQMFujCLHprDuMIqns88lJN++m
         KuPQ==
X-Gm-Message-State: AOAM532XfVeR8NniK2zRLYBvTq05o5o/M95i+FAmHFqCYI60UwmnFsXj
        sFzXBiMuMxizPFyGqwhhVzY=
X-Google-Smtp-Source: ABdhPJyzKM6nXEePTgUENtrGPUkkAJZ0GWONElyX+IXqAVcpspwVQWpLuR6f+IPwiGtE1to9y8RBKA==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr20252639pji.228.1616901593987;
        Sat, 27 Mar 2021 20:19:53 -0700 (PDT)
Received: from localhost ([2402:800:63b8:e092:ee2e:2ecc:e75a:abdc])
        by smtp.gmail.com with ESMTPSA id x186sm13226070pfc.65.2021.03.27.20.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 20:19:53 -0700 (PDT)
Date:   Sun, 28 Mar 2021 10:19:51 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] cmake: add a preparatory work-around to accommodate
 `vcpkg`
Message-ID: <YF/117C6LcNGQ7sm@danh.dev>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
 <543fd0f5d7e5ee297364d1d28091f2004a35f2d0.1616886386.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543fd0f5d7e5ee297364d1d28091f2004a35f2d0.1616886386.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-03-27 23:06:24+0000, Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> We are about to add support for installing the `.dll` files of Git's
> dependencies (such as libcurl) in the CMake configuration. The `vcpkg`
> ecosystem from which we get said dependencies makes that relatively
> easy: simply turn on `X_VCPKG_APPLOCAL_DEPS_INSTALL`.
> 
> However, current `vcpkg` introduces a limitation if one does that:
> While it is totally cool with CMake to specify multiple targets within
> one invocation of `install(TARGETS ...) (at least according to
> https://cmake.org/cmake/help/latest/command/install.html#command:install),
> `vcpkg`'s parser insists on a single target per `install(TARGETS ...)`
> invocation.
> 
> Well, that's easily accomplished: Let's feed the targets individually to
> the `install(TARGETS ...)` function in a `foreach()` look.
> 
> This also has the advantage that we do not have to manually cull off the
> two entries from the `${PROGRAMS_BUILT}` array before scheduling the
> remainder to be installed into `libexec/git-core`. Instead, we iterate
> through the array and decide for each entry where it wants to go.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index da2811ae3aad..a166be0eb1b8 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -811,15 +811,19 @@ list(TRANSFORM git_shell_scripts PREPEND "${CMAKE_BINARY_DIR}/")
>  list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
>  
>  #install
> -install(TARGETS git git-shell
> +foreach(program ${PROGRAMS_BUILT})
> +if(${program} STREQUAL git OR ${program} STREQUAL git-shell)

Please don't use `${}` around variable inside `if()`, and quote the
string. CMake has a quirk with the `${}` inside if (expanded variable
will be treated as a variable if it is defined, or string otherwise).
Unquoted string will be seen as a variable if it's defined, string
otherwise. IOW, suggested command:

	if (program STREQUAL "git" OR program STREQUAL "git-shell")

We also have another problem with quoted arguments could be interpreted
as variable or keyword if CMP0054 policy not enabled, too.
I think it's better to have it enabled, but it's not in the scope of
this patch.

 https://cmake.org/cmake/help/latest/policy/CMP0054.html


-- 
Danh
