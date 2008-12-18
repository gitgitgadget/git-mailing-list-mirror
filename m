From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 4/4] gitweb: link to patch(es) view in commit(diff) and (short)log view
Date: Thu, 18 Dec 2008 08:13:19 +0100
Message-ID: <1229584399-23879-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1229584399-23879-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1229584399-23879-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1229584399-23879-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1229584399-23879-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 08:15:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDD67-0007LV-Gj
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 08:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYLRHNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 02:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbYLRHNc
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 02:13:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:15163 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYLRHN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 02:13:29 -0500
Received: by fg-out-1718.google.com with SMTP id 19so119795fgg.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 23:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sBOmnhlV0/3c/WPq9WsP2DNi31Y4R7MYScAq2xTBkAk=;
        b=sGjMQ6KuECbbUQ8mYuV8hpWsg0M9bMmsry3r4pW6Usa4wVy1wL6EgOnYu98hh/TfyG
         kQp4xvn0tls/NX2HsUQzqqQCK4CxmzfbwMWlIx8HEdJ2a9pgJ/mWCOQcby4rujjnqA+A
         AUvgKun9HmXkekVh6JpLTdz1Pv6TiiJFGYSeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sy9Pf7/WTsZDldEaydtNUKEFHfEQYVdvHAgZ6S5JU0PigU9l7IJKOYwwdSzOA/9gEq
         INrFZY6SbqTk2VcmEY2HBX6/gkhJTCzs5rkx3Vm+M1sI8HTU5OX+3Z4K7KXT1K4GXc/0
         ihNMTXTtq9hBxQ5GmxtIa0KSq32YjQu+1EftI=
Received: by 10.86.95.20 with SMTP id s20mr931525fgb.39.1229584408098;
        Wed, 17 Dec 2008 23:13:28 -0800 (PST)
Received: from localhost ([78.13.57.58])
        by mx.google.com with ESMTPS id 12sm858081fgg.5.2008.12.17.23.13.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Dec 2008 23:13:27 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1229584399-23879-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103441>

We link to patch view in commit and commitdiff view, and to patches view
in log and shortlog view.

In (short)log view, the link is only offered when the number of commits
shown is no more than the allowed maximum number of patches.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 78aaebe..fd8bc29 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5024,6 +5024,15 @@ sub git_log {
 
 	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
 
+	my ($patch_max) = gitweb_get_feature('patches');
+	if ($patch_max) {
+		if ($patch_max < 0 || @commitlist <= $patch_max) {
+			$paging_nav .= " &sdot; " .
+				$cgi->a({-href => href(action=>"patches", -replay=>1)},
+					"patches");
+		}
+	}
+
 	git_header_html();
 	git_print_page_nav('log','', $hash,undef,undef, $paging_nav);
 
@@ -5103,6 +5112,11 @@ sub git_commit {
 			} @$parents ) .
 			')';
 	}
+	if (gitweb_check_feature('patches')) {
+		$formats_nav .= " | " .
+			$cgi->a({-href => href(action=>"patch", -replay=>1)},
+				"patch");
+	}
 
 	if (!defined $parent) {
 		$parent = "--root";
@@ -5416,9 +5430,8 @@ sub git_commitdiff {
 	my %params = @_;
 	my $format = $params{-format} || 'html';
 
-	my $patch_max;
+	my ($patch_max) = gitweb_get_feature('patches');
 	if ($format eq 'patch') {
-		($patch_max) = gitweb_get_feature('patches');
 		die_error(403, "Patch view not allowed") unless $patch_max;
 	}
 
@@ -5436,6 +5449,11 @@ sub git_commitdiff {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
 			        "raw");
+		if ($patch_max) {
+			$formats_nav .= " | " .
+				$cgi->a({-href => href(action=>"patch", -replay=>1)},
+					"patch");
+		}
 
 		if (defined $hash_parent &&
 		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
@@ -5992,6 +6010,14 @@ sub git_shortlog {
 			$cgi->a({-href => href(-replay=>1, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	}
+	my $patch_max = gitweb_check_feature('patches');
+	if ($patch_max) {
+		if ($patch_max < 0 || @commitlist <= $patch_max) {
+			$paging_nav .= " &sdot; " .
+				$cgi->a({-href => href(action=>"patches", -replay=>1)},
+					"patches");
+		}
+	}
 
 	git_header_html();
 	git_print_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
-- 
1.5.6.5
