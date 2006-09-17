From: Jakub Narebski <jnareb@gmail.com>
Subject: PATCH] gitweb: Fix warnings when PATH_INFO is empty
Date: Sun, 17 Sep 2006 14:09:44 +0200
Message-ID: <200609171409.44958.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 17 14:09:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOvSa-0006QJ-Vy
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 14:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWIQMJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 08:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWIQMJH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 08:09:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:26995 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964949AbWIQMJG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 08:09:06 -0400
Received: by ug-out-1314.google.com with SMTP id o38so284732ugd
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 05:09:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dSQyIgWW03HVs3jJWOo/88aWYDeX6BjIoPv1gmb3IX5zv87+DeeFykizF84irvNzBVXOGP1jHTP+msNaJl5nOgsFOLqP+8HQcZCt9G4gLqAUHIeyiRLJOrAGDj2cBRZ/8hIf0asij+ovQr4oVF/ZbvGvQYYrvoBEfhNu21oziVk=
Received: by 10.66.244.11 with SMTP id r11mr6546506ugh;
        Sun, 17 Sep 2006 05:09:04 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k30sm2355307ugc.2006.09.17.05.09.04;
        Sun, 17 Sep 2006 05:09:04 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27189>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   44 +++++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1549f5f..689528e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -274,29 +274,31 @@ if (defined $searchtext) {
 
 # now read PATH_INFO and use it as alternative to parameters
 our $path_info = $ENV{"PATH_INFO"};
-$path_info =~ s|^/||;
-$path_info =~ s|/$||;
-if (validate_input($path_info) && !defined $project) {
-	$project = $path_info;
-	while ($project && !-e "$projectroot/$project/HEAD") {
-		$project =~ s,/*[^/]*$,,;
-	}
-	if (defined $project) {
-		$project = undef unless $project;
-	}
-	if ($path_info =~ m,^$project/([^/]+)/(.+)$,) {
-		# we got "project.git/branch/filename"
-		$action    ||= "blob_plain";
-		$hash_base ||= $1;
-		$file_name ||= $2;
-	} elsif ($path_info =~ m,^$project/([^/]+)$,) {
-		# we got "project.git/branch"
-		$action ||= "shortlog";
-		$hash   ||= $1;
+if ($path_info) {
+	$path_info =~ s|^/||;
+	$path_info =~ s|/$||;
+	if (validate_input($path_info) && !defined $project) {
+		$project = $path_info;
+		while ($project && !-e "$projectroot/$project/HEAD") {
+			$project =~ s,/*[^/]*$,,;
+		}
+		if (defined $project) {
+			$project = undef unless $project;
+		}
+		if ($path_info =~ m,^$project/([^/]+)/(.+)$,) {
+			# we got "project.git/branch/filename"
+			$action    ||= "blob_plain";
+			$hash_base ||= $1;
+			$file_name ||= $2;
+		} elsif ($path_info =~ m,^$project/([^/]+)$,) {
+			# we got "project.git/branch"
+			$action ||= "shortlog";
+			$hash   ||= $1;
+		}
 	}
-}
 
-$git_dir = "$projectroot/$project";
+	$git_dir = "$projectroot/$project";
+}
 
 # dispatch
 my %actions = (
-- 
1.4.2.1
