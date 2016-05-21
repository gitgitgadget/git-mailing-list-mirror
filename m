From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v7 8/9] connect: actively reject git:// urls with a user part
Date: Sun, 22 May 2016 08:17:31 +0900
Message-ID: <20160521231732.4888-9-mh@glandium.org>
References: <20160521231732.4888-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 01:17:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4G9Z-0005cL-Bk
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 01:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbcEUXRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 19:17:48 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55498 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbcEUXRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 19:17:39 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b4G9F-0001Hv-5r; Sun, 22 May 2016 08:17:33 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160521231732.4888-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295244>

Currently, urls of the for git://user@host don't work because user@host
is not resolving at the DNS level, but we shouldn't be relying on it
being an invalid host name, and actively reject it for containing a
username in the first place.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/connect.c b/connect.c
index 52d34c7..04ce210 100644
--- a/connect.c
+++ b/connect.c
@@ -726,6 +726,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		const char *colon = strchr(host, ':');
 		char *override_vhost = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
 
+		if (user)
+			die("user@host is not allowed in git:// urls");
+
 		/* If the host contains a colon (ipv6 address), it needs to
 		 * be enclosed with square brackets. */
 		if (colon)
-- 
2.8.3.401.ga81c606.dirty
