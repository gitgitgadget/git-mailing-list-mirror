Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70DB51FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 12:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbdBHMff (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 07:35:35 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36459 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbdBHMfd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 07:35:33 -0500
Received: by mail-pf0-f195.google.com with SMTP id 19so11611445pfo.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 04:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=byNWeM+MiboWPPug1LTTyXZOQbpugCCfBNXk/cvdQRI=;
        b=fUlDC/hIcKtEpdbngdJfrUk7SJLrIpOnRJ7tRL8Uv67SyNGiLjyQyDYXsyS+Z/765q
         nrFwaNjaBMy3AJiK7tXv4lHCRIBOb5nhkSgAVmv2BqbVEO27QfZNgPMbLQDBrS5VuCeY
         idoxW5d+HoAJy3seE/ZNkX1U+lp45U6uruyq7yGpO/2n/64UTrvdGHQ+B9jtkNJRYdPA
         QV0eyxMoLyi+YyeqsN/96kBl8TwxVVFiPCPcDIByu8hhjqDgatxBihIxlfv0boHwMBn1
         COG6xHtGTCUAeevw5ynXTmquZXeWxEu8ZbGdUINdX/v8DAyMjy0LCY1QiNH+ZVasqZI1
         zFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=byNWeM+MiboWPPug1LTTyXZOQbpugCCfBNXk/cvdQRI=;
        b=m9M3YrLrWrGQ75LhTveIxG5bv+/H7CZwJ6ZVOFjJrC/DF7qV+WSFMyQIRBuRZErNUc
         dj8nw5VBPFifHRLTstAm55aAOlynoo7l977YQggs+Lx+La9ODg2cBAUHwAZhvxp4MLGU
         DDsqKMiVsbs586hPoqzREdiBcMr0JKV+QCyjbYAD0V9HOaEPGILnjRq8DPGbPwSxZzXD
         j3qKWKy1pYvZAcbMyykbwucjJjDQAOEsg0z6SZz2X0NE8iZs0rEZPmjq9tDc1cuvmjs5
         YWwuyGLdgE0TYhliX51SNWlel0iqhaIbrbkN1zU6MGnHIe49lW0O9inLTtXKRf9fWL5X
         0pnQ==
X-Gm-Message-State: AIkVDXIawb3S9gtyKzXwtWLDIZMGjJTMU1Psxd4L/xifSLVhwkkpxAYlDYM7bX0SrvVM6w==
X-Received: by 10.99.126.27 with SMTP id z27mr26331520pgc.177.1486553519763;
        Wed, 08 Feb 2017 03:31:59 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id z77sm19562272pfk.47.2017.02.08.03.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2017 03:31:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 08 Feb 2017 18:31:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] worktree.c: use submodule interface to access refs from another worktree
Date:   Wed,  8 Feb 2017 18:31:44 +0700
Message-Id: <20170208113144.8201-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170208113144.8201-1-pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch itself is relatively simple: manual parsing code is replaced
with a call to resolve_ref_submodule(). The manual parsing code must die
because only refs/files-backend.c should do that. Why submodule here is
a more interesting question.

From an outside look, any .git/worktrees/foo is seen as a "normal"
repository. You can set GIT_DIR to it and have access to everything,
even shared things that are not literally inside that directory, like
object db or shared refs.

On top of that, linked worktrees point to those directories with ".git"
files. These two make a linked worktree's path "X" a "submodule" (*) (**)
because X/.git is a file that points to a repository somewhere.

As such, we can just linked worktree's path as a submodule. We just need
to make sure they are unique because they are used to lookup submodule
refs store.

Main worktree is a a bit trickier. If we stand at a linked worktree, we
may still need to peek into main worktree's HEAD, for example. We can
treat main worktree's path as submodule as well since git_path_submodule()
can tolerate ".git" dirs, in addition to ".git" files.

The constraint is, if main worktree is X, then the git repo must be at
X/.git. If the user separates .git repo far away and tell git to point
to it via GIT_DIR or something else, then the "main worktree as submodule"
trick fails. Within multiple worktree context, I think we can limit
support to "standard" layout, at least for now.

(*) The differences in sharing object database and refs between
submodules and linked worktrees don't really matter in this context.

(**) At this point, we may want to rename refs *_submodule API to
something more neutral, maybe s/_submodule/_remote/

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 branch.c   |  3 +-
 worktree.c | 99 +++++++++++++++-----------------------------------------------
 worktree.h |  2 +-
 3 files changed, 27 insertions(+), 77 deletions(-)

diff --git a/branch.c b/branch.c
index b955d4f316..db5843718f 100644
--- a/branch.c
+++ b/branch.c
@@ -354,7 +354,8 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref)
 	for (i = 0; worktrees[i]; i++) {
 		if (worktrees[i]->is_detached)
 			continue;
-		if (strcmp(oldref, worktrees[i]->head_ref))
+		if (worktrees[i]->head_ref &&
+		    strcmp(oldref, worktrees[i]->head_ref))
 			continue;
 
 		if (set_worktree_head_symref(get_worktree_git_dir(worktrees[i]),
diff --git a/worktree.c b/worktree.c
index d633761575..25e5bc9a3e 100644
--- a/worktree.c
+++ b/worktree.c
@@ -19,54 +19,24 @@ void free_worktrees(struct worktree **worktrees)
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
+	target = resolve_ref_submodule(wt->path, "HEAD",
+				       RESOLVE_REF_READING,
+				       wt->head_sha1, &flags);
+	if (!target)
+		return;
+
+	if (flags & REF_ISSYMREF)
+		wt->head_ref = xstrdup(target);
+	else
+		wt->is_detached = 1;
 }
 
 /**
@@ -77,9 +47,7 @@ static struct worktree *get_main_worktree(void)
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
-	struct strbuf head_ref = STRBUF_INIT;
 	int is_bare = 0;
-	int is_detached = 0;
 
 	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
 	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
@@ -91,13 +59,10 @@ static struct worktree *get_main_worktree(void)
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
 
@@ -106,8 +71,6 @@ static struct worktree *get_linked_worktree(const char *id)
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf worktree_path = STRBUF_INIT;
-	struct strbuf head_ref = STRBUF_INIT;
-	int is_detached = 0;
 
 	if (!id)
 		die("Missing linked worktree name");
@@ -127,19 +90,14 @@ static struct worktree *get_linked_worktree(const char *id)
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
 
@@ -334,8 +292,6 @@ const struct worktree *find_shared_symref(const char *symref,
 					  const char *target)
 {
 	const struct worktree *existing = NULL;
-	struct strbuf path = STRBUF_INIT;
-	struct strbuf sb = STRBUF_INIT;
 	static struct worktree **worktrees;
 	int i = 0;
 
@@ -345,6 +301,10 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	for (i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
+		const char *symref_target;
+		unsigned char sha1[20];
+		int flags;
+
 		if (wt->is_bare)
 			continue;
 
@@ -359,25 +319,14 @@ const struct worktree *find_shared_symref(const char *symref,
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
+		symref_target = resolve_ref_submodule(wt->path, symref, 0,
+						      sha1, &flags);
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

