From: Jakub Narebski <jnareb@git.vger.kernel.org>
Subject: [PATCH] gitweb: bugfix: a.list formatting regression
Date: Tue, 22 Aug 2006 12:02:48 +0200
Message-ID: <11562409683011-git-send-email-jnareb@git.vger.kernel.org>
References: <20060822085540.1104.qmail@web31812.mail.mud.yahoo.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 22 12:05:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFT6P-0002om-1F
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 12:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWHVKC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 06:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWHVKC7
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 06:02:59 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:57007 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932147AbWHVKC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 06:02:58 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7MA1eiI022544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Aug 2006 12:01:41 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7MA2npx011679;
	Tue, 22 Aug 2006 12:02:49 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7MA2mv0011678;
	Tue, 22 Aug 2006 12:02:48 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <20060822085540.1104.qmail@web31812.mail.mud.yahoo.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25849>

From: Jakub Narebski <jnareb@gmail.com>

Fix regression introduced by
commit 17d07443188909ef5f8b8c24043cb6d9fef51bca.

"a.list" being "bold", makes a myriad of things shown by
gitweb in bold font-weight, which is a regression from
pre-17d07443188909ef5f8b8c24043cb6d9fef51bca behavior.

The fix is to add "subject" class and use this class
to replace pre-format_subject_html formatting of subject
(comment) via using (or not) <b>...</b> element. This
should go back to the pre-17d0744318... style.

Regression noticed by Luben Tuikov.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
Luben Tuikov wrote:

> 1. Commit 17d07443188909ef5f8b8c24043cb6d9fef51bca defines
> "a.list" twice in gitweb.css, once with bold and once with
> normal font-weight.

"table.tags a.list" means "a.list" inside "table.tags",
so it is not redefinition of "a.list", but override
(more specific CSS rule wins). It is for subject of tags
list ("summary" and "tags" actions) to be in normal
weight, as in such list the tag itself (ref) is in bold,
not the tag comment (first line of free form part of tag).

 gitweb/gitweb.css  |    7 +++++--
 gitweb/gitweb.perl |    4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 9013895..6c13d9e 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -117,11 +117,14 @@ div.list_head {
 
 a.list {
 	text-decoration: none;
-	font-weight: bold;
 	color: #000000;
 }
 
-table.tags a.list {
+a.subject {
+	font-weight: bold;
+}
+
+table.tags a.subject {
 	font-weight: normal;
 }
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90157d5..40c5177 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -504,11 +504,11 @@ sub format_subject_html {
 	$extra = '' unless defined($extra);
 
 	if (length($short) < length($long)) {
-		return $cgi->a({-href => $href, -class => "list",
+		return $cgi->a({-href => $href, -class => "list subject",
 		                -title => $long},
 		       esc_html($short) . $extra);
 	} else {
-		return $cgi->a({-href => $href, -class => "list"},
+		return $cgi->a({-href => $href, -class => "list subject"},
 		       esc_html($long)  . $extra);
 	}
 }
-- 
1.4.1.1
