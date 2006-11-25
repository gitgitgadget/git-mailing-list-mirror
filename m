X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Use author_epoch for pubdate in gitweb feeds
Date: Sat, 25 Nov 2006 15:54:34 +0100
Message-ID: <11644665273247-git-send-email-jnareb@gmail.com>
References: <11644664743455-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 25 Nov 2006 14:54:43 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y+ADDHdwug35zXe4VGHiDFTmZwdk7a2Q02Y11l8nr61At+OHh9fcQgULgFxecOnEOlrj7c9SeL5+KXw3NCYUTJXjVxonRasmXATozAT1mtj90xmoSBaSp8LSvhquYxsj0BOb5K8a/3ZEka7eFk5glxl9ers+7FcQOziZ/a0fTQs=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11644664743455-git-send-email-jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32291>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnyvP-0001FS-Qn for gcvg-git@gmane.org; Sat, 25 Nov
 2006 15:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966604AbWKYOyI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 09:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966606AbWKYOyI
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 09:54:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:38525 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966604AbWKYOyG
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 09:54:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so849710uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 06:54:06 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr8904454ugg.1164466446163; Sat, 25
 Nov 2006 06:54:06 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 o1sm15046512uge.2006.11.25.06.54.05; Sat, 25 Nov 2006 06:54:06 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAPEtTRY016985; Sat, 25 Nov 2006 15:55:38 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAPEtRai016984; Sat, 25 Nov 2006 15:55:27 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Use creation date (author_epoch) instead of former commit date
(committer_epoch) as publish date in gitweb feeds (RSS, Atom).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This I'm not so sure about. I just wonder why commit date was used
as publish date of feed item/entry...

 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 15dd1f4..fac7923 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4201,7 +4201,7 @@ sub git_feed {
 	}
 	if (defined($revlist[0])) {
 		%latest_commit = parse_commit($revlist[0]);
-		%latest_date   = parse_date($latest_commit{'committer_epoch'});
+		%latest_date   = parse_date($latest_commit{'author_epoch'});
 		print $cgi->header(
 			-type => $content_type,
 			-charset => 'utf-8',
@@ -4294,10 +4294,10 @@ XML
 		my $commit = $revlist[$i];
 		my %co = parse_commit($commit);
 		# we read 150, we always show 30 and the ones more recent than 48 hours
-		if (($i >= 20) && ((time - $co{'committer_epoch'}) > 48*60*60)) {
+		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = parse_date($co{'committer_epoch'});
+		my %cd = parse_date($co{'author_epoch'});
 
 		# get list of changed files
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-- 
1.4.4.1
