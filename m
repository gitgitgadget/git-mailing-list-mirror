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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C7C4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E3F2085B
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjxxmHNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgI3P0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgI3P0b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6373C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x23so2148225wmi.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qAro7NjDp0noRnLCqwMHT6ZhXkC5gSBxmctQSbFtfaU=;
        b=AjxxmHNETSQwAuwuZUG6jWqKlYqh6HCWuUJTS4Q7Cs0mw7aZ9sleIkUKMxxeD+WjsE
         xj5oeDQ0lVdm4vlyWKYGXXY1muXugBDLgZ4GjTceV2chK8vayxDAeu3F77B8e/5UrdWc
         YLP2XS9IUuwYVPCrZ6rMlIyeWPoNU60ZsGi2eGQs51qMd6ayEenoFEwHWunl6HhYY3ma
         VJFl762Kozf8vp/o2obAAHDgn3aBpsypAwiI5OntrtmNR4o+xav1u/ppNuIHpuiVwYBH
         lC0rOYlB0BWcgdCRQB2Sqc9g2BECyZ4Tzeb/VN5OsnMy49/CutsUTnHnytfhJRzohIvq
         ASeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qAro7NjDp0noRnLCqwMHT6ZhXkC5gSBxmctQSbFtfaU=;
        b=EIaTkdxqhxIRYYGveT/W97903P7fQMncAok1Xf5WGmhlOy7hn3WcwXagkXKtd8WEDG
         eA525opmohqvsJ52Mk1mJ5bEr/8RfKzpBdS34/ZiWla0fF2ckAMKgzV2hG6ODwyXusHW
         HkpkCA6y3bLdpYEC6ZBW59Rxnmm+inXCXlGgEoJ5rWo/1+enCR5wmbCd/1Bnf3Iz0mJW
         zPgM5/ftr4vWdX2Q7n69e2QWk1mjTUEY8woYdC5glDOGEIJgDEbdytmIgrWsRx7VL9Q0
         5ZdW2+2mrlwzk4BCABr8qOq+A1Eul6DMZdlaBOQVueWfBbW8gFtD/5KBVwT61RIaHlaS
         qVgQ==
X-Gm-Message-State: AOAM533ZHWNc3NXzCWXdE/C8vxJS8pKQmpWjhbHELcH7j2RH5qrkqMJF
        deocIrSOFhYOPqsJs+VXn+ul9z26OMA=
X-Google-Smtp-Source: ABdhPJykfNAMJGqQGPFiYw7J4sIdo1HU3ocHXnvAKZGgE0X89A1sqNAGN3fj/4J4pfTD/k7wwn5Phw==
X-Received: by 2002:a1c:7e90:: with SMTP id z138mr3589404wmc.122.1601479589482;
        Wed, 30 Sep 2020 08:26:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm4297860wre.30.2020.09.30.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:29 -0700 (PDT)
Message-Id: <56cfdb2ee9de3c60baedb10496f4dc628c910a41.1601479585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:18 +0000
Subject: [PATCH v4 04/10] cmake: fall back to using `vcpkg`'s `msgfmt.exe` on
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
index 12268f61ba..02241dcc77 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -152,7 +152,11 @@ endif()
 
 find_program(MSGFMT_EXE msgfmt)
 if(NOT MSGFMT_EXE)
-	message(WARNING "Text Translations won't be build")
+	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+	if(NOT EXISTS ${MSGFMT_EXE})
+		message(WARNING "Text Translations won't be built")
+		unset(MSGFMT_EXE)
+	endif()
 endif()
 
 #Force all visual studio outputs to CMAKE_BINARY_DIR
-- 
gitgitgadget

