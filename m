Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441D020193
	for <e@80x24.org>; Thu, 11 Aug 2016 23:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbcHKXOX (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 19:14:23 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36764 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbcHKXOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 19:14:21 -0400
Received: by mail-pa0-f51.google.com with SMTP id pp5so2703649pac.3
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 16:14:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mLeHLJBl2v9yHzut1HrmA7mSrS78qWQbh/foaolnTUo=;
        b=D5hj3IPx5132owPF7sE1dftSjX5KDaAKp58ex1e3vekYzgylMbPpnoIfIzE3ELCGUI
         gi/AHv9ctM5CLeeHa8Cv85dBFiTa3/vqJIMQycn/9uhS0sNlsKQaAvtyrUbp1kiwPmWP
         U4CsFZQEsADZxK1SMtZR+tTRxlzMtCFGvuyt7oSvLsSk9qK5Hf/iKFAmnXDjCDXkv4ev
         SeWej7QuOKeRLBgjAthf2GO1dyP1U+wJXgLT8Vou/uQGtXH/mu8kAai54ETIkSo08D8E
         M3AHIuk7iNAfeaxhpMbTialgy/2m4nB5R5Do1SFYUVQBk/uiZcPr2vm4WpPla+3gAEF9
         uhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mLeHLJBl2v9yHzut1HrmA7mSrS78qWQbh/foaolnTUo=;
        b=FXYDODVSwKCtF9GjMZqlm/7255m9UKQYNVxEfJuTzskM0vaTTy8tk7PeYBb16mlh6g
         SFl6d8ICnwlywGuZrp4SgrCnKoO6fTBQJoUhFc0CYy5P02KB0iG5SkyydtoWauLM8LO4
         zfdYcAKzp+AFMpSulOL2BNB4k/Wwh4zxby0KnHS6VhvyY1CHoFGM1il0NXAgpJ2jKV/i
         3081eM+ZOrjsB+85Ex86zR1b21cmJflYzOD5I6GlcEXbKOfoyqakJVTZcjnSHM8QAMOg
         ao3fkSzgT9YqZaDWONJT6FtieDnL+AQeDXDcnbDl7eJKKUk0CBnXt2GvCuxwilIWfRpH
         H2dg==
X-Gm-Message-State: AEkoouv42N9EnltcFyfEp2umOA08RrWSPfb0NazWtstU8fgjyhP4B/tghUTB4cRCKw4WhTNy
X-Received: by 10.66.191.66 with SMTP id gw2mr21390645pac.153.1470957260247;
        Thu, 11 Aug 2016 16:14:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2879:1504:a6e4:e441])
        by smtp.gmail.com with ESMTPSA id v26sm7722404pfi.41.2016.08.11.16.14.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 16:14:19 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 5/8] clone: factor out checking for an alternate path
Date:	Thu, 11 Aug 2016 16:14:02 -0700
Message-Id: <20160811231405.17318-6-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.737.g4a14654
In-Reply-To: <20160811231405.17318-1-sbeller@google.com>
References: <20160811231405.17318-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In a later patch we want to determine if a path is suitable as an
alternate from other commands than builtin/clone. Move the checking
functionality of `add_one_reference` to `compute_alternate_path` that is
defined in cache.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/clone.c | 42 ++++++--------------------------
 cache.h         |  1 +
 sha1_file.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 35 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f044a8c..24b17539 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -282,44 +282,16 @@ static void strip_trailing_slashes(char *dir)
 
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
-	char *ref_git;
-	const char *repo;
-	struct strbuf alternate = STRBUF_INIT;
-
-	/* Beware: read_gitfile(), real_path() and mkpath() return static buffer */
-	ref_git = xstrdup(real_path(item->string));
-
-	repo = read_gitfile(ref_git);
-	if (!repo)
-		repo = read_gitfile(mkpath("%s/.git", ref_git));
-	if (repo) {
-		free(ref_git);
-		ref_git = xstrdup(repo);
-	}
-
-	if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
-		char *ref_git_git = mkpathdup("%s/.git", ref_git);
-		free(ref_git);
-		ref_git = ref_git_git;
-	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
-		struct strbuf sb = STRBUF_INIT;
-		if (get_common_dir(&sb, ref_git))
-			die(_("reference repository '%s' as a linked checkout is not supported yet."),
-			    item->string);
-		die(_("reference repository '%s' is not a local repository."),
-		    item->string);
-	}
+	struct strbuf sb = STRBUF_INIT;
+	char *ref_git = compute_alternate_path(item->string, &sb);
 
