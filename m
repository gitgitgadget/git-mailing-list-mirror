From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 07/11] gitweb: add 'remotes' action
Date: Thu, 13 Nov 2008 23:49:13 +0100
Message-ID: <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 23:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0l1W-0004iw-Ar
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbYKMWtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbYKMWtU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:49:20 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:31154 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbYKMWtO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:49:14 -0500
Received: by fg-out-1718.google.com with SMTP id 19so912881fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VdzSPnmhpRsCEsuSq3PZYdxFZfG8+QLtR8nXIZGa6IE=;
        b=fIP1MgoHnKeDBVAK2fR4HhaJH9I2i/va7DzHeNV+Vk0k0gh2PW7LGwbtU55F4pVYMB
         cr81OeePpHE+PAayBvwCdznauSAYY9rNwAw4HlFZhIBVSjCRRCSsAFb/FbdVvoVkNtEE
         q4HeW4huHhIoJIODZvp/4d4opBBsJWuzGatRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YW3qwNu7WUy+NFBxBi14S+5AbFZQcZVZXLYG7FspgL1g8zfr4HFRVzDJaZ7kld5iMP
         UB+A16DYkTq9qb8+J6xsjFqoRjR3hnGmsgk1lvTiXrdb4wecAZKFQGWyM+nEBIzy5BYR
         ofzt7BNvxZ9u6W6+3XNtTwkVEpV4EPuckT/D4=
Received: by 10.181.141.7 with SMTP id t7mr76330bkn.10.1226616553645;
        Thu, 13 Nov 2008 14:49:13 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id y15sm5455482fkd.17.2008.11.13.14.49.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 14:49:13 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This action is similar to the 'heads' action, but it displays
remote heads, grouped by remote repository.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 03e0b21..09728cb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -507,6 +507,7 @@ our %actions = (
 	"commit" => \&git_commit,
 	"forks" => \&git_forks,
 	"heads" => \&git_heads,
+	"remotes" => \&git_remotes,
 	"history" => \&git_history,
 	"log" => \&git_log,
 	"rss" => \&git_rss,
@@ -4755,13 +4756,26 @@ sub git_heads {
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
 
-	my @headslist = git_get_heads_list();
+	my @headslist = git_get_heads_list(undef, 'heads');
 	if (@headslist) {
 		git_heads_body(\@headslist, $head);
 	}
 	git_footer_html();
 }
 
+sub git_remotes {
+	my $head = git_get_head_hash($project);
+	git_header_html();
+	git_print_page_nav('','', $head,undef,$head);
+	git_print_header_div('summary', $project . ' remotes');
+
+	my @headslist = git_get_heads_list(undef, 'remotes');
+	if (@headslist) {
+		git_split_heads_body(\@headslist, $head);
+	}
+	git_footer_html();
+}
+
 sub git_blob_plain {
 	my $type = shift;
 	my $expires;
-- 
1.5.6.5
