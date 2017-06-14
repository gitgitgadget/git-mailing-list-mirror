Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9B120401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdFNKZH (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:25:07 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:47765 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdFNKZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:25:06 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id L5TSdvCsT9tMzL5U1djKig; Wed, 14 Jun 2017 11:25:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497435906; bh=C+Bu27bdjqLZCuj6dOz2N+auJNTDJHUsj4j79WARr1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=VPz+EA3eWv27C95PHlildDv8rRWaMurnjlHxb0GOTb+nhb81OyCFc5M22TIW9uYm3
         yctEB66KR7P//bNCgIT67B1iJR5Mon4VKQzWuKHY9swbD8E9eRDdxZdg0y79su2vXc
         6TrzX9q0f+MguIIPnjTEwZSzBudBE3jVECeFiPRk=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=WOE9ZTkR c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=YyvG7Ur61TTfZU23CB8A:9 a=fdSLZKsEDcztVZcr:21 a=TUBgaXsHzhChUR-1:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/3] rebase: Add more regression tests for console output
Date:   Wed, 14 Jun 2017 11:24:27 +0100
Message-Id: <20170614102427.5220-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170614102427.5220-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170614102427.5220-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfFgch51d7qtpErqltQgmW/DsKBvdF6vCn1mOkYgv7o3xSIL3E+UqY+/xahgFm9aXQTXhDjznHiuhqhcJUdb2cWzhdD2lSLiymMs6Iq3zQDuEgDfIlpbv
 Kdua1zbczBqDzMyzwHVtO5RIv6Pejl5Fj8qsso9Gv/2GQ4JqAQ2Q8C2iykqXlYstExtnnGO68Z92BRRlyGI/6YcYySGQ0IVL5a/rasJHLUOwuOdd+3ncP6QD
 bUDsVSHAgaeWxKdXju/AqFO1SexYJEDhEuCTl4c1/r1pvtLnhXpHCU8r/GeUCF4+YTyB/M8RZfbZy7lwsZdKpw==
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
 t/t3420-rebase-autostash.sh | 72 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 2cbc2e89cd026c370a86da35e181d77f27081c7a..325ec75353b200bb88ab223e4a3b87d885cf2cf2 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -89,6 +89,68 @@ create_expected_success_merge() {
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
+	cr=$'\r' &&
+	cat >expected <<-EOF
+	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
+	HEAD is now at $(git rev-parse --short feature-branch) third commit
+	Rebasing (1/2)${cr}Rebasing (2/2)${cr}Successfully rebased and updated refs/heads/rebased-feature-branch.
+	Applying autostash resulted in conflicts.
+	Your changes are safe in the stash.
+	You can run "git stash pop" or "git stash drop" at any time.
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
@@ -199,10 +261,9 @@ testrebase() {
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
@@ -211,6 +272,13 @@ testrebase() {
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

