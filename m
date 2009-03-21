From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH] Invoke "git gc --auto" when a commit is successful.
Date: Sat, 21 Mar 2009 15:34:54 -0700
Message-ID: <1237674894-8151-1-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 23:36:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9nn-0004r4-1b
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbZCUWe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbZCUWe5
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:34:57 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:37910 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbZCUWe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:34:56 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id B084C38341;
	Sat, 21 Mar 2009 15:34:54 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 8060E38E755B;
	Sat, 21 Mar 2009 15:34:54 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 4D8BD17A4B; Sat, 21 Mar 2009 15:34:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114089>

This functionality was added to the previous git-commit.sh script in d4bb43e,
but omitted when the script was ported to C in f5bbc32. This patch reinstates
the functionality by copying the equivalent code that was introduced in
builtin-merge.c in 1c7b76b.

Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 builtin-commit.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 46e649c..780c142 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1029,5 +1029,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (!quiet)
 		print_summary(prefix, commit_sha1);
 
+	/*
+	 * Perform an automatic garbage collection if the commit was successful.
+	 * We ignore errors in 'gc --auto', since the user should see them.
+	 */
+	const char *argv_gc_auto[] = { "gc", "--auto", NULL };
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+
 	return 0;
 }
-- 
1.6.2.1
