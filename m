From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix empty line processing in git-shortlog.perl
Date: Sun, 06 Nov 2005 23:42:18 +0100
Message-ID: <20051106224218.22797.97260.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 23:42:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYtDY-0001eu-3g
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 23:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVKFWmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVKFWmU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 17:42:20 -0500
Received: from w241.dkm.cz ([62.24.88.241]:44233 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751258AbVKFWmU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 17:42:20 -0500
Received: (qmail 22809 invoked from network); 6 Nov 2005 23:42:18 +0100
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 6 Nov 2005 23:42:18 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11234>

Faced with a commit such as

	commit f1b2646c7f2713c3ea4bce120e1d0d8091808be4
	Author: Adrian Bunk <bunk@r063144.stusta.swh.mhn.de>
	Date:   Sun Nov 6 20:30:38 2005 +0100

	    From: Michal Wronski <wrona@mat.uni.torun.pl>

	    I've jchanged my email. Please apply this patch so as to everybody
	    could send me a remarks about mqueuefs.

	    Signed-off-by: Michal Wronski <Michal.Wronski@motorola.com>
	    Signed-off-by: Adrian Bunk <bunk@stusta.de>

git-shortlog.perl would produce a line with an empty commit title.

This patch fixes that. I believe that just changing the last * to + in the
original regexp would work, but Adrian says it doesn't fix it for him, and
I believe this regexp is way clearer anyway. This is also the original
regexp used before a24e658649170c99fdcb4aaa41545679ad02f755.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-shortlog.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-shortlog.perl b/git-shortlog.perl
index 0b14f83..7283159 100755
--- a/git-shortlog.perl
+++ b/git-shortlog.perl
@@ -94,7 +94,7 @@ sub changelog_input {
 
 		# skip to non-blank line
 		elsif ($pstate == 3) {
-			next unless /^\s*?(.*)/;
+			next unless /^\s*?(\S.*)$/;
 
 			# skip lines that are obviously not
 			# a 1-line cset description
