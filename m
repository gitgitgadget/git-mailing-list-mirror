From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: [PATCH] Use standard -t option for touch.
Date: Thu, 18 Jan 2007 11:18:51 +0100
Message-ID: <20070118102814.0C32FA914@diphong.localdomain>
X-From: git-owner@vger.kernel.org Thu Jan 18 11:28:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7UVI-0006mK-DO
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 11:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbXARK2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 05:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbXARK2R
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 05:28:17 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:49144 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbXARK2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 05:28:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id BD89128161;
	Thu, 18 Jan 2007 11:28:14 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id g8maeU+8eZgK; Thu, 18 Jan 2007 11:28:14 +0100 (CET)
Received: from diphong.localdomain (ppp-62-216-203-232.dynamic.mnet-online.de [62.216.203.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 8976D28160;
	Thu, 18 Jan 2007 11:28:14 +0100 (CET)
Received: by diphong.localdomain (Postfix, from userid 1001)
	id 0C32FA914; Thu, 18 Jan 2007 11:28:14 +0100 (CET)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37075>

Non-GNU touch do not have the -d option to take free form
date strings.  The POSIX -t option should be more widespread.
For this to work, date needs to output YYYYMMDDHHMM.SS date strings.

Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
---
 t/t4200-rerere.sh |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 5ee5b23..91be272 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -120,29 +120,29 @@ case "$(date -d @11111111 +%s 2>/dev/null)" in
 	just_over_15_days_ago=$(($now-1-15*86400))
 	almost_60_days_ago=$(($now+60-60*86400))
 	just_over_60_days_ago=$(($now-1-60*86400))
-	predate1="$(date -d "@$almost_60_days_ago" +%c)"
-	predate2="$(date -d "@$almost_15_days_ago" +%c)"
-	postdate1="$(date -d "@$just_over_60_days_ago" +%c)"
-	postdate2="$(date -d "@$just_over_15_days_ago" +%c)"
+	predate1="$(date -d "@$almost_60_days_ago" +%Y%m%d%H%M.%S)"
+	predate2="$(date -d "@$almost_15_days_ago" +%Y%m%d%H%M.%S)"
+	postdate1="$(date -d "@$just_over_60_days_ago" +%Y%m%d%H%M.%S)"
+	postdate2="$(date -d "@$just_over_15_days_ago" +%Y%m%d%H%M.%S)"
 	;;
 *)
 	# it is not GNU date. oh, well.
-	predate1="$(date)"
-	predate2="$(date)"
-	postdate1='1 Oct 2006 00:00:00'
-	postdate2='1 Dec 2006 00:00:00'
+	predate1="$(date +%Y%m%d%H%M.%S)"
+	predate2="$(date +%Y%m%d%H%M.%S)"
+	postdate1='200610010000.00'
+	postdate2='200612010000.00'
 esac
 
-touch -m -d "$predate1" $rr/preimage
-touch -m -d "$predate2" $rr2/preimage
+touch -m -t "$predate1" $rr/preimage
+touch -m -t "$predate2" $rr2/preimage
 
 test_expect_success 'garbage collection (part1)' 'git rerere gc'
 
 test_expect_success 'young records still live' \
 	"test -f $rr/preimage -a -f $rr2/preimage"
 
-touch -m -d "$postdate1" $rr/preimage
-touch -m -d "$postdate2" $rr2/preimage
+touch -m -t "$postdate1" $rr/preimage
+touch -m -t "$postdate2" $rr2/preimage
 
 test_expect_success 'garbage collection (part2)' 'git rerere gc'
 
-- 
1.5.0.rc1.g8bef
