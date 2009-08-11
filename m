From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 1/6] Minor unrelated fixes
Date: Tue, 11 Aug 2009 12:10:21 +0200
Message-ID: <1249985426-13726-2-git-send-email-johan@herland.net>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mar96-0008GJ-Ed
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbZHKNLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbZHKNLE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:11:04 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40825 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751665AbZHKNLC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 09:11:02 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO700LDZIY9LEC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:10:57 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7008QYIY6Z330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:10:57 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.11.95426
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125549>

Signed-off-by: Johan Herland <johan@herland.net>
---
 help.c             |    2 +-
 transport-helper.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index 6c46d8b..994561d 100644
--- a/help.c
+++ b/help.c
@@ -302,7 +302,7 @@ const char *help_unknown_cmd(const char *cmd)
 	struct cmdnames main_cmds, other_cmds;
 
 	memset(&main_cmds, 0, sizeof(main_cmds));
-	memset(&other_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
 	memset(&aliases, 0, sizeof(aliases));
 
 	git_config(git_unknown_cmd_config, NULL);
diff --git a/transport-helper.c b/transport-helper.c
index cc99368..a901630 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -8,7 +8,7 @@
 
 struct helper_data
 {
-	const char *name;
+	char *name;
 	struct child_process *helper;
 
 	char *marks_filename;
@@ -258,8 +258,10 @@ int transport_helper_init(struct transport *transport)
 		transport->url = transport->remote->foreign_vcs;
 	} else {
 		char *eom = strchr(transport->url, ':');
-		if (!eom)
+		if (!eom) {
+			free(data);
 			return -1;
+		}
 		data->name = xstrndup(transport->url, eom - transport->url);
 	}
 
-- 
1.6.4.rc3.138.ga6b98.dirty
