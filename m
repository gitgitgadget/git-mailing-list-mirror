Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158051F516
	for <e@80x24.org>; Sun,  1 Jul 2018 04:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeGAELg (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 00:11:36 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36463 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeGAELb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 00:11:31 -0400
Received: by mail-oi0-f68.google.com with SMTP id r16-v6so11375602oie.3
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vu1UFRsFZd7ddUgzOPzTxWtPvlmwBptYd9ybBFuj87w=;
        b=qQ60ZzeOdWJvPw+JgNYD6upD2yBNUC5+pl383qQVfp1yuIpn40ULYxsMY76N2lVhtW
         kgdzGeVqpZ54MLEsvGUOlMER0xGAo+am8n5WrFeBHILfRZJLBbqyQZT+BARM70QqB1qG
         +YJPzw+YvBMlb9JtXdpfnNuSgHEUOPoy/3Kz4DJb+cudLWjZq/AKexYIxlCVLMd/jEgY
         MS2DGKWPPi5K/A0hFrnXrCMKjXD5jexpeRYemiyMVLfEPh8rzIW0SYdmyU6L/pOMty/7
         0lOzsnSqVVMJGVxmzHpdpr4JmTSE0hAgK41uo9WBzBiRNd/jnjKfrKZNpoNFGKeI3Tge
         HiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vu1UFRsFZd7ddUgzOPzTxWtPvlmwBptYd9ybBFuj87w=;
        b=Owwdqml7o9uXj34SVHEYXcDc18UWf5c47nwiRyIw1f1sLhmdcqZBt9RoPuToD/1Wkk
         oYoJ1Y8khM286pXe+D7e1fHP4GKJm3YsBhIyOW6NKUYVsw1lQCyuhPXBzz4sOP7ZM36Y
         1d1kdwYs0gGqk4wtec5AibUQRQbrmCifp0OGMaoONC5+CM8mpU8U1GlvufOS9B5tWfMN
         n+NNox82TBMIGn0SyfF0M41/xb/tulynGte4HT4rnZTNA/KC+niLlknwyadsX5HSDzjJ
         YebtU0Ov8Teqz/sRBaqohv0b+k9WDO3P1JeRvJj5/1m4JkRuBQaFjZAMC48CSZBcEqBx
         NZAQ==
X-Gm-Message-State: APt69E1vDcP/EhutfMBUb7oxnl47yT8EzDtsCD8Ykp1zAw6t11vNsaLU
        GrSPk9ozbrK5HuRXXvq9sEFrRw==
X-Google-Smtp-Source: AAOMgpcqxgzruBsHRXYYNMUrihjL3QrP6LBeyISULkdee95iacB0HhlqZ9gWuIP3cplEkpCkeK7KMQ==
X-Received: by 2002:aca:2c02:: with SMTP id s2-v6mr3041332ois.82.1530418291045;
        Sat, 30 Jun 2018 21:11:31 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id m3-v6sm6222677oif.26.2018.06.30.21.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 21:11:30 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/6] t6036: add a failed conflict detection case with symlink add/add
Date:   Sat, 30 Jun 2018 21:11:18 -0700
Message-Id: <20180701041122.8753-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
In-Reply-To: <20180701041122.8753-1-newren@gmail.com>
References: <20180701041122.8753-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh | 66 +++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 4a94fa5ba..0ba04d46d 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -872,4 +872,70 @@ test_expect_failure 'check symlink modify/modify' '
 	)
 '
 
+#
+# criss-cross with add/add of a symlink:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: No symlink or path exists yet
+#   Commit B: set up symlink: fickle->disneyland
+#   Commit C: set up symlink: fickle->home
+#   Commit D: merge B&C, resolving in favor of B
+#   Commit E: merge B&C, resolving in favor of C
+#
+# This is an obvious add/add conflict for the symlink 'fickle'.  Can
+# git detect it?
+
+test_expect_success 'setup symlink add/add' '
+	test_create_repo symlink-add-add &&
+	(
+		cd symlink-add-add &&
+
+		touch ignoreme &&
+		git add ignoreme &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		test_ln_s_add disneyland fickle &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		test_ln_s_add home fickle &&
+		git add fickle &&
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
+test_expect_failure 'check symlink add/add' '
+	(
+		cd symlink-add-add &&
+
+		git checkout D^0 &&
+
+		test_must_fail git merge -s recursive E^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
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

