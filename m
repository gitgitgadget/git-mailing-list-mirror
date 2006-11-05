X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn: don't die on rebuild when --upgrade is specified
Date: Sat,  4 Nov 2006 21:51:11 -0800
Message-ID: <11627058733587-git-send-email-normalperson@yhbt.net>
References: <11627058712379-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Sun, 5 Nov 2006 05:51:31 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.3.3.ga126
In-Reply-To: <11627058712379-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30949>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggaub-00077U-Pv for gcvg-git@gmane.org; Sun, 05 Nov
 2006 06:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161058AbWKEFvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 00:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbWKEFvP
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 00:51:15 -0500
Received: from hand.yhbt.net ([66.150.188.102]:9386 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1161058AbWKEFvO (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 00:51:14 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 8046B2DC035; Sat,  4 Nov 2006 21:51:13 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 04 Nov 2006
 21:51:13 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--copy-remote and --upgrade are rarely (never?) used together,
so if --copy-remote is specified, that means the user really
wanted to copy the remote ref, and we should fail if that fails.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cc3335a..4a56f18 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3139,7 +3139,7 @@ sub copy_remote_ref {
 	my $ref = "refs/remotes/$GIT_SVN";
 	if (safe_qx('git-ls-remote', $origin, $ref)) {
 		sys(qw/git fetch/, $origin, "$ref:$ref");
-	} else {
+	} elsif ($_cp_remote && !$_upgrade) {
 		die "Unable to find remote reference: ",
 				"refs/remotes/$GIT_SVN on $origin\n";
 	}
-- 
1.4.3.3.ga126
