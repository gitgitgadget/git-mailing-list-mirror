From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3/RFC 4/5] gitweb: Create links leading to 'blame_incremental' using JavaScript
Date: Tue,  1 Sep 2009 13:39:19 +0200
Message-ID: <1251805160-5303-5-git-send-email-jnareb@gmail.com>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com>
 <1251805160-5303-2-git-send-email-jnareb@gmail.com>
 <1251805160-5303-3-git-send-email-jnareb@gmail.com>
 <1251805160-5303-4-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 13:32:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiRbO-0001Kk-7D
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 13:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbZIALcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 07:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZIALcK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 07:32:10 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:51858 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbZIALcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 07:32:04 -0400
Received: by fxm17 with SMTP id 17so3435949fxm.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=U0KIvKJmvq7VUCcbu5PLv2ZD83Lhs1p7joEBMK+WmP8=;
        b=W69URx7lA+ZtlKpddqvD9Wh0HsYMg4U0XaG7XuYVRcsXPnPzx0zVML32rNNvlnBHwW
         aHpGJw8sG0nFCk5CGuEcA4rY6CDQsRZ9YdN4ZTCu8Xk/XwDKH9jgeVmkyOpiVqoVZ0Bv
         i7OlaiID1yMUOS2pzxoTfBPG+d+wRZOGI7uPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G/22IyPJ3Z1n9aktAXRv/P+cFf3LBY8zFLWaTy0pC8TGX4PGX/v2v7tBj6Z3rQTy68
         OqTfON1YHQTCAx+uDEWEy5RMG/wUxa9vGnKt/EKaAl0ZavYLXpA63gB3IDHjMRuvohA4
         bl/7JI+eqYqIL7jeoMgBb4Ka2vjQ/DXiosaA4=
Received: by 10.103.86.9 with SMTP id o9mr2869323mul.4.1251804725227;
        Tue, 01 Sep 2009 04:32:05 -0700 (PDT)
Received: from localhost.localdomain (abwl209.neoplus.adsl.tpnet.pl [83.8.235.209])
        by mx.google.com with ESMTPS id s10sm3758388muh.47.2009.09.01.04.32.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 04:32:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n81BdXFq005349;
	Tue, 1 Sep 2009 13:39:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n81BdWBf005348;
	Tue, 1 Sep 2009 13:39:32 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1251805160-5303-4-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127533>

The new 'blame_incremental' view requires JavaScript to run.  Not all
web browsers implement JavaScript (e.g. text browsers such as Lynx),
and not all users have JavaScript enabled.  Therefore instead of
unconditionally linking to 'blame_incremental' view, we use JavaScript
to convert those links to lead to view utilizing JavaScript, by adding
'js=1' to link.

Currently the only action that takes 'js=1' into account is 'blame',
which then acts as if it was called as 'blame_incremental' action.
Possible enhancement would be to do JavaScript redirect by setting
window.location instead of modifying $format and $action in
git_blame_common() subroutine.

The only JavaScript-aware/using view is currently 'blame_incremental'.
While at it move reading JavaScript to git_footer_html() subroutine.
Note that in this view we do not add 'js=1' currently (even though
perhaps we should; note that for consistency we should also add 'js=1'
in links added by JavaScript part of 'blame_incremental').


This idea was originally implemented by Petr Baudis in
  http://article.gmane.org/gmane.comp.version-control.git/47614
but it added <script> element with fixBlameLinks() function in page
header, to be added as onload event using 'onload' attribute of HTML
'body' element: <body onload="fixBlameLinks();">.  This version adds
script at then end of page (in the page footer), and uses JavaScript
'window.onload=fixLinks();'.  Also in Petr version only links marked
with 'blamelink' class were modified, and they were modified by
replacing "a=blame" by "a=blame_incremental"... which doesn't work for
path_info links, and might replace wrong part if there is "a=blame" in
project name, ref name or file name.

Slightly different solution was implemented by Martin Koegler in
  http://thread.gmane.org/gmane.comp.version-control.git/47902/focus=47905
Here GitAddLinks() function was in gitweb.js file, not as contents of
<script> element.  It was also included in page header (in <head>
element) though, which means waiting for a script to load (and run).
It was smarter in that to "fix" (modify) link, it split URL, modified
value of 'a' parameter, and then recreated modified link.  It avoids
trouble with "a=blame" as substring in project name or file name, but
it doesn't work with path_info URL/link in the way it was written.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is in RFC stage.

Currently fixLinks() is not invoked for 'blame_incremental', but links
generated by startBlame (or to be more exact by event handler in
gitweb.js) lead to 'blame_incremental' directly.  Also the list of
"JavaScript-aware actions" is currently hardcoded to
'blame_incremental' (and relies on 'blame' + 'js=1' to change
$action).

Also fixLinks() adds 'js=1' to too many links, including $home_link,
and links to feeds (where JavaScript is not supported anyway).
Alternate solution would be to mark links which lead to action which
has JavaScript-requiring alternative, either marking it via 'class'
attribute, or providing for example 'alt_href' or 'jshref' attribute
with link to JavaScript-requiring variant.


