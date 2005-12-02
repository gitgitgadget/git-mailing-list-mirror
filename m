From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge-one-file: make sure we do not mismerge symbolic links.
Date: Fri, 02 Dec 2005 01:15:35 -0800
Message-ID: <7vu0dr7tc8.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
	<7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
	<Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
	<7vslte1y5z.fsf@assigned-by-dhcp.cox.net>
	<7v8xv39a8z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 02 10:17:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei712-0004ZG-OD
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 10:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbVLBJPh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 04:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbVLBJPh
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 04:15:37 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5782 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751764AbVLBJPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 04:15:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202091458.JKIL20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 04:14:58 -0500
To: git@vger.kernel.org
In-Reply-To: <7v8xv39a8z.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Dec 2005 00:25:00 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13109>

We ran "merge" command on O->A, O->B, A!=B case without verifying
the path involved is not a symlink.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-merge-one-file.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

01655e7c9a0b05d930aa7e27e74f75e086005bfc
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 906098d..c262dc6 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -58,6 +58,14 @@ case "${1:-.}${2:-.}${3:-.}" in
 # Modified in both, but differently.
 #
 "$1$2$3" | ".$2$3")
+
+	case ",$6,$7," in
+	*,120000,*)
+		echo "ERROR: $4: Not merging symbolic link changes."
+		exit 1
+		;;
+	esac
+
 	src2=`git-unpack-file $3`
 	case "$1" in
 	'')
-- 
0.99.9.GIT
