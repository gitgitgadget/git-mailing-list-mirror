From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] Fix start_command closing cmd->out/in regardless of cmd->close_out/in
Date: Mon, 19 Nov 2007 01:36:06 +0800
Message-ID: <1195407366-1610-1-git-send-email-pkufranky@gmail.com>
Cc: Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 18:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ito7t-0007PK-QD
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 18:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbXKRRjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 12:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbXKRRjv
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 12:39:51 -0500
Received: from mail.qikoo.org ([60.28.205.235]:51569 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751137AbXKRRju (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 12:39:50 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C44AA47067; Mon, 19 Nov 2007 01:36:06 +0800 (CST)
X-Mailer: git-send-email 1.5.3.5.1876.g7ba19-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65376>

When 'FILE *fp' is assigned to child_process.out and then start_command or
run_command is run, the standard output of the child process is expected to
be outputed to fp. However, sometimes fp is not expected to be closed since
further IO may be still performmed on fp.
---
 run-command.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 476d00c..4e5f58d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -115,13 +115,9 @@ int start_command(struct child_process *cmd)
 
 	if (need_in)
 		close(fdin[0]);
-	else if (cmd->in)
-		close(cmd->in);
 
 	if (need_out)
 		close(fdout[1]);
-	else if (cmd->out > 1)
-		close(cmd->out);
 
 	if (need_err)
 		close(fderr[1]);
-- 
1.5.3.5.1876.g7ba19-dirty
