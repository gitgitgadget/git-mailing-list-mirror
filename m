Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3B0C2D0CB
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C1820866
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 15:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvE/Vl5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfLOPM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:12:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42834 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfLOPM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 10:12:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so4136052wro.9
        for <git@vger.kernel.org>; Sun, 15 Dec 2019 07:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B8z/WqSKv7R2bd/ewASzg3qkWmm4v4TMnbxPC+acI08=;
        b=jvE/Vl5x0Nh4l2VocvGO9DfXtm59FtIU/Z4lMptOXWLnBLK75mPzGSJ6UW9Wlvyo/a
         rNq6659cmm40cIOk7r3XlDpTh8ZHDI9RzoPwGv4zPYw+4DS2gG7tFbA5w0YraGston3E
         V2Ql/Hu2COGD/4YhpALbiO1b6R8eruWi2LBlWwSG6tlWNvQUTCoStxl4u8yijrqwERev
         tdNIaeIvvRiD/cFRheUOQiyWRpktN0wh8qS5LV9wZHmwGsCUi8MJ1/3+DwZXK2GfOzCS
         I91KlyV1ihFQGxTLtdhsUy39LSquwK5r22QRqdKtsgv2pGl/DQW8/UbV31DIV6HKJZPx
         COFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B8z/WqSKv7R2bd/ewASzg3qkWmm4v4TMnbxPC+acI08=;
        b=XBtF244LVg4r1FSa7FHLw15DCwswkw3Ykr8+3ED3zJ/FJLlOE7A/pr4p2Zrc/tiQVn
         ePS2zyavC8T/uPpgtmLTdMIjSM9AImPZeQ4OLmoNTdCcn6PSSGvRNsw/pI0K+s3xeIXk
         RlUFWCezWB84TUxDZ7Bh1SXxDfHEctSsL3Woi3vLdQ6eU2loo64zxayP5ethoraKc6co
         azDFZAvfPrSAuG6WZeYNBtoW5l1bWZQrj4J5H2oe/QVx3Hw3G1szugjTmJ2mpGtAuTn6
         DeOpSjUGAv3AMbpBdYkJFKnXHeyZDlp+xBbQsIhFPBOsrz8rCUb8SeLk1Csxt0zP0Jlp
         BGpw==
X-Gm-Message-State: APjAAAWPd98Io1VU5LuMFTtEJtQs5kIBn7bDupkROSkpKIZSa2XwZgWz
        Z5gsMr1Rx5u0YbPSaLARyYUt8HoN
X-Google-Smtp-Source: APXvYqzssgg8JqTPJB+OWWgVT7MCb+oM/VC8KIYMck0Z7jMqIE0q9wNQpVeujl9yf9iytdUkHtf1VA==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr26246091wrm.62.1576422746959;
        Sun, 15 Dec 2019 07:12:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z189sm19342898wmc.2.2019.12.15.07.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 07:12:26 -0800 (PST)
Message-Id: <318074125990be47843cfa54b4276f93edde0ec5.1576422744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.482.v2.git.1576422744.gitgitgadget@gmail.com>
References: <pull.482.git.1575517503.gitgitgadget@gmail.com>
        <pull.482.v2.git.1576422744.gitgitgadget@gmail.com>
From:   "ryenus via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 15 Dec 2019 15:12:24 +0000
Subject: [PATCH v2 1/1] fix-typo: consecutive-word duplications
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, ryenus <ryenus@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ryenus <ryenus@gmail.com>

Correct unintentional duplication(s) of words, such as "the the",
and "can can" etc.

The changes are only applied to cases where it's fixing what is clearly
wrong or prone to misunderstanding, as suggested by the reviewers.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Denton Liu <liu.denton@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ryenus <ryenus@gmail.com>
---
 Documentation/RelNotes/2.7.3.txt | 2 +-
 Makefile                         | 2 +-
 graph.c                          | 2 +-
 submodule-config.c               | 2 +-
 t/t5314-pack-cycle-detection.sh  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes/2.7.3.txt b/Documentation/RelNotes/2.7.3.txt
index 6adf038915..f618d71efd 100644
--- a/Documentation/RelNotes/2.7.3.txt
+++ b/Documentation/RelNotes/2.7.3.txt
@@ -20,7 +20,7 @@ Fixes since v2.7.2
    tests.
 
  * "git show 'HEAD:Foo[BAR]Baz'" did not interpret the argument as a
-   rev, i.e. the object named by the the pathname with wildcard
+   rev, i.e. the object named by the pathname with wildcard
    characters in a tree object.
 
  * "git rev-parse --git-common-dir" used in the worktree feature
diff --git a/Makefile b/Makefile
index b7d7374dac..42a061d3fb 100644
--- a/Makefile
+++ b/Makefile
@@ -481,7 +481,7 @@ all::
 #
 # When DEVELOPER is set, DEVOPTS can be used to control compiler
 # options.  This variable contains keywords separated by
-# whitespace. The following keywords are are recognized:
+# whitespace. The following keywords are recognized:
 #
 #    no-error:
 #
diff --git a/graph.c b/graph.c
index e3fd0ea5f8..5da111f567 100644
--- a/graph.c
+++ b/graph.c
@@ -218,7 +218,7 @@ struct git_graph {
 	int merge_layout;
 	/*
 	 * The number of columns added to the graph by the current commit. For
-	 * 2-way and octopus merges, this is is usually one less than the
+	 * 2-way and octopus merges, this is usually one less than the
 	 * number of parents:
 	 *
 	 * 		| | |			| |    \
diff --git a/submodule-config.c b/submodule-config.c
index b93482d834..85064810b2 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -626,7 +626,7 @@ static void submodule_cache_check_init(struct repository *repo)
 
 /*
  * Note: This function is private for a reason, the '.gitmodules' file should
- * not be used as as a mechanism to retrieve arbitrary configuration stored in
+ * not be used as a mechanism to retrieve arbitrary configuration stored in
  * the repository.
  *
  * Runs the provided config function on the '.gitmodules' file found in the
diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
index e525466de0..0aec8619e2 100755
--- a/t/t5314-pack-cycle-detection.sh
+++ b/t/t5314-pack-cycle-detection.sh
@@ -53,7 +53,7 @@ immediately after the lookup for "dummy".
 
 
 
-# Create a pack containing the the tree $1 and blob $1:file, with
+# Create a pack containing the tree $1 and blob $1:file, with
 # the latter stored as a delta against $2:file.
 #
 # We convince pack-objects to make the delta in the direction of our choosing
-- 
gitgitgadget
