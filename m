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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C0AC4727D
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E4B2371F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOuLflHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgIZVdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgIZVcz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56735C0613D4
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d4so2648455wmd.5
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QPGEktvBa4u524d4A0i6OsR419ivIXg6j+KJkoHFQyE=;
        b=dOuLflHwLsiu6DrcOr7k8OHbkwCTsCarIZCGy8vpKjziQBgF78pwiH1VP4tYbjCYiZ
         YkEV+AFrZJveocbEcxWl037QOv+gv1ihV3tLRST49ATso3Xh21gUve4FmCtmR6znb/fs
         ZsuTuBs3Y0N/BVa5dYE3KS3KWq22Etu22260wfJAPdBLUi3Kr1n1Yple3VDz2Y6J4qMq
         FLatSPkQ680B9OlX6IvfjMI9HniCcsdDOUpWt12sVUt+rHNpRrJNUcJzDTMkh6L0Bcq/
         kEc2u3y4jWNOx7cGLTvagnPMIcCmltKzkRUbc33RilpuI4nm20+jGTBHN3Ed2HrJdoTN
         D7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QPGEktvBa4u524d4A0i6OsR419ivIXg6j+KJkoHFQyE=;
        b=Kyhmcfhpm64w7cXm0soMS/jKORpX1rCJMd0nGK/KRAXK3Gy+YN4BqYopGsxGiUTmwm
         uietYhQSpn51S6gy/E+HSdzo0HLcXvRtVsKkdQGrprcB/+RxGc8mjJoNemncFnhlLUiD
         6ZYKG4zytHYLJRCwnuUKuKhMYOPJD7t3zz9Hrkou7xqL3llAt5jIgc9GbR88x73/Th9z
         wT3Dm8K6r1ZJRAKhARLqfKZTluFwIfRQ3uKA/tEkvsriVC1DIzHUPgw6Xtl18RTsjl7i
         HRVCa9ovowyqqm+x4w9eUDLzp/QJBjS4OG3jhl5v/3SLd9C/y8jjpahNlqPmKtyPxbXT
         imiw==
X-Gm-Message-State: AOAM5325fBh6Pn5S0cq7jxOheK64I3xa+p00UOW+MSnwjO/pCOgCV7ZS
        02tvB9Gjr1dlx3LkPY4aqgIajZm03G4=
X-Google-Smtp-Source: ABdhPJyeHXFthb3+n1x4er3fZRDLN6zUQ2KhlDdiCWXsRh6PIqaw/x86PmENsTIywQw7PunYySKyDw==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr3976467wmd.2.1601155973997;
        Sat, 26 Sep 2020 14:32:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12sm7629741wrs.48.2020.09.26.14.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:53 -0700 (PDT)
Message-Id: <efc93f1dd972614d197b919e17693a910e568736.1601155970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:43 +0000
Subject: [PATCH v2 04/10] cmake: fall back to using `vcpkg`'s `msgfmt.exe` on
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
index 16014ac4f7..acb197fba5 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -155,7 +155,11 @@ endif()
 
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

