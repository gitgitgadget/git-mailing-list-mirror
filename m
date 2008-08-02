From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: ref markers link to named shortlogs
Date: Sat,  2 Aug 2008 17:39:14 +0200
Message-ID: <1217691554-10407-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 17:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPJDB-00034a-KT
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 17:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbYHBPjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 11:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYHBPjC
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 11:39:02 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:42025 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbYHBPjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 11:39:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so722758fgg.17
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Nahmcpap2/3CNYKWpklxB7s2VKjlJjXwvpubl6zkEB8=;
        b=JHss3epjTZIKdyXqM74RuUvEVsl64vG1soYBDwich8ky8Nf1LKGiCwlRcS2MfgBPx1
         9RcsrnRre/KXZ1c6crE1EXo8uiH7PK/sf0oX8sCux6NEul+K25VoEn9Ew1ClR+sz+PGm
         7/GTUUSu20WoHOczGnBO8dyFMIcKbBPs5nHbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=x5OZOjo1gLwwxSURcoIdecPnWsZg8WqoM+YChsfEOj8Xx4HrVNRwPKZZSevud5phnn
         cKG9oNZ81rkfbx0GNEh0zfqRjmzC7lGxel/3VcP2arj3fVDFoxZshmFrOv0N14G9Yx+A
         PVfwVw44eubvxd45fFPmgMQkKmRrZkPe3ypuU=
Received: by 10.86.71.1 with SMTP id t1mr8541228fga.36.1217691538629;
        Sat, 02 Aug 2008 08:38:58 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id 3sm3129693fge.3.2008.08.02.08.38.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Aug 2008 08:38:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91149>

This patch turns ref markers for tags and heads into links to
shortlog/refname. Appropriate changes are made in the CSS to prevent ref
markers to be annoyingly blue and underlined.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |    5 ++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index aa0eeca..2b43eea 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -481,6 +481,11 @@ span.refs span {
 	border-color: #ffccff #ff00ee #ff00ee #ffccff;
 }
 
+span.refs span a {
+	text-decoration: none;
+	color: inherit;
+}
+
 span.refs span.ref {
 	background-color: #aaaaff;
 	border-color: #ccccff #0033cc #0033cc #ccccff;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cd99b..7f391fa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1093,6 +1093,7 @@ sub format_log_line_html {
 sub format_ref_marker {
 	my ($refs, $id) = @_;
 	my $markers = '';
+	my $htmltext;
 
 	if (defined $refs->{$id}) {
 		foreach my $ref (@{$refs->{$id}}) {
@@ -1101,13 +1102,15 @@ sub format_ref_marker {
 			if ($ref =~ m!^(.*?)s?/(.*)$!) {
 				$type = $1;
 				$name = $2;
+				$htmltext = $cgi->a({-href => href(action=>"shortlog", hash=>$name)}, $name);
 			} else {
 				$type = "ref";
 				$name = $ref;
+				$htmltext = esc_html($name);
 			}
 
 			$markers .= " <span class=\"$type\" title=\"$ref\">" .
-			            esc_html($name) . "</span>";
+			            $htmltext . "</span>";
 		}
 	}
 
-- 
1.5.6.3
