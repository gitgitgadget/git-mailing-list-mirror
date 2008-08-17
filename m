From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 6/7] Modify setup_path() to only add git_exec_path() to PATH
Date: Sun, 17 Aug 2008 14:44:42 +0200
Message-ID: <1218977083-14526-7-git-send-email-prohaska@zib.de>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de>
 <1218977083-14526-2-git-send-email-prohaska@zib.de>
 <1218977083-14526-3-git-send-email-prohaska@zib.de>
 <1218977083-14526-4-git-send-email-prohaska@zib.de>
 <1218977083-14526-5-git-send-email-prohaska@zib.de>
 <1218977083-14526-6-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 14:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUhfq-0002AZ-T9
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 14:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbYHQMpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 08:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755448AbYHQMpx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 08:45:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:52330 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152AbYHQMpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 08:45:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m7HCjZYG022275;
	Sun, 17 Aug 2008 14:45:40 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m7HCihbT002872;
	Sun, 17 Aug 2008 14:44:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1218977083-14526-6-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92609>

Searching git programs only in the highest-priority location is
sufficient.  If the user explicitly overrides the default location
(by --exec-path or GIT_EXEC_PATH), we can safely expect that the
required programs are there.

This change allows testing of executables built with RUNTIME_PREFIX.
Calling system_path(GIT_EXEC_PATH) is avoided if a higher-priority
location is provided, which is the case for the tests.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 exec_cmd.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index d84e9e9..63efe23 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -114,9 +114,7 @@ void setup_path(void)
 
 	strbuf_init(&new_path, 0);
 
-	add_path(&new_path, argv_exec_path);
-	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
-	add_path(&new_path, system_path(GIT_EXEC_PATH));
+	add_path(&new_path, git_exec_path());
 	add_path(&new_path, argv0_path);
 
 	if (old_path)
-- 
1.6.0.rc3.22.g053fd
