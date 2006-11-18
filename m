X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/5] gitweb: Protect against possible warning in git_commitdiff
Date: Sat, 18 Nov 2006 23:35:38 +0100
Message-ID: <11638893431855-git-send-email-jnareb@gmail.com>
References: <1163889342877-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 18 Nov 2006 22:34:51 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k2bhkp+JtWIc+ZFoty8zYKO6xUSgyf/R7wfJCI3VV5WZ3cw4FexZmQiD5zFjWaDSEym8UCoLfXMrnAPP8rXjEoKd4T4qG02Zrd4PXrMYfqKcvRJ0B1ymM/IR6zN9gjuH34u6SIKvcYJh1wYvxd3yuQSToAehFgQnAkkl7/1WHUI=
X-Mailer: git-send-email 1.4.3.4
In-Reply-To: <1163889342877-git-send-email-jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31807>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlYla-0001jk-EY for gcvg-git@gmane.org; Sat, 18 Nov
 2006 23:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755271AbWKRWeU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 17:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbWKRWeU
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 17:34:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:12050 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755271AbWKRWeT
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 17:34:19 -0500
Received: by ug-out-1314.google.com with SMTP id m3so953027ugc for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 14:34:17 -0800 (PST)
Received: by 10.66.216.20 with SMTP id o20mr3566333ugg.1163889257836; Sat, 18
 Nov 2006 14:34:17 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 e23sm2272849ugd.2006.11.18.14.34.17; Sat, 18 Nov 2006 14:34:17 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAIMZh3K015347; Sat, 18 Nov 2006 23:35:43 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAIMZhQb015346; Sat, 18 Nov 2006 23:35:43 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm not sure _when_ this eror (warning) occur, as it happened to me
once, but I couldn't repeat it; but I didn't try too hard.

I think it is better coding practice, and more readable.

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7587595..b2482fe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3731,7 +3731,8 @@ sub git_commitdiff {
 			$hash_parent, $hash, "--"
 			or die_error(undef, "Open git-diff-tree failed");
 
-		while (chomp(my $line = <$fd>)) {
+		while (my $line = <$fd>) {
+			chomp $line;
 			# empty line ends raw part of diff-tree output
 			last unless $line;
 			push @difftree, $line;
-- 
1.4.3.4
