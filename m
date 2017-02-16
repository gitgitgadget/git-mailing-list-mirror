Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE261FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 12:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbdBPMEF (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 07:04:05 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33092 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753836AbdBPMEE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 07:04:04 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so1861755pgj.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyC5xfQFWxKAPZh1nDFJskB8V7DikXJ140ageu+JTOI=;
        b=TuVz66JBPh2IL76sS+gFKVpgSo5bkBWDvrLpdLnaF+Rnwv1O5wiXpeGSiOVZ67z5e0
         9lftuNNYmN7EVu/HnV0+p+eLmZ+xpLOylDq767RPRYjBGlJZN+42Yu9qaZiutLDtpMRF
         /dEiltbgOvWnDz492dItrnWuhA/+otaTb4KHRCEKZbPHXdTQIGMKfljaVal/DLrgS5bE
         HSmgr4qpcQnnJcE3cWHQDuvMBeWrBp5ggGsTTrZx84KC79Kl3nqZhkZ+3VcTLDLjELKN
         TCp4SosF/rpqCvblCfFVpB0GQjiWm+/Z9RyLP9xy3Ngeyu1dYlTmp35EmPi8n+7tJEFD
         9+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyC5xfQFWxKAPZh1nDFJskB8V7DikXJ140ageu+JTOI=;
        b=Q7lv6hQzMYRJytm6nk/aQPsoEbOjIMj1T08ULO70DKTSGvtgbSBd4YyN4lrQTh62fv
         sZjCdF/9q8/ittN7FAhO3akgu5YBpI/PMOlA30o//IzPeGV0NEkbtxkeDAxNBaBX9KuR
         7BLtTgprPKZQMFjj6XTgwTZ0WjjkU66jC6OOPC1BIlJcWjBfXdD87oOplq8R6Na2dlMS
         eTDGhtePwo2FJShN+nxqmEgX/QKTlpIJ4RDiol7ENK0vNDpO2XvCFvU/QXQEU0rtSuGt
         jgK/qkP9RZeRcQC2WNE+k+Hv59Gy66Joph1v5LEllsnJwTHrl/Rp7srQdRA9Jve2rKNG
         Q26Q==
X-Gm-Message-State: AMke39m9AwIb0B8bIQ+Hj/zDSD8Vxwejo/XD4hbLa6cw6rU/GGLc8508MTqZhQC1wypeug==
X-Received: by 10.84.169.67 with SMTP id g61mr2702178plb.137.1487246643277;
        Thu, 16 Feb 2017 04:04:03 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id r17sm13525762pgg.19.2017.02.16.04.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 04:04:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 19:03:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/5] worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
Date:   Thu, 16 Feb 2017 19:03:00 +0700
Message-Id: <20170216120302.5302-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216120302.5302-1-pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
 <20170216120302.5302-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The manual parsing code is replaced with a call to refs_resolve_ref_unsafe().
The manual parsing code must die because only refs/files-backend.c
should do that.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 branch.c   |   3 +-
 worktree.c | 102 ++++++++++++++++---------------------------------------------
 worktree.h |   2 +-
 3 files changed, 30 insertions(+), 77 deletions(-)

diff --git a/branch.c b/branch.c
index c431cbf6a..fcb4a765c 100644
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
index eb6121263..f8f520036 100644
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
 
@@ -359,24 +321,14 @@ const struct worktree *find_shared_symref(const char *symref,
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
index d59ce1fee..961252e71 100644
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

