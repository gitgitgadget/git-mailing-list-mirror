From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 1/3] send-email: pass Debug to Net::SMTP::SSL::new
Date: Sun,  1 Dec 2013 23:48:41 +0100
Message-ID: <3bb0c80c70e1c40236034552bec037cb0c26167c.1385938050.git.tr@thomasrast.ch>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 01 23:49:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnFp4-0004Wn-IH
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 23:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab3LAWtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 17:49:01 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:39510 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab3LAWsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 17:48:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 2211F4D6595;
	Sun,  1 Dec 2013 23:48:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WQ8gOuLLhjhh; Sun,  1 Dec 2013 23:48:45 +0100 (CET)
Received: from linux.local (unknown [89.204.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A66EB4D64C4;
	Sun,  1 Dec 2013 23:48:44 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc3.5.g2a1fe2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238600>

We forgot to pass the Debug option through to Net::SMTP::SSL->new --
which is the same as Net::SMTP->new.  This meant that with security
set to SSL, we would never enable debug output.

Pass through the flag.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 git-send-email.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3782c3b..f7468b6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1217,6 +1217,7 @@ sub send_message {
 			$smtp ||= Net::SMTP::SSL->new($smtp_server,
 						      Hello => $smtp_domain,
 						      Port => $smtp_server_port,
+						      Debug => $debug_net_smtp,
 						      ssl_verify_params());
 		}
 		else {
-- 
1.8.5.rc3.5.g2a1fe2f
