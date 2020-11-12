Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD32C2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1DE422227
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib70ivD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgKLWok (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgKLWoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:16 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BECDC0613D4
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:16 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k2so7718990wrx.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=esuiaVwX5BoC6K7GjUiIIYFLk9J0bjTSSdng3qhqHUc=;
        b=ib70ivD859BPRFabJbtNvbWDiX5qFynHrN4BNtkVpODqfvGRsg3gdx+O1sFOQOgE6v
         O2kw5BqB/wTles/4iJ5qYGBpCJxaFwHg/isLTRqH98Wd7AbUyxVnd6KZVWo2pslzPe5V
         AG4tDSToJI4xWlNoOAbYI0c+eNnFXt7QNgv7wJ15lT+VulLfDvja2IsW+LtqqT1oPx8/
         Wl3Y9/cPotEpsydRwHlv2N4LK100yFVzo281AOIE+5FIl0IMssRnKQJtAFDJLWES4DCX
         0qsK7cWCWIklAeFC8KKhdvlrNLqg+lOngR60a7Q0udynmOEwgGJb12pT7NBEo6Hfy3fV
         Hm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=esuiaVwX5BoC6K7GjUiIIYFLk9J0bjTSSdng3qhqHUc=;
        b=hNn2AqeDR9D2ek5unPAIfbY8sevk2EH0tn1ma5hesbHxas886OM7fW6N9h9vWihbB2
         VNVVK6tQTUza87RwK8i/q7rpXC2oV6rUllvspkpTFzETPc1afhnlNPWDpP9BeOgpqI1w
         jjlNnpPGkHJo2QsFq6TyYWiI9vKwnJR2lTPRHuct9OtLSbpoM3yy0FIXs0WPqExKRI+F
         Wequ3WoZ5k7gvL/yDmtlHXUNZClyCxx3WtzJJvp+05YKy1g7S0KNi8dy+LgbCiGWR3TF
         FE7caJZJ+xGjoVBBgcJpRHkyBp+ZGA72iEoQ0KNbKRmTWyLcJf3TCD193yDW0XkdmOKE
         NSCg==
X-Gm-Message-State: AOAM530FKv2+ThJhKljWdp7eHzvD6YmDIfKmHwfL7nvIJN4/naznJ8GP
        klfcwaO0wo5jay+x3tUmqm39IUb4/MI=
X-Google-Smtp-Source: ABdhPJyfb+5ovtJcuc85EK6SrOzy5zCK6qPCCo2UiH9zaADH7SDiQ4OqEs9bDQ21IU/agdOFbEXvQw==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr2205573wrm.81.1605221055160;
        Thu, 12 Nov 2020 14:44:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12sm8974974wmc.45.2020.11.12.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:14 -0800 (PST)
Message-Id: <e2f140939928835d8941efffbd68929ad9ce82e8.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:48 +0000
Subject: [PATCH 18/28] t64*: preemptively adjust alignment to prepare for
 `master` -> `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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

