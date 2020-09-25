Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A42C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E2C208A9
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uX2a5A25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgIYO2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgIYO2s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28780C0613D6
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v12so3524245wmh.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vyLvrpHfDqe4agokkpcNOrP/sTPDYeWnNvNcWxUJ/E0=;
        b=uX2a5A25SCKl9op7dH1CYBvaZ3kUDG6U8ZZVTWjRbU3AqJ93daX1XI4mZZoxdE99dW
         wcROQhMd/kIvTLaQ25WOsV9wLlJmBTbevAyBZX+iCK8Ro69JghNRifkLDkUkGHhy8+JG
         ec6GB/7Q4cWZ3B0H+5UqH8yh37FchqwBlAn2hov5DskbBFosvdqNeuHbbeti9pM980s/
         +AemRKCRqRZmLyQUCDvbYly9IRznScnkl8EFDgZE5rGNozln2KnNk9GcwIubHznImyaE
         oMu+jmMfrr2/wvpai+p78+Q+wMYlhkUkaWKDm+rasciJRAunzhNRGV39PjtXG82+YTOB
         vYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vyLvrpHfDqe4agokkpcNOrP/sTPDYeWnNvNcWxUJ/E0=;
        b=UovedRNxDZfx2Xs6l3MQatG4hkaGvuM2gyfOtN5RdSjyUT75XAIl/SrKtJwrxryn8c
         sykr3g3dT59hZclAvY/5oSOv5JlP8xTMpNQi4FEuXyH6oG6GuR16xgQMETdEvWz3ckJa
         l1mqgex+khHIP5mhq8GfO6rq03NNM4R+eBYkZv8vvVxcrxgIe6ZNyQZhimvon6eNbUp2
         pPZ1I+B9jWh3C3obV/IeOTeBzt0yvMFVnmLxsh2HRHpnc+Gt5QL+1AkplgQ+u9RggHD1
         4rmn8zKNYv9AGFOIn+yzj6HPt+xCrcGONsj46cuKkoogUkJwLAszG0j1pCAA2XhgHkBk
         g+6g==
X-Gm-Message-State: AOAM532ceLJ4rFCvtByC6bfZYJ0WizEsYoAkxuEsHcMqBcD4l3G8PejL
        03imkt9qOMwiLnA3iddf9r0c26Aronk=
X-Google-Smtp-Source: ABdhPJynw6xQua43LOG9WPAr3oZblB00qiC/ZINCjOWWu4F2M3+P3znwOo9v4Hm6J26B/wFvUKJJXA==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr3606460wmi.21.1601044126681;
        Fri, 25 Sep 2020 07:28:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4sm3250163wrr.26.2020.09.25.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:46 -0700 (PDT)
Message-Id: <3a07bd4916c3949eadaa10fde142fba0acaa974b.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:36 +0000
Subject: [PATCH 08/10] cmake (Windows): initialize vcpkg/build dependencies
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

