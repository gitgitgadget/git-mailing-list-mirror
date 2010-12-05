From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sat,  4 Dec 2010 23:59:08 -0200
Message-ID: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 05 03:01:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PP3uY-0000To-JA
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 03:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024Ab0LEB7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 20:59:16 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45505 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931Ab0LEB7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 20:59:16 -0500
Received: by yxt3 with SMTP id 3so4927656yxt.19
        for <git@vger.kernel.org>; Sat, 04 Dec 2010 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=GIOwodUQB9L6Gl2ZCURGFwDdoco+/56Ab50Q7m8YyuU=;
        b=aS/qVa8kE3KaSXftKEB0qp0KVDiQ9hXzUaqf5IBvtPYO3YV7MijZa1mmS6gEXCV8Zd
         5+hBsAvM0qISAvchKpZm8XUNo8yJbB/Iw9AGgw7aG57lfBI4VEGLVayhwjNVrAjsdcJj
         Eyx0KbBH5YXH/Bk/XnA54Yol9LVNdBQI4x6WU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=iscoJrQrljCiBQoPhkvzv1JPysby/tWYIzbh5hPrDm4dWvGD+Az/W+ljcE7S8wzG02
         QhPSt27ksfQVebNrpdeOC0LUpf8nQTXP1P4C/hE6gSt0WNb9gi34TT34C3KhUmr8+S2r
         mG+IOHn/WBEOqyHx+BpMipijf40BPxJu6+VqA=
Received: by 10.151.146.12 with SMTP id y12mr6645429ybn.118.1291514355531;
        Sat, 04 Dec 2010 17:59:15 -0800 (PST)
Received: from localhost ([186.205.6.151])
        by mx.google.com with ESMTPS id p1sm2325711ybn.5.2010.12.04.17.59.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Dec 2010 17:59:14 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.343.g7d43d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162925>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/commit.c     |    2 +-
 builtin/merge-base.c |    2 +-
 builtin/merge.c      |    2 +-
 commit.c             |    2 +-
 commit.h             |    2 +-
 revision.c           |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4fd1a16..11a0412 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1321,7 +1321,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 				allow_fast_forward = 0;
 		}
 		if (allow_fast_forward)
-			parents = reduce_heads(parents);
+			parents = commit_list_reduce_reads(parents);
 	} else {
 		if (!reflog_msg)
 			reflog_msg = "commit";
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 96dd160..9a8b445 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -54,7 +54,7 @@ static int handle_octopus(int count, const char **args, int reduce, int show_all
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	result = reduce ? reduce_heads(revs) : get_octopus_merge_bases(revs);
+	result = reduce ? commit_list_reduce_reads(revs) : get_octopus_merge_bases(revs);
 
 	if (!result)
 		return 1;
diff --git a/builtin/merge.c b/builtin/merge.c
index c24a7be..de21499 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -821,7 +821,7 @@ static int finish_automerge(struct commit_list *common,
 	if (allow_fast_forward) {
 		parents = remoteheads;
 		commit_list_insert(lookup_commit(head), &parents);
-		parents = reduce_heads(parents);
+		parents = commit_list_reduce_reads(parents);
 	} else {
 		struct commit_list **pptr = &parents;
 
diff --git a/commit.c b/commit.c
index 2d9265d..50bd85b 100644
--- a/commit.c
+++ b/commit.c
@@ -759,7 +759,7 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	return ret;
 }
 
-struct commit_list *reduce_heads(struct commit_list *heads)
+struct commit_list *commit_list_reduce_reads(struct commit_list *heads)
 {
 	struct commit_list *p;
 	struct commit_list *result = NULL, **tail = &result;
diff --git a/commit.h b/commit.h
index 9113bbe..648cadc 100644
--- a/commit.h
+++ b/commit.h
@@ -165,7 +165,7 @@ static inline int single_parent(struct commit *commit)
 	return commit->parents && !commit->parents->next;
 }
 
-struct commit_list *reduce_heads(struct commit_list *heads);
+struct commit_list *commit_list_reduce_reads(struct commit_list *heads);
 
 extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
diff --git a/revision.c b/revision.c
index b1c1890..a000d5d 100644
--- a/revision.c
+++ b/revision.c
@@ -1795,7 +1795,7 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	 * Further reduce the parents by removing redundant parents.
 	 */
 	if (1 < cnt) {
-		struct commit_list *h = reduce_heads(commit->parents);
+		struct commit_list *h = commit_list_reduce_reads(commit->parents);
 		cnt = commit_list_count(h);
 		free_commit_list(commit->parents);
 		commit->parents = h;
-- 
1.7.3.2.343.g7d43d
