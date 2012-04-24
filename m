From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH] gitweb: Don't set owner if got empty value from
 projects.list
Date: Tue, 24 Apr 2012 19:50:05 +0200
Message-ID: <20120424175005.GD15600@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:50:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMjsl-0002vp-Kq
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 19:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757125Ab2DXRuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 13:50:19 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:53868 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481Ab2DXRuS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 13:50:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id A68475F004F;
	Tue, 24 Apr 2012 19:51:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2pLu4wTiZs0f; Tue, 24 Apr 2012 19:50:59 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 5873E5F0047;
	Tue, 24 Apr 2012 19:50:59 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 8E0864671B; Tue, 24 Apr 2012 19:50:05 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196232>

Prevent setting owner to an empty value if it is not specified in
projects.list file. Otherwise it stops retrieving information about the
owner from other files.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
The change is necessary due to 14b289bdf7c31176dc525cbe81173ec636598782:
"gitweb: Refactor checking if part of project info need filling", which
replaced !defined with !exists in check if owner is set.  

 gitweb/gitweb.perl |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3aeeb8b..adb0caa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2906,9 +2906,11 @@ sub git_get_projects_list {
 			}
 			if (check_export_ok("$projectroot/$path")) {
 				my $pr = {
-					path => $path,
-					owner => to_utf8($owner),
+					path => $path
 				};
+				if ($owner) {
+					$pr->{'owner'} = to_utf8($owner);
+				}
 				push @list, $pr;
 			}
 		}
-- 
1.7.10

-- 
  Kacper Kornet
