From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 06/18] gitweb: Add more explicit means of disabling 'Generating...' page
Date: Thu,  9 Dec 2010 13:57:12 -0800
Message-ID: <1291931844-28454-7-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:57:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoUY-0007o9-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175Ab0LIV4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:49 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51850 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab0LIVzw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:52 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePq027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:50 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163350>

As requested this adds $cacheGenStatus variable, default 1 (on).
If caching is enabled it will explicitly disble the display of the
'Generating...' page and just force the user to stall indefinately.

Also adding it to gitweb's test code as I'm sure the 'Generating...'
page isn't that useful there.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl  |    6 ++++++
 gitweb/lib/cache.pl |    2 ++
 t/gitweb-lib.sh     |    1 +
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f2ef3da..05e7ba6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -293,6 +293,12 @@ our $maxCacheLife = 18000;
 # Used to enable or disable background forking of the gitweb caching.  Mainly here for debugging purposes
 our $cacheDoFork = 1;
 
+# Used to enable or disable the foreground "Generating..." page.  This is here to be more explicit should
+# people want to disable it.
+# Default: 1 (True - Enabled)
+# To disable set to 0
+our $cacheGenStatus = 1;
+
 our $fullhashpath = *STDOUT;
 our $fullhashbinpath = *STDOUT;
 our $fullhashbinpathfinal = *STDOUT;
diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index dd14bfb..a8ee99e 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -224,6 +224,8 @@ sub cacheWaitForUpdate {
 		$action eq "rss"
 		||
 		$action eq "opml"
+		||
+		! $cacheGenStatus
 	){
 		do {
 			sleep 2 if $x > 0;
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 16ce811..10c4a3d 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -26,6 +26,7 @@ our \$projects_list = '';
 our \$export_ok = '';
 our \$strict_export = '';
 our \$maxload = undef;
+our \$cacheGenStatus = 0;
 
 EOF
 
-- 
1.7.2.3
