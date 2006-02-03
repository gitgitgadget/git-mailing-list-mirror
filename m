From: Amos Waterland <apw@us.ibm.com>
Subject: [PATCH] do not open editor in dumb terminal
Date: Fri, 3 Feb 2006 06:41:33 -0500
Message-ID: <20060203114133.GA11499@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, boutcher@cs.umn.edu
X-From: git-owner@vger.kernel.org Fri Feb 03 12:41:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4zJr-0005Fj-Jp
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 12:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWBCLlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 06:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWBCLlg
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 06:41:36 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49612 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964780AbWBCLlg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 06:41:36 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k13BfZQV007588
	for <git@vger.kernel.org>; Fri, 3 Feb 2006 06:41:35 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k13BfZXV203598
	for <git@vger.kernel.org>; Fri, 3 Feb 2006 06:41:35 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k13BfYcC004823
	for <git@vger.kernel.org>; Fri, 3 Feb 2006 06:41:35 -0500
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k13BfYYX004820;
	Fri, 3 Feb 2006 06:41:34 -0500
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1F4zJl-00035S-OW; Fri, 03 Feb 2006 06:41:33 -0500
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15537>

Many people run git from a shell in emacs (obtained by M-x shell).  When
they try to do a commit without specifying a log message on the command
line with -m, git opens vi inside emacs, with unpleasant results.  I
think the right answer is to just refuse to open an editor in any dumb
terminal.

Signed-off-by: Amos Waterland <apw@us.ibm.com>
Cc: Dave C Boutcher <boutcher@cs.umn.edu>

---

 git-commit.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

c0ee93460521c1cbf9d3fe86a08b41295a79ebb1
diff --git a/git-commit.sh b/git-commit.sh
index 193feeb..fef8f96 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -207,6 +207,12 @@ then
 fi
 case "$no_edit" in
 '')
+	if [ "$TERM" = "dumb" ]; then
+		printf "%s: %s: %s\n" "git-commit" \
+			"cannot open editor in a dumb terminal" \
+			"use -m to supply message" >&2
+		exit 1
+	fi
 	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
-- 
1.1.6.g46dc-dirty
