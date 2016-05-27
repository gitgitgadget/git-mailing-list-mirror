From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v8 8/9] connect: actively reject git:// urls with a user part
Date: Fri, 27 May 2016 11:27:55 +0900
Message-ID: <20160527022756.22904-9-mh@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
Cc: git@vger.kernel.org, tboegi@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 04:28:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67Vl-0005KM-Mw
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbcE0C2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:28:23 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40446 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271AbcE0C2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:28:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b67VE-0005yV-VE; Fri, 27 May 2016 11:27:56 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160527022756.22904-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295714>

Currently, urls of the for git://user@host don't work because user@host
is not resolving at the DNS level, but we shouldn't be relying on it
being an invalid host name, and actively reject it for containing a
username in the first place.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/connect.c b/connect.c
index 0c4d23b..9aea3cd 100644
--- a/connect.c
+++ b/connect.c
@@ -730,6 +730,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		const char *colon = strchr(host, ':');
 		char *override_vhost = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
 
+		if (user)
+			die("user@host is not allowed in git:// urls");
+
 		/* If the host contains a colon (ipv6 address), it needs to
 		 * be enclosed with square brackets. */
 		if (colon)
-- 
2.8.3
