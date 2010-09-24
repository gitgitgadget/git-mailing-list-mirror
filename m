From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 06/12] gitweb: allow extra text after action in page header
Date: Fri, 24 Sep 2010 18:02:41 +0200
Message-ID: <1285344167-8518-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:04:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAlE-0006Mx-GT
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364Ab0IXQDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:03:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40483 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354Ab0IXQDq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:03:46 -0400
Received: by wyb28 with SMTP id 28so2051554wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OrutnYZaXLrjm0pja+XxnVmprxQp0aHU1NpT4PQ5s9w=;
        b=moclMnTtjguto6E0gPLiPZfZKRPOCVs6xCKurNp5iZPagcgF8aaZLXapPNbVDEp228
         WKzjuQ3S+xiqpyg4mdlLnc8cT/VLI8V7TuhAJcQ51GJ9JDvgT4sC03J/0y/bislzjDFx
         BCfA5GRKEDCyBLRkXSwXvaIc1GE7+7qZCPsno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lD9aVB/OTeySBA+xeMyOVT7HnQdQXs0bBZ3WvmVdrXpzQRumc4R8phoix7wBWWm28V
         mqrwqWpJ+dVo+QuVmsF/X+T0RvPzaMERU/Cd/LsZLN8ZBqiqdbLsqPDZr/XOO2YaZ5K5
         BucXBgGJ+rlXOgPEC6w/IfSpph+v5y3Qit5D0=
Received: by 10.216.144.22 with SMTP id m22mr2299023wej.0.1285344224862;
        Fri, 24 Sep 2010 09:03:44 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id p45sm1429152weq.45.2010.09.24.09.03.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:03:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157006>

This extra text is intended to 'specify' the action. Therefore, if it's
present, the action name in the header will be turned into a link to
the action itself but without specifying any parameter.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e70897e..76cf806 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3514,7 +3514,15 @@ EOF
 	if (defined $project) {
 		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
 		if (defined $action) {
-			print " / $action";
+			my $action_print = $action ;
+			if (defined $opts{'header_extra'}) {
+				$action_print = $cgi->a({-href => href(action=>$action)},
+					esc_html($action));
+			}
+			print " / $action_print";
+		}
+		if (defined $opts{'header_extra'}) {
+			print " / $opts{'header_extra'}";
 		}
 		print "\n";
 	}
-- 
1.7.3.68.g6ec8
