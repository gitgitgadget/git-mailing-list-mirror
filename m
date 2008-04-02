From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] verify-tag: Clean up the temporary file if gpg cannot be
 started.
Date: Wed, 02 Apr 2008 08:49:59 +0200
Message-ID: <47F32C97.6050007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 08:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgwo4-0005Cu-Lu
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 08:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbYDBGuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 02:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYDBGuE
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 02:50:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61268 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbYDBGuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 02:50:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JgwmL-00075h-78; Wed, 02 Apr 2008 08:49:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A7ABCAFCC; Wed,  2 Apr 2008 08:49:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78682>

From: Johannes Sixt <johannes.sixt@telecom.at>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-verify-tag.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index f3ef11f..db81496 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -46,8 +46,10 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	gpg.argv = args_gpg;
 	gpg.in = -1;
 	args_gpg[2] = path;
-	if (start_command(&gpg))
+	if (start_command(&gpg)) {
+		unlink(path);
 		return error("could not run gpg.");
+	}

 	write_in_full(gpg.in, buf, len);
 	close(gpg.in);
-- 
1.5.5.rc2.861.g18c5b.dirty
