Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4780AC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E4021548
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC8pVD6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgI1LR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1LR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 07:17:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5AC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:17:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b22so753238lfs.13
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecQixezh0+3ojCHBVjeq/84ES0AfKh5m7u/QdhsPwWM=;
        b=SC8pVD6UYtLbGcTknwIX4dBTGzMlXvSkZ8M9jl6UinzvES9+jFTU3iBNU2Aup6hlXF
         HNqMs7pmeWmV2bJbik+yt8kpk/sjFAoWkcp9QHwzf6Yu7VmROz8xkJa13fWBg/cGXRY7
         rvu4qQJri/+fnQNJEmzCbTaPYQO2+zP9MIcI02uoqGtSKhlxQsGcwWE7+5PT3pRxp1+e
         XcjfIDqE0i6lS4Qgqn6o7OBmiS7RqmpPoIXuTrJneilrMiQCxVUCRxf9yMARMoMJt1BX
         w/dZoNF2PYoVNti198UdyQjjw6xMNmAjeXam0PFPrucmrm/QzJNZ5wrCWJ8FwoZM2lHL
         V7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecQixezh0+3ojCHBVjeq/84ES0AfKh5m7u/QdhsPwWM=;
        b=NeXnRq2l5aqsQXz5dDzSVyrAG82Enc6wlD2ex7Z2LmA1skA8vWz46b0gskL6bm10Vd
         20Gx5e/jJYjmA/owai34JRcYyG4jAeaE6dULUTJNA/Deta/ns36PvbdccL4Cj9IempyE
         nLSTaBLMFuejZ9D6Nf4qxkBCNS4Ly/ah/p0UIgqwVPbC/txA0rkedCTDFLnsPlaKywOV
         9qEFZqEIOLSqtzqiaC1ujIOqwFem01RNFnh9A5u28ypyUS9bLaX53ASkq/yabUCZxTCw
         vS43wG6xAlK3hv2GZdg2VjYoDE77F1NllZ2H+3YEAQb3MoiVEATAoNNBzY9vO5qpW/Xr
         pulw==
X-Gm-Message-State: AOAM531ZOOTSAl530lVFseWxovxOzGUOYo5fgOjDja0ok/wtofdbhbl0
        VUGj7t8thMckNJH6gNfoofw=
X-Google-Smtp-Source: ABdhPJyOTNjsSwUXnYtLwSsFsTCRa3zO8UJXDWAwb7JNk3W3jQvg+dr2UH5L+faHtP17iO88iV73qg==
X-Received: by 2002:ac2:418c:: with SMTP id z12mr318610lfh.231.1601291874393;
        Mon, 28 Sep 2020 04:17:54 -0700 (PDT)
Received: from localhost.localdomain (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id y196sm2862903lfa.0.2020.09.28.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 04:17:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, sibisiddharthan.github@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2 02/10] cmake: do find Git for Windows' shell interpreter
Date:   Mon, 28 Sep 2020 13:17:48 +0200
Message-Id: <20200928111748.4122-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601155970.git.gitgitgadget@gmail.com>
References: <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601155970.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  find_program(SH_EXE sh)
>  if(NOT SH_EXE)
> -	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
> -			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
> +	set(SH_EXE "C:/Program Files/Git/bin/sh.exe")
> +	if(NOT EXISTS ${SH_EXE})
> +		message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
> +				"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
> +	endif()
>  endif()

You can write the find_program() command more succinctly as:

	find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin")

PATHS is is a list of extra directories to search, which are usually hard-coded
guesses[1]. This way we avoid an extra check and indentation level.

I found my Visual Studio installation already contains a sh.exe.  I think it
ships with VS by default; I can't even find a way to remove it. It's located
at:

C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer\Git\usr\bin\sh.exe

When I started writing this up I figured that could serve as an additional
fallback. However, if I use that shell I have to add (...)/usr/bin to PATH as
the various scripts need expr and sed among other things. I get the same result
if I search "C:/Program Files/Git/usr/bin", but there is no equivalent
(...)/bin in the Git included with VS for some reason.

For the curious I have attached the patch that ended up working, but I doubt
it's worth including (except the simplified if(NOT...) logic).

Øsse.

[1]: https://cmake.org/cmake/help/latest/command/find_program.html

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5007f173f1..baa46e4e97 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -41,10 +41,17 @@ cmake_minimum_required(VERSION 3.14)
 #set the source directory to root of git
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 
-find_program(SH_EXE sh)
+find_program(SH_EXE sh
+    PATHS  "C:/Program Files/Git/bin"
+           "$ENV{VSINSTALLDIR}/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team Explorer/Git/usr/bin"
+ )
 if(NOT SH_EXE)
 	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
+else()
+    # Make sure various utilities are available in PATH
+    get_filename_component(dir "${SH_EXE}" DIRECTORY)
+    set(ENV{PATH} "$ENV{PATH};${dir}")
 endif()
 
 #Create GIT-VERSION-FILE using GIT-VERSION-GEN

