Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B7120323
	for <e@80x24.org>; Sat, 18 Mar 2017 11:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdCRLH4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 07:07:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35333 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdCRLHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 07:07:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so13248667pge.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vP2EZDO+gJxuT/IzDyX8SJjiYb1E1vk2ILfR4NqMbaA=;
        b=jPQadCenGo4EEquPmAOYm37JoKTCiA1ktP0/GLdCmQZm4ENOzFmrr8aUNLCKbueVa6
         EkaohavSAKngv1N6toP3ePRvsWz1AN2mpZmP3hkOimxv2+csD5WKtg+PK6Q7sNTYtuaJ
         ECzSFje6LcmT+yjeh/1MWNZpS/UuC2ZHwGXSG9iIe5woSCYYPxbvH+6zwpRh7bUgJXrM
         Nt/mc7cvgr32dbbMav2neZUCnGwrOWvxmkot+xDD7ocVML/6Tuxw2lMLHeFtdGF2viOZ
         ePneJy5aawbxukj1ILUizngJ4vnP2jL2Z4vDBCoQpzaXBBqoLYjuDJETY6LI5nfkaH+6
         W0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vP2EZDO+gJxuT/IzDyX8SJjiYb1E1vk2ILfR4NqMbaA=;
        b=fHq2d7cNcColS81+zLD41CkTHpbW4Htuj2ECe6/ojuoTzSe3C32mpS62MLFVaBORMy
         uxGFS9p4EAEiDce4aIH5wNjcmfX+mjnaCV9FoLefHhcK0dLOfOjiVi0bAtzWP+byVSTQ
         Fv6ES+Vn+dfJcO+Gmo4ME1uXPsrmqqhThtLIlD5kWg2NchCukYYSABgdW1a9Jv2nIjGe
         AVHrkUnG/4+rfM7NN5o6NfCcxUDdKaD8NX4wEiteNEUfU6/NRpOS3yx4iK2GKzukNrbL
         IipaD94LTdl/3L2fmiCErg8oSzpzIvToWwi5U8qTOAoIpQOaO7TMuajw5dioesU0YSLR
         pzLg==
X-Gm-Message-State: AFeK/H3JMIPz2v3S9UnA/7JfGCgqpyyv1WRfkqzvGecFnw3dsev9I2s3JEMeLVyfDbG9Kg==
X-Received: by 10.99.36.71 with SMTP id k68mr21267013pgk.68.1489831355092;
        Sat, 18 Mar 2017 03:02:35 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id s65sm21839856pgb.64.2017.03.18.03.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:02:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:02:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 3/4] worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
Date:   Sat, 18 Mar 2017 17:02:05 +0700
Message-Id: <20170318100206.5980-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318100206.5980-1-pclouds@gmail.com>
References: <20170216120302.5302-1-pclouds@gmail.com>
 <20170318100206.5980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The manual parsing code is replaced with a call to refs_resolve_ref_unsafe().
The manual parsing code must die because only refs/files-backend.c
should do that.
---
 branch.c                               |   3 +-
 t/helper/test-ref-store.c              |  19 ++++++
 t/t1407-worktree-ref-store.sh (new +x) |  40 +++++++++++++
 worktree.c                             | 102 +++++++++------------------------
 worktree.h                             |   2 +-
 5 files changed, 89 insertions(+), 77 deletions(-)
 create mode 100755 t/t1407-worktree-ref-store.sh

