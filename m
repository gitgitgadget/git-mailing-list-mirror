From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 2/3] gitweb.cgi: git_blame2: Allow back-trekking through commits
Date: Sun, 23 Jul 2006 13:36:32 -0700 (PDT)
Message-ID: <20060723203632.91085.qmail@web31804.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-813057455-1153686992=:89551"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Jul 23 22:36:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4kgm-0002dM-Bx
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 22:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWGWUgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 16:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWGWUgd
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 16:36:33 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:57459 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751306AbWGWUgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 16:36:33 -0400
Received: (qmail 91087 invoked by uid 60001); 23 Jul 2006 20:36:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=d/oRIoqTlSZUXJtRCyox/syYBTBnCcyhbBubVSLrV0sC8CZAn/qJ4avleAnOAw68e9KFtLBp7z6sjmrVw+1ZXPWGCUJUFh3dCikrLO6pyjFjviPLXEq8ClAutk+ZCitLuEmkk0x49Ec+KGeDVnmelKZeDwkNn32mBvXcSZ/TI88=  ;
Received: from [71.80.232.189] by web31804.mail.mud.yahoo.com via HTTP; Sun, 23 Jul 2006 13:36:32 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24105>

--0-813057455-1153686992=:89551
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This patch adds the capability of back-trekking through
commits from git_blame2() as follows:
blame2->commit->blame2->commit->blame2->...->initial commit.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)
--0-813057455-1153686992=:89551
Content-Type: text/inline; name="p2.patch"
Content-Description: 3952834181-p2.patch
Content-Disposition: name="p2.patch"; filename="p2.patch"

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 57f4a2e..2c2d9c8 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -2022,8 +2022,13 @@ sub git_commit {
 		print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash")}, "commitdiff");
 	}
 	print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree") . "\n" .
-	      "<br/><br/></div>\n";
+		"<br/>\n";
+	if (defined $file_name && defined $co{'parent'}) {
+		my $parent = $co{'parent'};
+		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;hb=$parent;f=$file_name")}, "blame") . "\n";
+	}
+	print "<br/></div>\n";
+
 	if (defined $co{'parent'}) {
 		print "<div>\n" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash"), -class => "title"}, esc_html($co{'title'}) . $ref) . "\n" .
-- 
1.4.2.rc1.g9b54


--0-813057455-1153686992=:89551--
