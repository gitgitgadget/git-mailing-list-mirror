From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 3/5] restrict the patch filtering
Date: Tue,  6 Mar 2007 16:57:41 -0500
Message-ID: <117321826466-git-send-email-dzickus@redhat.com>
References: <1173218263315-git-send-email-dzickus@redhat.com> <11732182643385-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 22:59:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOhhI-0007Zu-Cj
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 22:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbXCFV7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 16:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbXCFV7O
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 16:59:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49724 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030359AbXCFV7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 16:59:10 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l26Lx9Yi007001
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 16:59:09 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l26Lx8ec013041
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 16:59:09 -0500
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l26Lx7Ti007407;
	Tue, 6 Mar 2007 16:59:08 -0500
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l26LvifA007894;
	Tue, 6 Mar 2007 16:57:44 -0500
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l26LviVF007893;
	Tue, 6 Mar 2007 16:57:44 -0500
X-Mailer: git-send-email 1.5.0.2.212.gd52f-dirty
In-Reply-To: <11732182643385-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41599>

I have come across many emails that use long strings of '-'s as separators
for ideas.  This patch below limits the separator to only 3 '-', with the
intent that long string of '-'s will stay in the commit msg and not in the
patch file.

Signed-off-by: Don Zickus <dzickus@redhat.com>

---
I purposedly separated this patch out because I wasn't sure if anyone would
have objections to it.  I tested it on numerous emails with and with patches
and didn't see any issues.
---
 builtin-mailinfo.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 0532003..0d7c77b 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -666,7 +666,8 @@ static int handle_commit_msg(char *line)
 	}
 
 	if (!memcmp("diff -", line, 6) ||
-	    !memcmp("---", line, 3) ||
+	    !memcmp("---\n", line, 4) ||
+	    !memcmp("--- ", line, 4) ||
 	    !memcmp("Index: ", line, 7)) {
 		fclose(cmitmsg);
 		cmitmsg = NULL;
-- 
1.5.0.2.212.gd52f-dirty
