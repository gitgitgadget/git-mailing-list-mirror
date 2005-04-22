From: Morten Welinder <mwelinder@gmail.com>
Subject: [PATCH] Constify
Date: Fri, 22 Apr 2005 14:08:02 -0400
Message-ID: <118833cc050422110872a6f4a5@mail.gmail.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Apr 22 20:05:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP2Va-0002Mu-2B
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 20:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVDVSIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 14:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVDVSIc
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 14:08:32 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:7387 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262101AbVDVSID convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 14:08:03 -0400
Received: by rproxy.gmail.com with SMTP id a41so582207rng
        for <git@vger.kernel.org>; Fri, 22 Apr 2005 11:08:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RI3BSOFRiWc+hYt1p2Ww7vMF+ybRLNwqn0nub0aYnoLYFcFFLUJJAxwyX10TCTv96s5yoEQrjgpiwTQ5JT/UDbZNMkZq3ZW4XiuPP+Un3QHngtnMn97btW6pQw0iW0Q6dlEB+9Ad9zYeq69zMLjQRt/86o46Rey/THu8fgIFYlw=
Received: by 10.38.10.66 with SMTP id 66mr3876653rnj;
        Fri, 22 Apr 2005 11:08:02 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Fri, 22 Apr 2005 11:08:02 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

This patch makes strings type "const char *" and keeps people honest.
[Here's to hoping that nothing in this email setup mangles whitespace...]

Signed-off-by: Morten Welinder (mwelinder@gmail.com)


Index: Makefile
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/Makefile  (mode:100644
sha1:2d7e4cf0464c45b7c5b169bff7e5c4e7768c13a1)
+++ uncommitted/Makefile  (mode:100664)
@@ -12,7 +12,7 @@
 # BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
 # break unless your underlying filesystem supports those sub-second times
 # (my ext3 doesn't).
-CFLAGS=-g -O2 -Wall
+CFLAGS=-g -O2 -Wall -Wwrite-strings
 
 # Should be changed to /usr/local
 prefix=$(HOME)
Index: commit-tree.c
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/commit-tree.c 
(mode:100644 sha1:c0b07f89286c3f6cceae8122b4c3142c8efaf8e1)
+++ uncommitted/commit-tree.c  (mode:100664)
@@ -62,7 +62,7 @@
 	return i;
 }
 
-static void finish_buffer(char *tag, char **bufp, unsigned int *sizep)
+static void finish_buffer(const char *tag, char **bufp, unsigned int *sizep)
 {
 	int taglen;
 	int offset;
@@ -273,7 +273,7 @@
  */
 #define MAXPARENT (16)
 
-static char *commit_tree_usage = "commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char *commit_tree_usage = "commit-tree <sha1> [-p
<sha1>]* < changelog";
 
 int main(int argc, char **argv)
 {
Index: diff-cache.c
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/diff-cache.c 
(mode:100644 sha1:5e1d1a6e6d83291964dca82e6969e576f6a839ec)
+++ uncommitted/diff-cache.c  (mode:100664)
@@ -215,7 +215,7 @@
 	return 0;
 }
 
-static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] <tree sha1>";
+static const char *diff_cache_usage = "diff-cache [-r] [-z]
[--cached] <tree sha1>";
 
 int main(int argc, char **argv)
 {
Index: diff-tree.c
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/diff-tree.c  (mode:100644
sha1:0f370927dd2496a420af53d137676b6c3c445f75)
+++ uncommitted/diff-tree.c  (mode:100664)
@@ -178,7 +178,7 @@
 	return retval;
 }
 
