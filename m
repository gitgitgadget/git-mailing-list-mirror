From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFC/PATCH] gitweb: link to toggle 'no merges' option
Date: Thu, 17 Dec 2009 10:05:53 +0100
Message-ID: <1261040753-4859-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: jnareb@gmail.com, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 10:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLCJX-0004UI-3G
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 10:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757992AbZLQJGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 04:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757283AbZLQJGR
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 04:06:17 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:49464 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbZLQJGH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 04:06:07 -0500
Received: by fxm21 with SMTP id 21so1679224fxm.21
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 01:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/sMFqGhNE2T+/O/lSZreq6JTTaAq9nkFXk9wcE3uCNI=;
        b=EYyNoMrulBGNHttBdwJhe5qnVMbat7GXlAoMV3RQbI+ZP1T3cKXgswMnWrpMxYHJ72
         fTeiNTSyoMIYZmaud1SiIl6nqSviXxndfmnN2z3gonwpCXRNN1+PV3jW9Zvd3wgsK1ok
         XYr9mMcoCofU4iFQb9gH2/Pc3NUx/KeAh02GU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dw0gk4BzUdsd5+P+GumnO/HnCoae1ZXfzlDC78V2bxhQ4glCsyCFi7YW2AAts0+rth
         oKHY/XZHoG73kh6Qa2KeLtYp7BdTHEyP4t+GdnboTEmDMZL2nHmnQ+eHWA03IEkRwS1a
         36PkPtO94pO789Ef4WgtaJQJqBiwh0063+utk=
Received: by 10.223.6.9 with SMTP id 9mr2589433fax.84.1261040760732;
        Thu, 17 Dec 2009 01:06:00 -0800 (PST)
Received: from localhost (host-78-13-49-147.cust-adsl.tiscali.it [78.13.49.147])
        by mx.google.com with ESMTPS id 12sm3238520fks.9.2009.12.17.01.05.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Dec 2009 01:05:58 -0800 (PST)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135361>

In views that support --no-merges, introduce a link that toggles the
option.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

---
 gitweb/gitweb.css  |   11 +++++++++++
 gitweb/gitweb.perl |   14 ++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

This is something I've been wanting for a while. There are a number of
things that don't 'click' with this proof of concept, and I'm coming to
the list to hear the opinion of users and developers on how to improve
the thing.

The patch is live at http://git.oblomov.eu/, an example affected page is
http://git.oblomov.eu/git/shortlog

Things that are sure to change:

 * the aesthetics and location of the toggle link (it shows on mousehover
   in the title). Other options I've considered are:
    + next to pagination (first | prev | next), either before or after
      the existing entries
    + on mouseover for the table section that refers to the (short)log;
      this would make it possible to put it summary view too, for example

 * if you toggle merge view when not on the first page, the reference
   (first) commit in the view is likely to change drastically, which
   causes confusion. I have not found a satisfactory solution for this,
   since the obvious way to 'lock' the view (start paginating from the
   current top commit) prevents prev/next navigation

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 50067f2..0da6ef0 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -572,3 +572,14 @@ span.match {
 div.binary {
 	font-style: italic;
 }
+
+span.merge_toggle a {
+	font-size: 66%;
+	color: white !important;
+	font-weight: normal;
+	vertical-align: top;
+	text-decoration:none;
+	visibility: hidden;
+}
+
+*:hover > span.merge_toggle a { visibility:visible }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7e477af..a63f419 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3118,11 +3118,15 @@ sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
 
+	my $can_have_merges = grep(/^$action$/, @{$allowed_options{'--no-merges'}});
+	my $has_merges = !grep(/^--no-merges$/, @extra_options);
+
 	my $title = "$site_name";
 	if (defined $project) {
 		$title .= " - " . to_utf8($project);
 		if (defined $action) {
 			$title .= "/$action";
+			$title .= " (no merges)" unless $has_merges;
 			if (defined $file_name) {
 				$title .= " - " . esc_path($file_name);
 				if ($action eq "tree" && $file_name !~ m|/$|) {
@@ -3235,6 +3239,16 @@ EOF
 		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
 		if (defined $action) {
 			print " / $action";
+			if ($can_have_merges) {
+				print " <span class='merge_toggle'>";
+				if ($has_merges) {
+					printf('<a href="%s">hide merges</a>', href(-replay=>1, 'extra_options'=>('--no-merges', @extra_options)));
+				} else {
+					my @href_extra = grep(!/^--no-merges$/, @extra_options);
+					printf('<a href="%s">show merges</a>', href(-replay=>1, 'extra_options'=>@href_extra));
+				}
+				print "</span>";
+			}
 		}
 		print "\n";
 	}
-- 
1.6.3.rc1.192.gdbfcb
