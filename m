Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16165C433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 14:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54812074B
	for <git@archiver.kernel.org>; Sat, 30 May 2020 14:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTsbmT8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgE3OIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 10:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgE3OIu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 10:08:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79487C03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 07:08:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so2399429plb.3
        for <git@vger.kernel.org>; Sat, 30 May 2020 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ePLLRYQREa1SwfGaJJ0rqqdKlteKcE018Bmib6DaRaY=;
        b=oTsbmT8wFRsUPMb7VEDndf8mZE0zH7oF2tn/3k4xXdlVoK24kAA/PwcvAjhXBbU4HN
         eH1Teo6DmhvGlddzD+oAGeO12/QFi0e9sLEIcYWu/+SDrMOXx4JwMaL4zeJkBuEbBVUp
         SMlx3GezX/hM9YCmqhYrC9dc0lttSk1vJVFj2RJsv7ZXRoTlUKkpo5hYnAiAn1DmjgMR
         QWmQewQEO4hFE+uArIH3MRG7ItztE/xx7rQenTJPpvy1Ru2YypCBWhkFrdtGkNheurPz
         Ec2vYf5Nrb+YbNDvxA6Csvi7O87ZKJ2Q8OWvttOGp0eMo1RsiOccC2jvSquWUIioOPzM
         013A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ePLLRYQREa1SwfGaJJ0rqqdKlteKcE018Bmib6DaRaY=;
        b=T73Tqrnkc3Rp86IunDsQTKH0iJP3HiG8yn+Jmw6vjAiR3zQE58bMtBlR186Fl2dW03
         eU8ueDCra9VQTfSpXyNhDR64RDS/HtnV2ds0Pm5Zo+2B6PCkRznLgxtHLhFdnbH9qCYx
         aysD90yyyltEKw6lDdfVnvdQ8MdqeXm0s9wVkSMC3LEuNNmQBJGVIL4N9hX9+syO2cgN
         0B94225Txu6Ccy+qyX4dXPApcnMHnAcvkjCGykzTTPIhttv7l1eSVw6tfxSRYjb21vZ8
         whes0r8wMLUe2Uhj235qy7eugsilYMbRBW1Rcj8FM66H43v+PqJ+scTLUDdypW1FKDKc
         ba1g==
X-Gm-Message-State: AOAM533+76SCS3hD3XVHvuVuXGwnDLc2iXryktwLMCSTb2BRbl6Yjqqm
        fowY/ObMG6MU8Jj+JHjL6mr9Bb1w
X-Google-Smtp-Source: ABdhPJzaFr5ka0RR6a4E98pp2AxPQG6IHVHJuC2DydRBbuCMP+Q0N9TCvmSklOWZ1VV7Bu7kZKq7dA==
X-Received: by 2002:a17:902:7582:: with SMTP id j2mr61164pll.98.1590847729943;
        Sat, 30 May 2020 07:08:49 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id o13sm1711349pgs.82.2020.05.30.07.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 07:08:49 -0700 (PDT)
Date:   Sat, 30 May 2020 21:08:47 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v3 7/8] cmake: support for building git on windows with
 msvc and clang.
Message-ID: <20200530140847.GC2151@danh.dev>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
 <8f36e30cd2218fa56fb0c2b89f6f51726b0eb285.1590759624.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f36e30cd2218fa56fb0c2b89f6f51726b0eb285.1590759624.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-29 13:40:23+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> 
> This patch adds support for Visual Studio and Clang builds
> 
> The minimum required version of CMake is upgraded to 3.15 because
> this version offers proper support for Clang builds on Windows.
> 
> Libintl is not searched for when building with Visual Studio or Clang
> because there is no binary compatible version available yet.
> 
> NOTE: In the link options invalidcontinue.obj has to be included.
> The reason for this is because by default, Windows calls abort()'s
> instead of setting errno=EINVAL when invalid arguments are passed to
> standard functions.
> This commit explains it in detail:
> 4b623d80f73528a632576990ca51e34c333d5dd6

I think it's better to say:

	See 4b623d80f7 (MSVC: link in invalidcontinue.obj for better
	POSIX compatibility, 2014-03-29) for detail.


(I haven't read the referenced commit, FWIW)

> On Windows the default generator is Visual Studio,so for Visual Studio
> builds do this:
> 
> cmake `relative-path-to-srcdir`
> 
> NOTE: Visual Studio generator is a multi config generator, which means
> that Debug and Release builds can be done on the same build directory.
> 
> For Clang builds do this:
> 
> On bash
> CC=Clang cmake `relative-path-to-srcdir` -G Ninja

I think you meant CC=clang, note the lowercase c,
that will cmake this note applicable for case-sensitive filesystem.

... reading this patch ...

So, this is applicable for Windows only, it's fine as is, then.
It's still better to lowercase it, though.

> 		-DCMAKE_BUILD_TYPE=[Debug or Release]
> 
> On cmd
> set CC=Clang
> cmake `relative-path-to-srcdir` -G Ninja
> 		-DCMAKE_BUILD_TYPE=[Debug or Release]
> 
> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  contrib/buildsystems/CMakeLists.txt | 55 +++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 46197d0b806..0a3f711db88 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -98,8 +98,11 @@ find_package(ZLIB REQUIRED)
>  find_package(CURL)
>  find_package(EXPAT)
>  find_package(Iconv)
> -find_package(Intl)
>  
> +#Don't use libintl on Windows Visual Studio and Clang builds
> +if(NOT (WIN32 AND (CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")))

Personally, I find this is a bit ugly.
Does it work to move the if(WIN32) down there, here.
Then make sub-condition for MSVC and Clang?

> +	find_package(Intl)
> +endif()
>  
>  if(NOT Intl_FOUND)
>  	add_compile_definitions(NO_GETTEXT)
> @@ -123,7 +126,7 @@ if(Intl_FOUND)
>  endif()
>  
>  
> -if(WIN32)
> +if(WIN32 AND NOT MSVC)#not required for visual studio builds

for the down there, I meant here.
Using "NOT MSVC" here and `CMAKE_C_COMPILER_ID STREQUAL "MSVC"` above
may puzzle people interest in this patch.

>  	find_program(WINDRES_EXE windres)
>  	if(NOT WINDRES_EXE)
>  		message(FATAL_ERROR "Install windres on Windows for resource files")
> @@ -135,6 +138,13 @@ if(NOT MSGFMT_EXE)
>  	message(WARNING "Text Translations won't be build")
>  endif()
>  
> +#Force all visual studio outputs to CMAKE_BINARY_DIR
> +if(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
> +	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
> +	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
> +	add_compile_options(/MP)
> +endif()
> +
>  #default behaviour
>  include_directories(${CMAKE_SOURCE_DIR})
>  add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
> @@ -172,6 +182,10 @@ endif()
>  
>  #Platform Specific
>  if(CMAKE_SYSTEM_NAME STREQUAL "Windows")

I missed this line from previous patch
(and my comment in previous round, which suggested remove ${})
Does `if(WIN32)` and `if(CMAKE_SYSTEM_NAME STREQUAL "Windows")` have
different meanings?
I don't know much about CMake on Windows to really sure about this.

-- 
Danh
