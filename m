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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477EBC47420
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9918208FE
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6SiC/xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgI1VJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1VJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F686C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e2so2559832wme.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SbWyixT4xQU5T8fvNxqPN5QRWcIo+QSrGmmPklZctcI=;
        b=q6SiC/xEhtT8HthTOnKXsNh2B52igc+DSrHR2ahvc5CHzeWX+l0KRbwUn0/vlwMBJI
         O1//vifMHb5eZzAwyqQ0luEmrzJRQoZeawqEolYylF88rm+EVZtKf50zhDubzDpyvKtw
         0mgtztb5quN3V5zF/RDTEBGASAggIvqyd/x/qSlaFUHGDHq/oxl77wVEs1BxLTWN2YPl
         5ee8jl3ejivmAkZ3K9n6dKZ7mOteTGF/6q9fVBckEBdIZQFrIilO/Yo7lAJl4wdKs5ui
         LDBM+9LiQcVIwnL/XUJZBoMO3ILskN0r5cMGIbGMxVPyH2mHDMS2V6t1Go4RvIdft49N
         Fo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SbWyixT4xQU5T8fvNxqPN5QRWcIo+QSrGmmPklZctcI=;
        b=G+xdoNjzcz6ypQ5/yXZZ6vh3pSaB6ggHlttTd0aDdQgtVsb+APcUJYPJjBz84l5SbP
         tesrqGWwTDu3E3zBSMcflDyvAV7iM6ptCq2xS94Tz/EuR85FW3hJ+qY7KrE333wHBPsK
         9yqVREz08yrVO/KaFtGxwwHObK73bf2PTQUHSjzNfmBzMy9x50ozJTnpIXjZ6DvxCa+o
         YPV4D9DMQfE5qSlEHA7LkSHLjz8elhPxy825f6aGd2mo6DcfH72nUjnH01ELx9N4vlVx
         JbKZlMF5pFaxLlHmzXo4GDdps8KyVTbz+wRoWTXFafCEasM2RYPSUp84sOIpctKVPlBj
         VjFw==
X-Gm-Message-State: AOAM5319PKg21gk2ny68ScaD0tpYNzTQ8bkIOkLqAjhoOB0AM5QECLZP
        odVdOl70MjSIuhzuYfjBW8A+5z8okMo=
X-Google-Smtp-Source: ABdhPJyqJrLNYJW1UuFVLEFKIp635HSHcpjCgrbGkLrvw1VC2dpBMO2ripGP3xa0za+9MqOhrAP8tg==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr1060662wmi.53.1601327363811;
        Mon, 28 Sep 2020 14:09:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm3030204wrx.82.2020.09.28.14.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:23 -0700 (PDT)
Message-Id: <f1baf0f9740ccce202e6eb8b631c5cf9c6127817.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:09 +0000
Subject: [PATCH v3 04/11] cmake: fall back to using `vcpkg`'s `msgfmt.exe` on
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

We are already relying on `vcpkg` to manage our dependencies, including
`libiconv`. Let's also use the `msgfmt.exe` from there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 12268f61ba..683cf38263 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -152,7 +152,11 @@ endif()
 
 find_program(MSGFMT_EXE msgfmt)
 if(NOT MSGFMT_EXE)
-	message(WARNING "Text Translations won't be build")
+	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+	if(NOT EXISTS ${MSGFMT_EXE})
+		message(WARNING "Text Translations won't be build")
+		unset(MSGFMT_EXE)
+	endif()
 endif()
 
 #Force all visual studio outputs to CMAKE_BINARY_DIR
-- 
gitgitgadget

