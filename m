Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8421E1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbcFQUZT (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:25:19 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:60161 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964838AbcFQUY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:29 -0400
Received: (qmail 21682 invoked from network); 17 Jun 2016 20:24:28 -0000
Received: (qmail 7285 invoked from network); 17 Jun 2016 20:24:28 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:27 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 19/38] tests: unpack-trees: update to use test_i18n* functions
Date:	Fri, 17 Jun 2016 20:21:08 +0000
Message-Id: <1466194887-18236-20-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use functions test_i18ncmp and test_i18ngrep to successfully pass tests
running under GETTEXT_POISON.

The output strings compared to in these test were marked for translation
in ed47fdf ("i18n: unpack-trees: mark strings for translation",
2016-04-09) and later improved in 2e3926b ("i18n: unpack-trees: avoid
substituting only a verb in sentences", 2016-05-12).

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t1011-read-tree-sparse-checkout.sh | 2 +-
 t/t3400-rebase.sh                    | 4 ++--
 t/t3404-rebase-interactive.sh        | 4 ++--
 t/t7607-merge-overwrite.sh           | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 0c74bee..3583105 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -247,7 +247,7 @@ error: The following untracked working tree files would be overwritten by checko
 Please move or remove them before you can switch branches.
 Aborting
 EOF
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success 'checkout without --ignore-skip-worktree-bits' '
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 47b5682..f5fd15e 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -136,8 +136,8 @@ test_expect_success 'setup: recover' '
 test_expect_success 'Show verbose error when HEAD could not be detached' '
 	>B &&
 	test_must_fail git rebase topic 2>output.err >output.out &&
-	grep "The following untracked working tree files would be overwritten by checkout:" output.err &&
-	grep B output.err
+	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" output.err &&
+	test_i18ngrep B output.err
 '
 rm -f B
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f4ccd10..8ac1868 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -219,9 +219,9 @@ test_expect_success 'abort with error when new base cannot be checked out' '
 	git commit -m "remove file in base" &&
 	set_fake_editor &&
 	test_must_fail git rebase -i master > output 2>&1 &&
-	grep "The following untracked working tree files would be overwritten by checkout:" \
+	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" \
 		output &&
-	grep "file1" output &&
+	test_i18ngrep "file1" output &&
 	test_path_is_missing .git/rebase-merge &&
 	git reset --hard HEAD^
 '
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 758a623..e8ec54c 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -125,7 +125,7 @@ test_expect_success 'will not overwrite untracked file in leading path' '
 	cp important sub &&
 	cp important sub2 &&
 	test_must_fail git merge sub 2>out &&
-	test_cmp out expect &&
+	test_i18ncmp out expect &&
 	test_path_is_missing .git/MERGE_HEAD &&
 	test_cmp important sub &&
 	test_cmp important sub2 &&
-- 
2.6.6

