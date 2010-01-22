From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: PATCH 2/5] make "mktag" a built-in
Date: Fri, 22 Jan 2010 08:26:20 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001220825190.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain> <alpine.LFD.2.00.1001220822560.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:27:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMLu-0005G1-FA
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab0AVQ1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321Ab0AVQ1O
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:27:14 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51766 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754662Ab0AVQ1O (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:27:14 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGQKRg016617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 08:26:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGQKFc015176;
	Fri, 22 Jan 2010 08:26:20 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001220822560.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137759>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Jan 2010 07:34:44 -0800

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
Another trivial one.

 Makefile                   |    2 +-
 mktag.c => builtin-mktag.c |    6 +-----
 builtin.h                  |    1 +
 git.c                      |    1 +
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 70ac4b3..c5a1190 100644
--- a/Makefile
+++ b/Makefile
@@ -389,7 +389,6 @@ PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
-PROGRAMS += git-mktag$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-shell$X
 PROGRAMS += git-show-index$X
@@ -670,6 +669,7 @@ BUILTIN_OBJS += builtin-merge-index.o
 BUILTIN_OBJS += builtin-merge-ours.o
 BUILTIN_OBJS += builtin-merge-recursive.o
 BUILTIN_OBJS += builtin-merge-tree.o
+BUILTIN_OBJS += builtin-mktag.o
 BUILTIN_OBJS += builtin-mktree.o
 BUILTIN_OBJS += builtin-mv.o
 BUILTIN_OBJS += builtin-name-rev.o
diff --git a/mktag.c b/builtin-mktag.c
similarity index 98%
rename from mktag.c
rename to builtin-mktag.c
index a3b4270..1cb0f3f 100644
--- a/mktag.c
+++ b/builtin-mktag.c
@@ -153,7 +153,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 #undef PD_FMT
 
-int main(int argc, char **argv)
+int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char result_sha1[20];
@@ -161,10 +161,6 @@ int main(int argc, char **argv)
 	if (argc != 1)
 		usage("git mktag < signaturefile");
 
-	git_extract_argv0_path(argv[0]);
-
-	setup_git_directory();
-
 	if (strbuf_read(&buf, 0, 4096) < 0) {
 		die_errno("could not read from stdin");
 	}
diff --git a/builtin.h b/builtin.h
index e961b33..2aaef74 100644
--- a/builtin.h
+++ b/builtin.h
@@ -73,6 +73,7 @@ extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_mktag(int argc, const char **argv, const char *prefix);
 extern int cmd_mktree(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index eae12e3..0b8f8a7 100644
--- a/git.c
+++ b/git.c
@@ -338,6 +338,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-tree", cmd_merge_tree, RUN_SETUP },
+		{ "mktag", cmd_mktag, RUN_SETUP },
 		{ "mktree", cmd_mktree, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
-- 
1.6.6.1.399.g73128
