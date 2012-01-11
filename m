From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] mailinfo documentation: accurately describe non -k case
Date: Wed, 11 Jan 2012 21:13:42 +0100
Message-ID: <e915a551c9bbf12f4d8fd929e9ed24f3223790ee.1326312730.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 21:13:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl4YV-0007NG-V0
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 21:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010Ab2AKUNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 15:13:50 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:51417 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757824Ab2AKUNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 15:13:49 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Jan
 2012 21:13:46 +0100
Received: from thomas.inf.ethz.ch (129.132.210.223) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Jan
 2012 21:13:48 +0100
X-Mailer: git-send-email 1.7.9.rc0.168.g3847c
X-Originating-IP: [129.132.210.223]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188391>

Since its very first description of -k, the documentation for
git-mailinfo claimed that (in the case without -k) after cleaning up
bracketed strings [blah], it would insert [PATCH].

It doesn't; on the contrary, one of the important jobs of mailinfo is
to remove those strings.

Since we're already there, rewrite the paragraph to give a complete
enumeration of all the transformations.  Specifically, it was missing
the whitespace normalization (run of isspace(c) -> ' ') and the
removal of leading ':'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-mailinfo.txt |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 51dc325..97e7a8e 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -25,13 +25,24 @@ command directly.  See linkgit:git-am[1] instead.
 OPTIONS
 -------
 -k::
-	Usually the program 'cleans up' the Subject: header line
-	to extract the title line for the commit log message,
-	among which (1) remove 'Re:' or 're:', (2) leading
-	whitespaces, (3) '[' up to ']', typically '[PATCH]', and
-	then prepends "[PATCH] ".  This flag forbids this
-	munging, and is most useful when used to read back
-	'git format-patch -k' output.
+	Usually the program removes email cruft from the Subject:
+	header line to extract the title line for the commit log
+	message.  This option prevents this munging, and is most
+	useful when used to read back 'git format-patch -k' output.
++
+Specifically, the following are removed until none of them remain:
++
+--
+*	Leading and trailing whitespace.
+
+*	Leading `Re:`, `re:`, and `:`.
+
+*	Leading bracketed strings (between `[` and `]`, usually
+	`[PATCH]`).
+--
++
+Finally, runs of whitespace are normalized to a single ASCII space
+character.
 
 -b::
 	When -k is not in effect, all leading strings bracketed with '['
-- 
1.7.9.rc0.168.g3847c
