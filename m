From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 4/4] gitweb: link heads and remotes view
Date: Sun, 16 Nov 2008 14:28:09 +0100
Message-ID: <1226842089-1159-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 14:29:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1hhA-00027T-2j
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 14:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbYKPN2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 08:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbYKPN2L
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 08:28:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57037 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbYKPN2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 08:28:07 -0500
Received: by ug-out-1314.google.com with SMTP id 39so219624ugf.37
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 05:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FxUkiIi7YbYJW/Uxqq/Rr9FpWwKncQ3f2CV2xaOPGuc=;
        b=Xx2YNaHHP69lCbpMbngNEcuLOrG6yagLjybmWz3k+pUvEgml92Y9Twph6lDQ6LDwEt
         ZINGVEsz3Oo9hpPTtYckLflIVKrJjVqVml7lK2CsATbpZCss1OV8yPjNbN3YDmKVJrZV
         YqSLnhN754b7JofSyOoERd+HNzdEf3Xhqr7AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LpN+QiubDznxT7rojRnvmqR7iDpfa8MtPOkqARCO/xHFDfbOgk3asp+GLScu/snBAF
         d1fd79fMrOoLPs9o+Cj3Va2bfaLdquhW1qMhP0PHygcOaAZjMIyzM8MdBFsxS4EshwvQ
         i+aoGJ/HO1Jv74cMLMcCqvET3cBobFIEIGAuY=
Received: by 10.67.121.14 with SMTP id y14mr832745ugm.72.1226842086589;
        Sun, 16 Nov 2008 05:28:06 -0800 (PST)
Received: from localhost ([94.37.6.2])
        by mx.google.com with ESMTPS id 27sm2516463ugp.37.2008.11.16.05.28.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 05:28:06 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226842089-1159-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101127>

Add a link in heads view to remotes view (if the feature is
enabled), and conversely from remotes to heads.
---
 gitweb/gitweb.perl |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6b09918..95162db 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4736,7 +4736,10 @@ sub git_tags {
 sub git_heads {
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	my $heads_nav = gitweb_check_feature('remote_heads') ?
+		$cgi->a({-href => href(action=>"remotes", -replay=>1)},
+		        "remotes") : undef;
+	git_print_page_nav('','', $head,undef,$head, $heads_nav);
 	git_print_header_div('summary', $project);
 
 	my @headslist = git_get_heads_list(undef, 'heads');
@@ -4752,7 +4755,10 @@ sub git_remotes {
 
 	my $head = git_get_head_hash($project);
 	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
+	my $heads_nav =
+		$cgi->a({-href => href(action=>"heads", -replay=>1)},
+		        "heads");
+	git_print_page_nav('','', $head,undef,$head, $heads_nav);
 	git_print_header_div('summary', $project);
 
 	my @remotelist = git_get_heads_list(undef, 'remotes');
-- 
1.5.6.5
