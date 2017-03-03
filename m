Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3DE32023D
	for <e@80x24.org>; Fri,  3 Mar 2017 11:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdCCLmW (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 06:42:22 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:65535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdCCLlW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 06:41:22 -0500
Received: from evilbit.green-communications.fr ([82.228.44.140]) by
 mrelayeu.kundenserver.de (mreue101 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 0M0Qv7-1cQrff1ekH-00uYwJ; Fri, 03 Mar 2017 12:33:42 +0100
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t6042: Add failing test for rename/rename/delete/delete.
Date:   Fri,  3 Mar 2017 12:33:16 +0100
Message-Id: <20170303113317.18575-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K0:7iH0FSLTLaL+r3sMsM1PRfAbyImcAEOyPF16RybsX5iYNFSXkjk
 APdqIoVJg36uH6hTMJLhMzAEt5cI+HjcWqYF1eQw+HSpS6GhWN3xMmWeb2brsCMhYs2xE40
 70HOBGxvQSd8oAImdmrhVXP49yqMlNjVq6McRsnPUqn8ghRdHelcOxIL156+rdpvgNHDllZ
 s/f2OhzuP4jXMhog+q6NQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YjWhCyIaEKg=:xaAJZmNYwp/YoHx/CFW6TV
 IhNcHCQBdFS7oZV7l5hZwA1HesFLjarrMoBpQMN8bSRponPS3xupzf+fP0qB9ARXECmCWhoaT
 JKsyaG2G/5hMWarV1PePZeKlaNVz8vtIhsRyW6WhxAi3E92ueO1aKdtVh+97B38RaQFAwzPzy
 oqR+pU9uBIrgSA+Dov3ZClt9aW5afRsJpYrT08IP1KAx5piG9UFpKgRwhX4rAHY2qUYUe45TF
 ymFCtZQJ4cLOo8p57TKioxNJxk1f3N8yV1r5MfSzmJzqdSAWbjlaV0/g2mcTzPY/kyi7b2RrX
 xqV7dBrOpyf7ZAzY9zCR066DxH0326xuweOoa6WVnX1zJZlewk2siI0QmG9tQLCnD4N4sb/hB
 zHXwevNElfz0Z0MChGa5t2BFcE5oOpMerENlzoYCxowrehM0lWeILiGw00RyUptRcjI8uzIkn
 QzyzbldQ4hJXFsP1nSGtAyz4qCGOK5TI0YY1BlJ42kvbnuLiQXFduFTCH2s3LB4oI+esKoSs4
 1NKv7ofgcW1gNYLj+mk6wzGQpPtRUpxjBKJLCRouCibugzrTX/L5yDMs1DUwhCWeOK+jPU4Xo
 KOBMzYGYtJrNrZ0YY5Y2kEqdhDvBn5XkyvGRoqF5p75bqR5MFdxhop9QWBDknuQErBWLvZYVJ
 SVmeP05HE/1c+h9M1vUGyVvZrt5FiY5l3Qx2yWsIG9xPZ3YQNJVKME52Piahbvi+O34c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each side of a rename 2to1 could also be deleted by the other side.
The code does not expect this.  While it luckily works for files,
it fails for symlinks as follow:

CONFLICT (rename/rename): Rename a->c in HEAD. Rename b->c in C^0
Renaming a to c~HEAD and b to c~C^0 instead
error: cannot read object 0000000000000000000000000000000000000000 'c~C^0'

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 t/t6042-merge-rename-corner-cases.sh | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 411550d2b..ea4e14cbd 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -575,4 +575,42 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 	test ! -f c
 '
 
+# Testcase setup for rename/rename/delete/delete (2in1, deleted):
+#   Commit A: new symlinks: a->alice b->bob
+#   Commit B: rename a->c, delete b
+#   Commit C: rename b->c, delete a
+#
+# We should not fail completely.
+
+test_expect_success 'setup rename/rename/delete/delete conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	ln -s alice a &&
+	ln -s bob b &&
+	git add a b &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a c &&
+	git rm b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv b c &&
+	git rm a &&
+	git commit -m C
+'
+
+test_expect_failure 'rename/rename/delete/delete leaves at least one file' '
+	git checkout B^0 &&
+	test_must_fail git merge -s recursive C^0 &&
+
+	test -L "c~HEAD" &&
+	test -L "c~C^0"
+'
+
 test_done
-- 
2.11.0

