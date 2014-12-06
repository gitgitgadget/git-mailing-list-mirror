From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2] doc: make clear --assume-unchanged's user contract
Date: Sat,  6 Dec 2014 15:04:30 +0000
Message-ID: <1417878270-4364-2-git-send-email-philipoakley@iee.org>
References: <1417878270-4364-1-git-send-email-philipoakley@iee.org>
Cc: ?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 16:03:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxGto-0002Nd-3S
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 16:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbaLFPDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 10:03:52 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:40296 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751932AbaLFPDv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 10:03:51 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ai4MAHQag1ROl3SjPGdsb2JhbABZgwaBKoYzxjQEAgKBERcBAQEBAQEFAQEBATg7hAMBBVYjEAhJOQoUBgESiD/UfQEBAQcCIJBPB4Q2BYVYlSmLUIo8PzCCQwEBAQ
X-IPAS-Result: Ai4MAHQag1ROl3SjPGdsb2JhbABZgwaBKoYzxjQEAgKBERcBAQEBAQEFAQEBATg7hAMBBVYjEAhJOQoUBgESiD/UfQEBAQcCIJBPB4Q2BYVYlSmLUIo8PzCCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,529,1413241200"; 
   d="scan'208";a="654259112"
Received: from host-78-151-116-163.as13285.net (HELO localhost) ([78.151.116.163])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 06 Dec 2014 15:03:49 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1417878270-4364-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260953>

Many users misunderstand the --assume-unchanged contract, believing
it means Git won't look at the flagged file.

Be explicit that the --assume-unchanged contract is by the user that
they will NOT change the file so that Git does not need to look (and
expend, for example, lstat(2) cycles)

Mentioning "Git stops checking" does not help the reader, as it is
only one possible consequence of what that assumption allows Git to
do, but

   (1) there are things other than "stop checking" that Git can do
       based on that assumption; and
   (2) Git is not obliged to stop checking; it merely is allowed to.

Also, this is a single flag bit, correct the plural to singular, and
the verb, accordingly.

Drop the stale and incorrect information about "poor-man's ignore",
which is not what this flag bit is about at all.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-update-index.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e0a8702..da1ccbc 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -78,20 +78,18 @@ OPTIONS
         Set the execute permissions on the updated files.
 
 --[no-]assume-unchanged::
-	When these flags are specified, the object names recorded
-	for the paths are not updated.  Instead, these options
-	set and unset the "assume unchanged" bit for the
-	paths.  When the "assume unchanged" bit is on, Git stops
-	checking the working tree files for possible
-	modifications, so you need to manually unset the bit to
-	tell Git when you change the working tree file. This is
+	When this flag is specified, the object names recorded
+	for the paths are not updated.  Instead, this option
+	sets/unsets the "assume unchanged" bit for the
+	paths.  When the "assume unchanged" bit is on, the user
+	promises not to change the file and allows Git to assume
+	that the working tree file matches what is recorded in
+	the index.  If you want to change the working tree file,
+	you need to unset the bit to tell Git.  This is
 	sometimes helpful when working with a big project on a
 	filesystem that has very slow lstat(2) system call
 	(e.g. cifs).
 +
-This option can be also used as a coarse file-level mechanism
-to ignore uncommitted changes in tracked files (akin to what
-`.gitignore` does for untracked files).
 Git will fail (gracefully) in case it needs to modify this file
 in the index e.g. when merging in a commit;
 thus, in case the assumed-untracked file is changed upstream,
-- 
1.9.4.msysgit.0
