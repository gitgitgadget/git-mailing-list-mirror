Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFDD71FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbdFSR5j (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:57:39 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:53322 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdFSR5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:57:38 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id N0uGdKeNKHGLwN0vhdVsLu; Mon, 19 Jun 2017 18:57:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497895057; bh=jFJWFalheQ2ZNeZcy9LLvKahihT0pDpV6HmydJewQsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=iLaj69iX6YmJJoj9ScWqPg7dnXSb78NMU3HyArLlirk4it1s2q8o5Acc/omhA7lRu
         gdQM3ocjpZclZOrOBHGPFiSF1yJzs3ER99FdKlTW68Gmm8hnsdYwLOP8BsLfsXOoTb
         Tm9e3Nk2W8hqQqr3lGupPcbQwr8DsGg15P5nfulU=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=YyvG7Ur61TTfZU23CB8A:9 a=5R_RLCRGQUWTAMPE:21 a=5Ytg2kSA6LLqIRDr:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 4/4] rebase: Add more regression tests for console output
Date:   Mon, 19 Jun 2017 18:56:05 +0100
Message-Id: <20170619175605.27864-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170619175605.27864-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170619175605.27864-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfF6bmd2oMuo9edP9dTRJ5LaaKwcCIalI1Zub/j0ccopY65i+j9R6L2iGDAaD2Ace3vvSfRWSfWj1r9BwTiw5KMKoJwxaSPJCWqwZtsrAr7w1yxhxYKM+
 smqXko6EGa+ClPaivzx8sqYl+q+WvksP2r+xPcKaNbaeQLvyCqS/SXaR8Lb3xkkoOr0BHeuGEAiT3WEs0ZzaQ/NAZmxZTFCvB2rfgDI9jtJ59blCrXfB39al
 fyNr39rKFF0AxmXBWpp7C9Zh10ZIu/c16V4lTmhdb5otznUnnV2KQX2Wxtyg4BNeOYO7eY6HDlY/ZuKz4DDQIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check the console output when using --autostash and the stash does not
apply is what we expect. The test is quite strict but should catch any
changes to the console output from the various rebase flavors.

Thanks-to: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3420-rebase-autostash.sh | 71 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index cd1012798cb300f4f1ddeba6fdcad544ca9ea1d9..2c01ae6ad2a104940e388013984e7fa2a0d5aed5 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -88,6 +88,67 @@ create_expected_success_merge() {
 	EOF
 }
 
+create_expected_failure_am() {
+	cat >expected <<-EOF
+	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
+	HEAD is now at $(git rev-parse --short feature-branch) third commit
+	First, rewinding head to replay your work on top of it...
+	Applying: second commit
+	Applying: third commit
+	Applying autostash resulted in conflicts.
+	Your changes are safe in the stash.
+	You can run "git stash pop" or "git stash drop" at any time.
+	EOF
+}
+
+create_expected_failure_interactive() {
+	q_to_cr >expected <<-EOF
+	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
+	HEAD is now at $(git rev-parse --short feature-branch) third commit
+	Rebasing (1/2)QRebasing (2/2)QApplying autostash resulted in conflicts.
+	Your changes are safe in the stash.
+	You can run "git stash pop" or "git stash drop" at any time.
+	Successfully rebased and updated refs/heads/rebased-feature-branch.
+	EOF
+}
+
+create_expected_failure_merge() {
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
+	Applying autostash resulted in conflicts.
+	Your changes are safe in the stash.
+	You can run "git stash pop" or "git stash drop" at any time.
+	EOF
+}
+
 testrebase() {
 	type=$1
 	dotest=$2
@@ -198,10 +259,9 @@ testrebase() {
 		test_config rebase.autostash true &&
 		git reset --hard &&
 		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >file4 &&
 		git add file4 &&
-		git rebase$type unrelated-onto-branch &&
+		git rebase$type unrelated-onto-branch >actual 2>&1 &&
 		test_path_is_missing $dotest &&
 		git reset --hard &&
 		grep unrelated file4 &&
@@ -210,6 +270,13 @@ testrebase() {
 		git stash pop &&
 		grep dirty file4
 	'
+
+	test_expect_success "rebase$type: check output with conflicting stash" '
+		test_when_finished git branch -D rebased-feature-branch &&
+		suffix=${type#\ --} && suffix=${suffix:-am} &&
+		create_expected_failure_$suffix &&
+		test_cmp expected actual
+	'
 }
 
 test_expect_success "rebase: fast-forward rebase" '
-- 
2.13.0

