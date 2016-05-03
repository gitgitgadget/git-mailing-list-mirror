From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4 03/11] connect: only match the host with core.gitProxy
Date: Tue,  3 May 2016 17:50:44 +0900
Message-ID: <1462265452-32360-4-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 10:51:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axW34-0004la-LC
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbcECIvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 04:51:08 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:51944 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755800AbcECIu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 04:50:58 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1axW2e-0008Qt-BQ; Tue, 03 May 2016 17:50:52 +0900
X-Mailer: git-send-email 2.8.1.16.gaa70619.dirty
In-Reply-To: <1462265452-32360-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293340>

Currently, core.gitProxy doesn't actually match purely on domain names
as documented: it also matches ports.

So a core.gitProxy value like "script for kernel.org" doesn't make the
script called for an url like git://kernel.org:port/path, while it is
called for git://kernel.org/path.

This per-port behavior seems like an oversight rather than a deliberate
choice, so, make git://kernel.org:port/path call the gitProxy script in
the case described above.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index d3448c2..2a08318 100644
--- a/connect.c
+++ b/connect.c
@@ -706,7 +706,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		/* These underlying connection commands die() if they
 		 * cannot connect.
 		 */
-		if (git_use_proxy(hostandport))
+		if (git_use_proxy(host))
 			conn = git_proxy_connect(fd, host, port);
 		else
 			git_tcp_connect(fd, host, port, flags);
-- 
2.8.1.16.gaa70619.dirty
