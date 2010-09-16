From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 4/7] gitweb: link heads and remotes view
Date: Thu, 16 Sep 2010 11:31:02 +0200
Message-ID: <1284629465-14798-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 11:31:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwAoq-0007PY-CB
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab0IPJbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:31:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52672 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab0IPJbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:31:45 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so1146293wyf.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nRa5RmVt9Ket1as7oL3KzTGH8LKMo3yaaCYxMgOPwvE=;
        b=uEthX94ywS85mepMfUpjkBDGU/2GWMl3If9BtX1SoYLT93WlTUvOAM7abCkhHnuOde
         id7jr+HQzsVPdXBZooG4UzhumC6G0eRKLFcC+weA87D89tX1i1x2RIls8a3g+fBAoWCe
         ePnK+yFCaxde5Nfjrk9d1MVsvZ3xeByKG+Yek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VMjOmccA5z7aYA0TOp6E7oVeWCvEXrWePBNwv+yN+Al2V2zPJLdgJlrIuBHhkcyUUB
         0UBLuiueUS0XtoNs7A7hBPafMkObUcxTC/D2+lZ0nvlcgRewUw9DoSavX/YZISHcpQ4w
         VWCKj2BYc62s8pI3+wrb3v6FBa7l3SERIo8O0=
Received: by 10.227.128.8 with SMTP id i8mr2561257wbs.91.1284629504875;
        Thu, 16 Sep 2010 02:31:44 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id m25sm2125833wbc.19.2010.09.16.02.31.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 02:31:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.230.g8b572
In-Reply-To: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156307>

Add a link in heads view to remotes view (if the feature is
enabled), and conversely from remotes to heads.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0118739..6138c6e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5511,7 +5511,10 @@ sub git_tags {
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
@@ -5527,7 +5530,10 @@ sub git_remotes {
 
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
1.7.3.rc1.230.g8b572
