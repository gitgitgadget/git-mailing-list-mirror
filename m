Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55D8C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808E4613D3
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbhI2BPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:15:53 -0400
Received: from avasout07.plus.net ([84.93.230.235]:51476 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242636AbhI2BPx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:15:53 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id VOAcmgcWvdY2SVOAdm6M5F; Wed, 29 Sep 2021 02:14:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632878051; bh=oevgcDPEdu8n/qiPCrcWhwrWAIIA4kb0lZrA1/rFB7E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aS/1wpqQh04OzHnJ81aVKp2YV7L4GCpOoIudVAi649E1ssJb9+eUVXlkAZvrYOkR3
         0dkhxkFN866xXoQI08f1rZrW2zB0J/5kSVERunEPAsH6C/SgfxAbsHOjPD7y5xm7KJ
         yP9st1UghutswbAOdO45GGzshqcVBI4+x4j53dWpOMI9sfnTh6zWQ/xuzYdGopiiVY
         kKxub+hQxWSByY50Kulpi0E8zqob/znMxjkYp+Tq9r3O8oYnUwzDNmj84Hh7GIYhNx
         cUzQIrQOnFCvkBDDSbrrD6m5ezW0OUTC027wa///iQeOMo1eREvPyF67aKbbuX/Xxm
         LuuLNC5VeEZqw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NP5OB3yg c=1 sm=1 tr=0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=ILbTJERBAOJUPR4ELocA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 3/3] Makefile: restrict -Wpedantic and
 -Wno-pedantic-ms-format better
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com, avarab@gmail.com
References: <20210926100512.58924-1-carenas@gmail.com>
 <20210929004832.96304-1-carenas@gmail.com>
 <20210929004832.96304-4-carenas@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d19fa4bc-9af7-17cc-86d4-c15ad257cf82@ramsayjones.plus.com>
Date:   Wed, 29 Sep 2021 02:14:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929004832.96304-4-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLFVT1PWuz0rSBDHlwJaLxG9otDeeg1OABDXCIZJ6ZQFtKvtSYE9EEsbouEikO/c+Mm/fm1yr+nSq3EK5+WIgCHefV8f1G1uuZZ1VkiXK3uCO3wRDYTa
 qnkKtnnl73SWMzF1mXWNREwo3QH9hzKprURc4gx1cQYuZkwonA4uBvZxNilSl1o4qbttESN7Lit83Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/09/2021 01:48, Carlo Marcelo Arenas Belón wrote:
> 6a8cbc41ba (developer: enable pedantic by default, 2021-09-03)
> enables pedantic mode in as many compilers as possible to help gather
> feedback on future tightening, so lets do so.
> 
> -Wpedantic is missing in some really old gcc 4 versions so lets restrict
> it to gcc5 and clang4 (it does work in clang3 AFAIK, but it will be
> unlikely that a developer will use such an old compiler anyway).
> 
> MinGW gcc is the only one which has -Wno-pedantic-ms-format, and while
> that is available also in older compilers, the Windows SDK provides gcc10
> so let's aim for that.
> 
> Note that in order to target the flag to only Windows, additional changes
> were needed in config.mak.uname to propagate the OS detection which also
> did some minor refactoring, but which is functionaly equivalent.
> 
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  config.mak.dev   | 7 ++++++-
>  config.mak.uname | 8 +++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/config.mak.dev b/config.mak.dev
> index cdf043c52b..7673fed114 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -6,14 +6,19 @@ ifeq ($(filter no-error,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS += -Werror
>  SPARSE_FLAGS += -Wsparse-error
>  endif
> +
>  DEVELOPER_CFLAGS += -Wall
>  ifeq ($(filter no-pedantic,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS += -pedantic
> +ifneq (($or $(filter gcc5,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
>  DEVELOPER_CFLAGS += -Wpedantic
> -ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
> +ifneq ($(filter gcc10,$(COMPILER_FEATURES)),)
> +ifeq ($(uname_S),MINGW)
>  DEVELOPER_CFLAGS += -Wno-pedantic-ms-format
>  endif
>  endif
> +endif
> +endif
>  DEVELOPER_CFLAGS += -Wdeclaration-after-statement
>  DEVELOPER_CFLAGS += -Wformat-security
>  DEVELOPER_CFLAGS += -Wold-style-definition
> diff --git a/config.mak.uname b/config.mak.uname
> index 76516aaa9a..124ddfce36 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -11,6 +11,10 @@ uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
>  uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
>  uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
>  
> +ifneq ($(findstring MINGW,$(uname_S)),)
> +	uname_S := MINGW
> +endif
> +
>  ifdef MSVC
>  	# avoid the MingW and Cygwin configuration sections
>  	uname_S := Windows
> @@ -588,7 +592,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
>  	SHELL_PATH = /usr/coreutils/bin/bash
>  endif
> -ifneq (,$(findstring MINGW,$(uname_S)))
> +ifeq ($(uname_S),MINGW)
>  	pathsep = ;
>  	HAVE_ALLOCA_H = YesPlease
>  	NO_PREAD = YesPlease
> @@ -705,6 +709,8 @@ ifeq ($(uname_S),QNX)
>  	NO_STRLCPY = YesPlease
>  endif
>  
> +export uname_S
> +

This export seems to be unnecessary.

ATB,
Ramsay Jones

>  vcxproj:
>  	# Require clean work tree
>  	git update-index -q --refresh && \
> 
