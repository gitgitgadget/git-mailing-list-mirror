From: Adam Roben <aroben@apple.com>
Subject: [PATCH] Documentation/git-svn: Instructions for cloning a git-svn-created repository
Date: Mon,  6 Aug 2007 01:16:43 -0700
Message-ID: <1186388203181-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Eric Wong <normalperson@yhbt.net>,
	Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 10:16:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHxll-0007kx-GR
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 10:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366AbXHFIQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 04:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757508AbXHFIQp
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 04:16:45 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:62841 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355AbXHFIQo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 04:16:44 -0400
Received: from relay5.apple.com (relay5.apple.com [17.128.113.35])
	by mail-out3.apple.com (Postfix) with ESMTP id E9848DAC8E1;
	Mon,  6 Aug 2007 01:16:43 -0700 (PDT)
Received: from relay5.apple.com (unknown [127.0.0.1])
	by relay5.apple.com (Symantec Mail Security) with ESMTP id D14E829C003;
	Mon,  6 Aug 2007 01:16:43 -0700 (PDT)
X-AuditID: 11807123-a7a49bb000007d99-12-46b6d8eb5d90
Received: from localhost.localdomain (unknown [17.151.100.170])
	by relay5.apple.com (Apple SCV relay) with ESMTP id 90E7F30400B;
	Mon,  6 Aug 2007 01:16:43 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.2
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55122>

These instructions tell you how to create a clone of a repository created with
git-svn, that can in turn be used with git-svn.

Signed-off-by: Adam Roben <aroben@apple.com>
---
> gitster: (3) you prepare one git-svn managed git repository, allow others to
> clone it via git, and have each of these cloned git repositories to interact
> with svn via git-svn -- this third mode of operation is not supported.
> 
> spearce: be nice if someone who cared about git-svn supporting (3) either wrote
> a patch for the documentation, or taught the tool how to do this more
> automatically.

Here's that patch. Maybe I'll get around to Shawn's second (far more ideal)
suggestion sometime.

 Documentation/git-svn.txt |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 0a210e4..3e3b597 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -435,6 +435,25 @@ Tracking and contributing to an entire Subversion-managed project
 # of dcommit/rebase/show-ignore should be the same as above.
 ------------------------------------------------------------------------
 
+The initial 'git-svn clone' Subversion can be quite time-consuming (especially
+for large repositories). If multiple people (or one person with multiple
+machines) want to use git-svn to interact with the same Subversion repository,
+you can do the initial 'git-svn clone' to a repository on a server and have
+each person clone that repository with 'git clone':
+
+------------------------------------------------------------------------
+# Do the initial import on a server
+	ssh server "cd /pub && git-svn clone http://svn.foo.org/project
+# Clone locally
+	git clone server:/pub/project
+# Tell git-svn which branch contains the Subversion commits
+	git update-ref refs/remotes/git-svn origin/master
+# Initialize git-svn locally (be sure to use the same URL and -T/-b/-t options as were used on server)
+	git-svn init http://svn.foo.org/project
+# Pull the latest changes from Subversion
+	git-svn rebase
+------------------------------------------------------------------------
+
 REBASE VS. PULL/MERGE
 ---------------------
 
-- 
1.5.2.2
