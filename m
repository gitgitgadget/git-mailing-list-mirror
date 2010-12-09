From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 14/18] gitweb: add print_transient_header() function for central header printing
Date: Thu,  9 Dec 2010 13:57:20 -0800
Message-ID: <1291931844-28454-15-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoTi-0007Gf-CS
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab0LIV40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:26 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51866 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468Ab0LIV4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:56:03 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LteQ0027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:56:02 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:56:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163339>

There are a few things I would like to reuse the transient header
information I'm using, currently this is only the 'Generating...'
page, but there is at least one additional warning page I would
like to use this on.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/lib/cache.pl |   47 ++++++++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index 63dbe9e..723ae9b 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -94,6 +94,31 @@ sub cache_fetch {
 	#$actions{$action}->();
 }
 
+sub print_transient_header {
+	print $::cgi->header(
+				-type=>'text/html',
+				-charset => 'utf-8',
+				-status=> 200,
+				-expires => 'now',
+				# HTTP/1.0
+				-Pragma => 'no-cache',
+				# HTTP/1.1
+				-Cache_Control => join(
+							', ',
+							qw(
+								private
+								no-cache
+								no-store
+								must-revalidate
+								max-age=0
+								pre-check=0
+								post-check=0
+							)
+						)
+				);
+	return;
+}
+
 sub isBinaryAction {
 	my ($action) = @_;
 
@@ -292,27 +317,7 @@ sub cacheWaitForUpdate {
 
 	$| = 1;
 
-	print $::cgi->header(
-				-type=>'text/html',
-				-charset => 'utf-8',
-				-status=> 200,
-				-expires => 'now',
-				# HTTP/1.0
-				-Pragma => 'no-cache',
-				# HTTP/1.1
-				-Cache_Control => join(
-							', ',
-							qw(
-								private
-								no-cache
-								no-store
-								must-revalidate
-								max-age=0
-								pre-check=0
-								post-check=0
-							)
-						)
-				);
+	print_transient_header();
 
 	print <<EOF;
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/TR/html4/strict.dtd">
-- 
1.7.2.3
