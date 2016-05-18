From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 18/21] tests: unpack-trees: update to use test_i18n* functions
Date: Wed, 18 May 2016 15:27:51 +0000
Message-ID: <1463585274-9027-19-git-send-email-vascomalmeida@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:31:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33RE-0001jN-2r
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbcERPaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:30:55 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:58925 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932601AbcERPau (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:30:50 -0400
Received: (qmail 21571 invoked from network); 18 May 2016 15:30:48 -0000
Received: (qmail 32311 invoked from network); 18 May 2016 15:30:48 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 18 May 2016 15:30:43 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294961>

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
2.7.3
