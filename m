From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] Add warning about known issues to documentation of
	cvsimport
Date: Mon, 23 Mar 2009 20:53:05 +0100
Message-ID: <20090323195304.GC26678@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 20:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlqEO-0005CD-7g
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 20:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283AbZCWTxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 15:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757492AbZCWTxK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 15:53:10 -0400
Received: from darksea.de ([83.133.111.250]:35911 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754434AbZCWTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 15:53:09 -0400
Received: (qmail 30709 invoked from network); 23 Mar 2009 20:52:53 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Mar 2009 20:52:53 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114345>

The described issues are compiled from the tests by Michael Haggerty and me.
Because it is not apparent that these can be fixed anytime soon at least warn
unwary users not to rely on the inbuilt cvsimport to much.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-cvsimport.txt |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index b7a8c10..3123725 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -24,6 +24,9 @@ repository, or incrementally import into an existing one.
 Splitting the CVS log into patch sets is done by 'cvsps'.
 At least version 2.1 is required.
 
+*WARNING:* for certain situations the import leads to incorrect results.
+Please see the section <<issues,ISSUES>> for further reference.
+
 You should *never* do any work of your own on the branches that are
 created by 'git-cvsimport'.  By default initial import will create and populate a
 "master" branch from the CVS repository's main branch which you're free
@@ -164,6 +167,37 @@ If '-v' is specified, the script reports what it is doing.
 Otherwise, success is indicated the Unix way, i.e. by simply exiting with
 a zero exit status.
 
+[[issues]]
+ISSUES
+------
+Problems related to timestamps:
+
+ * If timestamps of commits in the cvs repository are not stable enough
+   to be used for ordering commits
+ * If any files were ever "cvs import"ed more than once (e.g., import of
+   more than one vendor release)
+ * If the timestamp order of different files cross the revision order
+   within the commit matching time window
+
+Problems related to branches:
+
+ * Branches on which no commits have been made are not imported
+ * All files from the branching point are added to a branch even if
+   never added in cvs
+ * files added to the source branch *after* a daughter branch was
+   created: If previously no commit was made on the daugther branch they
+   will erroneously be added to the daughter branch in git
+
+Problems related to tags:
+
+* Multiple tags on the same revision are not imported
+
+If you suspect that any of these issues may apply to the repository you
+want to import consider using these alternative tools which proved to be
+more stable in practise:
+
+* cvs2git (part of cvs2svn), `http://cvs2svn.tigris.org`
+* parsecvs, `http://cgit.freedesktop.org/~keithp/parsecvs`
 
 Author
 ------
-- 
1.6.1.2.390.gba743
