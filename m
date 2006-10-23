From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-send-email: do not pass custom Date: header
Date: Mon, 23 Oct 2006 00:46:37 -0700
Message-ID: <11615895973387-git-send-email-normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 23 09:47:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbuWC-0008Fp-Be
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 09:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWJWHqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 03:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWJWHqk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 03:46:40 -0400
Received: from hand.yhbt.net ([66.150.188.102]:43208 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751704AbWJWHqj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 03:46:39 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6B6517DC031;
	Mon, 23 Oct 2006 00:46:37 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 23 Oct 2006 00:46:37 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.1.g3e3bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29821>

We already generate a Date: header based on when the patch was
emailed.  git-format-patch includes the Date: header of the
patch.  Having two Date: headers is just confusing, so we
just use the current Date:

Often the mailed patches in a patch series are created over a
series of several hours or days, so the Date: header from the
original commit is incorrect for email, and often far off enough
for spam filters to complain.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1c6d2cc..c42dc3b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -514,7 +514,7 @@ foreach my $t (@files) {
 						$2, $_) unless $quiet;
 					push @cc, $2;
 				}
-				elsif (/^[-A-Za-z]+:\s+\S/) {
+				elsif (!/^Date:\s/ && /^[-A-Za-z]+:\s+\S/) {
 					push @xh, $_;
 				}
 
-- 
1.4.3.1.g3e3bc
