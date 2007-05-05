From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] Add colour support in rebase and merge tree diff stats output.
Date: Sat,  5 May 2007 16:48:54 -0400
Message-ID: <1178398134288-git-send-email-jbowes@dangerouslyinc.com>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat May 05 22:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkRHO-0001eG-OQ
	for gcvg-git@gmane.org; Sat, 05 May 2007 22:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933354AbXEEUyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 16:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933404AbXEEUyz
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 16:54:55 -0400
Received: from ms-smtp-04.southeast.rr.com ([24.25.9.103]:49188 "EHLO
	ms-smtp-04.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933354AbXEEUyy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 16:54:54 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-04.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l45Ksq4h003686;
	Sat, 5 May 2007 16:54:52 -0400 (EDT)
X-Mailer: git-send-email 1.5.2.rc1.741.g85102-dirty
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46286>

The rebase and merge commands used diff-tree to display the summary stats of
what files had changed from the operation. diff-tree does not read the
diff ui configuration options, so the diff.color setting was not used.

Have rebase and merge call diff rather than diff-tree, which does read the
diff ui options.

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 
I'm not sure if setting GIT_PAGER to '' is the best way to disable the pager
in this case (though I'm quite certain it should be disabled), but it does
the trick. Perhaps there should be a git --no-pager option?

 git-merge.sh  |    3 ++-
 git-rebase.sh |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 7ebbce4..351676f 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -90,7 +90,8 @@ finish () {
 	?*)
 		case "$no_summary" in
 		'')
-			git-diff-tree --stat --summary -M "$head" "$1"
+			# We want color (if set), but no pager
+			GIT_PAGER='' git-diff --stat --summary -M "$head" "$1"
 			;;
 		esac
 		;;
diff --git a/git-rebase.sh b/git-rebase.sh
index 2dc2c4f..61770b5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -307,7 +307,8 @@ fi
 if test -n "$verbose"
 then
 	echo "Changes from $mb to $onto:"
-	git-diff-tree --stat --summary "$mb" "$onto"
+	# We want color (if set), but no pager
+	GIT_PAGER='' git-diff --stat --summary "$mb" "$onto"
 fi
 
 # Rewind the head to "$onto"; this saves our current head in ORIG_HEAD.
-- 
1.5.2.rc1.741.g85102-dirty
