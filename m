From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Sat, 03 Jun 2006 13:11:48 -0400
Message-ID: <11493547080-git-send-email-vonbrand@inf.utfsm.cl>
Reply-To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 20:12:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmab5-0007TI-1j
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 20:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWFCSLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 14:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWFCSLg
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 14:11:36 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:17134 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751771AbWFCSLf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 14:11:35 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53IBQDf021653
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 14:11:26 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53HBn47010825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 13:11:49 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53HBmWd010824;
	Sat, 3 Jun 2006 13:11:48 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
X-Greylist: Delayed for 00:59:32 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 14:11:26 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21201>

- Fix the regular expressions for local addresses
- Fix the fallback regexp for non-local addresses, simplify the logic

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 git-send-email.perl |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ed1d89b..a7a7797 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -314,18 +314,15 @@ sub extract_valid_address {
 	my $address = shift;
 
 	# check for a local address:
-	return $address if ($address =~ /^([\w\-]+)$/);
+	return $address if ($address =~ /^([\w\-.]+)$/);
 
 	if ($have_email_valid) {
 		return Email::Valid->address($address);
 	} else {
 		# less robust/correct than the monster regexp in Email::Valid,
 		# but still does a 99% job, and one less dependency
-		my $cleaned_address;
-		if ($address =~ /([^\"<>\s]+@[^<>\s]+)/) {
-			$cleaned_address = $1;
-		}
-		return $cleaned_address;
+		$address =~ /([\w\-.]+@[\w\-.]+)/;
+		return $1;
 	}
 }
 
-- 
1.3.3.g86f7
