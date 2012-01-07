From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 4/5] git-daemon: produce output when ready
Date: Sat,  7 Jan 2012 12:42:46 +0100
Message-ID: <1325936567-3136-5-git-send-email-drizzd@aon.at>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 12:51:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjUnw-0003AC-Ew
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 12:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab2AGLvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jan 2012 06:51:14 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:36571 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751810Ab2AGLvN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2012 06:51:13 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 011CAA7EB4;
	Sat,  7 Jan 2012 12:51:39 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1325936567-3136-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188069>

If a client tries to connect after git-daemon starts, but before it
opens a listening socket, the connection will fail. Output "[PID]
Ready to rumble]" after opening the socket successfully in order to
inform the user that the daemon is now ready to receive
connections.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 daemon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index 15ce918..ab21e66 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1086,6 +1086,8 @@ static int serve(struct string_list *listen_addr, int listen_port,
 
 	drop_privileges(cred);
 
+	loginfo("Ready to rumble");
+
 	return service_loop(&socklist);
 }
 
@@ -1270,10 +1272,8 @@ int main(int argc, char **argv)
 	if (inetd_mode || serve_mode)
 		return execute();
 
-	if (detach) {
+	if (detach)
 		daemonize();
-		loginfo("Ready to rumble");
-	}
 	else
 		sanitize_stdfds();
 
-- 
1.7.8
