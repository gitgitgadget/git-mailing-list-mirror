From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 5/8] rebase: remove useless arguments check
Date: Sun,  3 Nov 2013 16:54:21 +0100
Message-ID: <1383494064-5653-6-git-send-email-boklm@mars-attacks.org>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 16:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd011-0007zG-8t
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 16:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab3KCPyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 10:54:55 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:35793 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab3KCPyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 10:54:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id C19694941
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:55:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DFIcCCBJ5lfX; Sun,  3 Nov 2013 16:55:06 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id CA1F648BC;
	Sun,  3 Nov 2013 16:55:04 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 6EDCD43934; Sun,  3 Nov 2013 16:54:48 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237262>

Remove a check on the number of arguments for --onto and -x options.
It is not possible for $# to be <= 2 at this point :

 - if --onto or -x has an argument, git rev-parse --parseopt will
   provide something like this :
     set -- --onto 'x' --
   when parsing the "--onto" option, $# will be 3 or more if there are
   other options.

 - if --onto or -x doesn't have an argument, git rev-parse --parseopt
   will exit with an error and display usage information.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 git-rebase.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6ebef7e8b86e..6b9279a69028 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -236,12 +236,10 @@ do
 		action=${1##--}
 		;;
 	--onto)
-		test 2 -le "$#" || usage
 		onto="$2"
 		shift
 		;;
 	-x)
-		test 2 -le "$#" || usage
 		cmd="${cmd}exec $2${LF}"
 		shift
 		;;
-- 
1.8.4.2
