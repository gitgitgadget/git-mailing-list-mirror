From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v5 5/9] connect: group CONNECT_DIAG_URL handling code
Date: Mon, 16 May 2016 09:07:36 +0900
Message-ID: <20160516000740.19042-6-mh@glandium.org>
References: <20160516000740.19042-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:08:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b264m-00026o-AN
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbcEPAH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 20:07:57 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34866 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbcEPAHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 20:07:47 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b264S-0004y8-Py; Mon, 16 May 2016 09:07:40 +0900
X-Mailer: git-send-email 2.8.2.411.ga331486
In-Reply-To: <20160516000740.19042-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294706>

Previous changes made both branches handling CONNECT_DIAG_URL identical.
We can now remove one of those branches and have CONNECT_DIAG_URL be
handled in one place.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/connect.c b/connect.c
index 3428149..8813f90 100644
--- a/connect.c
+++ b/connect.c
@@ -691,7 +691,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &host, &port, &path);
-	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
+	if (flags & CONNECT_DIAG_URL) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
 		printf("Diag: userandhost=%s\n", host ? host : "NULL");
@@ -761,20 +761,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 			int putty = 0, tortoiseplink = 0;
 			transport_check_allowed("ssh");
 
-			if (flags & CONNECT_DIAG_URL) {
-				printf("Diag: url=%s\n", url ? url : "NULL");
-				printf("Diag: protocol=%s\n", prot_name(protocol));
-				printf("Diag: userandhost=%s\n", host ? host : "NULL");
-				printf("Diag: port=%s\n", port ? port : "NONE");
-				printf("Diag: path=%s\n", path ? path : "NULL");
-
-				free(host);
-				free(port);
-				free(path);
-				free(conn);
-				return NULL;
-			}
-
 			ssh = getenv("GIT_SSH_COMMAND");
 			if (!ssh) {
 				const char *base;
-- 
2.8.2.411.ga331486
