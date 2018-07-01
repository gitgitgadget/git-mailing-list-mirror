Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE181F516
	for <e@80x24.org>; Sun,  1 Jul 2018 04:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeGAELj (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 00:11:39 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42342 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeGAELf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 00:11:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id n84-v6so11881300oib.9
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 21:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uHzVdaZ2sDF+k4HCk+t/kxy6ePh2pZerF/7RARK9fxw=;
        b=p7CCPI6ARmvx5tDqroFX5FOsLDf5YF0sImx4EZcVMqtC8RyeBjiEzp3I40NgbN84dK
         /R/XGvyscjJhHnk+uZVlhK0R0cvUqQ9d+MZQYSJ5zFNdMxlerikCCjgpZ/DQL2Lr9QFm
         uT0GSYYkppdZP9723HXgVey5IZWrjbcHNgT728et3Lqqbhiz1iP2oTHFc4JWnBgA5/70
         GDi7bB6Es3GOy1yVb8aWxKbdKLEWkAaxWF37jlLaos3MAxB7HgZPka1KOR2+eGTeOl30
         zBwQBCVbZTuPGW5ClZBYAb1LM9hCAdJUPaoUHmOtlEbgB9Z7XLbJqPRT3XPSyTtkNcvy
         gmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uHzVdaZ2sDF+k4HCk+t/kxy6ePh2pZerF/7RARK9fxw=;
        b=W7Gk3Hq6Qf9aa0NzJGkZ7fDktLdHpKBd+rNqWzh4b1OtOOPKtWYTEISlsL1YRhaQgc
         oOUxMjv1MRudlcE0/mS8b8y+/k/L9tY2Q6LHAasHvFCdUB6AmYzSm18wbzy3gmC1ZWQy
         5k16n/UPAR2t0W2DZf0hyJsm5oZYY9yzdA4v6CnwwUYFTz190KCnC0eosg8UjGs5M7hC
         9scr4KygTPx10rIK/hpvLHRKC6YrO+grC+ivTsAvZU1LfQEqskVMHGcOSnVw5lXakG/6
         8B9IOMOaLZmpQ8SNZkcBbIQ1e1JVo51FgtDIadFhv2Wf0gblGeywXk3Wi2KbELSUCLMu
         9iOg==
X-Gm-Message-State: APt69E1H5PpbfsYcQcpy2arm4d1SZmYGFp+Ch7SQtkEcxH2TB5TpBml2
        d9XLgSkSR6lCBYF7IP/BwSmHcw==
X-Google-Smtp-Source: AAOMgpeBTleumfwR4wi7tMhAaYtQdp/ufwUMWxg10CdT//oEMBEQzMCmQYonekZtZJKy3aYIPRduPw==
X-Received: by 2002:aca:f356:: with SMTP id r83-v6mr11158672oih.257.1530418294580;
        Sat, 30 Jun 2018 21:11:34 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id m3-v6sm6222677oif.26.2018.06.30.21.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 21:11:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/6] t6036: add a failed conflict detection case with submodule add/add
Date:   Sat, 30 Jun 2018 21:11:20 -0700
Message-Id: <20180701041122.8753-5-newren@gmail.com>
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
index 0c8f81331..e920c7505 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1026,4 +1026,92 @@ test_expect_failure 'check submodule modify/modify' '
 	)
 '
 
+#
+# criss-cross with add/add on a submodule:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: nothing of note
+#   Commit B: introduce submodule repo
+#   Commit C: introduce submodule repo at different commit
+#   Commit D: merge B&C, resolving in favor of B
+#   Commit E: merge B&C, resolving in favor of C
+#
+# This is an obvious add/add conflict for the submodule 'repo'.  Can
+# git detect it?
+
+test_expect_success 'setup submodule add/add' '
+	test_create_repo submodule-add-add &&
+	(
+		cd submodule-add-add &&
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
+		touch irrelevant-file &&
+		git add irrelevant-file &&
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
+test_expect_failure 'check submodule add/add' '
+	(
+		cd submodule-add-add &&
+
+		git checkout D^0 &&
+
+		test_must_fail git merge -s recursive E^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out
+	)
+'
+
 test_done
-- 
2.18.0.130.gd703bbb5d

