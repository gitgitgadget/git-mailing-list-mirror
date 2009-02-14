From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Sat, 14 Feb 2009 21:23:24 +0100
Message-ID: <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch>
References: <200902142056.42198.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:25:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYR4r-0004S2-J7
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbZBNUXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbZBNUXm
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:23:42 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:27331 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbZBNUXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:23:40 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:35 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:33 +0100
X-Mailer: git-send-email 1.6.2.rc0.296.ge2122
In-Reply-To: <200902142056.42198.trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 20:23:33.0959 (UTC) FILETIME=[1BF56570:01C98EE2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109920>

We should use test_must_fail to negate output status, so that
segfaults can be caught.  One instance of ! negation remains, but that
actually tests the return code of 'grep'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

New in this series.

 t/t3301-notes.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 43d82a2..764fad5 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -16,7 +16,7 @@ VISUAL=./fake_editor.sh
 export VISUAL
 
 test_expect_success 'cannot annotate non-existing HEAD' '
-	! MSG=3 git notes edit
+	MSG=3 test_must_fail git notes edit
 '
 
 test_expect_success setup '
@@ -31,8 +31,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'need valid notes ref' '
-	! MSG=1 GIT_NOTES_REF=/ git notes edit &&
-	! MSG=2 GIT_NOTES_REF=/ git notes show
+	MSG=1 GIT_NOTES_REF=/ test_must_fail git notes edit &&
+	MSG=2 GIT_NOTES_REF=/ test_must_fail git notes show
 '
 
 # 1 indicates caught gracefully by die, 128 means git-show barked
@@ -47,7 +47,7 @@ test_expect_success 'create notes' '
 	test 1 = $(git ls-tree refs/notes/commits | wc -l) &&
 	test b1 = $(git notes show) &&
 	git show HEAD^ &&
-	! git notes show HEAD^
+	test_must_fail git notes show HEAD^
 '
 
 cat > expect << EOF
-- 
1.6.2.rc0.296.ge2122
