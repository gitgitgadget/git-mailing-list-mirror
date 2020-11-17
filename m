Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8875BC64EBC
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A82221F8
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEwgJxkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgKQQMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgKQQMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:48 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2149EC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:48 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so16518784wrt.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=esuiaVwX5BoC6K7GjUiIIYFLk9J0bjTSSdng3qhqHUc=;
        b=oEwgJxkpPlX5a4Fh/71iXG1+/8ojU/k97QPhgsWJh1DjpGK+YxO2T1hAElKsPktysL
         wurddYMIDMz4/9E84gkZSG6VMtE6jkhGmkovPE5J7ccJ54g4fz1O8yDlnG1fTymGEtPR
         vj5+GqnmCo0e0GEXBtiaJpW7n4kU2B1Y2C9lvDgn8RQp6eqK0Oz3vbnhKSCLJT+8eE8E
         5hbKnb5NNP633zreTp8b2gsVl8yp0qXTthdZCTy/6euh/G7G+YLMRogKT/3NHij7glMw
         JL8syUicv1K2jqP1oDFwPR3ImwxhFE3MrUU/yUU2dyXPJu3qNaE09J6d7v0RrBO8i2cj
         oqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=esuiaVwX5BoC6K7GjUiIIYFLk9J0bjTSSdng3qhqHUc=;
        b=fSGJp3XO+uv9DHPhX/pM3yAKH1pVqm843Vs0cMlGwORKGu1J8B6K8SNK0GB2syrOWw
         SJF/rfF0PTFGOvlcdEWqWTyhQVUwf6jlviMSwWh/hX57bOTddXgQCuGLa2APnhMztCaD
         JeDg4g3IxBD0s34fOlo/jXh25Y1CCBkuoabZCXkpNwCb+rk+BCb3AEG1Luq0/bbktp8B
         Y6v17Ie+k/zx0MvCH2rBEk8ntGiB33aZafcFVjD8hvxTeYh+hMsYTJL1ncOZjCFsI1WZ
         IU/NmQVDpLTYyjmnnhNBIULGncO2JSXSq3OVLdJxD+Ivh1armCKcZHgF5ZOFnx1lNsmf
         H0Vw==
X-Gm-Message-State: AOAM533tL+SVS9liITEM9S+fLbj5QctnRsKicgv2gdAfhI7PkCLTbI1i
        YOQrCmH2dGaBx8rKU1mR3W1FA6IdwIk=
X-Google-Smtp-Source: ABdhPJzxeVptlXmjz3hF5xdD9GE42+5bQcaz2ePb4voNwg8/dXrc84ZICsaSy4yBlYydNLC0t97iBA==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr241826wru.45.1605629566770;
        Tue, 17 Nov 2020 08:12:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm29297659wrx.9.2020.11.17.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:46 -0800 (PST)
Message-Id: <04878e2268c17bd480e2fccace780462142dd665.1605629548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:18 +0000
Subject: [PATCH v2 18/27] t64*: preemptively adjust alignment to prepare for
 `master` -> `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are in the process of renaming the default branch name to `main`,
which is two characters shorter than `master`. Therefore, some lines
need to be adjusted in t6416, t6422 and t6427 that want to align text
involving the default branch name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6416-recursive-corner-cases.sh    | 8 ++++----
 t/t6422-merge-rename-corner-cases.sh | 4 ++--
 t/t6427-diff3-conflict-markers.sh    | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 887c2195a9..dbccc3158a 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -385,7 +385,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
 		test_line_count = 2 out &&
 
 		git rev-parse >expect       \
-			master:file  B:file &&
+			master:file    B:file &&
 		git rev-parse   >actual      \
 			:1:file      :2:file &&
 		test_cmp expect actual
@@ -407,7 +407,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 		test_line_count = 2 out &&
 
 		git rev-parse >expect       \
-			master:file  B:file &&
+			master:file    B:file &&
 		git rev-parse   >actual      \
 			:1:file      :3:file &&
 		test_cmp expect actual
@@ -1553,7 +1553,7 @@ test_expect_failure 'check conflicting modes for regular file' '
 # Setup:
 #          L1---L2
 #         /  \ /  \
-#   master    X    ?
+#     master    X    ?
 #         \  / \  /
 #          R1---R2
 #
@@ -1748,7 +1748,7 @@ test_expect_success 'check nested conflicts' '
 # Setup:
 #          L1---L2---L3
 #         /  \ /  \ /  \
-#   master    X1   X2   ?
+#     master    X1   X2   ?
 #         \  / \  / \  /
 #          R1---R2---R3
 #
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 78bfaf17f0..e40a1b686f 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -1130,7 +1130,7 @@ test_conflicts_with_adds_and_renames() {
 	# Setup:
 	#          L
 	#         / \
-	#   master   ?
+	#     master   ?
 	#         \ /
 	#          R
 	#
@@ -1290,7 +1290,7 @@ test_conflicts_with_adds_and_renames add    add
 # Setup:
 #          L
 #         / \
-#   master   ?
+#     master   ?
 #         \ /
 #          R
 #
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index f4655bb358..f7620e677c 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -43,7 +43,7 @@ test_expect_success 'check no merge base' '
 # Setup:
 #          L1
 #         /  \
-#   master    ?
+#     master    ?
 #         \  /
 #          R1
 #
@@ -101,7 +101,7 @@ test_expect_success 'check unique merge base' '
 # Setup:
 #          L1---L2--L3
 #         /  \ /      \
-#   master    X1       ?
+#     master    X1       ?
 #         \  / \      /
 #          R1---R2--R3
 #
-- 
gitgitgadget

