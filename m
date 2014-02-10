From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 5/9] rebase: remove useless arguments check
Date: Mon, 10 Feb 2014 01:03:34 +0000
Message-ID: <1391994218-639101-6-git-send-email-sandals@crustytoothpaste.net>
References: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 10 02:04:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCfII-0001O6-CZ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 02:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbaBJBEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 20:04:05 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51745 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752097AbaBJBDq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Feb 2014 20:03:46 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4100F28086;
	Mon, 10 Feb 2014 01:03:45 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
In-Reply-To: <1391994218-639101-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241895>

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
1.9.0.rc3.1008.gd08b47c.dirty
