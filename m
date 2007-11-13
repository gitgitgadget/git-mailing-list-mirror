From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 07/11] builtin run_command: do not exit with -1.
Date: Tue, 13 Nov 2007 21:05:02 +0100
Message-ID: <1194984306-3181-8-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21F-0001Be-DJ
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761420AbXKMUFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761486AbXKMUFb
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:31 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49203 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762485AbXKMUFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:11 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 07DB010ACF8;
	Tue, 13 Nov 2007 21:05:08 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64855>

There are shells that do not correctly detect an exit code of -1 as a
failure. We simply truncate the status code to the lower 8 bits.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 4a250f7..37d99d6 100644
--- a/git.c
+++ b/git.c
@@ -256,7 +256,7 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 
 	status = p->fn(argc, argv, prefix);
 	if (status)
-		return status;
+		return status & 0xff;
 
 	/* Somebody closed stdout? */
 	if (fstat(fileno(stdout), &st))
-- 
1.5.3.5.1592.g0d6db
