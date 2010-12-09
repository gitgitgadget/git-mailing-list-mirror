From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 05/18] gitweb: Regression fix concerning binary output of files
Date: Thu,  9 Dec 2010 13:57:11 -0800
Message-ID: <1291931844-28454-6-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoSz-0006x0-UC
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450Ab0LIVzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:55:52 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51849 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196Ab0LIVzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:51 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePp027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:49 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163338>

This solves the regression introduced with v7.2 of the gitweb-caching code,
fix proposed by Jakub in his e-mail.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3c3ff08..f2ef3da 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5664,7 +5664,7 @@ sub git_blob_plain {
 	if ($caching_enabled) {
 		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
 	}else{
-		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
+		open BINOUT, '>&', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
 	}
 	binmode BINOUT, ':raw';
 	print BINOUT <$fd>;
@@ -5957,7 +5957,7 @@ sub git_snapshot {
 	if ($caching_enabled) {
 		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
 	}else{
-		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
+		open BINOUT, '>&', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
 	}
 	binmode BINOUT, ':raw';
 	print BINOUT <$fd>;
-- 
1.7.2.3
