Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91ACC433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 15:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCAD20657
	for <git@archiver.kernel.org>; Thu, 14 May 2020 15:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybep12QN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENPbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 11:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENPbo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 11:31:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E458C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 08:31:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y18so1449995pfl.9
        for <git@vger.kernel.org>; Thu, 14 May 2020 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=761h05H1slu1L+9K0zPzuy9/PJy+r8mhGlhbIGHTUCw=;
        b=Ybep12QNpUBYDKNao45Riero/6ENAT2MqqVPv/wZoAqSkjAIKEX8qH54vowyD0TpQB
         UjeUkq3c16XwR4XHWi3IAtX/j7Maun+0UIxz2bmc9ZVwhJHFA8E//FueaGsFYmm/fB9q
         gyZcfxoEWQ6vf6hxMs4tCht6DsW//0yQQ6D+eMGqwkA+y1Ft91LqBgHIpGfEMhMjDQSG
         N4Nw6u3AejjNJv2x459K/1bFkjlHSJ2Guo+07U48M5/rE7gZSCnajif24P07/oGyCVgm
         LmfxsgyTICmhPCAnJn6i/MwevzS3TaGhfKYG9mrRdNaK4lcq18sBXSVGhGQaYqxT7bb3
         hkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=761h05H1slu1L+9K0zPzuy9/PJy+r8mhGlhbIGHTUCw=;
        b=Swb5NGXo5UI+dt19bOzz8o5yd2o7Tfjs7/aESyqpJq+Qqse1135BeyGpKcuJZsGsF5
         qgPtIWUG/j9WT2IVgE/L+buq9kIisatnPQByM4JimiYg+olA3SOeSBEX0xKKGUjNWgEw
         wNTvTEbFzcH8PpttCx5jCOuxtS8VwTHzrroOkrsjWGQykBMWe8wcTaAxg0sNV2rv6HKR
         ebu4zRZ+ywQies2Kkly86+qd+CB0tDFL73a+G85FxtfyUGPwsCsbV+s43w/xLN6pWzkF
         h9BgRw69J8y8ts1FjGeCPksH0ft54jXfRLR7iN9gpcc9oclfb/5XqU1BbJAWNYnNE7qa
         kMTw==
X-Gm-Message-State: AOAM533uZPsfU9FKazrfgF8iJsYNnyIaiHV16Umj3hP9y7JR5lT5BkOq
        I4txPrGZZfWZp5D5Yrg/RQ8=
X-Google-Smtp-Source: ABdhPJwJMkOFxff9ipS4XbYA+CqQPyMbIu/Tytzp9ctfztsrEwOScyIT48cr2gb6eBBHlSdxP4b7Yw==
X-Received: by 2002:a63:5125:: with SMTP id f37mr4442033pgb.327.1589470303565;
        Thu, 14 May 2020 08:31:43 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id f10sm18274574pju.34.2020.05.14.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 08:31:42 -0700 (PDT)
Date:   Thu, 14 May 2020 22:31:40 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 08/11] cmake: added checks for struct stat and libiconv
Message-ID: <20200514153140.GB1939@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <f496cd7d8aa12047db7f6c0212fbcb2497469785.1589302255.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f496cd7d8aa12047db7f6c0212fbcb2497469785.1589302255.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-12 16:50:51+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> 
> The CMake script now checks whether st_blocks is a member of struct stat
> and set the compile definition NO_ST_BLOCKS_IN_STRUCT_STAT accordingly.
> 
> The check for whether ICONV_OMITS_BOM is also added as requested by Danh.

Please don't write my name in the commit message like this.
This maybe rephased to:
	
	While we're as it, add the check for ICONV_OMITS_BOM.

> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  CMakeLists.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 4353080b708..975791c8b89 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -22,6 +22,7 @@ project(git
>  include(CheckTypeSize)
>  include(CheckCSourceRuns)
>  include(CheckCSourceCompiles)
> +include(CheckCSourceRuns)
>  include(CheckIncludeFile)
>  include(CheckFunctionExists)
>  include(CheckSymbolExists)
> @@ -128,7 +129,7 @@ if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
>  	include_directories(compat/win32)
>  	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
>  				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
> -				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0 NO_ST_BLOCKS_IN_STRUCT_STAT
> +				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
>  				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
>  				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
>  	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
> @@ -280,6 +281,11 @@ if(HAVE_CLOCK_MONOTONIC)
>  	add_compile_definitions(HAVE_CLOCK_MONOTONIC)
>  endif()
>  
> +#check for st_blocks in struct stat
> +check_struct_has_member("struct stat" st_blocks "sys/stat.h" STRUCT_STAT_HAS_ST_BLOCKS)
> +if(NOT STRUCT_STAT_HAS_ST_BLOCKS)
> +	add_compile_definitions(NO_ST_BLOCKS_IN_STRUCT_STAT)
> +endif()
>  
>  #compile checks
>  check_c_source_runs("
> @@ -344,7 +350,6 @@ if(NOT HAVE_REGEX)
>  	add_compile_definitions(NO_REGEX NO_MBSUPPORT GAWK)
>  endif()
>  
> -
>  check_c_source_compiles("
>  #include <stddef.h>
>  #include <sys/types.h>
> @@ -368,6 +373,56 @@ if(HAVE_BSD_SYSCTL)
>  	add_compile_definitions(HAVE_BSD_SYSCTL)
>  endif()
>  
> +set(CMAKE_REQUIRED_LIBRARIES ${Iconv_LIBRARIES})
> +set(CMAKE_REQUIRED_INCLUDES ${Iconv_INCLUDE_DIRS})
> +
> +check_c_source_compiles("
> +#include <iconv.h>
> +
> +extern size_t iconv(iconv_t cd,
> +		char **inbuf, size_t *inbytesleft,
> +		char **outbuf, size_t *outbytesleft);
> +
> +int main(){return 0;}"
> +HAVE_NEW_ICONV)
> +if(HAVE_NEW_ICONV)
> +	set(HAVE_OLD_ICONV 0)
> +else()
> +	set(HAVE_OLD_ICONV 1)
> +endif()
> +
> +check_c_source_runs("
> +#include <iconv.h>
> +#if ${HAVE_OLD_ICONV}
> +typedef const char *iconv_ibp;
> +#else
> +typedef char *iconv_ibp;
> +#endif
> +
> +int main()
> +{
> +	int v;
> +	iconv_t conv;
> +	char in[] = \"a\"; iconv_ibp pin = in;
> +	char out[20] = \"\"; char *pout = out;
> +	size_t isz = sizeof in;
> +	size_t osz = sizeof out;
> +
> +	conv = iconv_open(\"UTF-16\", \"UTF-8\");
> +	iconv(conv, &pin, &isz, &pout, &osz);
> +	iconv_close(conv);
> +	v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
> +	return v != 0xfe + 0xff;
> +}"

I think the closing double-quote should be placed in a newline,
in order to make sure the source file ended with newline,
old C standard requires final newline.


-- 
Danh
