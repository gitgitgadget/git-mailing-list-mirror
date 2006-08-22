From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: bugfix: list regression
Date: Tue, 22 Aug 2006 01:55:40 -0700 (PDT)
Message-ID: <20060822085540.1104.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 22 10:56:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFS2z-0005oJ-68
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 10:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWHVIzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 04:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWHVIzm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 04:55:42 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:54686 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932141AbWHVIzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 04:55:41 -0400
Received: (qmail 1106 invoked by uid 60001); 22 Aug 2006 08:55:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4TRc9wxlkBo53MD0E0yjjfIhroYuKY8fI/ioVKqL0X/Ya9K6tf7YyF08ViBmJkmuYIw3ETG6m8XngbmFoFxEAn6tT5slNfIOiYosj6K6Lbc7f5XTmioUArodMVBqGrSbibFa1o5CkDq5Xql13zvRPB44hob8/4uo6qbm0MFwPgs=  ;
Received: from [71.84.29.50] by web31812.mail.mud.yahoo.com via HTTP; Tue, 22 Aug 2006 01:55:40 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25841>

Fix regression introduced by
commit 17d07443188909ef5f8b8c24043cb6d9fef51bca.

1. Commit 17d07443188909ef5f8b8c24043cb6d9fef51bca defines
"a.list" twice in gitweb.css, once with bold and once with
normal font-weight.

2. "a.list" being "bold", makes a myriad of things shown by
gitweb in bold font-weight, which is a regression from
pre-17d07443188909ef5f8b8c24043cb6d9fef51bca behavior.

The fix is to define separately "a.list_bold" and use
that style in format_subject_html().

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.css  |    9 +++++++--
 gitweb/gitweb.perl |    4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 9013895..db58629 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -115,13 +115,18 @@ div.list_head {
 	font-style: italic;
 }
 
-a.list {
+a.list_bold {
 	text-decoration: none;
 	font-weight: bold;
 	color: #000000;
 }
 
-table.tags a.list {
+a.list {
+	text-decoration: none;
+	color: #000000;
+}
+
+table.tags {
 	font-weight: normal;
 }
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 063735d..5237f25 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -504,11 +504,11 @@ sub format_subject_html {
 	$extra = '' unless defined($extra);
 
 	if (length($short) < length($long)) {
-		return $cgi->a({-href => $href, -class => "list",
+		return $cgi->a({-href => $href, -class => "list_bold",
 		                -title => $long},
 		       esc_html($short) . $extra);
 	} else {
-		return $cgi->a({-href => $href, -class => "list"},
+		return $cgi->a({-href => $href, -class => "list_bold"},
 		       esc_html($long)  . $extra);
 	}
 }
-- 
1.4.2.g3851f
