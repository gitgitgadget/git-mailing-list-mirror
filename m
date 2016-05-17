From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v6 5/9] connect: group CONNECT_DIAG_URL handling code
Date: Tue, 17 May 2016 10:35:50 +0900
Message-ID: <20160517013554.22578-6-mh@glandium.org>
References: <20160517013554.22578-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 03:36:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Tvl-0006uf-EW
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 03:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbcEQBgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 21:36:03 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35480 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932526AbcEQBgB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 21:36:01 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b2TvP-0005t9-0Q; Tue, 17 May 2016 10:35:55 +0900
X-Mailer: git-send-email 2.8.2.411.ga570dec.dirty
In-Reply-To: <20160517013554.22578-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294824>

Previous changes made both branches handling CONNECT_DIAG_URL identical.
We can now remove one of those branches and have CONNECT_DIAG_URL be
handled in one place.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/connect.c b/connect.c
index 4ce83f7..3a77b2f 100644
--- a/connect.c
+++ b/connect.c
@@ -708,7 +708,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &host, &port, &path);
-	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
+	if (flags & CONNECT_DIAG_URL) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
 		printf("Diag: userandhost=%s\n", host ? host : "NULL");
@@ -778,20 +778,6 @@ struct child_process *git_connect(int fd[2], const char *url,
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
2.8.2.411.ga570dec.dirty
