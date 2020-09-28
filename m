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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C056EC4727C
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AAB208FE
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwY7J5YD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgI1VJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgI1VJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6137C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d4so2476097wmd.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xfo38AuyHcLNa8/91Ulhsub9WGaHfYjdgMuwmOZ1tG0=;
        b=BwY7J5YDU+DIjrHHFNlw985x5/CNcfDtxqi2yF94SYVgFVIYxtGuqNGjv3jdn9n9Dv
         q72HiJhPeFs8QrtRZqfZm07XbJ8KhgyCYY54coZ2sxvsgmBj9xafvIblb4zZjLypkQ7X
         a0PMB2Cnad2TBuQ0gdAus24I3jXIYJvQhS93Ww869pwIzIEJNXMkpsCT0ZEqRCrmCimG
         dQekcW9AsNplI/uZ2B7a7ZoBUW6aX6fzXusHFLC+G9q9kQrC2LukMlDpvkw7XiODt7UV
         vrlpbiuijbV2Gop3CR8N7RM17uLXMkuiv14AQMIV+lrDUcblRmsqCkgJZFo6hx4PUzBd
         lHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xfo38AuyHcLNa8/91Ulhsub9WGaHfYjdgMuwmOZ1tG0=;
        b=Kbh7CjZuCrgxHwvVWTMVsKS0GLt1sNqfSO7p9MeNRgDt4imXt00OnjkPhuLYwAGuyo
         0D3H+DqWn3FLukwf4Nv16gNPH8hYFDyTi7IV+DaLzyBzVr7wXUETfp5jeRjtR0icdSHO
         1q9WrKKJYJNRhMb4NHH+jkqjJaIHOJKBisiTTQwRBuNjBy4/SKBPArl2vsBE0h4lwdQy
         UIuNx+f1pa/7ZpZ+cfuQkOnRn7umoHIs4zIJ8OMzY3nLKqKu3FJjKnHlZ84iqqJI/QYe
         7lPsUJkfpkhkkv1mXBlpiLVgafsmfI0NUyGLMvs11nXTgs9NrX7/B2fyf22P0d1gQf4H
         YVow==
X-Gm-Message-State: AOAM532zN07qksrBDZBhwBI9grC6/thvq7yc4GBJhQ11EPybuWBwvzL1
        fh4CuCKkX8cbcXMOUmbqTPbQE83iURw=
X-Google-Smtp-Source: ABdhPJyLvTWkSeBqQXu1wGYs8wqdGdHc6MBR8OY8+AIhusNwuYWhF6T/S8Cl/xG1bnRosjwpnwmFQg==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr1037337wmf.70.1601327366030;
        Mon, 28 Sep 2020 14:09:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 63sm3510441wrc.63.2020.09.28.14.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:25 -0700 (PDT)
Message-Id: <f61c3ef44228cd4a8dd85c4b9fda803f6a099ae5.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:11 +0000
Subject: [PATCH v3 06/11] cmake (Windows): let the `.dll` files be found when
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
        =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
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
index 1999db0c6b..361fe3de6d 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -939,6 +939,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
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

