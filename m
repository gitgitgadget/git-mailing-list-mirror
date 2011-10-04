From: Sitaram Chamarty <sitaram@atc.tcs.com>
Subject: [PATCH] git-difftool: allow skipping file by typing 'n' at prompt
Date: Tue, 4 Oct 2011 16:23:33 +0530
Message-ID: <20111004105333.GA24331@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 04 13:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB34m-0004Fg-1F
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 13:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451Ab1JDLWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 07:22:15 -0400
Received: from atcmail.atc.tcs.co.in ([203.200.212.145]:47158 "EHLO
	atcmail.atc.tcs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419Ab1JDLWN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 07:22:13 -0400
X-Greylist: delayed 1704 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Oct 2011 07:22:13 EDT
Received: from atcmail.atc.tcs.com (atcmail.atc.tcs.com [127.0.0.1])
	by atcmail.atc.tcs.com (8.13.8/8.13.8) with ESMTP id p94ArcsD025817;
	Tue, 4 Oct 2011 16:23:38 +0530
Received: (from sitaram@localhost)
	by atcmail.atc.tcs.com (8.13.8/8.13.8/Submit) id p94ArXPb025816;
	Tue, 4 Oct 2011 16:23:33 +0530
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-Spam-Status: No, score=-3.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on atcmail.atc.tcs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182761>

Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
---

I'm using what is pretty much a universal convention to
signify that the default choice is "y"; I hope documentation
for something so small is not needed but if it is, let me
know and I'll do that also.

 git-difftool--helper.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 8452890..bc1b098 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -38,15 +38,16 @@ launch_merge_tool () {
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
+	ans=y
 	if should_prompt
 	then
 		printf "\nViewing: '$MERGED'\n"
 		if use_ext_cmd
 		then
-			printf "Hit return to launch '%s': " \
+			printf "Launch '%s' [y]/n: " \
 				"$GIT_DIFFTOOL_EXTCMD"
 		else
-			printf "Hit return to launch '%s': " "$merge_tool"
+			printf "Launch '%s' [y]/n: " "$merge_tool"
 		fi
 		read ans
 	fi
@@ -54,9 +55,9 @@ launch_merge_tool () {
 	if use_ext_cmd
 	then
 		export BASE
-		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
+		test "$ans" != "n" && eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
-		run_merge_tool "$merge_tool"
+		test "$ans" != "n" && run_merge_tool "$merge_tool"
 	fi
 }
 
-- 
1.7.6
