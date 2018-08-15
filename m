Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5300D1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 09:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeHOMbR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 08:31:17 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:3481 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeHOMbR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 08:31:17 -0400
Received: from lindisfarne.localdomain ([92.22.33.100])
        by smtp.talktalk.net with SMTP
        id psHGfwZmBoI6LpsHMf4aEl; Wed, 15 Aug 2018 10:39:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1534325989;
        bh=dxrWgCpIYZhRuFAIadpw6mDZc9yPHsN4HKws8E9h/E0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Q+XyrpdwVSwl55j4MlMZiEGEpWBFVIQ+BOICnx+k+DvDxlFhvo9f3h8xts0QwS5Yp
         /1m4n8IVNKKt1uep2iPHsPqilJoKzPQXNla9vLae0T6mowj3qcMW5QlcM+0f1HFI8r
         cdgEZGH5P8AUOw0k37yraKd88oaKbcnbVu8ulxA8=
X-Originating-IP: [92.22.33.100]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=k9WtyX7eyn4O4XzWYcPtUg==:117
 a=k9WtyX7eyn4O4XzWYcPtUg==:17 a=evINK-nbAAAA:8 a=jDkEv8kEl1xXfLAzANAA:9
 a=5UrC9Gp94yTeVVeJ:21 a=wAeElkEm5LbadJSl:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/2] t3430: add conflicting commit
Date:   Wed, 15 Aug 2018 10:39:34 +0100
Message-Id: <20180815093935.10222-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180815093935.10222-1-phillip.wood@talktalk.net>
References: <20180815093935.10222-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfFgV3PQpTVPbB6bMvh/3Y6vmrV0mGZYp7h/YsLks5/B6/LZBklErTTeb3l6MnJpp+eDtdQ07lQ9L6HyFB242ToMahybJ1d9Zocpt+zuZWInYHnXsFiFO
 OPemSCnjhEvk1RDzBnRyoz+HPidcrzmXJirlnRrpxugTYnMuOo1vRW3uhCHyOTu4QMw44nRF+nglwTjurZ+OI3OR9ahu5axGXrg1K671S3+Ul8OnX52XhW7B
 JPHvdvQXOGXLJP4jMyFMpybkSNonR7lFHzIFcJjZ3wCIMYsSbx7fY6t39qRZwwet
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move the creation of conflicting-G from a test to the setup so that it
can be used in subsequent tests without creating the kind of implicit
dependencies that plague t3404. While we're at it simplify the
arguments to the test_commit() call the creates the conflicting commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3430-rebase-merges.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 78f7c99580..31fe4268d5 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -13,8 +13,10 @@ Initial setup:
     -- B --                   (first)
    /       \
  A - C - D - E - H            (master)
-       \       /
-         F - G                (second)
+   \    \       /
+    \    F - G                (second)
+     \
+      Conflicting-G
 '
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
@@ -49,7 +51,9 @@ test_expect_success 'setup' '
 	git merge --no-commit G &&
 	test_tick &&
 	git commit -m H &&
-	git tag -m H H
+	git tag -m H H &&
+	git checkout A &&
+	test_commit conflicting-G G.t
 '
 
 test_expect_success 'create completely different structure' '
@@ -72,7 +76,7 @@ test_expect_success 'create completely different structure' '
 	EOF
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
-	git rebase -i -r A &&
+	git rebase -i -r A master &&
 	test_cmp_graph <<-\EOF
 	*   Merge the topic branch '\''onebranch'\''
 	|\
@@ -141,8 +145,7 @@ test_expect_success 'failed `merge` writes patch (may be rescheduled, too)' '
 
 	: fail because of merge conflict &&
 	rm G.t .git/rebase-merge/patch &&
-	git reset --hard &&
-	test_commit conflicting-G G.t not-G conflicting-G &&
+	git reset --hard conflicting-G &&
 	test_must_fail git rebase --continue &&
 	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
 	test_path_is_file .git/rebase-merge/patch
-- 
2.18.0

