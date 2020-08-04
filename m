Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E14C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747BD20722
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyJSgpY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgHDAVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgHDAVD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:21:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D76C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:21:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f18so1036894wmc.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=djD/3SIoEHw+iUsL/AdbKgn+UWa7uq1S8vjdmn3IL3w=;
        b=tyJSgpY8FHNpNESJ/KkTiFDDZvRRg765Iseg2slaxqVi5HCAF4vTa1MdEBrGNo8IU1
         YXEFFWF03SJq7yseuRc08mFxfR3PDVRzuNLFmPA98L0HwQ7qkqKliK8EacEUVtIO6rf4
         02Sqjo5WF36YVnDGXREoXBMn6KuI7UtbH7PtB87b6LyGNDPIgaCIDPU8SSGfGJ+CuHCD
         A+x3ZoBpjZQuMfLYh7xOhdxkZzzEqOMPA6uANoibMSdNQznuotaZWEsxLlMZaGNHFqp4
         SZ1aBYF2XIOUGI/tBMaqw9S1QkxNU+0bqRXJjMLYuchFxvG4J0qSsJMu0ICnyLWJ3g3J
         LKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=djD/3SIoEHw+iUsL/AdbKgn+UWa7uq1S8vjdmn3IL3w=;
        b=SaCsh1c38cKfkNbFfV0fPj0IM9anDcZIsgM+QEjqay4y4am+2dLSdePrj5NVLJ20gL
         T2kbifXpQ45+H49XAzs1MWNC1mA2Q/8ptQXA1aodQii4IIeSmUfnL43kWkqVkwKIZSEI
         1i0ab6b2DRl3cVDr4DLsAKcYwjSS5Y7xgJBPIo0cgu67NK72ffrt6s+XWfCTAXpD8z3A
         tRzvgxO2QB4uNK1o/gWetwHdkks0wAcR/484GIwpHdWYlviGBoDEHsZ+VZQ6eiz+jRCf
         VylarubjOFEMLRorexq/tGyB/apWSBgTstdmcFfgEEthuX0TrSJ/fUPC9TldriEJQ6mz
         BxXw==
X-Gm-Message-State: AOAM533N26y0IB2mgvCKR6SRQ6NW8WVMLFq63qpG7tLrIg+HSIXMhMSK
        H2sfwnuRgTKObaekeT+CUDQ4Wm3F
X-Google-Smtp-Source: ABdhPJy50Ph/jS2pQjZDhAXJ+7vmWLSeEIvdDpKHR0tzKUpLsJSk4fmfztCphVCKc9EFDLSxZgJY5g==
X-Received: by 2002:a1c:286:: with SMTP id 128mr1364740wmc.37.1596500462054;
        Mon, 03 Aug 2020 17:21:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u66sm2052651wmu.37.2020.08.03.17.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:21:01 -0700 (PDT)
Message-Id: <2bd473e0aa963c6e883a6fcaf01f3137c5e6a2e8.1596500459.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
References: <pull.691.git.1596381647.gitgitgadget@gmail.com>
        <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Aug 2020 00:20:57 +0000
Subject: [PATCH v2 1/3] command-list.txt: add missing 'gitcredentials' and
 'gitremote-helpers'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The guides 'gitcredentials' and 'gitremote-helpers' do not currently
appear in command-list.txt.

'gitcredentials' was forgotten back when guides were added to
command-list.txt in 1b81d8cb19 (help: use command-list.txt for the
source of guides, 2018-05-20).

'gitremote-helpers' was moved to section 7 in 439cc74632 (docs: move
gitremote-helpers into section 7, 2019-03-25), but command-list.txt was
not updated at the time.

Add these two guides to the list of guides in 'command-list.txt', so
that they appear in the output of 'git help --guides', and capitalize
the first word of the description of 'gitcredentials', as was done in
1b81d8c (help: use command-list.txt for the source of guides,
2018-05-20) for the other guides.

While at it, add a comment in Documentation/Makefile to remind developers
to update command-list.txt if they add a new guide.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/Makefile           | 1 +
 Documentation/gitcredentials.txt | 2 +-
 command-list.txt                 | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ecd0b340b1..39f6fc8de7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -17,6 +17,7 @@ MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
 MAN1_TXT += gitweb.txt
 
+# man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 9e481aec85..758bf39ba3 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -3,7 +3,7 @@ gitcredentials(7)
 
 NAME
 ----
-gitcredentials - providing usernames and passwords to Git
+gitcredentials - Providing usernames and passwords to Git
 
 SYNOPSIS
 --------
diff --git a/command-list.txt b/command-list.txt
index 89aa60cde7..e5901f2213 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -195,6 +195,7 @@ git-write-tree                          plumbingmanipulators
 gitattributes                           guide
 gitcli                                  guide
 gitcore-tutorial                        guide
+gitcredentials                          guide
 gitcvs-migration                        guide
 gitdiffcore                             guide
 giteveryday                             guide
@@ -204,6 +205,7 @@ githooks                                guide
 gitignore                               guide
 gitmodules                              guide
 gitnamespaces                           guide
+gitremote-helpers                       guide
 gitrepository-layout                    guide
 gitrevisions                            guide
 gitsubmodules                           guide
-- 
gitgitgadget

