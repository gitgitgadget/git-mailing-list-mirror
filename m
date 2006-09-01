From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: gitweb_check_feature always return list
Date: Fri,  1 Sep 2006 21:31:08 +0200
Message-ID: <11571390683018-git-send-email-jnareb@gmail.com>
References: <ed8a90$pfn$1@sea.gmane.org>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 01 21:31:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJEjp-0001t8-7s
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 21:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWIATbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWIATbO
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 15:31:14 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:26011 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750757AbWIATbN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 15:31:13 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k81JTqId010212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Sep 2006 21:29:53 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k81JV8pm001686;
	Fri, 1 Sep 2006 21:31:08 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k81JV8kr001685;
	Fri, 1 Sep 2006 21:31:08 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <ed8a90$pfn$1@sea.gmane.org>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26306>

Modified feature_blame so it returns one-element list and not scalar,
thus making gitweb_check_feature always return list.  Updated comment
to explain that part.

This is continuation of Aneesh Kumar work:
  gitweb: Fix git_blame
"Converting the default values to array broke the git blame enable
 disable support. Fix the same."

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
We could modify %feature hash so the 'default' value could be either
array reference or a scalar instead.

 gitweb/gitweb.perl |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57ffa25..06bdb0e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -74,9 +74,12 @@ our %feature = (
 	#
 	# if feature is overridable (it means that allow-override has true value,
 	# then feature-sub will be called with default options as parameters;
-	# return value of feature-sub indicates if to enable specified feature
+	# return value of feature-sub indicates if to enable specified feature,
+	# and is taken to be current parameters of the feature
 	#
-	# use gitweb_check_feature(<feature>) to check if <feature> is enabled
+	# use gitweb_check_feature(<feature>) to check if <feature> is enabled;
+	# to be more exact to get current parameters of <feature>;
+	# gitweb_check_feature(<feature>) returns array (list) of current options
 
 	'blame' => {
 		'sub' => \&feature_blame,
@@ -111,12 +114,12 @@ sub feature_blame {
 	my ($val) = git_get_project_config('blame', '--bool');
 
 	if ($val eq 'true') {
-		return 1;
+		return (1);
 	} elsif ($val eq 'false') {
-		return 0;
+		return (0);
 	}
 
-	return $_[0];
+	return ($_[0]);
 }
 
 # To disable system wide have in $GITWEB_CONFIG
-- 
1.4.1.1
