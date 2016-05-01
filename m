From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 5/6] connect: don't xstrdup target_host
Date: Sun,  1 May 2016 15:02:52 +0900
Message-ID: <1462082573-17992-6-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 08:03:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awkTM-0007yr-8T
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 08:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbcEAGDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 02:03:00 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33622 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbcEAGC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 02:02:59 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1awkT0-0004h8-2S; Sun, 01 May 2016 15:02:54 +0900
X-Mailer: git-send-email 2.8.1.16.g58dac65.dirty
In-Reply-To: <1462082573-17992-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293140>

Now that hostandport is left unmodified in git_connect (we don't pass
it to get_host_and_port() anymore), we can avoid xstrdup'ing it.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index b3fce84..e2b976e 100644
--- a/connect.c
+++ b/connect.c
@@ -683,9 +683,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 */
 		char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
 		if (target_host)
-			target_host = xstrdup(target_host);
+			target_host = target_host;
 		else
-			target_host = xstrdup(hostandport);
+			target_host = hostandport;
 
 		transport_check_allowed("git");
 
@@ -707,7 +707,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 			     "%s %s%chost=%s%c",
 			     prog, path, 0,
 			     target_host, 0);
-		free(target_host);
 	} else {
 		conn = xmalloc(sizeof(*conn));
 		child_process_init(conn);
-- 
2.8.1.16.g58dac65.dirty
