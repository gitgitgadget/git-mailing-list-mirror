From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: [PATCH] git-svnimport: fix edge revisions double importing
Date: Mon, 8 Jan 2007 04:22:42 +0200
Message-ID: <20070108022242.GA19217@sashak.voltaire.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <20070104213142.GE11861@sashak.voltaire.com> <204011cb0701041404g684525fdm1d057e57a57aca92@mail.gmail.com> <20070107001719.GB16771@sashak.voltaire.com> <204011cb0701071012g30cb69a5h4622d94574d10521@mail.gmail.com> <20070107185906.GD18379@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Lee <chris133@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 03:15:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3k2p-0004Wm-PW
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 03:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbXAHCPX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 21:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbXAHCPX
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 21:15:23 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:53786 "EHLO
	taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030446AbXAHCPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 21:15:23 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 8 Jan 2007 04:15:20 +0200
Received: by sashak (sSMTP sendmail emulation); Mon,  8 Jan 2007 04:22:42 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20070107185906.GD18379@sashak.voltaire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 08 Jan 2007 02:15:20.0377 (UTC) FILETIME=[D8B37290:01C732CA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36223>

This fixes newly introduced bug when the incremental cycle edge revisions
are imported twice.

Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
---
 git-svnimport.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index afbbe63..f1f1a7d 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -943,10 +943,10 @@ if ($opt_l < $current_rev) {
 print "Processing from $current_rev to $opt_l ...\n" if $opt_v;
 
 my $from_rev;
-my $to_rev = $current_rev;
+my $to_rev = $current_rev - 1;
 
 while ($to_rev < $opt_l) {
-	$from_rev = $to_rev;
+	$from_rev = $to_rev + 1;
 	$to_rev = $from_rev + $repack_after;
 	$to_rev = $opt_l if $opt_l < $to_rev;
 	print "Fetching from $from_rev to $to_rev ...\n" if $opt_v;
-- 
1.5.0.rc0.g2484-dirty
