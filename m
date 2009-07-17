From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t4202-log.sh: Test git log --no-walk sort order
Date: Fri, 17 Jul 2009 16:28:06 +0200
Message-ID: <1247840886-14795-1-git-send-email-git@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0907141612350.4553@intel-tinevez-2-302>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 16:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRoQK-0004vi-R9
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 16:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbZGQO2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 10:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbZGQO2Y
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 10:28:24 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34146 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751019AbZGQO2X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2009 10:28:23 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 59B0F3BC2B9;
	Fri, 17 Jul 2009 10:28:23 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 17 Jul 2009 10:28:23 -0400
X-Sasl-enc: aBONeD3v2GG5jAPZQLFpd75JZL+AI3vF0iwaTm6GF6cb 1247840902
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B33EC4B2A8;
	Fri, 17 Jul 2009 10:28:22 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.3.483.g4f5e
In-Reply-To: <alpine.DEB.1.00.0907141612350.4553@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123464>

'git log --no-walk' sorts commits by commit time whereas 'git show' does
not (it leaves them as given on the command line). Document this by two
tests so that we never forget why ba1d450 (Tentative built-in "git
show", 2006-04-15) introduced it and 8e64006 (Teach revision machinery
about --no-walk, 2007-07-24) exposed it as an option argument.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t4202-log.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

v3: For completeness' sake, use git show -s.

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index aad3894..48e0088 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -149,6 +149,26 @@ test_expect_success 'git log --follow' '
 
 '
 
+cat > expect << EOF
+804a787 sixth
+394ef78 fifth
+5d31159 fourth
+EOF
+test_expect_success 'git log --no-walk <commits> sorts by commit time' '
+	git log --no-walk --oneline 5d31159 804a787 394ef78 > actual &&
+	test_cmp expect actual
+'
+
+cat > expect << EOF
+5d31159 fourth
+804a787 sixth
+394ef78 fifth
+EOF
+test_expect_success 'git show <commits> leaves list of commits as given' '
+	git show --oneline -s 5d31159 804a787 394ef78 > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup case sensitivity tests' '
 	echo case >one &&
 	test_tick &&
-- 
1.6.3.3.483.g4f5e
