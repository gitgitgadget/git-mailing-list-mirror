From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] git-request-pull: add --stat option
Date: Thu, 24 Apr 2014 11:29:23 +0200
Message-ID: <1398331763-601-1-git-send-email-jslaby@suse.cz>
Cc: git@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 24 11:29:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdFyN-0002YI-2o
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 11:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbaDXJ3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 05:29:31 -0400
Received: from ip4-83-240-18-248.cust.nbox.cz ([83.240.18.248]:58971 "EHLO
	ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754814AbaDXJ31 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Apr 2014 05:29:27 -0400
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.80.1)
	(envelope-from <jslaby@suse.cz>)
	id 1WdFy7-0000AL-LA; Thu, 24 Apr 2014 11:29:23 +0200
X-Mailer: git-send-email 1.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246952>

Which is passed on to git diff. I very need this option instead of
changing the terminal size.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 git-request-pull.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 5c1599752314..a23f03fddec0 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -13,6 +13,7 @@ OPTIONS_STUCKLONG=
 OPTIONS_SPEC='git request-pull [options] start url [end]
 --
 p    show patch text as well
+stat= specify stat output (see man git-diff for details)
 '
 
 . git-sh-setup
@@ -21,11 +22,16 @@ GIT_PAGER=
 export GIT_PAGER
 
 patch=
+stat=--stat
 while	case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	-p)
 		patch=-p ;;
+	--stat)
+		stat="$1=$2"
+		shift
+		;;
 	--)
 		shift; break ;;
 	-*)
@@ -152,6 +158,6 @@ then
 fi &&
 
 git shortlog ^$baserev $headrev &&
-git diff -M --stat --summary $patch $merge_base..$headrev || status=1
+git diff -M $stat --summary $patch $merge_base..$headrev || status=1
 
 exit $status
-- 
1.9.2
