From: Brad King <brad.king@kitware.com>
Subject: [PATCH 2/2] submodule: Tolerate auto/safecrlf when adding .gitmodules
Date: Wed, 20 Jun 2012 10:43:33 -0400
Message-ID: <eebc8b3692f8fcb95cf75278f7c9f9982e8f2cd6.1340202515.git.brad.king@kitware.com>
References: <cover.1340202515.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 16:53:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShMI7-0000jb-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 16:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab2FTOxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 10:53:50 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:57610 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755842Ab2FTOxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 10:53:49 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id A8959153F; Wed, 20 Jun 2012 10:43:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <cover.1340202515.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200299>

Temporarily disable 'core.safecrlf' to add '.gitmodules' so that
'git add' does not reject the LF newlines we write to the file
even if both 'core.autocrlf' and 'core.safecrlf' are enabled.
This fixes known breakage tested in t7400-submodule-basic.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 git-submodule.sh           |    2 +-
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5c61ae2..ed9a54a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -303,7 +303,7 @@ Use -f if you really want to add it." >&2
 
 	git config -f .gitmodules submodule."$sm_path".path "$sm_path" &&
 	git config -f .gitmodules submodule."$sm_path".url "$repo" &&
-	git add --force .gitmodules ||
+	git -c core.safecrlf=false add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 }
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5eaeb04..9a4da9b 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -99,7 +99,7 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
 
-test_expect_failure 'submodule add with core.autocrlf and core.safecrlf' '
+test_expect_success 'submodule add with core.autocrlf and core.safecrlf' '
 	(
 		cd addtest-crlf &&
 		git config core.autocrlf true &&
-- 
1.7.10
