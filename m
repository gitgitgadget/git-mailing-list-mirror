From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Strip any trailing slash on destination argument
Date: Tue, 1 Nov 2005 23:46:27 +0100
Message-ID: <200511012346.27393.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 01 23:08:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX4GO-0003XU-Lh
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 23:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVKAWFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 17:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVKAWFu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 17:05:50 -0500
Received: from pop.gmx.net ([213.165.64.20]:28121 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751335AbVKAWFt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 17:05:49 -0500
Received: (qmail invoked by alias); 01 Nov 2005 22:05:48 -0000
Received: from p54969405.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.148.5]
  by mail.gmx.net (mp022) with SMTP; 01 Nov 2005 23:05:48 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10960>

Needed because generating a target paths will add another slash.
This fixes e.g. "git-mv file dir/", which removed "file" from
version control by renaming it to "dir//file", as
git-update-index does not accept such paths.

Thanks goes to Ben Lau for noting this bug.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

 git-mv.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

applies-to: e39c96179f2cc5064a0255057b8e8a8863594536
e91e743bdf6d246b279fc7f8f5f7ab733690249b
diff --git a/git-mv.perl b/git-mv.perl
index 17e35b0..a21d87e 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -54,6 +54,8 @@ my ($src, $dst, $base, $dstDir);
 my $argCount = scalar @ARGV;
 if (-d $ARGV[$argCount-1]) {
 	$dstDir = $ARGV[$argCount-1];
+	# remove any trailing slash
+	$dstDir =~ s/\/$//;
 	@srcArgs = @ARGV[0..$argCount-2];
 	
 	foreach $src (@srcArgs) {
---
0.99.9
