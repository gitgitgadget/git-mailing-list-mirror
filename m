Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF71C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADB4208FE
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFZ+/In0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgI1VJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgI1VJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308DBC0613CF
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so2487146wme.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vcskzXK9EhFcrWXUKoLHVMIaYwYhGcUQ60l9JuhR1gY=;
        b=VFZ+/In081xd0Xy13K7OLHxE0F77WfZ6r4QX+tTDNWdnRBIItSv2oAe7v483TQyGn4
         G8FWTBMukZhWONml1t9YbVf1mwP3m0jEp8ygFgK7TqJ9aYQzyKPvKFI2St5Yp9McFFTV
         QbMc29CcadNeLjHJMvLR5vY14ghe5P1T8DLgLXAZu2GHukh9QCG6ttfmMqjPhfnJcOd8
         BRPzkL/T3RTGzXaacpxuwB8srbrCL6jn9Lww1n6mhl1RhZEikJ1Xg3u0R3/97w0cQuez
         /QMAFdiXbv+nWEi42T8fckywxV5CiiavzVJXWRAVM7ZvlvExkZdzv3aRPeiGy/YniTlL
         LDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vcskzXK9EhFcrWXUKoLHVMIaYwYhGcUQ60l9JuhR1gY=;
        b=DI/fvKtMwKEgRHPGBEpXaDHaW4mf/bflWLSfJ2GC+KB/A4W+rQFqkmWVissHbH7eMK
         1YpW+bCmfy0Oc4iuerZTJLU31v8HKetiYohVnJebCpfTnFN6egYSXqDV03bipsHQxdm4
         qJ6+ipKzBkkMUAAIQgKdaW5lHmKxRYtzVvgQMYT+WD+lu1axof36BScEoNzF5vHSB+/N
         dsOySZ0WCbtbzPKLuvAmgUTEaOEYbdaIRbKGyHicw4RVvGGJBeoZKe+3gq6PH5LgVq9A
         YWM+AipHEdQtImvlM3rdBpHZN3xfRAaZUWlVmvKeAvP/XNNmB+xiENgA1ql/aLYierlP
         8TIw==
X-Gm-Message-State: AOAM532MRLyhEgolokxoBzycj4xh5HFlQSBZ0kiwMYQlOrB5pgeRiHjH
        7nEfd1TR+xNjvD9LDUhpqN3HnrgK//Y=
X-Google-Smtp-Source: ABdhPJxdYOTWYuCeCSF3SThWbNafBiawGwaU1+UlG0Gcdp/Y9cWAWEPhuk5n3Ptsw21MBCglKpmmFw==
X-Received: by 2002:a1c:dd87:: with SMTP id u129mr1007304wmg.172.1601327362620;
        Mon, 28 Sep 2020 14:09:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d20sm1751088wmd.45.2020.09.28.14.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:22 -0700 (PDT)
Message-Id: <a49b28e001ffaf73d290a6c75943ff7650f87eda.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:08 +0000
Subject: [PATCH v3 03/11] cmake: ensure that the `vcpkg` packages are found on
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
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
index 1847a6fd58..12268f61ba 100644
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
 
 find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin")
 if(NOT SH_EXE)
-- 
gitgitgadget

