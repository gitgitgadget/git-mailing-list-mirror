From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] Escape project name in regexp
Date: Sun, 20 Apr 2008 23:03:56 +0200
Message-ID: <1208725436-25408-1-git-send-email-madduck@madduck.net>
References: <20080420210320.GA22732@piper.oerlikon.madduck.net>
Cc: 476076@bugs.debian.org, "martin f. krafft" <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 23:04:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JngiT-0004tY-Tu
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 23:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbYDTVEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 17:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYDTVEI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 17:04:08 -0400
Received: from clegg.madduck.net ([82.197.162.59]:47337 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbYDTVEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 17:04:06 -0400
Received: from wall.oerlikon.madduck.net (84-75-148-163.dclient.hispeed.ch [84.75.148.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 9D40EA80FF;
	Sun, 20 Apr 2008 23:03:56 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 234EA9F18E;
	Sun, 20 Apr 2008 23:03:56 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 10FFDC1757; Sun, 20 Apr 2008 23:03:56 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.rc2
In-Reply-To: <20080420210320.GA22732@piper.oerlikon.madduck.net>
X-Virus-Scanned: ClamAV 0.91.2/6850/Sun Apr 20 19:05:45 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79986>

The project name, when used in a regular expression, needs to be quoted
properly, so that stuff like '++' in the project name does not cause
Perl to barf.

Related info: http://bugs.debian.org/476076
This is a bug in Perl's CGI.pm, but fixing that exposed a similar bug in
gitweb.perl

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a48bebb..9865f9a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -511,7 +511,7 @@ sub evaluate_path_info {
 	}
 	# do not change any parameters if an action is given using the query string
 	return if $action;
-	$path_info =~ s,^$project/*,,;
+	$path_info =~ s,^\Q$project\E/*,,;
 	my ($refname, $pathname) = split(/:/, $path_info, 2);
 	if (defined $pathname) {
 		# we got "project.git/branch:filename" or "project.git/branch:dir/"
-- 
1.5.5.rc2
