From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] blame: simplify algorithm
Date: Wed,  5 Sep 2012 13:56:46 +0200
Message-ID: <df3f74c3b86ba27881a29f52543669ea4bee667e.1346845901.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 13:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9EE4-00071D-F6
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 13:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab2IEL4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 07:56:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59564 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318Ab2IEL4t (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 07:56:49 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7CEEE20798
	for <git@vger.kernel.org>; Wed,  5 Sep 2012 07:56:48 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 05 Sep 2012 07:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=0GlJ0KlfGrasDwoMiFWSQEZz/Lw=; b=qreG1b2UWsDYJqz8QsLC
	V6qLJbyhvtRNwSNFYjmm+N8TRYDGSYsrsdxBVSV2MEeJcjbUDzZ1NkILTUA5OEsm
	mjLFlA9LR3nWXxInXCzei5y5/FMcl74Zy3AszLME7gQRn2dIrB8tYE8ABuG66Hnj
	dMRLMKdlVEXWG9hKDLuwnz0=
X-Sasl-enc: Q3BNNnhGuUfT8f2F/Xj9YG/UEW0KMi8st/ReZRnkLNHM 1346846208
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1B5644825FA;
	Wed,  5 Sep 2012 07:56:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204818>

Recent research (http://tirania.org/blog/archive/2012/Aug-29.html)
resulted in a simplified algorithm for assigning blame in foss projects.
Make "git blame" use that algorithm by default.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I've updated the man page for 'git annotate' but not the one for 'git
blame' nor the tests, so this is RFC for now.

 Documentation/git-annotate.txt | 2 +-
 builtin/blame.c                | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 05fd482..cbeb996 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -16,7 +16,7 @@ Annotates each line in the given file with information from the commit
 which introduced the line. Optionally annotates from a given revision.
 
 The only difference between this command and linkgit:git-blame[1] is that
-they use slightly different output formats, and this command exists only
+they use different output formats, and this command exists only
 for backward compatibility to support existing scripts, and provide a more
 familiar command name for people coming from other SCM systems.
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 0e102bf..28d5829 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2341,6 +2341,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct parse_opt_ctx_t ctx;
 	int cmd_is_annotate = !strcmp(argv[0], "annotate");
 
+	if (!cmd_is_annotate) {
+		puts("Linus");
+		return 0;
+	}
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
-- 
1.7.12.406.gafd3f81
