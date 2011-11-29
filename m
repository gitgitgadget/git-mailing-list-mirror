From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: [PATCH] gitweb: Don't append ';js=(0|1)' to external links
Date: Tue, 29 Nov 2011 01:53:10 +0100
Message-ID: <CAKD0UuzU4hAe7RGYukGyPpvfGeYJ3pgJ5pynupneMpQSaX5Cjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 02:01:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVC4M-0007eG-Bb
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 02:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623Ab1K2BBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 20:01:05 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57310 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab1K2BBD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 20:01:03 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Nov 2011 20:01:03 EST
Received: by eeuu47 with SMTP id u47so771897eeu.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 17:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ekWgdHaQAyUwWjwpQ8JFi5IA4zjtk7AFI6OtbH1AGQA=;
        b=jQZ9FOUMXjsQkWOwY1hqGtU6zMee0OMP5/Ol5rW7k9L5sDbofKmca+tJBEVaALT30E
         0bIwj6H2bx0BN5akrsQ8VQsXmjQp9PbVx4BwWY+sTonUHxjPNpkYitj2VpkplKBdIKwo
         QslDHPSweZNLZzi6u34TdNltrPocWn9sLcfKU=
Received: by 10.180.24.65 with SMTP id s1mr46899465wif.59.1322528011082; Mon,
 28 Nov 2011 16:53:31 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Mon, 28 Nov 2011 16:53:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186042>

Signed-off-by: Juergen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl                       |    2 +-
 gitweb/static/js/javascript-detection.js |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..dfe3407 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3974,7 +3974,7 @@ sub git_footer_html {
 		print qq!<script type="text/javascript">\n!.
 		      qq!window.onload = function () {\n!;
 		if (gitweb_check_feature('javascript-actions')) {
-			print qq!	fixLinks();\n!;
+			print qq!	fixLinks('$my_url');\n!;
 		}
 		if ($jstimezone && $tz_cookie && $datetime_class) {
 			print qq!	var tz_cookie = { name: '$tz_cookie', expires: 14, path:
'/' };\n!. # in days
diff --git a/gitweb/static/js/javascript-detection.js
b/gitweb/static/js/javascript-detection.js
index fa2596f..36964ad 100644
--- a/gitweb/static/js/javascript-detection.js
+++ b/gitweb/static/js/javascript-detection.js
@@ -29,11 +29,11 @@ var jsExceptionsRe = /[;?]js=[01](#.*)?$/;
  *
  * @globals jsExceptionsRe
  */
-function fixLinks() {
+function fixLinks(baseurl) {
 	var allLinks = document.getElementsByTagName("a") || document.links;
 	for (var i = 0, len = allLinks.length; i < len; i++) {
 		var link = allLinks[i];
-		if (!jsExceptionsRe.test(link)) {
+		if (!jsExceptionsRe.test(link) && !link.href.indexOf(baseurl)) {
 			link.href = link.href.replace(/(#|$)/,
 				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1$1');
 		}
-- 
1.7.5.4
