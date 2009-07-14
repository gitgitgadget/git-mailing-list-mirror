From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] t4202-log.sh: Test git log --no-walk sort order
Date: Tue, 14 Jul 2009 14:45:19 +0200
Message-ID: <1247575519-9629-1-git-send-email-git@drmicha.warpmail.net>
References: <4A5C785C.6060706@viscovery.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 14:46:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQhOS-00077d-3Z
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 14:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbZGNMpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 08:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbZGNMpg
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 08:45:36 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59786 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752523AbZGNMpg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 08:45:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id CE0743B0F44;
	Tue, 14 Jul 2009 08:45:35 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 14 Jul 2009 08:45:35 -0400
X-Sasl-enc: S7z2UROmMLsyfcVThnz31TCE0xsdkdBIFJs3d6LzRUlp 1247575535
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3F966713F;
	Tue, 14 Jul 2009 08:45:35 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.3.483.g4f5e
In-Reply-To: <4A5C785C.6060706@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123243>

'git log --no-walk' sorts commits by commit time whereas 'git show' does
not (it leaves them as given on the command line). Document this by two
tests so that we never forget why ba1d450 (Tentative built-in "git
show", 2006-04-15) introduced it and 8e64006 (Teach revision machinery
about --no-walk, 2007-07-24) exposed it as an option argument.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
v2: Make it clearer (in the commmit message and the test description) that git
show leaves the commits as specified.

Nit-picked-by: Johannes Sixt <j.sixt@viscovery.net>
...but he was right!

 t/t4202-log.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index aad3894..72ba42c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -149,6 +149,29 @@ test_expect_success 'git log --follow' '
 
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
+ein
+804a787 sixth
+a/two
+394ef78 fifth
+a/two
+EOF
+test_expect_success 'git show <commits> leaves list of commits as given' '
+	git show --oneline --name-only 5d31159 804a787 394ef78 > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup case sensitivity tests' '
 	echo case >one &&
 	test_tick &&
-- 
1.6.3.3.483.g4f5e
