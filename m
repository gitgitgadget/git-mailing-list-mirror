From: Christian Thaeter <ct@pipapo.org>
Subject: [PATCH 4/5] Export some more functions to enable resetting the git state
Date: Mon,  7 Jan 2008 06:47:34 +0100
Message-ID: <1199684855-14246-4-git-send-email-ct@pipapo.org>
References: <1199684855-14246-1-git-send-email-ct@pipapo.org>
 <1199684855-14246-2-git-send-email-ct@pipapo.org>
 <1199684855-14246-3-git-send-email-ct@pipapo.org>
Cc: gitster@pobox.com, Christian Thaeter <ct@pipapo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 06:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBkqK-0006Yg-Jx
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 06:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbYAGFrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 00:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbYAGFrq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 00:47:46 -0500
Received: from pipapo.org ([217.140.77.75]:1101 "EHLO mail.pipapo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200AbYAGFrm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 00:47:42 -0500
Received: from localhost (mercur.pipapo.org [10.20.70.10])
	by mail.pipapo.org (Postfix) with SMTP id 47E7434F5C017;
	Mon,  7 Jan 2008 06:47:40 +0100 (CET)
Received: by localhost (sSMTP sendmail emulation); Mon, 07 Jan 2008 06:47:39 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <1199684855-14246-3-git-send-email-ct@pipapo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69764>

This declares the functions added by the former 2 commits as 'extern'.

Further invalidate_cached_refs() got renamed to
git_invalidate_cached_refs() and is exported too.

Signed-off-by: Christian Thaeter <ct@pipapo.org>
---
 cache.h |    3 +++
 refs.c  |    6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 39331c2..4352d08 100644
--- a/cache.h
+++ b/cache.h
@@ -224,7 +224,9 @@ extern char *get_refs_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern void reset_git_work_tree(void);
 extern const char *get_git_work_tree(void);
+extern void git_invalidate_cached_refs(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
@@ -553,6 +555,7 @@ extern struct packed_git *parse_pack_index_file(const unsigned char *sha1,
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
+extern void reset_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
 
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
diff --git a/refs.c b/refs.c
index 58f6d17..900cc5d 100644
--- a/refs.c
+++ b/refs.c
@@ -167,7 +167,7 @@ static void free_ref_list(struct ref_list *list)
 	}
 }
 
-static void invalidate_cached_refs(void)
+void git_invalidate_cached_refs(void)
 {
 	struct cached_refs *ca = &cached_refs;
 
@@ -898,7 +898,7 @@ int delete_ref(const char *refname, const unsigned char *sha1)
 	if (err && errno != ENOENT)
 		fprintf(stderr, "warning: unlink(%s) failed: %s",
 			git_path("logs/%s", lock->ref_name), strerror(errno));
-	invalidate_cached_refs();
+	git_invalidate_cached_refs();
 	unlock_ref(lock);
 	return ret;
 }
@@ -1137,7 +1137,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	invalidate_cached_refs();
+	git_invalidate_cached_refs();
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-- 
1.5.3.7