Differences from previous version (v2):
* fixLinks() function is put in gitweb.js together with all JavaScript
  code required for 'blame_incremental' view, instead of being defined
  inside <script> element.
* Running startBlame() was moved to git_footer_html, instead of being
  in git_blame_common
* The link to plain 'blame' view (which do not require JavaScript
  support enabled in web browser) inside <noscript> element is marked
  with 'js=0'.
* fixLinks() now doesn't add 'js=1' if links ends with '[?;]js=[01]'
  (so that e.g. 'js=0' means link to view which do not require
  JavaScript).
* performance: calculate number of elements in a list before loop


TODO for future commits:
* Use 'click' event to change links to jave 'js=1' parameter appended;
  this way we would check if JavaScript is enabled at the moment of
  following (clicking) link, not at the moment of loading the page.

  Unfortunately adding event listeners (much better solution than
  providing/adding 'onclick' attribute) is different in different
  browsers.  Some kind of wrapper around browser incompatibilities
  would be required.

 gitweb/gitweb.js   |   34 ++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl |   28 +++++++++++++++++++---------
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index bf38216..66fd64e 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -7,6 +7,39 @@
  * @license GPLv2 or later
  */
 
+/* ============================================================ */
+/* functions for generic gitweb actions and views */
+
+/**
+ * used to check if link has 'js' query parameter already (at end),
+ * and other reasons to not add 'js=1' param at the end of link
+ * @constant
+ */
+var jsExceptionsRe = /[;?]js=[01]$/;
+
+/**
+ * Add '?js=1' or ';js=1' to the end of every link in the document
+ * that doesn't have 'js' query parameter set already.
+ *
+ * Links with 'js=1' lead to JavaScript version of given action, if it
+ * exists (currently there is only 'blame_incremental' for 'blame')
+ *
+ * @globals jsExceptionsRe
+ */
+function fixLinks() {
+	var allLinks = document.getElementsByTagName("a") || document.links;
+	for (var i = 0, len = allLinks.length; i < len; i++) {
+		var link = allLinks[i];
+		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01]$/;
+			link.href +=
+				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1';
+		}
+	}
+}
+
+
+/* ============================================================ */
+
 /*
  * This code uses DOM methods instead of (nonstandard) innerHTML
  * to modify page.
@@ -89,6 +122,7 @@ function createRequestObject() {
 	return null;
 }
 
+
 /* ============================================================ */
 /* utility/helper functions (and variables) */
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 88c91ff..0adfd3f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -571,6 +571,8 @@ our @cgi_param_mapping = (
 	snapshot_format => "sf",
 	extra_options => "opt",
 	search_use_regexp => "sr",
+	# this must be last entry (for manipulation from JavaScript)
+	javascript => "js"
 );
 our %cgi_param_mapping = @cgi_param_mapping;
 
@@ -3255,6 +3257,18 @@ sub git_footer_html {
 		insert_file($site_footer);
 	}
 
+	print qq!<script type="text/javascript" src="$javascript"></script>\n!;
+	if ($action eq 'blame_incremental') {
+		print qq!<script type="text/javascript">\n!.
+		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
+		      qq!           "!. href() .qq!");\n!.
+		      qq!</script>\n!;
+	} else {
+		print qq!<script type="text/javascript">\n!.
+		      qq!window.onload = fixLinks;\n!.
+		      qq!</script>\n!;
+	}
+
 	print "</body>\n" .
 	      "</html>";
 }
@@ -4806,6 +4820,10 @@ sub git_tag {
 
 sub git_blame_common {
 	my $format = shift || 'porcelain';
+	if ($format eq 'porcelain' && $cgi->param('js')) {
+		$format = 'incremental';
+		$action = 'blame_incremental'; # for page title etc
+	}
 
 	# permissions
 	gitweb_check_feature('blame')
@@ -4885,7 +4903,7 @@ sub git_blame_common {
 	if ($format eq 'incremental') {
 		print "<noscript>\n<div class=\"error\"><center><b>\n".
 		      "This page requires JavaScript to run.\n Use ".
-		      $cgi->a({-href => href(action=>'blame',-replay=>1)},
+		      $cgi->a({-href => href(action=>'blame',javascript=>0,-replay=>1)},
 		              'this page').
 		      " instead.\n".
 		      "</b></center></div>\n</noscript>\n";
@@ -5016,14 +5034,6 @@ sub git_blame_common {
 	close $fd
 		or print "Reading blob failed\n";
 
-	if ($format eq 'incremental') {
-		print qq!<script type="text/javascript" src="$javascript"></script>\n!.
-		      qq!<script type="text/javascript">\n!.
-		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
-		      qq!           "!. href() .qq!");\n!.
-		      qq!</script>\n!;
-	}
-
 	git_footer_html();
 }
 
-- 
1.6.3.3
