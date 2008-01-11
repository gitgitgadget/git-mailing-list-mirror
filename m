From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-relink.perl: warn() instead of die() on directory open
 failure
Date: Fri, 11 Jan 2008 12:11:41 -0600
Message-ID: <4787B15D.3070105@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:16:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDOQV-0004bw-J7
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 19:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759882AbYAKSPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 13:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760070AbYAKSPv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 13:15:51 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45264 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759729AbYAKSPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 13:15:50 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0BIBjwT019852;
	Fri, 11 Jan 2008 12:11:45 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Jan 2008 12:11:41 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 11 Jan 2008 18:11:41.0672 (UTC) FILETIME=[6AA23680:01C8547D]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15652001
X-TM-AS-Result: : Yes--5.038400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDY3NS03MDAx?=
	=?us-ascii?B?NjAtNzExOTUzLTcwMjAyMC0xODgwMTktNzAyMTcxLTcwMDk3MS0x?=
	=?us-ascii?B?MjEzMzgtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70183>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Sometimes the repository to link to is not under your control.
If it contains files or unreadable directories, git-relink will
die without this patch.

-brandon


 git-relink.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-relink.perl b/git-relink.perl
index f6b4f6a..391b12d 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -69,7 +69,7 @@ sub do_scan_directory($$$) {
 	my $dfulldir = sprintf("%sobjects/%s/",$dstdir,$subdir);
 
 	opendir(S,$sfulldir)
-		or die "Failed to opendir $sfulldir: $!";
+		or (warn "Failed to opendir $sfulldir: $!" and return);
 
 	foreach my $file (grep(!/\.{1,2}$/, readdir(S))) {
 		my $sfilename = $sfulldir . $file;
-- 
1.5.4.rc2.84.gf85fd-dirty
