Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D85791F516
	for <e@80x24.org>; Sun,  1 Jul 2018 04:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeGAELi (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 00:11:38 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43346 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeGAELe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 00:11:34 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so7262559oin.10
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 21:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBxKKQRhgTLyLJCRR4nKVXxC4wijombMkRiQfkHU4cc=;
        b=E616/OHPPhSXRLXrc0dyL/soBwNbNhUx9cu2RgKco8nL5MvmC0f+VWWo8SxZHPhiu1
         k4e6RsK4mq/6qInwMg8vQTrvU+EyPkGsavvupgUOAG3AEN5wI8pXEsW1Wu1k1b7uK6d2
         gSrKtOBY2iSG82YEQ2wF89jJxmlg89J5Fm/bjlt/+t+lmiBnfQmaWL4yixqGTLZ2TDUQ
         uKg4qBq23NhsZ02ah3aVmw5weY14/dWe3iEjSx5TgY/h9A7XWXh+EEWbERj7Ra46BitP
         1jepWCdYwprGiWa4ovbwFTaAd9Yzcuozn7nhE1dvmMf9BAqk/pDF46b/U2iSmxPNJDR1
         FZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBxKKQRhgTLyLJCRR4nKVXxC4wijombMkRiQfkHU4cc=;
        b=Wzy4CRsWLqBLryjEYwR03Ovlp8VUGrZcbWloH3hLeOpCnGjpJBMLYrpF/ZnUIu2OvT
         LAYrrZ4PiLWY+C4EUIfNNUkjSqgI6vlCaCdPfCgc8fG9oWv17tTrCZSQiX2/pPlEvVNr
         1wHSc3iTxhW08F/ZQB/d+NlrNRfHFP8WrE9uiMp2UJJ8Cx/fhIkyY2cHznuZm6on8aYt
         KBNFwGn0Wcb1joX9Z+7CXoZtem/Rp9YTtZbYk0V5pa0UjDWrdwh4As1M/NosNdHNr45z
         9JIgdVZzed7jeu/pMatJUzlhO3VoYbZrU34VRaIkiXysW2/NLvXPzJaQpRo7RfBonpH1
         WoNQ==
X-Gm-Message-State: APt69E1GKibueW6RWX7hM2Wj6hUEd1NR9AKAVsM0n/A4eQ7arxTtNIo5
        c6qvf0W11Gm6raxe73uuUbvTJQ==
X-Google-Smtp-Source: AAOMgpd1XRdAoGdzUmfds7esgDCrq8/si2GnJcUC9aVwQZoIvcGWhQa3+LqsWg6kb3BzI+8iOGNCyg==
X-Received: by 2002:aca:d80b:: with SMTP id p11-v6mr11135956oig.210.1530418292792;
        Sat, 30 Jun 2018 21:11:32 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id m3-v6sm6222677oif.26.2018.06.30.21.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 21:11:32 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/6] t6036: add a failed conflict detection case with submodule modify/modify
Date:   Sat, 30 Jun 2018 21:11:19 -0700
Message-Id: <20180701041122.8753-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
In-Reply-To: <20180701041122.8753-1-newren@gmail.com>
References: <20180701041122.8753-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh | 88 +++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 0ba04d46d..0c8f81331 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -938,4 +938,92 @@ test_expect_failure 'check symlink add/add' '
 	)
 '
 
+#
+# criss-cross with modify/modify on a submodule:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: simple submodule repo
+#   Commit B: update repo
+#   Commit C: update repo differently
+#   Commit D: merge B&C, resolving in favor of B
+#   Commit E: merge B&C, resolving in favor of C
+#
+# This is an obvious modify/modify conflict for the submodule 'repo'.  Can
+# git detect it?
+
+test_expect_success 'setup submodule modify/modify' '
+	test_create_repo submodule-modify-modify &&
+	(
+		cd submodule-modify-modify &&
+
+		test_create_repo submod &&
+		(
+			cd submod &&
+			touch file-A &&
+			git add file-A &&
+			git commit -m A &&
+			git tag A &&
+
+			git checkout -b B A &&
+			touch file-B &&
+			git add file-B &&
+			git commit -m B &&
+			git tag B &&
+
+			git checkout -b C A &&
+			touch file-C &&
+			git add file-C &&
+			git commit -m C &&
+			git tag C
+		) &&
+
+		git -C submod reset --hard A &&
+		git add submod &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git -C submod reset --hard B &&
+		git add submod &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git -C submod reset --hard C &&
+		git add submod &&
+		git commit -m C &&
+
+		git checkout -q B^0 &&
+		git merge -s ours -m D C^0 &&
+		git tag D &&
+
+		git checkout -q C^0 &&
+		git merge -s ours -m E B^0 &&
+		git tag E
+	)
+'
+
+test_expect_failure 'check submodule modify/modify' '
+	(
+		cd submodule-modify-modify &&
+
+		git checkout D^0 &&
+
+		test_must_fail git merge -s recursive E^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out
+	)
+'
+
 test_done
-- 
2.18.0.130.gd703bbb5d