diff --git a/branch.c b/branch.c
index 5c12036b02..0b949b7fb2 100644
--- a/branch.c
+++ b/branch.c
@@ -355,7 +355,8 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref,
 	for (i = 0; worktrees[i]; i++) {
 		if (worktrees[i]->is_detached)
 			continue;
-		if (strcmp(oldref, worktrees[i]->head_ref))
+		if (worktrees[i]->head_ref &&
+		    strcmp(oldref, worktrees[i]->head_ref))
 			continue;
 
 		if (set_worktree_head_symref(get_worktree_git_dir(worktrees[i]),
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 57849ee59a..3c926ed85e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "refs.h"
+#include "worktree.h"
 
 static const char *notnull(const char *arg, const char *name)
 {
@@ -32,6 +33,23 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 		strbuf_release(&sb);
 
 		*refs = get_submodule_ref_store(gitdir);
+	} else if (skip_prefix(argv[0], "worktree:", &gitdir)) {
+		struct worktree **p, **worktrees = get_worktrees(0);
+
+		for (p = worktrees; *p; p++) {
+			struct worktree *wt = *p;
+
+			if (!wt->id) {
+				/* special case for main worktree */
+				if (!strcmp(gitdir, "main"))
+					break;
+			} else if (!strcmp(gitdir, wt->id))
+				break;
+		}
+		if (!*p)
+			die("no such worktree: %s", gitdir);
+
+		*refs = get_worktree_ref_store(*p);
 	} else
 		die("unknown backend %s", argv[0]);
 
@@ -261,6 +279,7 @@ int cmd_main(int argc, const char **argv)
 	const char *func;
 	struct command *cmd;
 
+	setup_git_directory();
 	argv = get_store(argv + 1, &refs);
 
 	func = *argv++;
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
new file mode 100755
index 0000000000..04d1e9d177
--- /dev/null
+++ b/t/t1407-worktree-ref-store.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='test worktree ref store api'
+
+. ./test-lib.sh
+
+RWT="test-ref-store worktree:wt"
+RMAIN="test-ref-store worktree:main"
+
+test_expect_success 'setup' '
+	test_commit first &&
+	git worktree add -b wt-master wt &&
+	(
+		cd wt &&
+		test_commit second
+	)
+'
+
+test_expect_success 'resolve_ref(<shared-ref>)' '
+	SHA1=`git rev-parse master` &&
+	echo "$SHA1 refs/heads/master 0x0" >expected &&
+	$RWT resolve-ref refs/heads/master 0 >actual &&
+	test_cmp expected actual &&
+	$RMAIN resolve-ref refs/heads/master 0 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'resolve_ref(<per-worktree-ref>)' '
+	SHA1=`git -C wt rev-parse HEAD` &&
+	echo "$SHA1 refs/heads/wt-master 0x1" >expected &&
+	$RWT resolve-ref HEAD 0 >actual &&
+	test_cmp expected actual &&
+
+	SHA1=`git rev-parse HEAD` &&
+	echo "$SHA1 refs/heads/master 0x1" >expected &&
+	$RMAIN resolve-ref HEAD 0 >actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/worktree.c b/worktree.c
index fa7bc67a50..c1ec334b06 100644
--- a/worktree.c
+++ b/worktree.c
@@ -19,54 +19,25 @@ void free_worktrees(struct worktree **worktrees)
 	free (worktrees);
 }
 
-/*
- * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
- * set is_detached to 1 (0) if the ref is detached (is not detached).
- *
- * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so
- * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
- * git_path). Parse the ref ourselves.
- *
- * return -1 if the ref is not a proper ref, 0 otherwise (success)
- */
-static int parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
-{
-	if (is_detached)
-		*is_detached = 0;
-	if (!strbuf_readlink(ref, path_to_ref, 0)) {
-		/* HEAD is symbolic link */
-		if (!starts_with(ref->buf, "refs/") ||
-				check_refname_format(ref->buf, 0))
-			return -1;
-	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
-		/* textual symref or detached */
-		if (!starts_with(ref->buf, "ref:")) {
-			if (is_detached)
-				*is_detached = 1;
-		} else {
-			strbuf_remove(ref, 0, strlen("ref:"));
-			strbuf_trim(ref);
-			if (check_refname_format(ref->buf, 0))
-				return -1;
-		}
-	} else
-		return -1;
-	return 0;
-}
-
 /**
- * Add the head_sha1 and head_ref (if not detached) to the given worktree
+ * Update head_sha1, head_ref and is_detached of the given worktree
  */
-static void add_head_info(struct strbuf *head_ref, struct worktree *worktree)
+static void add_head_info(struct worktree *wt)
 {
-	if (head_ref->len) {
-		if (worktree->is_detached) {
-			get_sha1_hex(head_ref->buf, worktree->head_sha1);
-		} else {
-			resolve_ref_unsafe(head_ref->buf, 0, worktree->head_sha1, NULL);
-			worktree->head_ref = strbuf_detach(head_ref, NULL);
-		}
-	}
+	int flags;
+	const char *target;
+
+	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
+					 "HEAD",
+					 RESOLVE_REF_READING,
+					 wt->head_sha1, &flags);
+	if (!target)
+		return;
+
+	if (flags & REF_ISSYMREF)
+		wt->head_ref = xstrdup(target);
+	else
+		wt->is_detached = 1;
 }
 
 /**
@@ -77,9 +48,7 @@ static struct worktree *get_main_worktree(void)
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
-	struct strbuf head_ref = STRBUF_INIT;
 	int is_bare = 0;
-	int is_detached = 0;
 
 	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
 	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
@@ -91,13 +60,10 @@ static struct worktree *get_main_worktree(void)
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->is_bare = is_bare;
-	worktree->is_detached = is_detached;
-	if (!parse_ref(path.buf, &head_ref, &is_detached))
-		add_head_info(&head_ref, worktree);
+	add_head_info(worktree);
 
 	strbuf_release(&path);
 	strbuf_release(&worktree_path);
-	strbuf_release(&head_ref);
 	return worktree;
 }
 
@@ -106,8 +72,6 @@ static struct worktree *get_linked_worktree(const char *id)
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
-	struct strbuf head_ref = STRBUF_INIT;
-	int is_detached = 0;
 
 	if (!id)
 		die("Missing linked worktree name");
@@ -127,19 +91,14 @@ static struct worktree *get_linked_worktree(const char *id)
 	strbuf_reset(&path);
 	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
 
-	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
-		goto done;
-
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->id = xstrdup(id);
-	worktree->is_detached = is_detached;
-	add_head_info(&head_ref, worktree);
+	add_head_info(worktree);
 
 done:
 	strbuf_release(&path);
 	strbuf_release(&worktree_path);
-	strbuf_release(&head_ref);
 	return worktree;
 }
 
@@ -334,8 +293,6 @@ const struct worktree *find_shared_symref(const char *symref,
 					  const char *target)
 {
 	const struct worktree *existing = NULL;
-	struct strbuf path = STRBUF_INIT;
-	struct strbuf sb = STRBUF_INIT;
 	static struct worktree **worktrees;
 	int i = 0;
 
@@ -345,6 +302,11 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
+		const char *symref_target;
+		unsigned char sha1[20];
+		struct ref_store *refs;
+		int flags;
+
 		if (wt->is_bare)
 			continue;
 
@@ -359,25 +321,15 @@ const struct worktree *find_shared_symref(const char *symref,
 			}
 		}
 
-		strbuf_reset(&path);
-		strbuf_reset(&sb);
-		strbuf_addf(&path, "%s/%s",
-			    get_worktree_git_dir(wt),
-			    symref);
-
-		if (parse_ref(path.buf, &sb, NULL)) {
-			continue;
-		}
-
-		if (!strcmp(sb.buf, target)) {
+		refs = get_worktree_ref_store(wt);
+		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
+							sha1, &flags);
+		if ((flags & REF_ISSYMREF) && !strcmp(symref_target, target)) {
 			existing = wt;
 			break;
 		}
 	}
 
-	strbuf_release(&path);
-	strbuf_release(&sb);
-
 	return existing;
 }
 
diff --git a/worktree.h b/worktree.h
index 6bfb985203..5ea5e503fb 100644
--- a/worktree.h
+++ b/worktree.h
@@ -4,7 +4,7 @@
 struct worktree {
 	char *path;
 	char *id;
-	char *head_ref;
+	char *head_ref;		/* NULL if HEAD is broken or detached */
 	char *lock_reason;	/* internal use */
 	unsigned char head_sha1[20];
 	int is_detached;
-- 
2.11.0.157.gd943d85

