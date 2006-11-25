X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Add author and contributor email to Atom feed
Date: Sat, 25 Nov 2006 15:54:33 +0100
Message-ID: <11644665113030-git-send-email-jnareb@gmail.com>
References: <11644664743455-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 25 Nov 2006 14:54:19 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YJyGW71i9TmYMT/FyHoUVz64U3Ldvtg/UIcl61M3RHk+1CXaPXIzwsB7OsYWj0vIcl3SvuHmc+nFGMYNFI+ZrreA/AhVZsFUibr4scSPYHVsIRXWnXP0JCWwNlzpHhMgMKdWGXtYKkXfZQ7c+ckmZKHnifBjATpdDsl9hbP3A8s=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11644664743455-git-send-email-jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32290>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnyur-0001AE-CS for gcvg-git@gmane.org; Sat, 25 Nov
 2006 15:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966599AbWKYOx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 09:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966603AbWKYOx6
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 09:53:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:38525 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966599AbWKYOx6
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 09:53:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so849710uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 06:53:57 -0800 (PST)
Received: by 10.67.117.2 with SMTP id u2mr8895033ugm.1164466437245; Sat, 25
 Nov 2006 06:53:57 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 29sm15138551uga.2006.11.25.06.53.51; Sat, 25 Nov 2006 06:53:57 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAPEtCkE016980; Sat, 25 Nov 2006 15:55:18 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAPEtBgE016979; Sat, 25 Nov 2006 15:55:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add author email (from 'author_email') and contributor email (from
'committer_email') to items in the Atom format gitweb feed.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2ebd9d7..15dd1f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4323,9 +4323,19 @@ XML
 			print "<entry>\n" .
 			      "<title type=\"html\">" . esc_html($co{'title'}) . "</title>\n" .
 			      "<updated>$cd{'iso-8601'}</updated>\n" .
-			      "<author><name>" . esc_html($co{'author_name'}) . "</name></author>\n" .
+			      "<author>\n" .
+			      "  <name>" . esc_html($co{'author_name'}) . "</name>\n";
+			if ($co{'author_email'}) {
+				print "  <email>" . esc_html($co{'author_email'}) . "</email>\n";
+			}
+			print "</author>\n" .
 			      # use committer for contributor
-			      "<contributor><name>" . esc_html($co{'committer_name'}) . "</name></contributor>\n" .
+			      "<contributor>\n" .
+			      "  <name>" . esc_html($co{'committer_name'}) . "</name>\n";
+			if ($co{'committer_email'}) {
+				print "  <email>" . esc_html($co{'committer_email'}) . "</email>\n";
+			}
+			print "</contributor>\n" .
 			      "<published>$cd{'iso-8601'}</published>\n" .
 			      "<link rel=\"alternate\" type=\"text/html\" href=\"$co_url\" />\n" .
 			      "<id>$co_url</id>\n" .
-- 
1.4.4.1
