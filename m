From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Cleanup Git logo and Git logo target generation
Date: Sun, 8 Oct 2006 22:17:24 +0200
Message-ID: <200610082217.25457.jnareb@gmail.com>
References: <20060919212725.GA13132@pasky.or.cz> <egauic$1l2$1@sea.gmane.org> <7vwt7aio8l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 22:16:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWf4d-0002PN-9A
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 22:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWJHUQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 16:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWJHUQc
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 16:16:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:494 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751433AbWJHUQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 16:16:32 -0400
Received: by ug-out-1314.google.com with SMTP id o38so510175ugd
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 13:16:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EOl9jzHxKUWmXGwDbRH2iHmqxfGbt1bo5H6Rl0nEggJYlEChG4pN0df7dCkX87J6bjeSDDQPWmo09o1DtYzg7KFxpt72Pr39aIfRDZJh6aNlhNn+lCdq23Fp4lfSPlVbpclj2LY9Cd6PVd/Gg5NVHimZ617dzkvDIV7SMlTML7g=
Received: by 10.67.117.18 with SMTP id u18mr5900402ugm;
        Sun, 08 Oct 2006 13:16:30 -0700 (PDT)
Received: from host-81-190-27-91.torun.mm.pl ( [81.190.27.91])
        by mx.google.com with ESMTP id w40sm677450ugc.2006.10.08.13.16.29;
        Sun, 08 Oct 2006 13:16:30 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vwt7aio8l.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28549>

Rename $githelp_url and $githelp_label to $logo_url and $logo_label to
be more obvious what they refer to; while at it add commented out
previous contents (git documentation at kernel.org). Add comment about
logo size.

Use $cgi->a(...) to generate Git logo link; it automatically escapes
attribute values when it is needed.  Escape href attribute using
esc_url instead of (incorrect!) esc_html.

Move styling of git logo <img> element from "style" attribute to CSS
via setting class to "logo".  Perhaps we should set it by id rather
than by class.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I hope that this version is applicable...

 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |   17 +++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 668e69a..3f62b6d 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -16,6 +16,11 @@ a:hover, a:visited, a:active {
 	color: #880000;
 }
 
+img.logo {
+	float: right;
+	border-width: 0px;
+}
+
 div.page_header {
 	height: 25px;
 	padding: 8px;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3320069..a966f9f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -46,13 +46,16 @@ our $home_text = "++GITWEB_HOMETEXT++";
 
 # URI of default stylesheet
 our $stylesheet = "++GITWEB_CSS++";
-# URI of GIT logo
+# URI of GIT logo (72x27 size)
 our $logo = "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type
 our $favicon = "++GITWEB_FAVICON++";
 
-our $githelp_url = "http://git.or.cz/";
-our $githelp_label = "git homepage";
+# URI and label (title) of GIT logo link
+#our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
+#our $logo_label = "git documentation";
+our $logo_url = "http://git.or.cz/";
+our $logo_label = "git homepage";
 
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
@@ -1376,11 +1379,9 @@ EOF
 	print "</head>\n" .
 	      "<body>\n" .
 	      "<div class=\"page_header\">\n" .
-	      "<a href=\"" . esc_html($githelp_url) .
-	      "\" title=\"" . esc_html($githelp_label) .
-	      "\">" .
-	      "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
-	      "</a>\n";
+	      $cgi->a({-href => esc_url($logo_url),
+	               -title => $logo_label},
+	              qq(<img src="$logo" width="72" height="27" alt="git" class="logo"/>));
 	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
 		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
-- 
1.4.2.1
