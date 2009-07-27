From: Johan Herland <johan@herland.net>
Subject: [RFC 01/11] Add specification of git-vcs-* helper programs
Date: Mon, 27 Jul 2009 03:04:09 +0200
Message-ID: <1248656659-21415-2-git-send-email-johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 03:05:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVEek-000457-AU
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 03:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbZG0BF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 21:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755117AbZG0BF0
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 21:05:26 -0400
Received: from mx.getmail.no ([84.208.15.66]:43054 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754775AbZG0BFZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 21:05:25 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF0077W1P1ZF40@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:25 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF004SX1O2UG30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:25 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.27.4819
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248656659-21415-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124143>

From: Daniel Barkalow <barkalow@iabervon.org>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-vcs.txt |   77 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-vcs.txt

diff --git a/Documentation/git-vcs.txt b/Documentation/git-vcs.txt
new file mode 100644
index 0000000..402c927
--- /dev/null
+++ b/Documentation/git-vcs.txt
@@ -0,0 +1,77 @@
+git-vcs(1)
+============
+
+NAME
+----
+git-vcs - Helper programs for interoperation with foreign systems
+
+SYNOPSIS
+--------
+'git vcs-<system>' <remote>
+
+DESCRIPTION
+-----------
+
+These programs are normally not used directly by end users, but are
+invoked by various git programs that interact with remote repositories
+when the repository they would operate on uses a foreign system.
+
+Each 'git vcs-<system>' is a helper for interoperating with a
+particular version control system. Different helpers have different
+capabilities (limited both by the particular helper and by the
+capabilities of the system they connect to), and they report what
+capabilities they support.
+
+These programs can store refs in refs/<system>/*, and arbitrary
+information in info/<system>.
+
+COMMANDS
+--------
+
+Commands are given by the caller on the helper's standard input, one per line.
+
+'capabilities'::
+	Outputs a single line with a list of feature names separated
+	by spaces. Each of these indicates a supported feature of the
+	helper, and the caller will only attempt operations that are
+	supported.
+
+'list'::
+	Outputs the names of refs, one per line. These may be
+	followed, after a single space, by "changed" or "unchanged",
+	indicating whether the foreign repository has changed from the
+	state in the ref. If the helper doesn't know, it doesn't have
+	to provide a value. (In particular, it shouldn't do expensive
+	operations, such as importing the content, to see whether it
+	matches.) Other information, not yet supported, may be output
+	as well, separated by single spaces.
+
+'import' ref::
+	Imports the given ref by outputting it in git-fast-import
+	format.
+
+'export' commit ref::
+	Sends the given commit to the foreign system, with the
+	location given by ref, and reimports it by outputting it in
+	git-fast-import format as the foreign system rendered it.
++
+All parents of commit must either have been created with 'import' or
+have been passed to 'export' previously. Depending on the features,
+there may be other restrictions on what may be exported.
+
+FEATURES
+--------
+
+'export'::
+	Helper supports exporting commits, at least exporting
+	non-merge commits whose parents are not the parents of any
+	other commit exported to the same branch or make in the other
+	system on the same branch.
+
+'export-branch'::
+	Helper supports creating new branches by exporting commits to
+	them.
+
+'export-merges'::
+	Helper supports exporting two-parent merges, where both
+	parents have already been exported successfully.
-- 
1.6.4.rc3.138.ga6b98.dirty
