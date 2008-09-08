From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH] t6023-merge-file: Work around non-portable sed usage
Date: Mon,  8 Sep 2008 20:29:18 +0200
Message-ID: <1220898558-73783-1-git-send-email-arjen@yaph.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:37:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KclcG-0003Sw-5I
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 20:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbYIHSg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbYIHSg1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 14:36:27 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:4402 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbYIHSg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 14:36:26 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Sep 2008 14:36:25 EDT
Received: from localhost.localdomain (aragorndsl.demon.nl [82.161.19.32])
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id m88ITIpQ074827;
	Mon, 8 Sep 2008 20:29:18 +0200 (CEST)
	(envelope-from arjen@yaph.org)
X-Mailer: git-send-email 1.6.0.1.402.ga75a
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95287>

OS X sed doesn't understand '\n' on the right side of a substitution.
Use a valid substitution character instead and use 'tr' to convert
those to a newline.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
This patch prevents the "diff3 -m" feature in next (commit
e0af48e49682ea) from breaking the tests which are added in that
commit.

 t/t6023-merge-file.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 42620e0..5e18d68 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -150,8 +150,8 @@ test_expect_success 'MERGE_ZEALOUS simplifies non-conflicts' '
 
 '
 
-sed -e 's/deerit./&\n\n\n\n/' -e "s/locavit,/locavit;/" < new6.txt > new8.txt
-sed -e 's/deerit./&\n\n\n\n/' -e "s/locavit,/locavit --/" < new7.txt > new9.txt
+sed -e 's/deerit./&%%%%/' -e "s/locavit,/locavit;/"< new6.txt | tr '%' '\012' > new8.txt
+sed -e 's/deerit./&%%%%/' -e "s/locavit,/locavit --/" < new7.txt | tr '%' '\012' > new9.txt
 
 test_expect_success 'ZEALOUS_ALNUM' '
 
-- 
1.6.0.1.402.ga75a
