From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/5] make "merge-index" a built-in
Date: Fri, 22 Jan 2010 08:25:16 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001220822560.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:26:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYML0-0004qI-9K
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab0AVQ0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525Ab0AVQ0S
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:26:18 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53516 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755020Ab0AVQ0R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:26:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGPHrw016527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 08:25:18 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGPHLD015068;
	Fri, 22 Jan 2010 08:25:17 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137758>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
Totally trivial. Famous last words.

 Makefile                               |    2 +-
 merge-index.c => builtin-merge-index.c |    7 ++-----
 builtin.h                              |    1 +
 git.c                                  |    1 +
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index e1c7ae5..70ac4b3 100644
--- a/Makefile
+++ b/Makefile
@@ -389,7 +389,6 @@ PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
-PROGRAMS += git-merge-index$X
 PROGRAMS += git-mktag$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-shell$X
@@ -667,6 +666,7 @@ BUILTIN_OBJS += builtin-mailsplit.o
 BUILTIN_OBJS += builtin-merge.o
 BUILTIN_OBJS += builtin-merge-base.o
 BUILTIN_OBJS += builtin-merge-file.o
+BUILTIN_OBJS += builtin-merge-index.o
 BUILTIN_OBJS += builtin-merge-ours.o
 BUILTIN_OBJS += builtin-merge-recursive.o
 BUILTIN_OBJS += builtin-merge-tree.o
diff --git a/merge-index.c b/builtin-merge-index.c
similarity index 94%
rename from merge-index.c
rename to builtin-merge-index.c
index 19ddd03..2c4cf5e 100644
--- a/merge-index.c
+++ b/builtin-merge-index.c
@@ -66,7 +66,7 @@ static void merge_all(void)
 	}
 }
 
-int main(int argc, char **argv)
+int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file = 0;
 
@@ -78,9 +78,6 @@ int main(int argc, char **argv)
 	if (argc < 3)
 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
 
-	git_extract_argv0_path(argv[0]);
-
-	setup_git_directory();
 	read_cache();
 
 	i = 1;
@@ -94,7 +91,7 @@ int main(int argc, char **argv)
 	}
 	pgm = argv[i++];
 	for (; i < argc; i++) {
-		char *arg = argv[i];
+		const char *arg = argv[i];
 		if (!force_file && *arg == '-') {
 			if (!strcmp(arg, "--")) {
 				force_file = 1;
diff --git a/builtin.h b/builtin.h
index cb8489f..e961b33 100644
--- a/builtin.h
+++ b/builtin.h
@@ -68,6 +68,7 @@ extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
 extern int cmd_merge(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_index(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index b60999c..eae12e3 100644
--- a/git.c
+++ b/git.c
@@ -331,6 +331,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
+		{ "merge-index", cmd_merge_index, RUN_SETUP },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
-- 
1.6.6.1.399.g73128.dirty
