From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] Improve usage messages
Date: Thu, 21 Apr 2005 22:41:52 +1000 (EST)
Message-ID: <20050421124152.A28137F87D@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 14:50:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOb7r-0002HV-9F
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 14:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVDUMyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 08:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVDUMyK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 08:54:10 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:7647 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261345AbVDUMxk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 08:53:40 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DObAx-0004vP-RC
	for git@vger.kernel.org; Thu, 21 Apr 2005 14:53:05 +0200
Received: (nullmailer pid 1126 invoked by uid 501);
	Thu, 21 Apr 2005 12:52:59 -0000
Received: from [150.203.247.5] (helo=smurf.noris.de)
	by server.smurf.noris.de with esmtp (Exim 4.50)
	id 1DOb6J-0004ly-1J
	for smurf@smurf.noris.de; Thu, 21 Apr 2005 14:48:23 +0200
Received: by smurf.noris.de (Postfix, from userid 501)
	id A28137F87D; Thu, 21 Apr 2005 22:41:52 +1000 (EST)
To: git@vger.kernel.org
X-Smurf-Spam-Score: -1.2 (-)
X-Smurf-Spam-Score: -1.5 (-)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds somewhat-improved usage messages to some of Linus' programs.
Specifically, they now handle -? / --help.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

Index: check-files.c
===================================================================
--- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/check-files.c  (mode:100644 sha1:7d16691aa9d51b5b4670d5837b3527ee7c7da79c)
+++ 265515f9c4f089b1b61e9d2312c4b3babe189618/check-files.c  (mode:100644 sha1:be904b13659a60eab31787b010a64f2274048a9f)
@@ -40,6 +40,8 @@
 {
 	int i;
 
+	if(argc == 2 && (!strcmp(argv[1],"-?") || !strcmp(argv[1],"--help")))
+		usage("check-files filename...");
 	read_cache();
 	for (i = 1; i < argc ; i++)
 		check_file(argv[i]);
Index: diff-tree.c
===================================================================
--- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/diff-tree.c  (mode:100644 sha1:b0122e42631410fa579115f025efc3cab777cde6)
+++ 265515f9c4f089b1b61e9d2312c4b3babe189618/diff-tree.c  (mode:100644 sha1:03fcc2fae2f0b06f3834f0b6e0d8762e70f49f51)
@@ -193,6 +193,11 @@
 	}
 }
 
+static const char diff_tree_usage[] = 
+	"diff-tree [ -r (recurse) | -z (\\0-terminate) ]"
+		"\n\t<tree sha1> <tree sha1>";
+
+
 int main(int argc, char **argv)
 {
 	unsigned char old[20], new[20];
@@ -209,11 +214,11 @@
 			line_termination = '\0';
 			continue;
 		}
-		usage("diff-tree [-r] [-z] <tree sha1> <tree sha1>");
+		usage(diff_tree_usage);
 	}
 
 	if (argc != 3 || get_sha1_hex(argv[1], old) || get_sha1_hex(argv[2], new))
-		usage("diff-tree [-r] [-z] <tree sha1> <tree sha1>");
+		usage(diff_tree_usage);
 	commit_to_tree(old);
 	commit_to_tree(new);
 	return diff_tree_sha1(old, new, "");
--- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/init-db.c  (mode:100644 sha1:dad06351ca35d0d2f68cd9e719c49805386f96fa)
+++ 265515f9c4f089b1b61e9d2312c4b3babe189618/init-db.c  (mode:100644 sha1:4afd436e719b347cdf6b4420c9d926e453f1f95b)
@@ -26,6 +26,9 @@
 	char *sha1_dir, *path;
 	int len, i;
 
+	if(argc != 1)
+		usage("init-db");
+
 	safe_create_dir(".git");
 
 	sha1_dir = getenv(DB_ENVIRONMENT);
--- 42a073eb6b5bb397a3e8768a032463a7fa02e6b9/write-tree.c  (mode:100644 sha1:827809dbddbff6dd8cf842641f6db5ad2f3ae07a)
+++ 265515f9c4f089b1b61e9d2312c4b3babe189618/write-tree.c  (mode:100644 sha1:55fe1c75c3065c8d5bef34f4f2e7af7aa147ea9d)
@@ -101,9 +101,13 @@
 int main(int argc, char **argv)
 {
 	int i, unmerged;
-	int entries = read_cache();
+	int entries;
 	unsigned char sha1[20];
 
+	if(argc != 1)
+		usage("write-tree");
+
+	entries = read_cache();
 	if (entries <= 0)
 		die("write-tree: no cache contents to write");
 
