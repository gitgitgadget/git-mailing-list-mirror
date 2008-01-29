From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-relink: avoid hard linking in objects/info directory
Date: Tue, 29 Jan 2008 16:41:30 -0600
Message-ID: <479FAB9A.9040009@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:42:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJz9s-0001V3-4M
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbYA2Wlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbYA2Wlu
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:41:50 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50864 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbYA2Wlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 17:41:49 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0TMfVJk029749;
	Tue, 29 Jan 2008 16:41:31 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 29 Jan 2008 16:41:31 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 29 Jan 2008 22:41:31.0112 (UTC) FILETIME=[17BA3680:01C862C8]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--8.472800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMjM3OS03MDQ5?=
	=?us-ascii?B?MjctNzAzODA3LTcwMDgxMC03MDQ0MjEtNzAwMDU3LTcwMTQwMy03?=
	=?us-ascii?B?MDYzOTAtNzAwMTYwLTE4ODAxOS03MDI1NjgtMTIxMzM4LTE0ODAz?=
	=?us-ascii?B?OS0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72008>

git-relink is intended to search for packs and loose objects in
common between two repositories and to replace the one set with
hard links to the other. Files other than packs and loose objects
should not be touched, so add the "info" sub-directory to the
pattern of directory excludes.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-relink.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-relink.perl b/git-relink.perl
index f6b4f6a..d267404 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -40,7 +40,7 @@ my $master_dir = pop @dirs;
 opendir(D,$master_dir . "objects/")
 	or die "Failed to open $master_dir/objects/ : $!";
 
-my @hashdirs = grep !/^\.{1,2}$/, readdir(D);
+my @hashdirs = grep !/^(\.{1,2}|info)$/, readdir(D);
 
 foreach my $repo (@dirs) {
 	$linked = 0;
-- 
1.5.4.rc5.3.gb953
