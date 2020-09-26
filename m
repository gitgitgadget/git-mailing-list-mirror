Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4EFC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE582371F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/V0w2tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgIZVdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgIZVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:33:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442CC0613D8
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so7672357wrr.4
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vyLvrpHfDqe4agokkpcNOrP/sTPDYeWnNvNcWxUJ/E0=;
        b=o/V0w2tuCdW/NUyglXoDYzhIJ2+ffKg/JL6u3A9Tqt5e3tBPTQ6707AX7WSegGd6+p
         0uaWant5bOnySUXpjcsfhua4TraSkW7H+37umtjoU1s1moAAFPv4ZUMPebPdnlUkklFJ
         oehpOMsYuL1gAqZf+2nNN5yCI80GH1AyTPAyfsZV6d2lAWCqsCa08NiS064UhBp2Wyxi
         HwmpWwR3+quEGfKYVcXCTYiHIPvTwXWhkn+SRnR1wgjRBVmL7Qh3YniP9gSGxtaVEhCW
         wklDQ/MHtFUpevczaR2eUsUtWMLpSnLmR0e5iOsmY/SpQc+NNDrLgz21ynKOfpFxLMWy
         ipzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vyLvrpHfDqe4agokkpcNOrP/sTPDYeWnNvNcWxUJ/E0=;
        b=Y5hqjO/lmrNC9P/8abYAry0DQAyqd00qeXrPnoEYMa0bPd/PGG3peyF+TFMnxkJsPe
         rq5cKXoMl1XScr9a50Uqsew/hYei1Rjgk4lQmgquMIfvsS68HLeDBawXHCiSsxmRZD6u
         VvXBnqcExhSwuy0DAAnblTrM+1uJu7srSrhf7mj1gfeqwYll8DBTNTdUzc2DMAFAjd3j
         T2jxfNifPor/q77I7Vjl/hzhKMVlmRYtOJZ0rz13WWC54O/klEECKQ+bjELqGJ/QJWOl
         UH0/maBgUbhOjtpH5KtORwgmo9CKPayIfSLVUXy4KJRQKkVmrKjOpZWQSGfxpG8ePyXG
         Sfdg==
X-Gm-Message-State: AOAM533uDfVvVxrjuN05k5Jm/tcNnKcSoy/tmVlYUULNkK1G0oMpBCD2
        gDxpjW47HdpcjhdWPIgcgbixCtJR9ZA=
X-Google-Smtp-Source: ABdhPJy3WRO4blTBZKY5aPQ6uYkQqCt1Ti9X1sCycRCpWKEZhvUYnP9HCPGX0Y2sBu3IiRFdgLPXYw==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr11431896wrp.187.1601155976748;
        Sat, 26 Sep 2020 14:32:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm7549179wrp.47.2020.09.26.14.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:56 -0700 (PDT)
Message-Id: <3587ee5e8d119b19fb3a4ff626c092acd5bd35ef.1601155970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:47 +0000
Subject: [PATCH v2 08/10] cmake (Windows): initialize vcpkg/build dependencies
 automatically
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The idea of having CMake support in Git's source tree is to enable
contributors on Windows to start contributing with little effort. To
that end, we just added some sensible defaults that will let users open
the worktree in Visual Studio and start building.

This expects the dependencies (such as zlib) to be available already,
though. If they are not available, we expect the user to run
`compat/vcbuild/vcpkg_install.bat`.

Rather than requiring this step to be manual, detect the situation and
run it as part of the CMake configuration step.

This concludes our journey to make it as effortless as possible to start
developing Git in Visual Studio: all the developer needs to do is to
clone Git's repository, open the worktree via `File>Open>Folder...` and
wait for CMake to finish configuring.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index d21849b730..1eaeb8b8e0 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -42,6 +42,10 @@ cmake_minimum_required(VERSION 3.14)
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 if(WIN32)
 	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
+	if(NOT EXISTS ${VCPKG_DIR})
+		message("Initializinge vcpkg and building the Git's dependencies (this will take a while...)")
+		execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg_install.bat)
+	endif()
 	list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-windows")
 
 	# In the vcpkg edition, we need this to be able to link to libcurl
-- 
gitgitgadget

