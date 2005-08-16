From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Add function to read an index file from an arbitrary filename.
Date: Tue, 16 Aug 2005 00:10:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508160009200.23242@iabervon.org>
References: <Pine.LNX.4.63.0508160004460.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 06:07:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4siv-0003cu-7p
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 06:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVHPEGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 00:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVHPEGo
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 00:06:44 -0400
Received: from iabervon.org ([66.92.72.58]:20490 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932599AbVHPEGo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 00:06:44 -0400
Received: (qmail 24324 invoked by uid 1000); 16 Aug 2005 00:10:03 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2005 00:10:03 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508160004460.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Note that the pack file has to be in the usual location if it gets
installed later.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 cache.h     |    2 ++
 sha1_file.c |   10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

59e5c6d163edae5da6136560d48a4750cceacdc6
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -319,6 +319,8 @@ extern int get_ack(int fd, unsigned char
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
+extern struct packed_git *parse_pack_index_file(unsigned char *sha1, 
+						char *idx_path);
 
 extern void prepare_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -476,12 +476,18 @@ struct packed_git *add_packed_git(char *
 
 struct packed_git *parse_pack_index(unsigned char *sha1)
 {
+	char *path = sha1_pack_index_name(sha1);
+	return parse_pack_index_file(sha1, path);
+}
+
+struct packed_git *parse_pack_index_file(unsigned char *sha1, char *idx_path)
+{
 	struct packed_git *p;
 	unsigned long idx_size;
 	void *idx_map;
-	char *path = sha1_pack_index_name(sha1);
+	char *path;
 
-	if (check_packed_git_idx(path, &idx_size, &idx_map))
+	if (check_packed_git_idx(idx_path, &idx_size, &idx_map))
 		return NULL;
 
 	path = sha1_pack_name(sha1);
