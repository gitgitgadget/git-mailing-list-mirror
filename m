From: mikukkon@miku.homelinux.net (Mika Kukkonen)
Subject: [PATCH] git: fix gcc4 warnings
Date: Sun, 3 Jul 2005 23:32:33 +0300
Message-ID: <20050703203233.GA19220@miku.homelinux.net>
Reply-To: mikukkon@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 22:33:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpB8x-00013v-Lf
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 22:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVGCUcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 16:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVGCUcn
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 16:32:43 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:5349 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S261492AbVGCUcj
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 16:32:39 -0400
Received: from localhost (mta1-o.i.luukku.com [10.0.1.112])
	by mta1-o.i.luukku.com (Postfix) with ESMTP id 9388215029B;
	Sun,  3 Jul 2005 23:32:38 +0300 (EEST)
Received: from srv1-elite-lanp (7781.dsl.mtv3.fi [82.203.129.119])
	by tarjoilu.luukku.com (Postfix) with ESMTP id 6FED2150013;
	Sun,  3 Jul 2005 23:32:38 +0300 (EEST)
Received: by srv1-elite-lanp (Postfix, from userid 1000)
	id 27FBCC2F7; Sun,  3 Jul 2005 23:32:34 +0300 (EEST)
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is a few trivial fixes to git about things that gcc4 complains about.

Signed-off-by: Mika Kukkonen <mikukkon@iki.fi>

diffstat:
 git/send-pack.c |    2 +-
 git/sha1_file.c |    4 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: git/send-pack.c
===================================================================
--- git.orig/send-pack.c
+++ git/send-pack.c
@@ -93,7 +93,7 @@ static void rev_list(int fd, struct ref 
 	exec_rev_list(refs);
 }
 
-static int pack_objects(int fd, struct ref *refs)
+static void pack_objects(int fd, struct ref *refs)
 {
 	pid_t rev_list_pid;
 
Index: git/sha1_file.c
===================================================================
--- git.orig/sha1_file.c
+++ git/sha1_file.c
@@ -384,8 +384,8 @@ struct packed_git *add_packed_git(char *
 {
 	struct stat st;
 	struct packed_git *p;
-	unsigned long idx_size;
-	void *idx_map;
+	unsigned long idx_size = 0;
+	void *idx_map = NULL;

 	if (check_packed_git_idx(path, &idx_size, &idx_map))
 		return NULL;
@@ -857,7 +857,7 @@ static void *unpack_non_delta_entry(unsi
 {
 	int st;
 	z_stream stream;
-	char *buffer;
+	unsigned char *buffer;
 
 	buffer = xmalloc(size + 1);
 	buffer[size] = 0;
@@ -949,7 +949,7 @@ int nth_packed_object_sha1(const struct 
 int find_pack_entry_one(const unsigned char *sha1,
 			struct pack_entry *e, struct packed_git *p)
 {
-	int *level1_ofs = p->index_base;
+	unsigned int *level1_ofs = p->index_base;
 	int hi = ntohl(level1_ofs[*sha1]);
 	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
 	void *index = p->index_base + 256;
