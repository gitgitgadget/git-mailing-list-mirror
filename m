From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] builtin-log: respect diff configuration options
Date: Fri, 07 Jul 2006 03:10:45 -0700
Message-ID: <11522670482020-git-send-email-normalperson@yhbt.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net> <11522670473116-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 07 12:11:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FynIW-0002Au-T3
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWGGKKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGGKKw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:10:52 -0400
Received: from hand.yhbt.net ([66.150.188.102]:12472 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932107AbWGGKKu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 06:10:50 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1654B7DC023;
	Fri,  7 Jul 2006 03:10:49 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  7 Jul 2006 03:10:48 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.g3dc65
In-Reply-To: <11522670473116-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23417>

The log commands are all capable of generating diffs, so we
should respect those configuration options for diffs here.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 builtin-log.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 864c6cd..698b71e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -47,6 +47,7 @@ int cmd_whatchanged(int argc, const char
 {
 	struct rev_info rev;
 
+	git_config(git_diff_config);
 	init_revisions(&rev);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
@@ -61,6 +62,7 @@ int cmd_show(int argc, const char **argv
 {
 	struct rev_info rev;
 
+	git_config(git_diff_config);
 	init_revisions(&rev);
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
@@ -77,6 +79,7 @@ int cmd_log(int argc, const char **argv,
 {
 	struct rev_info rev;
 
+	git_config(git_diff_config);
 	init_revisions(&rev);
 	rev.always_show_header = 1;
 	cmd_log_init(argc, argv, envp, &rev);
@@ -102,7 +105,7 @@ static int git_format_config(const char 
 		strcat(extra_headers, value);
 		return 0;
 	}
-	return git_default_config(var, value);
+	return git_diff_config(var, value);
 }
 
 
@@ -234,6 +237,7 @@ int cmd_format_patch(int argc, const cha
 	struct diff_options patch_id_opts;
 	char *add_signoff = NULL;
 
+	git_config(git_format_config);
 	init_revisions(&rev);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
@@ -243,7 +247,6 @@ int cmd_format_patch(int argc, const cha
 	rev.diffopt.msg_sep = "";
 	rev.diffopt.recursive = 1;
 
-	git_config(git_format_config);
 	rev.extra_headers = extra_headers;
 
 	/*
-- 
1.4.1.g3dc65
