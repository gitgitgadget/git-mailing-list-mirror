From: drafnel@gmail.com
Subject: [PATCH 2/5] Make mktag a builtin.
Date: Thu,  8 May 2008 21:19:46 -0500
Message-ID: <7689656.1210299528037.JavaMail.teamon@b301.teamon.com>
References: <1210299589-10448-1-git-send-email-drafnel@example.com>
 <1210299589-10448-2-git-send-email-drafnel@example.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:34:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuIRB-00059u-AV
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 04:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998AbYEICdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 22:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbYEICdV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 22:33:21 -0400
Received: from mailproxy01.teamon.com ([64.85.68.137]:18864 "EHLO
	b301.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755435AbYEICdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 22:33:19 -0400
X-Greylist: delayed 866 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 22:33:07 EDT
Received: from b301.teamon.com (localhost [127.0.0.1])
	by b301.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m492ImG10433;
	Fri, 9 May 2008 02:18:48 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <1210299589-10448-2-git-send-email-drafnel@example.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81590>

From: Brandon Casey <drafnel@gmail.com>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile  |    3 ++-
 builtin.h |    1 +
 git.c     |    1 +
 mktag.c   |    4 +---
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 9d84c8d..1128cef 100644
--- a/Makefile
+++ b/Makefile
@@ -282,7 +282,6 @@ PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
 PROGRAMS += git-merge-index$X
 PROGRAMS += git-merge-tree$X
-PROGRAMS += git-mktag$X
 PROGRAMS += git-mktree$X
 PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-patch-id$X
@@ -306,6 +305,7 @@ BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-get-tar-commit-id$X
 BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
+BUILT_INS += git-mktag$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
 BUILT_INS += git-show$X
@@ -423,6 +423,7 @@ LIB_OBJS += log-tree.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
+LIB_OBJS += mktag.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-revindex.o
diff --git a/builtin.h b/builtin.h
index 95126fd..a8d3a11 100644
--- a/builtin.h
+++ b/builtin.h
@@ -58,6 +58,7 @@ extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+extern int cmd_mktag(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 89b431f..81aa31c 100644
--- a/git.c
+++ b/git.c
@@ -325,6 +325,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
+		{ "mktag", cmd_mktag, RUN_SETUP },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
diff --git a/mktag.c b/mktag.c
index 5489ad6..352747b 100644
--- a/mktag.c
+++ b/mktag.c
@@ -156,7 +156,7 @@ static int verify_tag(const char *buffer, size_t size)
 
 #undef PD_FMT
 
-int main(int argc, char **argv)
+int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf;
 	unsigned char result_sha1[20];
@@ -164,8 +164,6 @@ int main(int argc, char **argv)
 	if (argc != 1)
 		usage("git-mktag < signaturefile");
 
-	setup_git_directory();
-
 	strbuf_init(&buf, 0);
 	if (strbuf_read(&buf, 0, 4096) < 0) {
 		die("could not read from stdin");
-- 
1.5.5.67.g9a49
