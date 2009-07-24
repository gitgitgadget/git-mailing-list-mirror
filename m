From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 10/10] gitweb: Create links leading to 'blame_incremental' using JavaScript
Date: Sat, 25 Jul 2009 00:44:10 +0200
Message-ID: <1248475450-5668-11-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:49:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTaP-0000l5-0W
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbZGXWtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbZGXWtN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:49:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:43259 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbZGXWtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:49:11 -0400
Received: by fg-out-1718.google.com with SMTP id e12so187225fga.17
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zPh+LUwyVDrcO3Y7BYbQw5RYq/9W07kzuB+qfZ6LG1o=;
        b=FJ+MTaJhKzV0gDiAYt7lh+1cOcDChGxI20cyvWKs5Co4SUpa7E2tapG+jYiSRZIOly
         mn/6EZpfqNut+D1CyyNWHoQjUs48tq/vTMN8vNlZkhCifWxXY4RmiyRjlWfYwZn1a3rj
         OIbw3klwvB3jSTvrNgufXSAZnQtzcJBN/gdJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xkssmOPepQTo87rJuWdVFFsW0DgUl3ujJIiAhLBbrdngi/tWHbMIrN2YY4gpU47GEp
         kC2kVYb35ms6hGncPxlrYTFJ1bhWA5R8sDo4XhIUe2Xr2rWLe7MdKdwjC+66w4yP+SJ8
         YMves5IZDtXwmIX0RYmnE6GR009fvDzpVW2NE=
Received: by 10.86.68.7 with SMTP id q7mr201477fga.3.1248475748504;
        Fri, 24 Jul 2009 15:49:08 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id 3sm9219857fge.28.2009.07.24.15.49.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:49:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMtNWm005890;
	Sat, 25 Jul 2009 00:55:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMt2Qx005884;
	Sat, 25 Jul 2009 00:55:02 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123969>

The new 'blame_incremental' view requires JavaScript to run.  Not all
web browsers implement JavaScript (e.g. text browsers such as Lynx),
and not all users have JavaScript enabled.  Therefore instead of
unconditionally link to 'blame_incremental' view, we use JavaScript to
convert those links to lead to view utilizing JavaScript, by adding
'js=1' to link.

The only JavaScript-aware/using view is currently 'blame_incremental'.
As first, it might want to have links to non-JavaScript version, and
second, it should also use window.onload, we do not add nor run
fixLinks() for such views (currently hardcoded 'blame_incremental')

Possible enhancement would be to do JavaScript redirect by setting
window.location instead of modifying $format and $action in
git_blame_common() subroutine.


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
<script> element.  This might be a better solution (although I think
it would be better to split JavaScript file and load only parts that
are required).  It was also included in page header (in <head>
element) though, which means waiting for a script to load (and run).
It was smarter in that to "fix" (modify) link, it split URL, modified
value of 'a' parameter, and then recreated modified link.  It avoids
trouble with "a=blame" as substring in project name or file name, but
it doesn't work with path_info URL/link in the way it was written.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new, and didn't appear in any way in any of my earlier
series dealing with incremental blame view.

TODO list:
* Extract and remove unrelated changes, like updating copyright
* Perhaps put fixLinks() function in separate file gitweb.js.
  Should gitweb use single JavaScript file, or should it be split into
  more than one file?
* Better solution to "don't invoke for JavaScript-aware actions"
  problem.  Currently hardcoded 'blame_incremental'.

 gitweb/blame.js    |    8 +++++---
 gitweb/gitweb.perl |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/gitweb/blame.js b/gitweb/blame.js
index 5a8a29f..d8ecee1 100644
--- a/gitweb/blame.js
+++ b/gitweb/blame.js
@@ -1,4 +1,6 @@
 // Copyright (C) 2007, Fredrik Kuivinen <frekui@gmail.com>
+//               2007, Petr Baudis <pasky@suse.cz>
+//          2008-2009, Jakub Narebski <jnareb@gmail.com>
 
 /* ============================================================ */
 /* generic utility functions */
@@ -36,7 +38,7 @@ function spacePad(n, width) {
 /**
  * @param {string} input: input value converted to string.
  * @param {number} size: desired length of output.
- * @param {string} ch: single character to prefix to s.
+ * @param {string} ch: single character to prefix to string.
  */
 function padLeft(input, size, ch) {
 	var s = input + "";
@@ -611,14 +613,14 @@ function startBlame(blamedataUrl, bUrl) {
 	projectUrl = bUrl;
 	if ((div_progress_bar = document.getElementById('progress_bar'))) {
 		div_progress_bar.setAttribute('style', 'width: 100%;');
-		//div_progress_bar.style.value = 'width: 100%;';
+		//div_progress_bar.style.value = 'width: 100%;'; // doesn't work
 	}
 	totalLines = countLines();
 	updateProgressInfo();
 
 	http.open('get', blamedataUrl);
 	http.setRequestHeader('Accept', 'text/plain'); // in case of future changes
-	// perhaps also 'multipart/x-mixed-replace'
+	// perhaps also, in the future, 'multipart/x-mixed-replace' (not standard)
 	http.onreadystatechange = handleResponse;
 	//http.onreadystatechange = function () { handleResponse(http); };
 	http.send(null);
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 036f8da..38492d0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3243,6 +3243,23 @@ sub git_footer_html {
 		insert_file($site_footer);
 	}
 
+	if ($action ne 'blame_incremental') {
+		print <<'HTML';
+<script type="text/javascript">/* <![CDATA[ */
+function fixLinks() {
+	//var allLinks = document.getElementsByTagName("a");
+	var allLinks = document.links;
+	for (var i = 0; i < allLinks.length; i++) {
+		var link = allLinks[i];
+		link.href +=
+			(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1';
+	}
+}
+window.onload = fixLinks;
+/* ]]> */</script>
+HTML
+	}
+
 	print "</body>\n" .
 	      "</html>";
 }
@@ -4794,6 +4811,10 @@ sub git_tag {
 
 sub git_blame_common {
 	my $format = shift || 'porcelain';
+	if ($format eq 'porcelain' && $cgi->param('js')) {
+		$format = 'incremental';
+		$action = 'blame_incremental'; # for page title etc
+	}
 
 	# permissions
 	gitweb_check_feature('blame')
-- 
1.6.3.3
