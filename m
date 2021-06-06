Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26213C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB51613DF
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 12:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFFMFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 08:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFMFE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 08:05:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7F8C061766
        for <git@vger.kernel.org>; Sun,  6 Jun 2021 05:02:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a20so14218957wrc.0
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HEi8+rxOPBghb+AsSj6zyh+caMylWWOo5i+0EQ+VefQ=;
        b=dCrm2iKSc0YGOytH6y5i2b1UASVLv5ugaFNlCshsAHL9dRaUuPinz2zuup4921TX3p
         OP5YOUWeJC0+xrwXuCAlXzng+pRF4rHH3HNSzGRDo76HQazNZ+2BsJ3ga0QLoblMNVNu
         7IJJK+/aMFK2n80WiglLDn5viB4w/1Hh3CUyQ0QzCBGd1qcbec7PfwB7R02XNoOYqe6y
         2rWkk0kJBCe4nU5ySgviUP0wrh2dqyRP0l/v/Q6kjnPWD9lbsPewmEyjZPPvtJCzDP9h
         JpszgvlrrLuRSuVdW2aH9CM7TwUVlmowP0LF5thYyfVSr53YLMBzLbHIZTjCGE6jLo1m
         fqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HEi8+rxOPBghb+AsSj6zyh+caMylWWOo5i+0EQ+VefQ=;
        b=ahsvfv7hvRGrwkSsx+5rW/qyHsifkcVwIwh5HHToSRv73Z3DTEqA5LELubamDLv2tX
         sVpdVOYHEvBMscOg46mQ9SEbAhbz/nBWew137tV391c7mwx5qfc+HUjQb3Hw27snmf3i
         CoZeilcRwdUgROGEQHxFdnBj8AdbUKcU3H8Q9PQO+CR4ytXxeI7J+U6DF4AMSo7TcOv8
         deNmEuyemt3dHAk2Bs9gdvZhdEYm28YUAJxhCYIfvSSjPex/Q+CxTgWUVypL6EIsAzdk
         3NuysbSxjsbQhGh7STId7FtiJQt7V/+1pT1irJXVU+ocwx0hsn8bfGuq+UL/mJFkuooM
         beNg==
X-Gm-Message-State: AOAM532IBocpY5Z3yN0hy1FVL5w2SwfHsoHzQwE0j7O74OFxKjBds8vW
        FBBMFH+mDJ67AAVEBXDDBJvkTYDg2DU=
X-Google-Smtp-Source: ABdhPJzMmpzB4fcSMejxXMF0HFbAl4pjfYn7qRyOgfQOdoXqmdoYwK+pgRCj63jgFZvZ+qlggee07g==
X-Received: by 2002:a05:6000:10cc:: with SMTP id b12mr12482460wrx.54.1622980977207;
        Sun, 06 Jun 2021 05:02:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm12515139wrv.39.2021.06.06.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 05:02:56 -0700 (PDT)
Message-Id: <a3b5eef5418861ee5c008aef0cdab3448b8fc5d9.1622980974.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
        <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Jun 2021 12:02:53 +0000
Subject: [PATCH v2 2/3] cmake: create compile_commands.json by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

Some users have expressed interest in a more "batteries included" way of
building via CMake[1], and a big part of that is providing easier access
to tooling external tools.

A straightforward way to accomplish this is to make it as simple as
possible is to enable the generation of the compile_commands.json file,
which is supported by many tools such as: clang-tidy, clang-format,
sourcetrail, etc.

This does come with a small run-time overhead during the configuration
step (~6 seconds on my machine):

    Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=TRUE

    real    1m9.840s
    user    0m0.031s
    sys     0m0.031s

    Time to configure with CMAKE_EXPORT_COMPILE_COMMANDS=FALSE

    real    1m3.195s
    user    0m0.015s
    sys     0m0.015s

This seems like a small enough price to pay to make the project more
accessible to newer users.  Additionally there are other large projects
like llvm [2] which has had this enabled by default for >6 years at the
time of this writing, and no real negative consequences that I can find
with my search-skills.

NOTE: That the compile_commands.json is currently produced only when
using the Ninja and Makefile generators.  See The CMake documentation[3]
for more info.

1: https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKMRgi_oZAWw@mail.gmail.com/
2: https://github.com/llvm/llvm-project/commit/2c5712051b31b316a9fc972f692579bd8efa6e67
3: https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index be6d9659c387..399a3cd6c071 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -57,6 +57,10 @@ if(NOT WIN32)
 	set(USE_VCPKG OFF CACHE BOOL FORCE)
 endif()
 
+if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
+	set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
+endif()
+
 if(USE_VCPKG)
 	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
 	if(NOT EXISTS ${VCPKG_DIR})
-- 
gitgitgadget

