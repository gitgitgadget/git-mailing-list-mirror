From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] hooks--commit-msg: no silent exit on duplicate Signed-off-by lines
Date: Sun, 13 Aug 2006 19:43:58 -0700 (PDT)
Message-ID: <20060814024358.20988.qmail@web31803.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-255727528-1155523438=:17553"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Aug 14 04:44:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCSQy-0007Lc-5o
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 04:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWHNCoD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 22:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWHNCoD
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 22:44:03 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:27008 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751800AbWHNCn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 22:43:59 -0400
Received: (qmail 20990 invoked by uid 60001); 14 Aug 2006 02:43:58 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=G4wbifTZZDfWYlCv4V8SGSDRoMeINoMY1FeVV5CVhNzD2sRGlyFg0our83qFAY2YdByxktbSodxFrgDODII0AMiznHc7iLClFaTxVFyhozUUesNBP/iqtsukZOEB4OFv1uV8FHdnadZhmJPCJaoQca8lblmEHF96DN+G3ykyiPk=  ;
Received: from [71.80.231.253] by web31803.mail.mud.yahoo.com via HTTP; Sun, 13 Aug 2006 19:43:58 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25311>

--0-255727528-1155523438=:17553
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

The commit-msg hook would silently exit if duplicate
Signed-off-by lines were found.  Users of git-commit would
not know it, unless they checked '$?'.  This patch makes the
commit-msg hook actually print out a message that duplicate
Signed-off-lines were found (and thus nothing were
committed).

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 templates/hooks--commit-msg |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)
--0-255727528-1155523438=:17553
Content-Type: text/inline; name="pa.patch"
Content-Description: 384313333-pa.patch
Content-Disposition: name="pa.patch"; filename="pa.patch"

diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg
index 23617f3..ec2b017 100644
--- a/templates/hooks--commit-msg
+++ b/templates/hooks--commit-msg
@@ -10,5 +10,8 @@ # To enable this hook, make this file ex
 
 # This example catches duplicate Signed-off-by lines.
 
-test "" = "$(grep '^Signed-off-by: ' "$1" |
-	 sort | uniq -c | sed -e '/^[ 	]*1[ 	]/d')"
+if [ -n "$(grep '^Signed-off-by: ' "$1" |
+	sort | uniq -c | sed -e '/^[ 	]*1[ 	]/d')" ] ; then
+    echo "Duplicate Signed-off-by lines in commit message"
+    exit 1
+fi
-- 
1.4.2.g73dbd

--0-255727528-1155523438=:17553--
