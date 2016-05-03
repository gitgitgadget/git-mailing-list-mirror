From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4 10/11] connect: actively reject git:// urls with a user part
Date: Tue,  3 May 2016 17:50:51 +0900
Message-ID: <1462265452-32360-11-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 10:52:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axW3p-00057r-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbcECIv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 04:51:56 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:51928 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669AbcECIvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 04:51:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1axW2e-0008R7-Me; Tue, 03 May 2016 17:50:52 +0900
X-Mailer: git-send-email 2.8.1.16.gaa70619.dirty
In-Reply-To: <1462265452-32360-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293343>

Currently, urls of the for git://user@host don't work because user@host
is not resolving at the DNS level, but we shouldn't be relying on it
being an invalid host name, and actively reject it for containing a
username in the first place.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/connect.c b/connect.c
index 0cec822..215d6d9 100644
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
2.8.1.16.gaa70619.dirty
