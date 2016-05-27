From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v8 5/9] connect: group CONNECT_DIAG_URL handling code
Date: Fri, 27 May 2016 11:27:52 +0900
Message-ID: <20160527022756.22904-6-mh@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
Cc: git@vger.kernel.org, tboegi@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 04:28:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67VS-0005BS-95
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbcE0C2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:28:06 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40428 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932275AbcE0C2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:28:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b67VE-0005yP-QC; Fri, 27 May 2016 11:27:56 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160527022756.22904-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295709>

Previous changes made both branches handling CONNECT_DIAG_URL identical.
We can now remove one of those branches and have CONNECT_DIAG_URL be
handled in one place.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/connect.c b/connect.c
index de7419e..4be06f4 100644
--- a/connect.c
+++ b/connect.c
@@ -701,7 +701,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &host, &port, &path);
-	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
+	if (flags & CONNECT_DIAG_URL) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
 		printf("Diag: userandhost=%s\n", host ? host : "NULL");
@@ -773,20 +773,6 @@ struct child_process *git_connect(int fd[2], const char *url,
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
2.8.3
