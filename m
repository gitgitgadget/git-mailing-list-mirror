From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Fix memory leak in git_connect with CONNECT_DIAG_URL
Date: Thu, 28 Apr 2016 18:19:15 +0900
Message-ID: <1461835155-15485-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 11:52:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avicK-0005hT-Ug
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 11:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbcD1JwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 05:52:13 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34340 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085AbcD1JwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 05:52:12 -0400
X-Greylist: delayed 1970 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Apr 2016 05:52:10 EDT
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1avi6N-00042R-FT; Thu, 28 Apr 2016 18:19:15 +0900
X-Mailer: git-send-email 2.8.1.5.g18c8a48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292859>

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/connect.c b/connect.c
index c53f3f1..dccf673 100644
--- a/connect.c
+++ b/connect.c
@@ -755,6 +755,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 				free(hostandport);
 				free(path);
 				free(conn);
+				strbuf_release(&cmd);
 				return NULL;
 			}
 
-- 
2.8.1.5.g18c8a48
