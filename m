From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] builtin-help: silently tolerate unknown keys
Date: Thu, 23 Apr 2009 15:49:06 +0200
Message-ID: <1240494546-25775-2-git-send-email-j6t@kdbg.org>
References: <1240494546-25775-1-git-send-email-j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 16:24:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwzq8-0002oS-Av
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 16:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbZDWOWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 10:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbZDWOWO
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 10:22:14 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13916 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbZDWOWN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 10:22:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1LwzJ7-0005se-4e; Thu, 23 Apr 2009 15:49:41 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 03C074E9; Thu, 23 Apr 2009 15:49:41 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id E70A4FA43; Thu, 23 Apr 2009 15:49:40 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc1.88.g1bf9
In-Reply-To: <1240494546-25775-1-git-send-email-j6t@kdbg.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117341>

If for some reason the config file contains a key without a subkey like

    [man]
        foo = bar

then even a plain

    git help

produces an error message. With this patch such an entry is ignored.

Additionally, the warning about unknown sub-keys is removed. It could
become annoying if new sub-keys are introduced in the future, and then
the configuration is read by an old version of git that does not know
about it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-help.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index 9b57a74..e7fbe9a 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -236,7 +236,7 @@ static int add_man_viewer_info(const char *var, const char *value)
 	const char *subkey = strrchr(name, '.');
 
 	if (!subkey)
-		return error("Config with no key for man viewer: %s", name);
+		return 0;
 
 	if (!strcmp(subkey, ".path")) {
 		if (!value)
@@ -249,7 +249,6 @@ static int add_man_viewer_info(const char *var, const char *value)
 		return add_man_viewer_cmd(name, subkey - name, value);
 	}
 
-	warning("'%s': unsupported man viewer sub key.", subkey);
 	return 0;
 }
 
-- 
1.6.3.rc1.88.g1bf9
