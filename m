From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 5/9] rebase: remove useless arguments check
Date: Sat,  1 Feb 2014 02:18:02 +0000
Message-ID: <1391221086-1044384-6-git-send-email-sandals@crustytoothpaste.net>
References: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 01 03:19:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9QAl-0008V4-KD
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 03:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbaBACSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 21:18:45 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51554 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754413AbaBACSN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jan 2014 21:18:13 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0EA1928082;
	Sat,  1 Feb 2014 02:18:12 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc1.1006.g81f3755.dirty
In-Reply-To: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241338>

From: Nicolas Vigier <boklm@mars-attacks.org>

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
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-rebase.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index c1f98ae..d1835ba 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -238,12 +238,10 @@ do
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
1.9.rc1.1006.g13f506b.dirty
