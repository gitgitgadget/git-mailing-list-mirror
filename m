From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] Escape project names before creating pathinfo URLs
Date: Sun, 20 Apr 2008 23:23:38 +0200
Message-ID: <1208726618-27477-1-git-send-email-madduck@madduck.net>
References: <1208725436-25408-1-git-send-email-madduck@madduck.net>
Cc: "martin f. krafft" <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 23:24:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnh1W-000300-Ne
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 23:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbYDTVXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 17:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYDTVXs
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 17:23:48 -0400
Received: from clegg.madduck.net ([82.197.162.59]:51816 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbYDTVXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 17:23:48 -0400
Received: from wall.oerlikon.madduck.net (84-75-148-163.dclient.hispeed.ch [84.75.148.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 69465A80FF;
	Sun, 20 Apr 2008 23:23:39 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 892779F18E;
	Sun, 20 Apr 2008 23:23:38 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 5C630C1757; Sun, 20 Apr 2008 23:23:38 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.rc2
In-Reply-To: <1208725436-25408-1-git-send-email-madduck@madduck.net>
X-Virus-Scanned: ClamAV 0.91.2/6850/Sun Apr 20 19:05:45 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79987>

If a project name contains special URL characters like +, gitweb's links
break in subtle ways. The solution is to pass the project name through
esc_url() and using the return value.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a48bebb..241ae17 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -633,7 +633,7 @@ sub href(%) {
 	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
 		# use PATH_INFO for project name
-		$href .= "/$params{'project'}" if defined $params{'project'};
+		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
 		delete $params{'project'};
 
 		# Summary just uses the project path URL
@@ -2575,7 +2575,7 @@ EOF
 		my $action = $my_uri;
 		my ($use_pathinfo) = gitweb_check_feature('pathinfo');
 		if ($use_pathinfo) {
-			$action .= "/$project";
+			$action .= "/".esc_url($project);
 		} else {
 			$cgi->param("p", $project);
 		}
-- 
1.5.5.rc2
