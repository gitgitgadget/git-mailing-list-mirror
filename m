Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B72C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCQPgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCQPgP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12197366BC
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so21903968edb.10
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ8zi8CuvWGz+nn2x5KY6Fh2+gpWJplLrx0ipO1RHBY=;
        b=iH7evbmfeIRlrX1aPef0FmaEO2wQAT/b3eCDGs5yreP4r7br2VuieOotgJl7LKzaCv
         YyPqVe25fn3YQxZu9hBQql07rtn74dg8Si43ZukdMlKaGixz6ykqE6dKIAvRNl7keMh6
         c9AxAwVKsfeKoHG+GmBG4dccxGL5RCDMifNo7oYwKO7PCzS08H7rXpP0FUIut//bwUgK
         MVsTHJnoTll+PsQ0TlbZbNnCda8HfnV3pw6OwDZYqGE0blTHJhTIUgZ0XEuzTEmd5/IN
         p2un+MxL+y087yof/IQMuSp9RD4ZWYE9lcB1CTsUjWEj49qtoWgri4rDlG4Cn6VB8K/o
         2YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ8zi8CuvWGz+nn2x5KY6Fh2+gpWJplLrx0ipO1RHBY=;
        b=US20oHgwIOVRh0BPkwZerljRIxY1DC9PUOC1ScShnClbpl94rvus3Ceb0ECwmA+Wt8
         8fFpelCj+GxGbasUzHVsjsgmTyoSExPhBKW5b8kdJOgIOpzhLsPILxESRh7Lb0qqtEes
         n2neSPj81gYNmG88X1J02ZLmWNipftVeUhYEYK2ozSpps/atb2m2mkhQZdEU4lHeEHTy
         L1MgnFHFqOTYUblD6TJYZL9knLYigqJtEwS4RmBKlcJ1qMBEkg9mbSOv9diW0ey9HfHV
         Zr6/cVAzZbELzH5rRSYkbTSVARF4DW6LqjV/NhyhSO2wIaf9VtMn+Ar+0671nUmufgKa
         TOLg==
X-Gm-Message-State: AO0yUKUGJHbnJ3b7zNEmbVcOIqq8XjzhBEMKuwVHWueYdeooVN70PZ0w
        EY3eYUQvqjPR7O8nMALGKs+2C5o2oaGdhg==
X-Google-Smtp-Source: AK7set/yajbNabvbT3fVmMpB0xb+kjKWfQqma5OaN3oCEfYCJ6N86gFpCDL7Axjzw6+d1eWjybCtxA==
X-Received: by 2002:a05:6402:516e:b0:4ad:7a9f:a9f0 with SMTP id d14-20020a056402516e00b004ad7a9fa9f0mr3605827ede.22.1679067340508;
        Fri, 17 Mar 2023 08:35:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/17] post-cocci: adjust comments for recent repo_* migration