-static char *diff_tree_usage = "diff-tree [-r] [-z] <tree sha1> <tree sha1>";
+static const char *diff_tree_usage = "diff-tree [-r] [-z] <tree sha1>
<tree sha1>";
 
 int main(int argc, char **argv)
 {
Index: fsck-cache.c
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/fsck-cache.c 
(mode:100644 sha1:96b8eb161107cd3219975d93a44874a5455b702e)
+++ uncommitted/fsck-cache.c  (mode:100664)
@@ -134,7 +134,7 @@
 int main(int argc, char **argv)
 {
 	int i, heads;
-	char *sha1_dir;
+	const char *sha1_dir;
 
 	sha1_dir = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
 	for (i = 0; i < 256; i++) {
Index: init-db.c
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/init-db.c  (mode:100644
sha1:dad06351ca35d0d2f68cd9e719c49805386f96fa)
+++ uncommitted/init-db.c  (mode:100664)
@@ -5,7 +5,7 @@
  */
 #include "cache.h"
 
-void safe_create_dir(char *dir)
+void safe_create_dir(const char *dir)
 {
 	if (mkdir(dir, 0755) < 0) {
 		if (errno != EEXIST) {
@@ -23,7 +23,8 @@
  */
 int main(int argc, char **argv)
 {
-	char *sha1_dir, *path;
+	const char *sha1_dir;
+	char *path;
 	int len, i;
 
 	safe_create_dir(".git");
Index: read-tree.c
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/read-tree.c  (mode:100644
sha1:7c938491ad358582c610edac4a36a03868f8631d)
+++ uncommitted/read-tree.c  (mode:100664)
@@ -221,7 +221,7 @@
 	}
 }
 
-static char *read_tree_usage = "read-tree (<sha> | -m <sha1> [<sha2> <sha3>])";
+static const char *read_tree_usage = "read-tree (<sha> | -m <sha1>
[<sha2> <sha3>])";
 
 int main(int argc, char **argv)
 {
Index: sha1_file.c
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/sha1_file.c  (mode:100644
sha1:f356acc9e6ce705fdfb947a5f36bba66fd9cd797)
+++ uncommitted/sha1_file.c  (mode:100664)
@@ -61,7 +61,7 @@
 	static char *name, *base;
 
 	if (!base) {
-		char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? :
DEFAULT_DB_ENVIRONMENT;
+		const char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? :
DEFAULT_DB_ENVIRONMENT;
 		int len = strlen(sha1_file_directory);
 		base = malloc(len + 60);
 		memcpy(base, sha1_file_directory, len);
Index: show-diff.c
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/show-diff.c  (mode:100644
sha1:da364e26e28823f951a6be1b686a458575f28ea1)
+++ uncommitted/show-diff.c  (mode:100664)
@@ -5,10 +5,10 @@
  */
 #include "cache.h"
 
-static char *diff_cmd = "diff -L 'a/%s' -L 'b/%s' ";
-static char *diff_opts = "-p -u";
-static char *diff_arg_forward  = " - '%s'";
-static char *diff_arg_reverse  = " '%s' -";
+static const char *diff_cmd = "diff -L 'a/%s' -L 'b/%s' ";
+static const char *diff_opts = "-p -u";
+static const char *diff_arg_forward  = " - '%s'";
+static const char *diff_arg_reverse  = " '%s' -";
 
 static void prepare_diff_cmd(void)
 {
@@ -35,15 +35,16 @@
  *  a b      ==> a b       ==> 'a b'
  *  a'b      ==> a'\''b    ==> 'a'\''b'
  */
-static char *sq_expand(char *src)
+static char *sq_expand(const char *src)
 {
 	static char *buf = NULL;
 	int cnt, c;
 	char *cp;
+	const char *sp;
 
 	/* count bytes needed to store the quoted string. */ 
-	for (cnt = 1, cp = src; *cp; cnt++, cp++)
-		if (*cp == '\'')
+	for (cnt = 1, sp = src; *sp; cnt++, sp++)
+		if (*sp == '\'')
 			cnt += 3;
 
 	if (! (buf = malloc(cnt)))
@@ -61,13 +62,13 @@
 	return buf;
 }
 
-static void show_differences(char *name, char *label, void *old_contents,
+static void show_differences(const char *name, char *label, void *old_contents,
 			     unsigned long long old_size, int reverse)
 {
 	FILE *f;
 	char *name_sq = sq_expand(name);
 	char *label_sq = (name != label) ? sq_expand(label) : name_sq;
-	char *diff_arg = reverse ? diff_arg_reverse : diff_arg_forward;
+	const char *diff_arg = reverse ? diff_arg_reverse : diff_arg_forward;
 	int cmd_size = strlen(name_sq) + strlen(label_sq) * 2 +
 		strlen(diff_cmd) + strlen(diff_opts) + strlen(diff_arg);
 	char *cmd = malloc(cmd_size);
Index: update-cache.c
===================================================================
--- 9f6f9ee7ad29cafe4265eae5050ce712b00bfce0/update-cache.c 
(mode:100644 sha1:9ad4ae278703ee621b723afc65f3a51038e30f52)
+++ uncommitted/update-cache.c  (mode:100664)
@@ -25,9 +25,11 @@
 	void *in;
 	SHA_CTX c;
 
-	in = "";
 	if (size)
 		in = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+	else
+		in = (void *)"";
+
 	close(fd);
 	if (!out || (int)(long)in == -1)
 		return -1;
