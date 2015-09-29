From: Lars Wendler <polynomial-c@gentoo.org>
Subject: [PATCH] git-send-email.perl: Fixed sending of many changes/patches
Date: Tue, 29 Sep 2015 17:00:20 +0200
Message-ID: <1443538820-20023-1-git-send-email-polynomial-c@gentoo.org>
Cc: juston.h.li@gmail.com, Stefan Agner <stefan@agner.ch>,
	Lars Wendler <polynomial-c@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 17:01:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgwPA-0007ib-FA
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 17:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbbI2PBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 11:01:06 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:46127 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755533AbbI2PA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 11:00:56 -0400
Received: from shanghai.paradoxon.rec (p4FDA9A55.dip0.t-ipconnect.de [79.218.154.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: polynomial-c@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8499D3409FE;
	Tue, 29 Sep 2015 15:00:54 +0000 (UTC)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278825>

From: Stefan Agner <stefan@agner.ch>

See http://permalink.gmane.org/gmane.comp.version-control.git/274569

Reported-by: Juston Li <juston.h.li@gmail.com>
Tested-by: Markos Chandras <hwoarang@gentoo.org>
Signed-off-by: Lars Wendler <polynomial-c@gentoo.org>
---
 git-send-email.perl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e3ff44b..e907e0ea 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1365,7 +1365,11 @@ Message-Id: $message_id
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
 		$smtp->data or die $smtp->message;
-		$smtp->datasend("$header\n$message") or die $smtp->message;
+		$smtp->datasend("$header\n") or die $smtp->message;
+		my @lines = split /^/, $message;
+		foreach my $line (@lines) {
+			$smtp->datasend("$line") or die $smtp->message;
+		}
 		$smtp->dataend() or die $smtp->message;
 		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
 	}
-- 
2.6.0
