From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] gitweb: Add author information to commitdiff view
Date: Mon, 28 Aug 2006 14:48:12 +0200
Message-ID: <11567692951542-git-send-email-jnareb@gmail.com>
References: <11567692943154-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 14:49:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHgXm-0005ac-Cs
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 14:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWH1Msa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWH1Ms2
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 08:48:28 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:9394 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750751AbWH1MsW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 08:48:22 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7SCl2qv031911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Aug 2006 14:47:02 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7SCmFXh017620;
	Mon, 28 Aug 2006 14:48:15 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7SCmFXJ017619;
	Mon, 28 Aug 2006 14:48:15 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11567692943154-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26152>

Add subroutine git_print_authorship to print author and date of
commit, div.author_date style to CSS, and use them in git_commitdiff.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.css  |    7 +++++++
 gitweb/gitweb.perl |   11 +++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index afd9e8a..eb9fc38 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -116,6 +116,13 @@ div.list_head {
 	font-style: italic;
 }
 
+div.author_date {
+	padding: 8px;
+	border: solid #d9d8d1;
+	border-width: 0px 0px 1px 0px;
+	font-style: italic;
+}
+
 a.list {
 	text-decoration: none;
 	color: #000000;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c2dcc6c..81d3e76 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1341,6 +1341,16 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+#sub git_print_authorship (\%) {
+sub git_print_authorship {
+	my $co = shift;
+
+	my %ad = parse_date($co->{'author_epoch'});
+	print "<div class=\"author_date\">" .
+	      esc_html($co->{'author_name'}) .
+	      " [$ad{'rfc2822'}]</div>\n";
+}
+
 sub git_print_page_path {
 	my $name = shift;
 	my $type = shift;
@@ -2914,6 +2924,7 @@ sub git_commitdiff {
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
+		git_print_authorship(\%co);
 		print "<div class=\"page_body\">\n";
 		print "<div class=\"log\">\n";
 		git_print_simplified_log($co{'comment'}, 1); # skip title
-- 
1.4.1.1
