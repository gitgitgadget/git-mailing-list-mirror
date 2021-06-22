Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F0EC4743C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763BF611C1
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFVA3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFVA3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 20:29:36 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C67C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso19558478otu.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v7a5aerGceyi/ZsHtZCAwJjuIr81Nv0H/XOrOc//1EA=;
        b=broq1G3LHFPghWtcyvmC0eiV/d78xTHb1kt10M/uciQfc3EmZcqhCBXs1HpxmtQ9F2
         pD5AtBnL+UVY7HoeIltKq3K+7LINMM54OdRV54f+MF6bfqlU2qnusgMP/FWoMPIm7doV
         DSn7B6YTbaBzC9T5bZ0j/nZOxniGdhiDEQEXo5Aok84p+JJNv/LUWMNHH+jgey72Rhom
         vWtoUxhCVUlDX5G0mtRZjPyCD5ksfQZ+Tn886RHB0C0EKsNgw/SKwMnAn3QVDRKCMful
         gW+TCudrmsRL7Ea32JYLXQx9g711Tyga3p5iSb73bLILLYlhV+6ZMV5HgktJL+etUpyO
         vqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7a5aerGceyi/ZsHtZCAwJjuIr81Nv0H/XOrOc//1EA=;
        b=jq4JIKq8g8emDaRYxqjAu4DZqPSjVG2EZJBt8aY/VeGKOrn6lDo4L1tkXvugAxhOly
         oNAfo3kMzE1TXQx24n3Fzz98L7K5uxbqi08CDss9yXK5JOrXPUdjb8Q3fJzNHBCJNTRa
         kj23xL3MhHbE8WCb1kLBEzq2dvTXbGOBA5RSWJehNRAvXWmrHgg94SYSNBUBaGZ9FzbR
         o7UZtYAeEWIfK/9s65yxdt6dKuJ9j65HqSwWpBej+tfWA3p2d/VOj23NKu7T0DV7/Vgp
         krjR7mX4eoK4NdDo2yx2wzBc+GE0zKjwV/KnYZFKKbup8Pp18dwW5Id6GbiRWW45xUUt
         iPdA==
X-Gm-Message-State: AOAM5303hL3ubTDbJNy2kjqMGmNzA9s1yJy48xx1O9eTzFwMgy9m3dY0
        18oozvucUWCpCMRDDZA18NrRHsQZGsOD5g==
X-Google-Smtp-Source: ABdhPJyNU30D77NCeHtFkFZFlCG8YF4reae7bLmoW4cLEX0KBsjWzBFjgNAGG4WmRU+Y5rUxEq7LzQ==
X-Received: by 2002:a9d:5381:: with SMTP id w1mr630328otg.259.1624321639981;
        Mon, 21 Jun 2021 17:27:19 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w5sm1590974oiv.7.2021.06.21.17.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:27:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/4] notes: fix merge.conflictstyle handling
Date:   Mon, 21 Jun 2021 19:27:13 -0500
Message-Id: <20210622002714.1720891-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622002714.1720891-1-felipe.contreras@gmail.com>
References: <20210622002714.1720891-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently it's completely ignored.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/notes.c                    |  3 ++-
 t/t6440-config-conflict-markers.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 74bba39ca8..a333cc68ec 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -23,6 +23,7 @@
 #include "notes-merge.h"
 #include "notes-utils.h"
 #include "worktree.h"
+#include "xdiff-interface.h"
 
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
@@ -1000,7 +1001,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_xmerge_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index cb2ee3ad0a..c51512ced6 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -55,4 +55,31 @@ test_expect_success 'merge-tree' '
 	)
 '
 
+test_expect_success 'notes' '
+	test_create_repo notes &&
+	(
+		test_commit initial &&
+
+		git -c core.notesRef=refs/notes/b notes add -m b initial &&
+
+		git update-ref refs/notes/r refs/notes/b &&
+		git -c core.notesRef=refs/notes/r notes add -f -m r initial &&
+
+		git update-ref refs/notes/l refs/notes/b &&
+		git config core.notesRef refs/notes/l &&
+		git notes add -f -m l initial &&
+
+		test_must_fail git notes merge r &&
+		! grep "^|||||||" .git/NOTES_MERGE_WORKTREE/* &&
+
+		git notes merge --abort &&
+		test_must_fail git -c merge.conflictstyle=diff3 notes merge r &&
+		grep "^|||||||" .git/NOTES_MERGE_WORKTREE/* &&
+
+		git notes merge --abort &&
+		test_must_fail git -c merge.conflictstyle=merge notes merge r &&
+		! grep "^|||||||" .git/NOTES_MERGE_WORKTREE/*
+	)
+'
+
 test_done
-- 
2.32.0

