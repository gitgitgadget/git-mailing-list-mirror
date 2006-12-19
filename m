X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Enter interactive mode if no parameters are given to git-add
Date: Tue, 19 Dec 2006 15:16:09 +0000
Message-ID: <200612191516.09606.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 15:16:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 52e3af961cb1e0e4
X-UID: 196
X-Length: 1074
Content-Disposition: inline
X-OriginalArrivalTime: 19 Dec 2006 15:18:18.0155 (UTC) FILETIME=[E9607FB0:01C72380]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34831>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwghf-0001RY-Uf for gcvg-git@gmane.org; Tue, 19 Dec
 2006 16:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752420AbWLSPQP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 10:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbWLSPQP
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 10:16:15 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:8633 "EHLO
 369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1752109AbWLSPQO (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 10:16:14 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Tue, 19 Dec 2006 15:18:18 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GwghP-0004Oh-00 for <git@vger.kernel.org>; Tue, 19 Dec
 2006 15:16:11 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

git-add with no parameters previously adds every modified file.  This
patch instead makes git-add enter interactive mode.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
This patch is against pu.

It seemed a bit nasty to add content without explicit instructions to do
so.  Instead, just drop into interactive mode, which they can easily get out
of if it was all a big accident, and additionally is quicker than typing
--interactive.

 builtin-add.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index aa2f0f3..52a63a0 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -96,10 +96,12 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		if (!strcmp("--interactive", argv[i]))
 			add_interactive++;
 	}
+	if (argc == 1)
+		add_interactive++;
 	if (add_interactive) {
 		const char *args[] = { "add--interactive", NULL };
 
-		if (add_interactive != 1 || argc != 2)
+		if (add_interactive != 1 || argc > 2)
 			die("add --interactive does not take any parameters");
 		execv_git_cmd(args);
 		exit(1);
-- 
1.4.4.2.g95ee-dirty
