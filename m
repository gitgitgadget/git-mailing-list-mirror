From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2/RFC 3/3] gitweb: Create links leading to 'blame_incremental' using JavaScript
Date: Thu,  6 Aug 2009 19:11:52 +0200
Message-ID: <1249578712-3862-4-git-send-email-jnareb@gmail.com>
References: <1249578712-3862-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 19:12:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ6Vu-00048i-6p
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 19:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353AbZHFRMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 13:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756348AbZHFRMR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 13:12:17 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:55660 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322AbZHFRMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 13:12:16 -0400
Received: by qyk34 with SMTP id 34so955137qyk.33
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0ea2pPC6hadKi7p1xV45ojoS6d2GI7KHRizNR71Ea1c=;
        b=PBoeqqGjyOz1iW16NKToOsVVEx7qvO5giQv3p9zMYcsY43CcKcwxe0+QT83wEo9z9W
         GeLprdcLArWdcNlpwNobnvuji/yq3KNZwRD/ZzUxL8bm1vuS1FxgnVjvTyMw1uix/H4+
         W5imIJyd0XGYXYfZYPXIthuXkU49dyS9H/4Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wrRgyNC+Wa32u2AVZWbbDalN7QJtK1poJO7wU8HVGaRDz3b03D2/A0lGEppOHDk9hR
         jgcQ2vUQqRpW1xs/F+RozS6HZMk7FMVp0B3fFx77X3K0RKfwkipQJn7OiPFVTmS4Ozhc
         Ks16lSp8/179lIjmdAI6tF8RMtk+tMd45CQgk=
Received: by 10.229.99.143 with SMTP id u15mr206983qcn.4.1249578735789;
        Thu, 06 Aug 2009 10:12:15 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.5])
        by mx.google.com with ESMTPS id 23sm150529ywh.15.2009.08.06.10.12.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 10:12:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n76HCBrT003907;
	Thu, 6 Aug 2009 19:12:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n76HCBOk003906;
	Thu, 6 Aug 2009 19:12:11 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1249578712-3862-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125094>

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
This is nearly the same as previous (first) version, it only doesn't
have unrelated changes to blame.js that were included in earlier
version by mistake.


TODO list:
* Put fixLinks() function in gitweb.js, together with all code
  required for 'blame_incremental' view.
* Better solution to "don't invoke for JavaScript-aware actions"
  problem.  Currently hardcoded 'blame_incremental'.

  The problem to be solved is that we might want in views utilizing
  JavaScript to have fallback links to version not using JavaScript.


TODO for future commits:
* Use 'click' event to change links to jave 'js=1' parameter appended;
  this way we would check if JavaScript is enabled at the moment of
  following (clicking) link, not at the moment of loading the page.

  Unfortunately adding event listeners (much better solution than
  providing/adding 'onclick' attribute) is different in different
  browsers.

 gitweb/gitweb.perl |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b94ce10..32cbb20 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3242,6 +3242,23 @@ sub git_footer_html {
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
@@ -4793,6 +4810,10 @@ sub git_tag {
 
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
