From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v6 8/9] connect: actively reject git:// urls with a user part
Date: Tue, 17 May 2016 10:35:53 +0900
Message-ID: <20160517013554.22578-9-mh@glandium.org>
References: <20160517013554.22578-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 03:36:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Tw1-00070z-Jq
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 03:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933002AbcEQBgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 21:36:24 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35494 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932984AbcEQBgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 21:36:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b2TvP-0005tF-5U; Tue, 17 May 2016 10:35:55 +0900
X-Mailer: git-send-email 2.8.2.411.ga570dec.dirty
In-Reply-To: <20160517013554.22578-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294831>

Currently, urls of the for git://user@host don't work because user@host
is not resolving at the DNS level, but we shouldn't be relying on it
being an invalid host name, and actively reject it for containing a
username in the first place.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/connect.c b/connect.c
index dcaf32f..7360d57 100644
--- a/connect.c
+++ b/connect.c
@@ -733,6 +733,9 @@ struct child_process *git_connect(int fd[2], const char *url,
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
2.8.2.411.ga570dec.dirty
