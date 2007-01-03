From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix "Use of uninitialized value" warning in git_tags_body
Date: Wed,  3 Jan 2007 22:54:29 +0100
Message-ID: <11678612691404-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 03 22:51:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2E1C-0001cT-CR
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 22:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbXACVvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 16:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbXACVvX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 16:51:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:24314 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107AbXACVvW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 16:51:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5286539uga
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 13:51:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=WewQqrf3XpBgfSZVkCbrPTjmaFxzJvQP6l50UrpfNTly5f5kP3bGUcMuTXgznu329hGn6bj+CW18HSYKcVzGiZTVm0k1nUFsPndcavsCTNioj25h55quvfVaH5k9h8rFWnbid95Q3Hf3opN90nQhCEBIoSswLwqc5ofEF+Bf7BI=
Received: by 10.66.242.20 with SMTP id p20mr27523466ugh.1167861081403;
        Wed, 03 Jan 2007 13:51:21 -0800 (PST)
Received: from roke.D-201 ( [81.190.20.195])
        by mx.google.com with ESMTP id i39sm33037996ugd.2007.01.03.13.51.20;
        Wed, 03 Jan 2007 13:51:21 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l03LsURc023800;
	Wed, 3 Jan 2007 22:54:30 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l03LsTNY023799;
	Wed, 3 Jan 2007 22:54:29 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35893>

Fix "Use of uninitialized value" warning in git_tags_body generated
for lightweight tags of tree and blob object; those don't have age
($tag{'age'}) defined.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2179054..fd671f3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2813,8 +2813,12 @@ sub git_tags_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td><i>$tag{'age'}</i></td>\n" .
-		      "<td>" .
+		if (defined $tag{'age'}) {
+			print "<td><i>$tag{'age'}</i></td>\n";
+		} else {
+			print "<td></td>\n";
+		}
+		print "<td>" .
 		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'}),
 		               -class => "list name"}, esc_html($tag{'name'})) .
 		      "</td>\n" .
-- 
1.4.4.3
