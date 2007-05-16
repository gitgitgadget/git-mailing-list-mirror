From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7/6] gitweb: Empty patch for merge means trivial merge, not no differences
Date: Thu, 17 May 2007 00:05:55 +0200
Message-ID: <11793531552023-git-send-email-jnareb@gmail.com>
References: <11784930091585-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 00:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoRYh-0005dF-03
	for gcvg-git@gmane.org; Thu, 17 May 2007 00:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760863AbXEPWBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 18:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760974AbXEPWBQ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 18:01:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:60601 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760863AbXEPWBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 18:01:15 -0400
Received: by ug-out-1314.google.com with SMTP id 44so208359uga
        for <git@vger.kernel.org>; Wed, 16 May 2007 15:01:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gWSgLRpQMpw3wWIl7yA+XoPYaBeAIccaIDcHl7edLdVAL3HRFhoANOktG6JYWmeq1FSdnRCn+xdEcCJx4cmev0y3u2OLTvni+H/3tCnxtpXH9JmJ634fpDfvejPlrRvRPO8cwERTJ7e48y19PHefONDEbjjT8YvxagmopFNUtoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lorkaVexFi2xHFzco9FO7g+BLzPgsO6v/pyX/uAJ2gadYRYS4J9361dGGDTVgpZbmrtg31lCl2p4NXmESP2YG7o1rcu0pGRiQGxKbZqoj84ZoF+kbBAlC67neveqFDT5losfWJ+UiMWmYYmw+XFGfwSMK5BnazBIrfQKzcEJxgU=
Received: by 10.67.100.17 with SMTP id c17mr6989048ugm.1179352874430;
        Wed, 16 May 2007 15:01:14 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id j2sm7220175mue.2007.05.16.15.01.12;
        Wed, 16 May 2007 15:01:13 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4GM5wdg031615;
	Thu, 17 May 2007 00:05:58 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4GM5tq9031613;
	Thu, 17 May 2007 00:05:56 +0200
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <11784930091585-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47462>

Earlier commit 4280cde95fa4e3fb012eb6d0c239a7777baaf60c made gitweb
show "No differences found" message for empty diff, for the HTML
output. But for merge commits, either -c format we use or --cc format,
empty diff doesn't mean no differences, but trivial merge.

Show "Trivial merge" message instead of "No differences found" for
merges.

While at it reword conditional in the code for easier reading.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 549e027..8c688be 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2877,7 +2877,14 @@ sub git_patchset_body {
 	} continue {
 		print "</div>\n"; # class="patch"
 	}
-	print "<div class=\"diff nodifferences\">No differences found</div>\n" if (!$patch_number);
+
+	if ($patch_number == 0) {
+		if (@hash_parents > 1) {
+			print "<div class=\"diff nodifferences\">Trivial merge</div>\n";
+		} else {
+			print "<div class=\"diff nodifferences\">No differences found</div>\n";
+		}
+	}
 
 	print "</div>\n"; # class="patchset"
 }
-- 
1.5.1.4
