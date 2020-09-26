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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14D2C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB68023719
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLJUb7I7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIZVdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgIZVc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC5C0613D6
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so2844132wmm.2
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bRp5s+30vZ/dwGxaU1pFoSCDKRfHr+eKVN9HMmOsOR8=;
        b=fLJUb7I7012sW2cIXZQC95PgRk8TspJxQ1rYCBwlAKclRHLGb1n2lIvbZg60U4oRk7
         5zUeIKzMs1eDzoxJudcuT5auzKVHnaKLjnNzZX+aZJlC/aofxjBFYJS/erPJPcBrh8Af
         Z+bSiRVE8udMhGoIySHd9MXKDKd+0Vh8SrwR3eiwLrmeP1GzAgv3AWf5oALKsSHojB1v
         NngKM/78Qt9nNOvOfNoE/78/nRR6NYMYeLo95LPS3tq1VKgVwkcH6QZ/La5aDr5coDum
         glnblXgkOxiDEoWgJ0GhW367RXqKnsD/ZJOeT7FNkifgjEynlpl0k2JK2R5vSK2A2knA
         JUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bRp5s+30vZ/dwGxaU1pFoSCDKRfHr+eKVN9HMmOsOR8=;
        b=er/SeNTX1zRgp6lPjXgaBXs14LcoWM44ASLdLlm63ms6Vna9NbjccJtoHE3cWnT/oA
         AEIm8glJT6Jl25mxrfk4hfBBgVIrqRBfaFepjcLUOlHinVYowMk2ZTbGPvSWdNMzvlh5
         DTL7oJoOS/E8Up5Sgtec1KL8fsSUuaOpNm4+6kZxNZO2zlxGFYE19lWcTpa2uI9109tU
         3/l6nzhZtv+B2hFqK2patpPuKp8LsJztKi1s3uJCU3/AOIF3In7O0BoD3fzceFF9GYkS
         NlbD8+NEGgqYJJ7MtiIzzNgWO9OBenc6vc6Ud0C6sOKtHlAg7hos2H5CqUnMqIjW0NCu
         TRRA==
X-Gm-Message-State: AOAM530jm0IraAd5UMVo6p9qOdDO/otxTwfaGq4eicZRtnAZg+Xv6wpl
        e23ADREySNY7yhLoVYhq0MOSIDRDA5g=
X-Google-Smtp-Source: ABdhPJzeQ0s7KZtLfj1Z5UOxgUthtUndcEFjjnFHK+NWoCSmwM4TW6u0uq3rrbm3+YX5iOC9N8suJA==
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr4127853wmb.138.1601155975360;
        Sat, 26 Sep 2020 14:32:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm7670850wrl.42.2020.09.26.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:54 -0700 (PDT)
Message-Id: <88abbd9a788091f869ae297f33e0fa5a6ea535a8.1601155970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:45 +0000
Subject: [PATCH v2 06/10] cmake (Windows): let the `.dll` files be found when
 running the tests
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

Contrary to Unix-ish platforms, the dependencies' shared libraries are
not usually found in one central place. In our case, since we use
`vcpkg`, they are to be found inside the `compat/vcbuild/vcpkg/` tree.

Let's make sure that they are in the search path when running the tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index e66ae137c2..5a4e0ccb01 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -942,6 +942,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
+if(WIN32)
+	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
+endif()
 
 #Make the tests work when building out of the source tree
 get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
-- 
gitgitgadget

