From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: use out-of-line GIT logo.
Date: Mon, 31 Jul 2006 00:38:39 +0200
Message-ID: <20060730223839.GB16364@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 31 00:38:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Jvp-0002op-D6
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 00:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWG3Wil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 18:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWG3Wil
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 18:38:41 -0400
Received: from admingilde.org ([213.95.32.146]:29915 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751400AbWG3Wik (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 18:38:40 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G7Jvj-0007Gk-W4
	for git@vger.kernel.org; Mon, 31 Jul 2006 00:38:39 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24477>

Use the normal web server instead of the CGI to provide the git logo,
just like the gitweb.css.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 Makefile            |    2 ++
 gitweb/README       |    2 ++
 gitweb/git-logo.png |  Bin
 gitweb/gitweb.pl    |   29 ++++-------------------------
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/Makefile b/Makefile
index bd59d6b58d1cfcaecd033f186d7c2cc537416b75..40e129490b337a70f0ee5c60ce25980359e658c9 100644
--- a/Makefile
+++ b/Makefile
@@ -122,6 +122,7 @@ GITWEB_PROJECTROOT = /pub/git
 GITWEB_LIST = 
 GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
+GITWEB_LOGO = git-logo.png
 
 export prefix bindir gitexecdir template_dir GIT_PYTHON_DIR
 
@@ -584,6 +585,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.pl
 	    -e 's|@@GITWEB_LIST@@|$(GITWEB_LIST)|g' \
 	    -e 's|@@GITWEB_HOMETEXT@@|$(GITWEB_HOMETEXT)|g' \
 	    -e 's|@@GITWEB_CSS@@|$(GITWEB_CSS)|g' \
+	    -e 's|@@GITWEB_LOGO@@|$(GITWEB_LOGO)|g' \
 	    $< >$@+
 	chmod +x $@+
 	mv $@+ $@
diff --git a/gitweb/README b/gitweb/README
index ed939e2fb5264cce24e770272583b12372c3ab68..1b2180c7314ea3d10db78c88b48092a70491f8b8 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -21,6 +21,8 @@ You can specify the following configurat
    overview page.
  * GITWEB_CSS
    Points to the location where you put gitweb.css on your web server.
+ * GITWEB_LOGO
+   Points to the location where you put git-logo.png on your web server.
 
 Any comment/question/concern to:
   Kay Sievers <kay.sievers@vrfy.org>
diff --git a/gitweb/git-logo.png b/gitweb/git-logo.png
new file mode 100644
index 0000000000000000000000000000000000000000..16ae8d5382de5ffe63b54139245143513a87446e
GIT binary patch
literal 208
zc%17D@N?(olHy`uVBq!ia0vp^9zZP3!VDyJZ(h*_QW60^A+G=b|4&GW-LQTYLj%LP
zv&RoGFuZv2?ECj`Q+bxV1Jx9Jx;TbtoKN;hS77mqk>KLcN(xR?VB+A-bX~J>A)^7$
z<ODOdpotq91+P5}P07hQlas@<h^Ig+iB0QZlI&(irr;$UFBq65)WQU>JXDx2{a_29
zsY;<{(@cXMleq+Ux^^7wU9iYSkxkvP$)WY2Yo|g1Bf}C~#iK$pv;G0CXYh3Ob6Mw<
G&;$VMfkjjR

diff --git a/gitweb/gitweb.pl b/gitweb/gitweb.pl
index 8e05c335f801d4c52a9b348fa56fccfae36ce621..e6e9f83076630958d0134bfbb29989882f6f1d0d 100755
--- a/gitweb/gitweb.pl
+++ b/gitweb/gitweb.pl
@@ -51,6 +51,8 @@ our $home_text = "@@GITWEB_HOMETEXT@@";
 
 # URI of default stylesheet
 our $stylesheet = "@@GITWEB_CSS@@";
+# URI of GIT logo
+our $logo = "@@GITWEB_LOGO@@";
 
 # source of projects list
 our $projects_list = "@@GITWEB_LIST@@" || "$projectroot";
@@ -70,10 +72,7 @@ if (defined $action) {
 		undef $action;
 		die_error(undef, "Invalid action parameter.");
 	}
-	if ($action eq "git-logo.png") {
-		git_logo();
-		exit;
-	} elsif ($action eq "opml") {
+	if ($action eq "opml") {
 		git_opml();
 		exit;
 	}
@@ -320,7 +319,7 @@ sub git_header_html {
 EOF
 	print "<div class=\"page_header\">\n" .
 	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
-	      "<img src=\"$my_uri?" . esc_param("a=git-logo.png") . "\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
+	      "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
 	      "</a>\n";
 	print $cgi->a({-href => esc_param($home_link)}, "projects") . " / ";
 	if (defined $project) {
@@ -755,26 +754,6 @@ sub date_str {
 	return %date;
 }
 
-# git-logo (cached in browser for one day)
-sub git_logo {
-	binmode STDOUT, ':raw';
-	print $cgi->header(-type => 'image/png', -expires => '+1d');
-	# cat git-logo.png | hexdump -e '16/1 " %02x"  "\n"' | sed 's/ /\\x/g'
-	print	"\x89\x50\x4e\x47\x0d\x0a\x1a\x0a\x00\x00\x00\x0d\x49\x48\x44\x52" .
-		"\x00\x00\x00\x48\x00\x00\x00\x1b\x04\x03\x00\x00\x00\x2d\xd9\xd4" .
-		"\x2d\x00\x00\x00\x18\x50\x4c\x54\x45\xff\xff\xff\x60\x60\x5d\xb0" .
-		"\xaf\xaa\x00\x80\x00\xce\xcd\xc7\xc0\x00\x00\xe8\xe8\xe6\xf7\xf7" .
-		"\xf6\x95\x0c\xa7\x47\x00\x00\x00\x73\x49\x44\x41\x54\x28\xcf\x63" .
-		"\x48\x67\x20\x04\x4a\x5c\x18\x0a\x08\x2a\x62\x53\x61\x20\x02\x08" .
-		"\x0d\x69\x45\xac\xa1\xa1\x01\x30\x0c\x93\x60\x36\x26\x52\x91\xb1" .
-		"\x01\x11\xd6\xe1\x55\x64\x6c\x6c\xcc\x6c\x6c\x0c\xa2\x0c\x70\x2a" .
-		"\x62\x06\x2a\xc1\x62\x1d\xb3\x01\x02\x53\xa4\x08\xe8\x00\x03\x18" .
-		"\x26\x56\x11\xd4\xe1\x20\x97\x1b\xe0\xb4\x0e\x35\x24\x71\x29\x82" .
-		"\x99\x30\xb8\x93\x0a\x11\xb9\x45\x88\xc1\x8d\xa0\xa2\x44\x21\x06" .
-		"\x27\x41\x82\x40\x85\xc1\x45\x89\x20\x70\x01\x00\xa4\x3d\x21\xc5" .
-		"\x12\x1c\x9a\xfe\x00\x00\x00\x00\x49\x45\x4e\x44\xae\x42\x60\x82";
-}
-
 sub get_file_owner {
 	my $path = shift;
 
-- 
1.4.2.rc2.gf055

-- 
Martin Waitz
