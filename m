From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] builtin-reflog: Allow reflog expire to name partial ref
Date: Sun, 10 Aug 2008 22:22:21 +0200
Message-ID: <1218399741-37049-1-git-send-email-pdebie@ai.rug.nl>
References: <9746FE5D-816C-4818-B32F-EE0028918F72@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 22:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSHRp-0007Hi-0S
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 22:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbYHJUWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 16:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbYHJUWZ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 16:22:25 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:64815 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416AbYHJUWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 16:22:25 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6208.online.nl (SMTP Server) with ESMTP id 7AC711C00087;
	Sun, 10 Aug 2008 22:22:23 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6208.online.nl (SMTP Server) with ESMTP id 5D98C1C00086;
	Sun, 10 Aug 2008 22:22:22 +0200 (CEST)
X-ME-UUID: 20080810202222383.5D98C1C00086@mwinf6208.online.nl
X-Mailer: git-send-email 1.6.0.rc1.288.g5b89f
In-Reply-To: <9746FE5D-816C-4818-B32F-EE0028918F72@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91883>

This allows you to specify 'git reflog expire master' without needing
to give the full refname like 'git reflog expire refs/heads/master'

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 builtin-reflog.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 5af3f28..f4d1f32 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -540,11 +540,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free(collected.e);
 	}
 
-	while (i < argc) {
-		const char *ref = argv[i++];
+	for (; i < argc; i++) {
+		char *ref;
 		unsigned char sha1[20];
-		if (!resolve_ref(ref, sha1, 1, NULL)) {
-			status |= error("%s points nowhere!", ref);
+		if (!dwim_log(argv[i], strlen(argv[i]), sha1, &ref)) {
+			status |= error("%s points nowhere!", argv[i]);
 			continue;
 		}
 		set_reflog_expiry_param(&cb, explicit_expiry, ref);
-- 
1.6.0.rc0.320.g49281
