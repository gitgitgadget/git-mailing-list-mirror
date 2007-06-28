From: Alexandre Vassalotti <alexandre@peadrop.com>
Subject: [PATCH] git-tag: Fix the main while loop exit condition.
Date: Thu, 28 Jun 2007 12:56:57 -0400
Message-ID: <11830498172717-git-send-email-alexandre@peadrop.com>
Cc: Alexandre Vassalotti <alexandre@peadrop.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 18:53:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3xFO-0005gV-6a
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 18:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759287AbXF1Qxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 12:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758404AbXF1Qxc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 12:53:32 -0400
Received: from qb-out-0506.google.com ([72.14.204.230]:57645 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062AbXF1Qxb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 12:53:31 -0400
Received: by qb-out-0506.google.com with SMTP id e11so202321qbe
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 09:53:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:sender;
        b=bBNLBlqgJajzjRapKnUff0ejdH32G2tu0hUu629YYB/xM5kltnM+ejzZ26nSSgTpZq5I2lyYOunymFm4MP+3UAs7FX+6uB8pceWr3iz8o0HL4FWoWz/jSTN/H/nWPrSJ4U8MiFzEk2XmOD5edmh32CMaoYopsYaeyaTx790U8ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:sender;
        b=dryS7hYM0hI4mdkKEuO9n0lLPNW8y+u+ZU4j3bBUnuIH3+3QxBMhvfj7UV4ghsu0TRS7pzd+6QmjO9isBU8WkQFX7PcUJzbBaaDnXlX1JoCnHlLDaxgoLcdU89kC2KpO3AG1jwaiXQag8WKjsZ4mycPsddWbQrICwAozQhoZO2s=
Received: by 10.70.11.5 with SMTP id 5mr649959wxk.1183049610799;
        Thu, 28 Jun 2007 09:53:30 -0700 (PDT)
Received: from helios ( [69.70.201.158])
        by mx.google.com with ESMTP id i16sm2191600wxd.2007.06.28.09.53.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jun 2007 09:53:29 -0700 (PDT)
Received: from alex by helios with local (Exim 4.63)
	(envelope-from <alex@localhost>)
	id 1I3xIf-0006qy-S6; Thu, 28 Jun 2007 12:56:57 -0400
X-Mailer: git-send-email 1.5.2.1.144.gabc40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51118>

This stop git-tag from emitting a "shift: can't shift that many"
error, when listing tags.

Signed-off-by: Alexandre Vassalotti <alexandre@peadrop.com>
---
 git-tag.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-tag.sh b/git-tag.sh
index c840439..bc0d735 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -14,18 +14,20 @@ username=
 list=
 verify=
 LINES=0
-while case "$#" in 0) break ;; esac
-do
+while [ $# -ne 0 ]; do
     case "$1" in
     -a)
 	annotate=1
+	shift
 	;;
     -s)
 	annotate=1
 	signed=1
+	shift
 	;;
     -f)
 	force=1
+	shift
 	;;
     -n)
         case $2 in
@@ -36,6 +38,7 @@ do
 		[ -z "$LINES" ] && LINES=1 # 1 line is default when -n is used
 		;;
 	esac
+	shift
 	;;
     -l)
 	list=1
@@ -122,7 +125,6 @@ do
 	break
 	;;
     esac
-    shift
 done
 
 [ -n "$list" ] && exit 0
-- 
1.5.2.1.144.gabc40
