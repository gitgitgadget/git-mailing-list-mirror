From: Chris Webb <chris@arachsys.com>
Subject: [PATCH] imap-send: suppress warning about cleartext password with CRAM-MD5
Date: Sat, 27 Mar 2010 15:00:19 +0000
Message-ID: <1269702019-27063-1-git-send-email-chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 27 16:00:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvXV4-00084G-0w
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 16:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471Ab0C0PAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 11:00:24 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:41083 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab0C0PAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 11:00:21 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NvXUp-0004Fl-NB; Sat, 27 Mar 2010 15:00:20 +0000
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143335>

If a CRAM-MD5 challenge-response is used to authenticate to the IMAP server,
git imap-send shouldn't warn about the password being sent in the clear.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 imap-send.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index aeb2985..7107923 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1226,9 +1226,6 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 			fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host);
 			goto bail;
 		}
-		if (!imap->buf.sock.ssl)
-			imap_warn("*** IMAP Warning *** Password is being "
-				  "sent in the clear\n");
 
 		if (srvc->auth_method) {
 			struct imap_cmd_cb cb;
@@ -1253,6 +1250,9 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 				goto bail;
 			}
 		} else {
+			if (!imap->buf.sock.ssl)
+				imap_warn("*** IMAP Warning *** Password is being "
+					  "sent in the clear\n");
 			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
 				fprintf(stderr, "IMAP error: LOGIN failed\n");
 				goto bail;
-- 
1.7.0.1
