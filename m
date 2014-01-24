From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 5/9] rebase: remove useless arguments check
Date: Fri, 24 Jan 2014 00:51:02 +0000
Message-ID: <1390524666-51274-6-git-send-email-sandals@crustytoothpaste.net>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 01:51:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Uzv-0001nj-1R
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 01:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbaAXAvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 19:51:40 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51331 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752902AbaAXAvU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 19:51:20 -0500
Received: from vauxhall.elevennetworks.com (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 85D9028082;
	Fri, 24 Jan 2014 00:51:19 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc0.1002.gd081c64.dirty
In-Reply-To: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240991>

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
1.9.rc0.1002.gd081c64.dirty
