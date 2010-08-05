From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Document -B<n>[/<m>], -M<n> and -C<n> variants of -B, -M and -C
Date: Thu,  5 Aug 2010 18:14:25 +0200
Message-ID: <1281024865-31780-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqbp9hoxbd.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 05 18:24:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh3FF-0007xl-RC
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760095Ab0HEQYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:24:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:53307 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755178Ab0HEQYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:24:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o75GEi52004522
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 18:14:44 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oh35g-0004jN-Cl; Thu, 05 Aug 2010 18:14:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oh35g-0008H9-B3; Thu, 05 Aug 2010 18:14:44 +0200
X-Mailer: git-send-email 1.7.2.1.30.g18195
In-Reply-To: <vpqbp9hoxbd.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 05 Aug 2010 18:14:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152685>

These options take an optional argument, but this optional argument was
not documented.

Original patch by Matthieu Moy, but documentation for -B mostly copied
from the explanations of Junio C Hamano.

While we're there, fix a typo in a comment in diffcore.h.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/diff-options.txt |   35 ++++++++++++++++++++++++++++++-----
 diffcore.h                     |    2 +-
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 2371262..eecedaa 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -206,10 +206,29 @@ endif::git-format-patch[]
 	the diff-patch output format.  Non default number of
 	digits can be specified with `--abbrev=<n>`.
 
--B::
-	Break complete rewrite changes into pairs of delete and create.
-
--M::
+-B[<n>][/<m>]::
+	Break complete rewrite changes into pairs of delete and
+	create. This serves two purposes:
++
+It affects the way a change that amounts to a total rewrite of a file
+not as a series of deletion and insertion mixed together with a very
+few lines that happen to match textually as the context, but as a
+single deletion of everything old followed by a single insertion of
+everything new, and the number `m` controls this aspect of the -B
+option (defaults to 60%). `-B/70%` specifies that less than 30% of the
+original should remain in the result for git to consider it a total
+rewrite (i.e. otherwise the resulting patch will be a series of
+deletion and insertion mixed together with context lines).
++
+When used with -M, a totally-rewritten file is also considered as the
+source of a rename (usually -M only considers a file that disappeared
+as the source of a rename), and the number `n` controls this aspect of
+the -B option (defaults to 50%). `-B20%` specifies that a change with
+addition and deletion compared to 20% or more of the file's size are
+eligible for being picked up as a possible source of a rename to
+another file.
+
+-M[<n>]::
 ifndef::git-log[]
 	Detect renames.
 endif::git-log[]
@@ -218,9 +237,15 @@ ifdef::git-log[]
 	For following files across renames while traversing history, see
 	`--follow`.
 endif::git-log[]
+	If `n` is specified, it is a is a threshold on the similarity
+	index (i.e. amount of addition/deletions compared to the
+	file's size). For example, `-M90%` means git should consider a
+	delete/add pair to be a rename if more than 90% of the file
+	hasn't changed.
 
--C::
+-C[<n>]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
+	If `n` is specified, it has the same meaning as for `-M<n>`.
 
 ifndef::git-format-patch[]
 --diff-filter=[ACDMRTUXB*]::
diff --git a/diffcore.h b/diffcore.h
index 491bea0..fed9b15 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -18,7 +18,7 @@
 #define MAX_SCORE 60000.0
 #define DEFAULT_RENAME_SCORE 30000 /* rename/copy similarity minimum (50%) */
 #define DEFAULT_BREAK_SCORE  30000 /* minimum for break to happen (50%) */
-#define DEFAULT_MERGE_SCORE  36000 /* maximum for break-merge to happen 60%) */
+#define DEFAULT_MERGE_SCORE  36000 /* maximum for break-merge to happen (60%) */
 
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
 
-- 
1.7.2.1.30.g18195