Date:   Fri, 17 Mar 2023 16:35:20 +0100
Message-Id: <patch-16.17-86e24add191-20230317T152725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits we changed many calls to macros that were
providing a "the_repository" argument to invoke corresponding repo_*()
function instead. Let's follow-up and adjust references to those in
comments, which coccinelle didn't (and inherently can't) catch.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/branch.c   | 2 +-
 builtin/shortlog.c | 2 +-
 cache.h            | 4 ++--
 commit.h           | 4 ++--
 diff.h             | 2 +-
 object-file.c      | 2 +-
 object-store.h     | 4 ++--
 pretty.c           | 2 +-
 refs.c             | 2 +-
 sequencer.c        | 6 +++---
 strbuf.h           | 6 +++---
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index bbcfb34b3c6..45910039e6b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -156,7 +156,7 @@ static int branch_merged(int kind, const char *name,
 	/*
 	 * After the safety valve is fully redefined to "check with
 	 * upstream, if any, otherwise with HEAD", we should just
-	 * return the result of the in_merge_bases() above without
+	 * return the result of the repo_in_merge_bases() above without
 	 * any of the following code, but during the transition period,
 	 * a gentle reminder is in order.
 	 */
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 62f91b8b932..f287a6acd03 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -176,7 +176,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 		return;
 
 	/*
-	 * Using format_commit_message("%B") would be simpler here, but
+	 * Using repo_format_commit_message("%B") would be simpler here, but
 	 * this saves us copying the message.
 	 */
 	commit_buffer = repo_logmsg_reencode(the_repository, commit, NULL,
diff --git a/cache.h b/cache.h
index d835ac8b4d2..555354e1961 100644
--- a/cache.h
+++ b/cache.h
@@ -443,7 +443,7 @@ void validate_cache_entries(const struct index_state *istate);
 /*
  * Bulk prefetch all missing cache entries that are not GITLINKs and that match
  * the given predicate. This function should only be called if
- * has_promisor_remote() returns true.
+ * repo_has_promisor_remote() returns true.
  */
 typedef int (*must_prefetch_predicate)(const struct cache_entry *);
 void prefetch_cache_entries(const struct index_state *istate,
@@ -1201,7 +1201,7 @@ void check_repository_format(struct repository_format *fmt);
  * terminated.
  *
  * The non-`_r` version returns a static buffer which remains valid until 4
- * more calls to find_unique_abbrev are made.
+ * more calls to repo_find_unique_abbrev are made.
  *
  * The `_r` variant writes to a buffer supplied by the caller, which must be at
  * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of bytes
diff --git a/commit.h b/commit.h
index e98ee6e698e..d4adf111019 100644
--- a/commit.h
+++ b/commit.h
@@ -130,7 +130,7 @@ const void *get_cached_commit_buffer(struct repository *, const struct commit *,
 /*
  * Get the commit's object contents, either from cache or by reading the object
  * from disk. The resulting memory should not be modified, and must be given
- * to unuse_commit_buffer when the caller is done.
+ * to repo_unuse_commit_buffer when the caller is done.
  */
 const void *repo_get_commit_buffer(struct repository *r,
 				   const struct commit *,
@@ -139,7 +139,7 @@ const void *repo_get_commit_buffer(struct repository *r,
 /*
  * Tell the commit subsystem that we are done with a particular commit buffer.
  * The commit and buffer should be the input and return value, respectively,
- * from an earlier call to get_commit_buffer.  The buffer may or may not be
+ * from an earlier call to repo_get_commit_buffer.  The buffer may or may not be
  * freed by this call; callers should not access the memory afterwards.
  */
 void repo_unuse_commit_buffer(struct repository *r,
diff --git a/diff.h b/diff.h
index 8b510eb579d..0aa36e81261 100644
--- a/diff.h
+++ b/diff.h
@@ -614,7 +614,7 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
 #define DIFF_STATUS_FILTER_BROKEN	'B'
 
 /*
- * This is different from find_unique_abbrev() in that
+ * This is different from repo_find_unique_abbrev() in that
  * it stuffs the result with dots for alignment.
  */
 const char *diff_aligned_abbrev(const struct object_id *sha1, int);
diff --git a/object-file.c b/object-file.c
index 141cf85f25b..47c52681640 100644
--- a/object-file.c
+++ b/object-file.c
@@ -267,7 +267,7 @@ int hash_algo_by_length(int len)
 
 /*
  * This is meant to hold a *small* number of objects that you would
- * want read_object_file() to be able to return, but yet you do not want
+ * want repo_read_object_file() to be able to return, but yet you do not want
  * to write them into the object store (e.g. a browse-only
  * application).
  */
diff --git a/object-store.h b/object-store.h
index b47849d4e7e..9217ae83064 100644
--- a/object-store.h
+++ b/object-store.h
@@ -216,7 +216,7 @@ struct raw_object_store {
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
-	 * approximate_object_count() instead.
+	 * repo_approximate_object_count() instead.
 	 */
 	unsigned long approximate_object_count;
 	unsigned approximate_object_count_valid : 1;
@@ -343,7 +343,7 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
 /*
  * Enabling the object read lock allows multiple threads to safely call the
- * following functions in parallel: repo_read_object_file(), read_object_file(),
+ * following functions in parallel: repo_read_object_file(),
  * read_object_with_reference(), oid_object_info() and oid_object_info_extended().
  *
  * obj_read_lock() and obj_read_unlock() may also be used to protect other
diff --git a/pretty.c b/pretty.c
index 076d1c363e7..23ac06b93f3 100644
--- a/pretty.c
+++ b/pretty.c
@@ -719,7 +719,7 @@ const char *repo_logmsg_reencode(struct repository *r,
 		 * Otherwise, we still want to munge the encoding header in the
 		 * result, which will be done by modifying the buffer. If we
 		 * are using a fresh copy, we can reuse it. But if we are using
-		 * the cached copy from get_commit_buffer, we need to duplicate it
+		 * the cached copy from repo_get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
 		if (msg == get_cached_commit_buffer(r, commit, NULL))
diff --git a/refs.c b/refs.c
index aeae31c972f..cd7537bce64 100644
--- a/refs.c
+++ b/refs.c
@@ -1821,7 +1821,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 			return NULL;
 
 		/*
-		 * dwim_ref() uses REF_ISBROKEN to distinguish between
+		 * repo_dwim_ref() uses REF_ISBROKEN to distinguish between
 		 * missing refs and refs that were present but invalid,
 		 * to complain about the latter to stderr.
 		 *
diff --git a/sequencer.c b/sequencer.c
index aa3ebb47d98..fb5a540fa04 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -768,9 +768,9 @@ static int is_index_unchanged(struct repository *r)
 	/*
 	 * If head_commit is NULL, check_commit, called from
 	 * lookup_commit, would have indicated that head_commit is not
-	 * a commit object already.  parse_commit() will return failure
+	 * a commit object already.  repo_parse_commit() will return failure
 	 * without further complaints in such a case.  Otherwise, if
-	 * the commit is invalid, parse_commit() will complain.  So
+	 * the commit is invalid, repo_parse_commit() will complain.  So
 	 * there is nothing for us to say here.  Just return failure.
 	 */
 	if (repo_parse_commit(the_repository, head_commit))
@@ -5365,7 +5365,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 	 * For "uninteresting" commits, i.e. commits that are not to be
 	 * rebased, and which can therefore not be labeled, we use a unique
 	 * abbreviation of the commit name. This is slightly more complicated
-	 * than calling find_unique_abbrev() because we also need to make
+	 * than calling repo_find_unique_abbrev() because we also need to make
 	 * sure that the abbreviation does not conflict with any other
 	 * label.
 	 *
diff --git a/strbuf.h b/strbuf.h
index f6dbb9681ee..b980f9edc6d 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -631,7 +631,7 @@ void strbuf_add_separated_string_list(struct strbuf *str,
 void strbuf_list_free(struct strbuf **list);
 
 /**
- * Add the abbreviation, as generated by find_unique_abbrev, of `sha1` to
+ * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
  * the strbuf `sb`.
  */
 struct repository;
@@ -706,14 +706,14 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 
 /*
  * Copy "name" to "sb", expanding any special @-marks as handled by
- * interpret_branch_name(). The result is a non-qualified branch name
+ * repo_interpret_branch_name(). The result is a non-qualified branch name
  * (so "foo" or "origin/master" instead of "refs/heads/foo" or
  * "refs/remotes/origin/master").
  *
  * Note that the resulting name may not be a syntactically valid refname.
  *
  * If "allowed" is non-zero, restrict the set of allowed expansions. See
- * interpret_branch_name() for details.
+ * repo_interpret_branch_name() for details.
  */
 void strbuf_branchname(struct strbuf *sb, const char *name,
 		       unsigned allowed);
-- 
2.40.0.rc1.1034.g5867a1b10c5

