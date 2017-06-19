Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6429B1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbdFSR5e (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:57:34 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:53322 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdFSR5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:57:33 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id N0uGdKeNKHGLwN0vcdVsKj; Mon, 19 Jun 2017 18:57:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497895053; bh=o6NjJDwS2O/Fetrto7PGeBOrRnvUXcfIsbzBq0VL7hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=rIx/hfrlU9XWYoyHLavG8NZMjorpWhyPAD8rnBi8sARiAQmSI2ghLAeul2g7Gb7IH
         jyVIiMQ4RGcHyULOQwmgErDK6ZwTltpllUA+PYVaUK+aHNDd7hi0wIOmAAFWZSKGZn
         0NuAcprZK+PHX+uVRMhWPVBOAfUxZCARQz6S2us0=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=jcH9Egk3IKjZb0eTBqIA:9 a=XfB-0t-N4Ekl57LG:21 a=l0286e0O3Z2ZxtI1:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 3/4] rebase: Add regression tests for console output
Date:   Mon, 19 Jun 2017 18:56:04 +0100
Message-Id: <20170619175605.27864-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170619175605.27864-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170619175605.27864-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfII996HvmHdLI1dp17oHZrX5icqjRmzMCW6nQ5cFc6ehQ/ILeWONvuAWQ/V5IcD+QG+AWw08jAIJLg8WB/jtmYrB15X0GGzFp4BKLQ8RfjsU38JFyE5J
 /7DyUuU8gWxV0n1eQis3fMp5v8TjWRhU43bdm5A9lySAqTHrZssoi384nKpATTJgErLwr9lAc16VWB6H84MEcXhw4DmdcuEm4w8ZqSxP0K0CFwhAVknkF4n+
 DF5NxW4nfZeatx8YIGZbgX8A8qJpVSZHHT0rusVLOhLopp1d/BMr7AOqMBy56lpKgfabC4awM5NxYd+amcrc1A==
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
 t/t3420-rebase-autostash.sh | 65 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index ab8a63e8d6dc643b28eb0c74ba3f032b7532226f..cd1012798cb300f4f1ddeba6fdcad544ca9ea1d9 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -33,6 +33,61 @@ test_expect_success setup '
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
+	q_to_cr >expected <<-EOF
+	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
+	HEAD is now at $(git rev-parse --short feature-branch) third commit
+	Rebasing (1/2)QRebasing (2/2)QApplied autostash.
+	Successfully rebased and updated refs/heads/rebased-feature-branch.
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
@@ -51,14 +106,20 @@ testrebase() {
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

