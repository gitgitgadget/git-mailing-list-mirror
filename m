From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Better error message for git svn dcommit on empty repository.
Date: Mon,  5 May 2008 10:18:28 +0200
Message-ID: <1209975508-9998-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20080429071552.GH24171@muzzle>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 05 10:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsvxM-0007EO-5M
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 10:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbYEEIVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 04:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYEEIVH
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 04:21:07 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:34716 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbYEEIVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 04:21:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m458K3We010521;
	Mon, 5 May 2008 10:20:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Jsvu0-0001GH-HM; Mon, 05 May 2008 10:18:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Jsvu0-0002ba-Em; Mon, 05 May 2008 10:18:28 +0200
X-Mailer: git-send-email 1.5.5.1.72.gccbb6.dirty
In-Reply-To: <20080429071552.GH24171@muzzle>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 05 May 2008 10:20:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81243>

Ideally, git-svn should be able to do the initial commit, but since it
isn't, this patch makes it give an accurate error message.

Acked-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-svn.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b864b54..9a70c1e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -410,10 +410,12 @@ sub cmd_dcommit {
 	$head ||= 'HEAD';
 	my @refs;
 	my ($url, $rev, $uuid, $gs) = working_head_info($head, \@refs);
-	print "Committing to $url ...\n";
+	if ($url) {
+		print "Committing to $url ...\n";
+	}
 	unless ($gs) {
 		die "Unable to determine upstream SVN information from ",
-		    "$head history\n";
+		    "$head history.\nPerhaps the repository is empty.";
 	}
 	my $last_rev;
 	my ($linear_refs, $parents) = linearize_history($gs, \@refs);
-- 
1.5.5.1.72.gccbb6.dirty
