From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 2/2] cvsimport: add <remote>/HEAD reference in separate remotes more
Date: Mon, 04 Jun 2007 10:01:49 +0100
Message-ID: <b16b1562b7ac72cee8c402b702a750b6@pinky>
References: <4663D42A.7090201@shadowen.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 11:27:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv8q9-0000yh-0Z
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 11:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbXFDJ0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 05:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbXFDJ0z
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 05:26:55 -0400
Received: from 85-210-221-102.dsl.pipex.com ([85.210.221.102]:36122 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752794AbXFDJ0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 05:26:54 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1Hv8Rh-0005In-S8
	for git@vger.kernel.org; Mon, 04 Jun 2007 10:01:49 +0100
InReply-To: <4663D42A.7090201@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49089>


When in separate remote mode (via -r <remote>) we can now use
the name HEAD for the CVS HEAD.  In keeping with git-clone
remotes/<remote>/HEAD is creates as a symbolic ref to the user
specified name for the HEAD which defaults to master.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 7837c7b..598b9c8 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1026,6 +1026,8 @@ if ($orig_branch) {
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
 	system("git-update-ref", "refs/heads/master", "$remote/$opt_o")
 		unless -f "$git_dir/refs/heads/master";
+	system("git-symbolic-ref", "$remote/HEAD", "$remote/$opt_o")
+		if ($opt_r && $opt_o ne 'HEAD');
 	system('git-update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
 		system('git checkout');
