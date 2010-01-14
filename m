From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 7/9] gitweb: cleanup error message produced by undefined $site_header
Date: Wed, 13 Jan 2010 17:23:03 -0800
Message-ID: <1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 02:24:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVERL-0002pa-5N
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab0ANBXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602Ab0ANBXO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:23:14 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:56021 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab0ANBXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:23:13 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0E1N5Lt009231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:23:12 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 17:23:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136912>

If $site_header is not defined you get extraneous errors in the web
logs:

[Wed Jan 13 16:55:42 2010] [error] [client ::1] [Wed Jan 13 16:55:42 2010] gitweb.cgi: Use of uninitialized value $site_header in -f at /var/www/gitweb/gitweb.cgi line 3287., referer: http://git/gitweb.cgi

for example.  This ensures that the variable is defined before trying to use it.
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 07fdeb5..c4a177d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3277,7 +3277,7 @@ EOF
 	print "</head>\n" .
 	      "<body>\n";
 
-	if (-f $site_header) {
+	if ($site_header && -f $site_header) {
 		insert_file($site_header);
 	}
 
-- 
1.6.5.2
