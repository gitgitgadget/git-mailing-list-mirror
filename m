From: Ryan Schmitt <rschmitt@pobox.com>
Subject: [PATCH] rm: Accept --staged as a synonym of --cached
Date: Fri, 21 Feb 2014 21:30:09 -0800
Message-ID: <1393047009-30168-1-git-send-email-rschmitt@pobox.com>
Cc: Ryan Schmitt <rschmitt@u.rochester.edu>,
	Ryan Schmitt <rschmitt@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 06:30:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH5Ae-0001Xv-9P
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 06:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbaBVFae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 00:30:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbaBVFad (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 00:30:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4585D6EA68;
	Sat, 22 Feb 2014 00:30:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=NYkwl+sydf01/0ymWbEpF1s03q0
	=; b=arGTIYPySaCn+VDZYlRO2999i10+MyLQxDgpjktYZ7IKosmMRUlgvwZEGRj
	6ymt479Kz3Qitafbr0A1P1yShJ6qj48r2XJ8QFB4YJgINvEoWMtPGtv9ScmsAAqS
	mC+YPFBOjEaIYK+TFNRhb9VbH+ItFolkLPob543GvKlwasMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=xsWjo/xxsmvcXO7V9FXOl
	Gt5ZXa2QbPtXrc0ZoNavNOyPllvag7NbqUb+qGS3oTy/L2EPFQWnNGDBSIbKspJj
	/j1Wq2YcQBkqh0ZEmpTT3vpzY8e3ZW7pgfB5XcfxhOd/e7qlmDhMIUfxzJ2M/J7N
	3tkANdWZ1O3iQ/Od8FPBao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2944A6EA67;
	Sat, 22 Feb 2014 00:30:33 -0500 (EST)
Received: from localhost.localdomain (unknown [76.121.230.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8879E6EA63;
	Sat, 22 Feb 2014 00:30:30 -0500 (EST)
X-Mailer: git-send-email 1.8.3.2
X-Pobox-Relay-ID: 72B6A22C-9B82-11E3-B418-1B26802839F8-18705681!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242501>

From: Ryan Schmitt <rschmitt@u.rochester.edu>

This makes git-rm more consistent with git-diff, which also accepts
--staged as a synonym of --cached.

Signed-off-by: Ryan Schmitt <rschmitt@pobox.com>
---
 Documentation/git-rm.txt | 2 +-
 builtin/rm.c             | 1 +
 t/t3600-rm.sh            | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git Documentation/git-rm.txt Documentation/git-rm.txt
index f1efc11..8635e67 100644
--- Documentation/git-rm.txt
+++ Documentation/git-rm.txt
@@ -58,7 +58,7 @@ OPTIONS
 --cached::
 	Use this option to unstage and remove paths only from the index.
 	Working tree files, whether modified or not, will be
-	left alone.
+	left alone. --staged is a synonym for --cached.
 
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
diff --git builtin/rm.c builtin/rm.c
index 960634d..a88697b 100644
--- builtin/rm.c
+++ builtin/rm.c
@@ -269,6 +269,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
+	OPT_BOOL( 0 , "staged",         &index_only, N_("synonym for --cached")),
 	OPT__FORCE(&force, N_("override the up-to-date check")),
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
diff --git t/t3600-rm.sh t/t3600-rm.sh
index 3d30581..c32dbf4 100755
--- t/t3600-rm.sh
+++ t/t3600-rm.sh
@@ -72,6 +72,12 @@ test_expect_success \
      git rm --cached -f foo'
 
 test_expect_success \
+    'Test that git rm --staged foo is synonymous with git rm --cached foo' \
+    'echo content > foo
+     git add foo
+     git rm --staged foo'
+
+test_expect_success \
     'Post-check that foo exists but is not in index after git rm foo' \
     '[ -f foo ] && test_must_fail git ls-files --error-unmatch foo'
 
-- 
1.8.3.2
