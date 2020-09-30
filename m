Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB00C47427
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB720759
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe0PdGkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgI3P0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbgI3P0e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB26C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k10so2276977wru.6
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Y7JiewA7VkJhtRHwveP6+buQvtiiaFjlssilvtT8Wk=;
        b=Oe0PdGkQcfv6ca2l2YGmD72E5GgUNHnhvNkxuPU5nKaxhlIbxxB8JjYwXC9ro8MR1i
         2KIpdiexSSo63/d0jnefCWuEPRfKG3QhpusxO4ZN6cJFsyXiH3Tze/OX2Qe/Rv1YVPM2
         3ge5jsizwU2COy6VFzyLooy0n3e0YfmeY5jNXx+zIzyLdv+UTbq+dLc3Mwewf+DwUiWG
         sUT47Tb6fKKqdEi0vCx8fb9cNnjZlFxNfiCjUxMTWJ/xHryFbDvhjed4qQrWMfYvw7an
         qmLiXJknaYwVBU4FXmZ5OKVahdwgf/xZNk+JmlJcLPeAgHmREcz+W6/V46K78uL4AWnn
         L3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Y7JiewA7VkJhtRHwveP6+buQvtiiaFjlssilvtT8Wk=;
        b=rK2RHNKDSA8xhTZr0F79v9B5kSMXkdDOfuqQ3mcju63kvOT/EGQZnjdRvXtsBXdU7r
         iEK8LrFey4lp0QDuXVQJGgU/N/x3BdcCkqEoeOpm6ALYDzUbbPWaScFLi5QcNxJ2N9OW
         ooBjr1qYIAURdSSe6+pqsn/YRDwuqKRdRJA9ZctSrLNayr+f7vlZyDNP/EkJoVL5kOAF
         aQgSqiQo4JkYhhvmhNcnLrerE2aRnUrixX8dPYVxvxvqCnwM2qRwc+HPtvj3cksZmBIH
         vlg3i2XfIatleVRalfA0ESmge69JNI+tRml+8zXHQs60+NrCN8zbvA7R7MPngwVGWh22
         gaiw==
X-Gm-Message-State: AOAM533HernqPdPTP0T0XkrhbeEkhuHAD7f+cI7bTKEESeP5p+otIMuD
        bxZaePJINXWrj/0umuD5KGGaY+FHcbs=
X-Google-Smtp-Source: ABdhPJwEr41t+EtEmQ8b5fV0o9C1Km77s1GMamEZ5g0M9hm/w+jmJyAz8GUvED+LPJluQDDLLE1mBw==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr3871377wrv.156.1601479592503;
        Wed, 30 Sep 2020 08:26:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm3264385wmb.30.2020.09.30.08.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:32 -0700 (PDT)
Message-Id: <14ddfc17815d68f2f32aebbc4b0ecb3ce6f25dc1.1601479585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:22 +0000
Subject: [PATCH v4 08/10] cmake (Windows): initialize vcpkg/build dependencies
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
        =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
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

Note that this obviously only applies to the scenario when we want to
compile in Visual Studio (i.e. with MS Visual C), not with GCC.
Therefore, we guard this new code block behind the `MSVC` conditional.

This concludes our journey to make it as effortless as possible to start
developing Git in Visual Studio: all the developer needs to do is to
clone Git's repository, open the worktree via `File>Open>Folder...` and
wait for CMake to finish configuring.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

squash! cmake (Windows): initialize vcpkg/build dependencies automatically

MSVC
---
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 78b90abe5e..ebadae2271 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -42,6 +42,10 @@ cmake_minimum_required(VERSION 3.14)
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 if(WIN32)
 	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
+	if(MSVC AND NOT EXISTS ${VCPKG_DIR})
+		message("Initializing vcpkg and building the Git's dependencies (this will take a while...)")
+		execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg_install.bat)
+	endif()
 	list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-windows")
 
 	# In the vcpkg edition, we need this to be able to link to libcurl
-- 
gitgitgadget

