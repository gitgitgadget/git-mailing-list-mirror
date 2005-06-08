From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Fix git-merge-one-file permissions auto-merging
Date: Wed, 8 Jun 2005 23:26:55 +0200
Message-ID: <20050608212655.GQ982@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 23:23:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg80y-00033O-By
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 23:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVFHV1C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 17:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVFHV1C
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 17:27:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22498 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261799AbVFHV05 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 17:26:57 -0400
Received: (qmail 11748 invoked by uid 2001); 8 Jun 2005 21:26:55 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In the automerge case, permissions were not restored properly after the
merge tool was invoked and overwrote the target file.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit d0a0933d6ed6190a767f6baad6c93aa79b3901b2
tree 0a278964e7cd15b2f35b00551747c4908d65b244
parent 9d6694e94c2ff7fc24ecb4124234cef6c6037ad5
author Petr Baudis <pasky@ucw.cz> Wed, 08 Jun 2005 23:26:23 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Wed, 08 Jun 2005 23:26:23 +0200

 git-merge-one-file-script |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-merge-one-file-script b/git-merge-one-file-script
--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -63,10 +63,14 @@ case "${1:-.}${2:-.}${3:-.}" in
 	merge -p "$src1" "$orig" "$src2" > "$4"
 	ret=$?
 	rm -f -- "$orig" "$src1" "$src2"
+
 	if [ "$6" != "$7" ]; then
 		echo "ERROR: Permissions $5->$6->$7 don't match."
 		ret=1
 	fi
+	case "$6" in *7??) mode=+x;; *) mode=-x;; esac
+	chmod "$mode" "$4"
+
 	if [ $ret -ne 0 ]; then
 		# Reset the index to the first branch, making
 		# git-diff-file useful

|
-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
