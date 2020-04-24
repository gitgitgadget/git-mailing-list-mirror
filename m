Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219E1C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F058720781
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn22ZFsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgDXRjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728826AbgDXRjy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 13:39:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9908DC09B047
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:39:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so3993841plt.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HA+4AtiHsthMK5LRp2oNcvN+MaLAd6yzjrm+55p7+xI=;
        b=Nn22ZFsIRH23X7+88c94ugU6xNmz7GtmR4DWs25DiLww6hKHZoEc7SEb8/DmB01Bgd
         w1PGFD6b+e0W1V1baGceGPm6t6QHiVzAjHkbsF72HIKQBAEU9CYZACxZ0YSvlVt2hkW9
         +/qOkxDxniM6ehTrF0SPDuVjsyvJDYIfUAG6r0RA5N/DdDHd9qGNkDbNRfyw4fJ4m692
         DAA2UlN29SXitbVbcqWrWxXnDHgPNHEWirEfvd8HmoI7NjQxa8zv4pJ2YUeQRz+Hzmfd
         /sUUttp5J6gjyUmODu2UIvlPQz3zTfcsISvIAk0PbD229/0CX0mR/AdSO7xfZOjH+ELH
         Dggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HA+4AtiHsthMK5LRp2oNcvN+MaLAd6yzjrm+55p7+xI=;
        b=WzUmqIcQjfY0W9eIU5YYBK28BExw/2mhQkVSr6IeTcV5Jt28OGzs4Sc/8Goa0w99I3
         09fBGkGop8FDNjDSo6iYspVhaK/tporgsERkK8ukez6Bv3m+nE1QWm+IxWOoMcReVKum
         mWvSSe9z4P1X0YY7Yvtio9z0kcJcu11S7zt659V1d62hBI4Dsh2EAMmhDcy+HHNhxrCf
         S+NkK/zs9c31ppn7CbvhZEubP3xMFLAREYbz0AUsM7OSHFq7EICxSoZ5efEaOywaJkFL
         w+o5cwUngJOY3+fPZySpHG36zCc1zvPwTpDvVtLmt84MTYwfR31V/pu8tf6LBMhThdZ0
         d39Q==
X-Gm-Message-State: AGi0PuZRNbrJwXJrC6I29+Wb7gPvc2MSHLxsQRya1t0/kU89CqIZoJzC
        613yOAPOZioVt+Q57s5Xg9U=
X-Google-Smtp-Source: APiQypJw0bvgF8KEAPVpVlVDAev3MPQP2zHa/Rcef+Ce9TkzZlcVhDyuNDnElAU26SRL50N5rGSetg==
X-Received: by 2002:a17:90a:3568:: with SMTP id q95mr7697333pjb.47.1587749994085;
        Fri, 24 Apr 2020 10:39:54 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id z190sm6218806pfb.1.2020.04.24.10.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:39:53 -0700 (PDT)
Date:   Sat, 25 Apr 2020 00:39:51 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 7/8] cmake: support for building git on windows with msvc
 and clang.
Message-ID: <20200424173951.GM1949@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <0577d7bf0a84f94396bd956bd7f6bbc711d3bf26.1587700897.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0577d7bf0a84f94396bd956bd7f6bbc711d3bf26.1587700897.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 04:01:36+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
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
> 
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
> 		-DCMAKE_BUILD_TYPE=[Debug or Release]
> 
> On cmd
> set CC=Clang
> cmake `relative-path-to-srcdir` -G Ninja
> 		-DCMAKE_BUILD_TYPE=[Debug or Release]
> 
> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  CMakeLists.txt | 57 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index d9eb1060390..5ad3a2557f7 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -2,7 +2,7 @@
>  #	Copyright (c) 2020 Sibi Siddharthan
>  #
>  
> -cmake_minimum_required(VERSION 3.14)
> +cmake_minimum_required(VERSION 3.15)

3.14 is a step too far, and, now, we want CMake 3.15?

>  
>  #Parse GIT-VERSION-GEN to get the version
>  file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN git_version REGEX "DEF_VER=v(.*)")
> @@ -32,8 +32,11 @@ find_package(ZLIB REQUIRED)
>  find_package(CURL)
>  find_package(EXPAT)
>  find_package(Iconv)
> -find_package(Intl)
>  
> +#Don't use libintl on Windows Visual Studio and Clang builds
> +if(NOT (WIN32 AND (CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")))
> +	find_package(Intl)
> +endif()
>  
>  if(NOT Intl_FOUND)
>  	add_compile_definitions(NO_GETTEXT)
> @@ -61,7 +64,7 @@ if(NOT SH_EXE)
>  	message(FATAL_ERROR "sh interpreter was not found in your path, please install one. On Windows you can get it from here https://gitforwindows.org/")
>  endif()
>  
> -if(WIN32)
> +if(WIN32 AND NOT MSVC)#not required for visual studio builds
>  	find_program(WINDRES_EXE windres)
>  	if(NOT WINDRES_EXE)
>  		message(FATAL_ERROR "Install windres on Windows for resource files")
> @@ -73,6 +76,13 @@ if(NOT MSGFMT_EXE)
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
> @@ -110,6 +120,10 @@ endif()
>  
>  #Platform Specific
>  if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
> +	if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
> +		include_directories(compat/vcbuild/include)
> +		add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)

This is fair, I hate those warning, too.

Is _CRT_NONSTDC_NO_DEPRECATE implied when _CRT_SECURE_NO_WARNINGS
defined? Or otherwise around?


-- 
Danh
