From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] Document -B<n>[/<m>], -M<n> and -C<n> variants of -B, -M and -C
Date: Mon,  2 Aug 2010 13:12:07 +0200
Message-ID: <1280747527-30444-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vk4ocrkfa.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 02 13:14:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfsyO-0002Is-BI
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 13:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab0HBLOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 07:14:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41695 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab0HBLOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 07:14:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o72BAItm008460
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Aug 2010 13:10:19 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OfswN-0005bH-JL; Mon, 02 Aug 2010 13:12:19 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OfswN-0007vj-IC; Mon, 02 Aug 2010 13:12:19 +0200
X-Mailer: git-send-email 1.7.2.1.10.g5cb67a
In-Reply-To: <7vk4ocrkfa.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 Aug 2010 13:10:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o72BAItm008460
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281352220.55569@iSSv1z/EQf88Pzapws8N0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152405>

These options take an optional argument, but this optional argument was
not documented.

While we're there, fix a typo in a comment in diffcore.h.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Here's a new version. I've eliminated "line" from the wording. I'm
still not sure I'm technically correct, especially about the
interaction between "n" and "m" (the "A rewrite is considered when
both thresholds are reached par of the patch).

 Documentation/diff-options.txt |   24 +++++++++++++++++++-----
 diffcore.h                     |    2 +-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 2371262..f1ab4e7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -206,10 +206,22 @@ endif::git-format-patch[]
 	the diff-patch output format.  Non default number of
 	digits can be specified with `--abbrev=<n>`.
 
--B::
-	Break complete rewrite changes into pairs of delete and create.
-
--M::
+-B[<n>]::
+-B<n>/<m>::
+	Break complete rewrite changes into pairs of delete and
+	create. When `n` and/or `m` are specified, they give threshold
+	(as a percentage of changed content) above which a change is
+	considered as complete rewrite. `n` is a threshold on the
+	similarity index (i.e. amount of addition/deletions compared
+	to the file's size). For example, `-B90%` means git will
+	detect a rewrite if more than 90% of the file's content have
+	been modified. `m` is a threshold on the disimilarity index
+	(i.e. amount of deletions from the old version). A rewrite is
+	considered when both thresholds are reached. When either `n`
+	or `m` is not specified, the default applies (`n` = 50% and
+	`m` = 60%). See linkgit:gitdiffcore[7] for more details.
+
+-M[<n>]::
 ifndef::git-log[]
 	Detect renames.
 endif::git-log[]
@@ -218,9 +230,11 @@ ifdef::git-log[]
 	For following files across renames while traversing history, see
 	`--follow`.
 endif::git-log[]
+	If `n` is specified, it has the same meaning as for `-B<n>`.
 
--C::
+-C[<n>]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
+	If `n` is specified, it has the same meaning as for `-B<n>`.
 
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
1.7.2.1.10.g5cb67a
