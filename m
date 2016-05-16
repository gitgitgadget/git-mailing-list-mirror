From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v5 8/9] connect: actively reject git:// urls with a user part
Date: Mon, 16 May 2016 09:07:39 +0900
Message-ID: <20160516000740.19042-9-mh@glandium.org>
References: <20160516000740.19042-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 02:08:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2650-0002IT-2P
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbcEPAHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 20:07:55 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34882 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbcEPAHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 20:07:47 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b264S-0004yE-Uk; Mon, 16 May 2016 09:07:40 +0900
X-Mailer: git-send-email 2.8.2.411.ga331486
In-Reply-To: <20160516000740.19042-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294703>

Currently, urls of the for git://user@host don't work because user@host
is not resolving at the DNS level, but we shouldn't be relying on it
being an invalid host name, and actively reject it for containing a
username in the first place.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/connect.c b/connect.c
index df15ff3..fdd40b0 100644
--- a/connect.c
+++ b/connect.c
@@ -716,6 +716,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 		 */
 		struct strbuf target_host = STRBUF_INIT;
 		char *override_vhost = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
+		if (user)
+			die("user@host is not allowed in git:// urls");
+
 		if (override_vhost)
 			strbuf_addstr(&target_host, override_vhost);
 		else {
-- 
2.8.2.411.ga331486
