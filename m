From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] git-send-email: Do not attempt to STARTTLS more than once
Date: Thu,  3 Jul 2008 00:11:31 +0200
Message-ID: <1215036691-28618-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 00:12:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEAYi-0005j5-Lh
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 00:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473AbYGBWLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 18:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756396AbYGBWLT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 18:11:19 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:10592 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755324AbYGBWLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 18:11:18 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 3 Jul 2008 00:11:16 +0200
Received: from localhost.localdomain ([84.75.156.10]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 3 Jul 2008 00:11:16 +0200
X-Mailer: git-send-email 1.5.6.1.278.g3d7f6
X-OriginalArrivalTime: 02 Jul 2008 22:11:16.0585 (UTC) FILETIME=[8C369D90:01C8DC90]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87201>

With the previous TLS patch, send-email would attempt to STARTTLS at
the beginning of every mail, despite reusing the last connection.  We
simply skip further encryption checks after successful TLS initiation.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-send-email.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a047b01..3564419 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -772,6 +772,7 @@ X-Mailer: git-send-email $gitversion
 				if ($smtp->code == 220) {
 					$smtp = Net::SMTP::SSL->start_SSL($smtp)
 						or die "STARTTLS failed! ".$smtp->message;
+					$smtp_encryption = '';
 				} else {
 					die "Server does not support STARTTLS! ".$smtp->message;
 				}
-- 
1.5.6.1.278.g3d7f6