-	if (!access(mkpath("%s/shallow", ref_git), F_OK))
-		die(_("reference repository '%s' is shallow"), item->string);
+	if (!ref_git)
+		die("%s", sb.buf);
 
-	if (!access(mkpath("%s/info/grafts", ref_git), F_OK))
-		die(_("reference repository '%s' is grafted"), item->string);
+	strbuf_addf(&sb, "%s/objects", ref_git);
+	add_to_alternates_file(sb.buf);
 
-	strbuf_addf(&alternate, "%s/objects", ref_git);
-	add_to_alternates_file(alternate.buf);
-	strbuf_release(&alternate);
-	free(ref_git);
+	strbuf_release(&sb);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index 95a0bd3..35f41f7 100644
--- a/cache.h
+++ b/cache.h
@@ -1344,6 +1344,7 @@ extern struct alternate_object_database {
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 extern void read_info_alternates(const char * relative_base, int depth);
+extern char *compute_alternate_path(const char *path, struct strbuf *err);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index 02940f1..7351d8c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -418,6 +418,80 @@ void add_to_alternates_file(const char *reference)
 	free(alts);
 }
 
+/*
+ * Compute the exact path an alternate is at and returns it. In case of
+ * error NULL is returned and the human readable error is added to `err`
+ * `path` may be relative and should point to $GITDIR.
+ * `err` must not be null.
+ */
+char *compute_alternate_path(const char *path, struct strbuf *err)
+{
+	char *ref_git = NULL;
+	const char *repo, *ref_git_s;
+	struct strbuf err_buf = STRBUF_INIT;
+
+	ref_git_s = real_path_if_valid(path);
+	if (!ref_git_s) {
+		strbuf_addf(&err_buf, _("path '%s' does not exist"), path);
+		goto out;
+	} else
+		/*
+		 * Beware: read_gitfile(), real_path() and mkpath()
+		 * return static buffer
+		 */
+		ref_git = xstrdup(ref_git_s);
+
+	repo = read_gitfile(ref_git);
+	if (!repo)
+		repo = read_gitfile(mkpath("%s/.git", ref_git));
+	if (repo) {
+		free(ref_git);
+		ref_git = xstrdup(repo);
+	}
+
+	if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
+		char *ref_git_git = mkpathdup("%s/.git", ref_git);
+		free(ref_git);
+		ref_git = ref_git_git;
+	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
+		struct strbuf sb = STRBUF_INIT;
+		if (get_common_dir(&sb, ref_git)) {
+			strbuf_addf(&err_buf,
+				    _("reference repository '%s' as a linked "
+				      "checkout is not supported yet."),
+				    path);
+			goto out;
+		}
+
+		strbuf_addf(&err_buf, _("reference repository '%s' is not a "
+					"local repository."), path);
+		goto out;
+	}
+
+	if (!access(mkpath("%s/shallow", ref_git), F_OK)) {
+		strbuf_addf(&err_buf, _("reference repository '%s' is shallow"),
+			    path);
+		goto out;
+	}
+
+	if (!access(mkpath("%s/info/grafts", ref_git), F_OK)) {
+		strbuf_addf(&err_buf,
+			    _("reference repository '%s' is grafted"),
+			    path);
+		goto out;
+	}
+
+out:
+	if (err_buf.len) {
+		strbuf_addbuf(err, &err_buf);
+		free(ref_git);
+		ref_git = NULL;
+	}
+
+	strbuf_release(&err_buf);
+	return ref_git;
+}
+
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
 {
 	struct alternate_object_database *ent;
-- 
2.9.2.737.g4a14654

