From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 8/8] Make the rest of commands work from a subdirectory.
Date: Sat, 26 Nov 2005 01:57:21 -0800
Message-ID: <7vek534tq6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 10:58:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfwoA-0002Zh-Ct
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 10:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVKZJ5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 04:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVKZJ5X
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 04:57:23 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8368 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750838AbVKZJ5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 04:57:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126095654.ZQBK3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 04:56:54 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12774>

These commands are converted to run from a subdirectory.

    commit-tree convert-objects merge-base merge-index mktag
    pack-objects pack-redundant prune-packed read-tree tar-tree
    unpack-file unpack-objects update-server-info write-tree

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 commit-tree.c        |    2 ++
 convert-objects.c    |    2 ++
 merge-base.c         |    2 ++
 merge-index.c        |    1 +
 mktag.c              |    2 ++
 pack-objects.c       |    2 ++
 pack-redundant.c     |    2 ++
 prune-packed.c       |    2 ++
 read-tree.c          |    2 ++
 tar-tree.c           |    2 ++
 unpack-file.c        |    2 ++
 unpack-objects.c     |    2 ++
 update-server-info.c |    2 ++
 write-tree.c         |    5 ++++-
 14 files changed, 29 insertions(+), 1 deletions(-)

applies-to: 46e976598ab7b7822d7664fdcc88dc63d2e9cf7a
87a21588fb4f8ed433364716ccb90ef934a99585
diff --git a/commit-tree.c b/commit-tree.c
index b60299f..4634b50 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -91,6 +91,8 @@ int main(int argc, char **argv)
 	if (argc < 2 || get_sha1_hex(argv[1], tree_sha1) < 0)
 		usage(commit_tree_usage);
 
+	setup_git_directory();
+
 	check_valid(tree_sha1, "tree");
 	for (i = 2; i < argc; i += 2) {
 		char *a, *b;
diff --git a/convert-objects.c b/convert-objects.c
index a892013..d78a8b4 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -316,6 +316,8 @@ int main(int argc, char **argv)
 	unsigned char sha1[20];
 	struct entry *entry;
 
+	setup_git_directory();
+
 	if (argc != 2 || get_sha1(argv[1], sha1))
 		usage("git-convert-objects <sha1>");
 
diff --git a/merge-base.c b/merge-base.c
index 751c3c2..e73fca7 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -236,6 +236,8 @@ int main(int argc, char **argv)
 	struct commit *rev1, *rev2;
 	unsigned char rev1key[20], rev2key[20];
 
+	setup_git_directory();
+
 	while (1 < argc && argv[1][0] == '-') {
 		char *arg = argv[1];
 		if (!strcmp(arg, "-a") || !strcmp(arg, "--all"))
diff --git a/merge-index.c b/merge-index.c
index 727527f..024196e 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -102,6 +102,7 @@ int main(int argc, char **argv)
 	if (argc < 3)
 		usage("git-merge-index [-o] [-q] <merge-program> (-a | <filename>*)");
 
+	setup_git_directory();
 	read_cache();
 
 	i = 1;
diff --git a/mktag.c b/mktag.c
index 585677e..97e270a 100644
--- a/mktag.c
+++ b/mktag.c
@@ -111,6 +111,8 @@ int main(int argc, char **argv)
 	if (argc != 1)
 		usage("cat <signaturefile> | git-mktag");
 
+	setup_git_directory();
+
 	// Read the signature
 	size = 0;
 	for (;;) {
diff --git a/pack-objects.c b/pack-objects.c
index 8864a31..a62c9f8 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -473,6 +473,8 @@ int main(int argc, char **argv)
 	struct object_entry **list;
 	int i;
 
+	setup_git_directory();
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/pack-redundant.c b/pack-redundant.c
index 793fa08..0a43278 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -600,6 +600,8 @@ int main(int argc, char **argv)
 	unsigned char *sha1;
 	char buf[42]; /* 40 byte sha1 + \n + \0 */
 
+	setup_git_directory();
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if(!strcmp(arg, "--")) {
diff --git a/prune-packed.c b/prune-packed.c
index 26123f7..d24b097 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -58,6 +58,8 @@ int main(int argc, char **argv)
 {
 	int i;
 
+	setup_git_directory();
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/read-tree.c b/read-tree.c
index df156ea..e3b9c0d 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -629,6 +629,8 @@ int main(int argc, char **argv)
 	unsigned char sha1[20];
 	merge_fn_t fn = NULL;
 
+	setup_git_directory();
+
 	newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (newfd < 0)
 		die("unable to create new cachefile");
diff --git a/tar-tree.c b/tar-tree.c
index 970c4bb..bacb23a 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -407,6 +407,8 @@ int main(int argc, char **argv)
 	void *buffer;
 	unsigned long size;
 
+	setup_git_directory();
+
 	switch (argc) {
 	case 3:
 		basedir = argv[2];
diff --git a/unpack-file.c b/unpack-file.c
index d4ac3a5..07303f8 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -29,6 +29,8 @@ int main(int argc, char **argv)
 	if (argc != 2 || get_sha1(argv[1], sha1))
 		usage("git-unpack-file <sha1>");
 
+	setup_git_directory();
+
 	puts(create_temp_file(sha1));
 	return 0;
 }
diff --git a/unpack-objects.c b/unpack-objects.c
index 8490895..cfd61ae 100644
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -269,6 +269,8 @@ int main(int argc, char **argv)
 	int i;
 	unsigned char sha1[20];
 
+	setup_git_directory();
+
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/update-server-info.c b/update-server-info.c
index e824f62..0b6c383 100644
--- a/update-server-info.c
+++ b/update-server-info.c
@@ -19,5 +19,7 @@ int main(int ac, char **av)
 	if (i != ac)
 		usage(update_server_info_usage);
 
+	setup_git_directory();
+
 	return !!update_server_info(force);
 }
diff --git a/write-tree.c b/write-tree.c
index 2b2c6b7..0aac32f 100644
--- a/write-tree.c
+++ b/write-tree.c
@@ -86,9 +86,12 @@ static int write_tree(struct cache_entry
 int main(int argc, char **argv)
 {
 	int i, funny;
-	int entries = read_cache();
+	int entries;
 	unsigned char sha1[20];
 	
+	setup_git_directory();
+
+	entries = read_cache();
 	if (argc == 2) {
 		if (!strcmp(argv[1], "--missing-ok"))
 			missing_ok = 1;
---
0.99.9.GIT
