From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Improve error output of git-rebase without any arguments
Date: Sun, 17 Aug 2008 02:26:21 +0200
Message-ID: <1218932781-30475-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 02:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUW7V-0000Mq-73
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 02:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbYHQA01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 20:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYHQA01
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 20:26:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:58085 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751354AbYHQA00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 20:26:26 -0400
Received: (qmail invoked by alias); 17 Aug 2008 00:26:24 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp063) with SMTP; 17 Aug 2008 02:26:24 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX185l5EJz7k5w2/CJbCNjQ588rgEUhQEOTIiFePZCl
	XQ2rSJsOEWJHYw
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KUW69-0007vv-Ru; Sun, 17 Aug 2008 02:26:21 +0200
X-Mailer: git-send-email 1.6.0.rc3.308.g5b83
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92562>

"git rebase" without arguments on initial startup showed:

	fatal: Needed a single revision
	invalid upstream

This patch makes it show the ordinary usage string.
For the case that .git/rebase-{apply,merge} exists,

	A rebase is in progress, try --continue, --skip or --abort.

is shown now.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
	Stumbled across this today and looks for me like
	a patch for 1.6.0 :-)

 git-rebase.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 412e135..fe669ad 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -146,6 +146,12 @@ is_interactive () {
 
 is_interactive "$@" && exec git-rebase--interactive "$@"
 
+if test $# -eq 0
+then
+	test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
+	die 'A rebase is in progress, try --continue, --skip or --abort.'
+fi
+
 while test $# != 0
 do
 	case "$1" in
@@ -277,7 +283,7 @@ It seems that I cannot create a '"$GIT_DIR"'/rebase-apply directory,
 and I wonder if you are in the middle of patch application or another
 rebase.  If that is not the case, please
 	rm -fr '"$GIT_DIR"'/rebase-apply
- and run me again.  I am stopping in case you still have something
+and run me again.  I am stopping in case you still have something
 valuable there.'
 		exit 1
 	fi
-- 
1.6.0.rc3.308.g5b83
