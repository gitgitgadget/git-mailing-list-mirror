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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2048BC4727C
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C9F20BED
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpc0p0/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgIYO2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgIYO2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F7C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y15so3538914wmi.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eZubIZIwUMiFrmcNwqR+VL9ixmOdNHlOZovIEYzMITo=;
        b=jpc0p0/P4eJd6b7bbI3Uzrekq0K4BfM2RqiUH0JgQJWyyHStzwpuDzt780wYmKGyOH
         7Gzgm8JSgSr0j51h0WCXKXHRXtGCXDROwJrcYSiLbjl+NWFeC+xIrkUnEGg11ZnwOdta
         6/JJz8+cx2uO34gIifZAvx0sOK0pUk+r6895jgj+S8gXqGd2fC1wBdm4yZh/JTHKTcJg
         5YsP6OFVYocIBEE2bnv51f0dOXNL2vm/uhHot39xaFn1WC+XbEsVRkEQXkQKJaw++YBV
         1gyuAaZ22ffIysNAX479U7REupXktgQF4uBI13Xiig63iTsV7b5d+rOpZ7FSvuofLOj1
         rNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eZubIZIwUMiFrmcNwqR+VL9ixmOdNHlOZovIEYzMITo=;
        b=QCVDs7U3VeQSjjYw5KCOEUH4wskJzJRREKodJMsEC6/mNtCQnUa1puhj25nTAzrS3I
         HLhvmmUHImQBPTPUkXopy1dG4Z9AawgzSbCQh6uZawmpwAEfNp9keDwOCDZFcuM7bocQ
         QxkKA7KogkTneqjTLTxaZ79mg+rEbYqf2cNHZt4wCSA6CBNLv3F3PMr9zofuU94AgmC1
         KREPU6AWmGdiywnp8TnChnDJsu6g7gl7z1/ERPNbPC2SC4fsXxep6u3C96676/Hwgo6c
         G/XxiwWs4NYUEY6Pd3Z1XCrd4DXBfjZEERVBGjFtfsLRifa9woaJNhwFBN3qu8alt8CI
         ENpg==
X-Gm-Message-State: AOAM531nLC8dXK8cDbx5T6i6LNhxab4RNsxYNtFp8fdjTFod612TZZbB
        8Fi4fQyrJNEseLBoZtqrV6wc6f2WplY=
X-Google-Smtp-Source: ABdhPJwlPIyCZ8gxvY9N6djybhOyCqtJgSzEcdOwAk7L33uVDev4bMs5hXbCYNy2XLb/NXZiBn05Ag==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr3296154wmi.163.1601044122654;
        Fri, 25 Sep 2020 07:28:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm571280wrm.6.2020.09.25.07.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:42 -0700 (PDT)
Message-Id: <5967822a0c69b9f822d3a4f6412c626c4a43cc35.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:31 +0000
Subject: [PATCH 03/10] cmake: ensure that the `vcpkg` packages are found on
 Windows
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

On Windows, we use the `vcpkg` project to manage the dependencies, via
`compat/vcbuild/`. Let's make sure that these dependencies are found by
default.

This is needed because we are about to recommend loading the Git
worktree as a folder into Visual Studio, relying on the automatic CMake
support (which would make it relatively cumbersome to adjust the search
path used by CMake manually).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index d14fa4f3dc..16014ac4f7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -40,6 +40,13 @@ cmake_minimum_required(VERSION 3.14)
 
 #set the source directory to root of git
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
+if(WIN32)
+	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
+	list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-windows")
+
+	# In the vcpkg edition, we need this to be able to link to libcurl
+	set(CURL_NO_CURL_CMAKE ON)
+endif()
 
 find_program(SH_EXE sh)
 if(NOT SH_EXE)
-- 
gitgitgadget

