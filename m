From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] packed objects: minor cleanup
Date: Wed, 15 Feb 2006 17:45:01 -0800
Message-ID: <7v64ngm602.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
	<7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 02:45:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9YCj-0004ph-9j
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 02:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWBPBpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 20:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWBPBpE
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 20:45:04 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:23284 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751360AbWBPBpD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 20:45:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216014352.PLNZ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 20:43:52 -0500
To: git@vger.kernel.org
In-Reply-To: <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 15 Feb 2006 17:43:25 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16259>

The delta depth is unsigned.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * And this is the clean-up patch that comes before the "packed
   representation reuse" patch.

 cache.h      |    2 +-
 pack-check.c |    4 ++--
 sha1_file.c  |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

f8f135c9bae74f846a92e1f1f1fea8308802ace5
diff --git a/cache.h b/cache.h
index c255421..b5db01f 100644
--- a/cache.h
+++ b/cache.h
@@ -322,7 +322,7 @@ extern int num_packed_objects(const stru
 extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
 extern int find_pack_entry_one(const unsigned char *, struct pack_entry *, struct packed_git *);
 extern void *unpack_entry_gently(struct pack_entry *, char *, unsigned long *);
-extern void packed_object_info_detail(struct pack_entry *, char *, unsigned long *, unsigned long *, int *, unsigned char *);
+extern void packed_object_info_detail(struct pack_entry *, char *, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/pack-check.c b/pack-check.c
index 67a7ecd..eca32b6 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -84,7 +84,7 @@ static void show_pack_info(struct packed
 		char type[20];
 		unsigned long size;
 		unsigned long store_size;
-		int delta_chain_length;
+		unsigned int delta_chain_length;
 
 		if (nth_packed_object_sha1(p, i, sha1))
 			die("internal error pack-check nth-packed-object");
@@ -98,7 +98,7 @@ static void show_pack_info(struct packed
 		if (!delta_chain_length)
 			printf("%-6s %lu %u\n", type, size, e.offset);
 		else
-			printf("%-6s %lu %u %d %s\n", type, size, e.offset,
+			printf("%-6s %lu %u %u %s\n", type, size, e.offset,
 			       delta_chain_length, sha1_to_hex(base_sha1));
 	}
 
diff --git a/sha1_file.c b/sha1_file.c
index 3d11a9b..64cf245 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -830,7 +830,7 @@ void packed_object_info_detail(struct pa
 			       char *type,
 			       unsigned long *size,
 			       unsigned long *store_size,
-			       int *delta_chain_length,
+			       unsigned int *delta_chain_length,
 			       unsigned char *base_sha1)
 {
 	struct packed_git *p = e->p;
@@ -844,7 +844,7 @@ void packed_object_info_detail(struct pa
 	if (kind != OBJ_DELTA)
 		*delta_chain_length = 0;
 	else {
-		int chain_length = 0;
+		unsigned int chain_length = 0;
 		memcpy(base_sha1, pack, 20);
 		do {
 			struct pack_entry base_ent;
-- 
1.2.0.gcfba7
