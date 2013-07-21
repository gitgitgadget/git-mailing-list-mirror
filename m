From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 1/2] rev-parse: remove restrictions on some options
Date: Sun, 21 Jul 2013 13:49:26 +0100
Message-ID: <f1f8ff52a8b8dc70803bba0eb8fb7f9f82ddfd5b.1374410829.git.john@keeping.me.uk>
References: <7v4nbquw3l.fsf@alter.siamese.dyndns.org>
 <cover.1374410829.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 14:50:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0t5M-0003ei-Ss
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 14:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab3GUMty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 08:49:54 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:51663 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945Ab3GUMtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 08:49:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 373E6606508;
	Sun, 21 Jul 2013 13:49:53 +0100 (BST)
X-Quarantine-ID: <Y-vMz-qYIQsM>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y-vMz-qYIQsM; Sun, 21 Jul 2013 13:49:52 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 7F9D6606502;
	Sun, 21 Jul 2013 13:49:52 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3CD52161E2E9;
	Sun, 21 Jul 2013 13:49:52 +0100 (BST)
X-Quarantine-ID: <MUUBTxeAVRtz>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUUBTxeAVRtz; Sun, 21 Jul 2013 13:49:51 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C73D7161E359;
	Sun, 21 Jul 2013 13:49:38 +0100 (BST)
X-Mailer: git-send-email 1.8.3.3.972.gc83849e.dirty
In-Reply-To: <cover.1374410829.git.john@keeping.me.uk>
In-Reply-To: <cover.1374410829.git.john@keeping.me.uk>
References: <cover.1374410829.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230929>

The "--local-env-vars" and "--resolve-git-dir" arguments to
git-rev-parse are currently only handled if they appear first on the
command line (in the case of "--local-env-vars", only if it is the only
argument).  While it may not make sense to use these options when any
others are specified, there is no reason for this restriction and it
might confuse users if these arguments appear to be ignored.

There is no need for any documentation change here as the restrictions
on these options are not documented.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/rev-parse.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index de894c7..c9aa28f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -486,21 +486,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	if (argc > 1 && !strcmp("--sq-quote", argv[1]))
 		return cmd_sq_quote(argc - 2, argv + 2);
 
-	if (argc == 2 && !strcmp("--local-env-vars", argv[1])) {
-		int i;
-		for (i = 0; local_repo_env[i]; i++)
-			printf("%s\n", local_repo_env[i]);
-		return 0;
-	}
-
-	if (argc > 2 && !strcmp(argv[1], "--resolve-git-dir")) {
-		const char *gitdir = resolve_gitdir(argv[2]);
-		if (!gitdir)
-			die("not a gitdir '%s'", argv[2]);
-		puts(gitdir);
-		return 0;
-	}
-
 	if (argc > 1 && !strcmp("-h", argv[1]))
 		usage(builtin_rev_parse_usage);
 
@@ -661,6 +646,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_remote_ref(show_reference, NULL);
 				continue;
 			}
+			if (!strcmp(arg, "--local-env-vars")) {
+				int i;
+				for (i = 0; local_repo_env[i]; i++)
+					printf("%s\n", local_repo_env[i]);
+				continue;
+			}
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree = get_git_work_tree();
 				if (work_tree)
@@ -711,6 +702,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				printf("%s%s.git\n", cwd, len && cwd[len-1] != '/' ? "/" : "");
 				continue;
 			}
+			if (!strcmp(arg, "--resolve-git-dir")) {
+				const char *gitdir = resolve_gitdir(argv[i+1]);
+				if (!gitdir)
+					die("not a gitdir '%s'", argv[i+1]);
+				puts(gitdir);
+				continue;
+			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
 				printf("%s\n", is_inside_git_dir() ? "true"
 						: "false");
-- 
1.8.3.3.972.gc83849e.dirty
