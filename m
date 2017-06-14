Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF17D20401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdFNKZE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:25:04 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:47765 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdFNKZC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:25:02 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id L5TSdvCsT9tMzL5TwdjKi5; Wed, 14 Jun 2017 11:25:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497435901; bh=m89/UWblCm/VlNpcnOW22azlIIZBqXMdHzl0vB+sqf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=dsLeRljFZbALZxR5op3+0gXz5ufzEnh9KCyG3GfN5i4mH4iXVpgtw45qIZQpTRdZR
         2mLVr6u41KABuMgddT2Y5q+HZEZGtxY2cmK1Uos0p3gl5n2EN/9STaghyqLh516Yux
         155JtzYg8Iz6Pg3t9MAwsDdoUy4LElAoOKGDTDzo=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=WOE9ZTkR c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=jcH9Egk3IKjZb0eTBqIA:9 a=kHrK2y5IrQO8Pndc:21 a=qH09ULg5OLRf9Px1:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/3] rebase: Add regression tests for console output
Date:   Wed, 14 Jun 2017 11:24:26 +0100
Message-Id: <20170614102427.5220-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170614102427.5220-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170614102427.5220-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfAA7RLVnoVB9PPETzPu1SyxajLSzmUujoAUYcCuEujD4lIU2hhqWn6m9X22I+aqHFlmKLvIDW2yDVLOUJua1WDmYM9jNiWrCBGroQq8H88bX/JU2jT7M
 zeE753WewGHtQ2Prx4WAEgDdCW62DshNq0nm5BSQVGhku0L/hk6JjEy+zrDaJ16Qp2dcK2EZvzOw8QSoRXm5SQIatqkgEgNo216U0CY43VzFipDKaQc7gsJl
 E5pA7qFAgsSZ62tgGEPOfB7rd45bIXLLp5obiF9TiijtiY/pLyf43XcnolLvxjrT8VKV4x/NAS91yuR+8PRMDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check the console output when using --autostash and the stash applies
cleanly is what we expect. The test is quite strict but should catch
any changes to the console output from the various rebase flavors.

Thanks-to: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3420-rebase-autostash.sh | 66 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index ab8a63e8d6dc643b28eb0c74ba3f032b7532226f..2cbc2e89cd026c370a86da35e181d77f27081c7a 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -33,6 +33,62 @@ test_expect_success setup '
 	git commit -m "related commit"
 '
 
+create_expected_success_am() {
+	cat >expected <<-EOF
+	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
+	HEAD is now at $(git rev-parse --short feature-branch) third commit
+	First, rewinding head to replay your work on top of it...
+	Applying: second commit
+	Applying: third commit
+	Applied autostash.
+	EOF
+}
+
+create_expected_success_interactive() {
+	cr=$'\r' &&
+	cat >expected <<-EOF
+	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
+	HEAD is now at $(git rev-parse --short feature-branch) third commit
+	Rebasing (1/2)${cr}Rebasing (2/2)${cr}Successfully rebased and updated refs/heads/rebased-feature-branch.
+	Applied autostash.
+	EOF
+}
+
+create_expected_success_merge() {
+	cat >expected <<-EOF
+	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
+	HEAD is now at $(git rev-parse --short feature-branch) third commit
+	First, rewinding head to replay your work on top of it...
+	Merging unrelated-onto-branch with HEAD~1
+	Merging:
+	$(git rev-parse --short unrelated-onto-branch) unrelated commit
+	$(git rev-parse --short feature-branch^) second commit
+	found 1 common ancestor:
+	$(git rev-parse --short feature-branch~2) initial commit
+	[detached HEAD $(git rev-parse --short rebased-feature-branch~1)] second commit
+	 Author: A U Thor <author@example.com>
+	 Date: Thu Apr 7 15:14:13 2005 -0700
+	 2 files changed, 2 insertions(+)
+	 create mode 100644 file1
+	 create mode 100644 file2
+	Committed: 0001 second commit
+	Merging unrelated-onto-branch with HEAD~0
+	Merging:
+	$(git rev-parse --short rebased-feature-branch~1) second commit
+	$(git rev-parse --short feature-branch) third commit
+	found 1 common ancestor:
+	$(git rev-parse --short feature-branch~1) second commit
+	[detached HEAD $(git rev-parse --short rebased-feature-branch)] third commit
+	 Author: A U Thor <author@example.com>
+	 Date: Thu Apr 7 15:15:13 2005 -0700
+	 1 file changed, 1 insertion(+)
+	 create mode 100644 file3
+	Committed: 0002 third commit
+	All done.
+	Applied autostash.
+	EOF
+}
+
 testrebase() {
 	type=$1
 	dotest=$2
@@ -51,14 +107,20 @@ testrebase() {
 		test_config rebase.autostash true &&
 		git reset --hard &&
 		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >>file3 &&
-		git rebase$type unrelated-onto-branch &&
+		git rebase$type unrelated-onto-branch >actual 2>&1 &&
 		grep unrelated file4 &&
 		grep dirty file3 &&
 		git checkout feature-branch
 	'
 
+	test_expect_success "rebase$type --autostash: check output" '
+		test_when_finished git branch -D rebased-feature-branch &&
+		suffix=${type#\ --} && suffix=${suffix:-am} &&
+		create_expected_success_$suffix &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
 		test_config rebase.autostash true &&
 		git reset --hard &&
-- 
2.13.0

