From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/7] Add specification of git-vcs-* helper programs
Date: Wed, 27 May 2009 14:15:29 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905271403570.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 20:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Nfj-0001Hm-Aq
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 20:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbZE0SPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 14:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763445AbZE0SPc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 14:15:32 -0400
Received: from iabervon.org ([66.92.72.58]:46847 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933045AbZE0SP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 14:15:29 -0400
Received: (qmail 18390 invoked by uid 1000); 27 May 2009 18:15:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 May 2009 18:15:29 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120085>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
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
1.6.0.6
