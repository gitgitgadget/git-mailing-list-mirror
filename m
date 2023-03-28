Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACBDC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjC1OAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjC1OAE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:00:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDA6CA2E
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l8-20020a05600c1d0800b003ef6708bbf6so5467971wms.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkbujhribciW0kk9GzD5NeMadZfjgk8Ez4tf4skKY9E=;
        b=KYOny1QkOYMsYuJ3vg1PQiz0NCzVDBKKN5+7E//fYhncnpt5+ZEZdMP2gOP5OdSrX3
         r/ByByMY551WJdwUADhwW7iopHGFr6Yslva5tLXo3ywuM7shz/laNt+VBBsmOVkpVn5T
         tNgk1v6j7Z4StfKLUb4wch5AKRp+UuCaefrvDnaYWb8I+U7L27B5OmaJX3E1qDAMymsT
         6DXbUF4yV4iVhmwx5uP3r0sQ5sL8jMXBwJHanHo0SwWFaLKNWfPb3oiRjiyQjVY9Jfm0
         /VaHbZEea1GqyViyvok2y2nErejV8wTumw8mYL/dfJb3NTXyvZEypVYu25UPr+oRNy8K
         WWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkbujhribciW0kk9GzD5NeMadZfjgk8Ez4tf4skKY9E=;
        b=iEYJt18dW3IL/UISNsF5gWKb3FFzLPEvKlD4QvHMN6vxqXfRMHcEDTf8XdYCMGHmNB
         8gztYTPmNSXjas3sK7K+ihWEHU6S8JsYyA9iIoBmH7ajhJAqn3DqCmEkaBHQ8X/uRFa0
         aFA7P7wXFnXcI/maW5Zk+LN0QdMllNs6w3nqGde4+iO9jGPiHV6h7T/J4vWzSGf9OXAP
         m7SrMxxCVpKj3OHEkAijKcWVL3595YZfFphqZDaR37p/1DenNKCejn87PDDTHZ0knL0P
         gR1rg710/pVl1hrykEjrbFCrLwuW0f3Ahx/6xy0h5T/I40fnwtolkYZ3fU6EtiBuGj9m
         OJ2A==
X-Gm-Message-State: AO0yUKW9Sq+jiMB5J3EoFlR+n9SFppS0Bc8WQYU/RKLoSepZ9N02v9Du
        IrZ3kBWQx+DA4K/lmsczaljEHYSyXpmWLg==
X-Google-Smtp-Source: AK7set/nva7cljENDhPSpFmUut+Lwrm/Bt8qOn7riC6djMFbr0xLaMS0S8dqTnGsJHPg/kMVJ+xhUA==
X-Received: by 2002:a7b:c3c7:0:b0:3ed:ff92:dd2a with SMTP id t7-20020a7bc3c7000000b003edff92dd2amr12531239wmj.12.1680011963835;
        Tue, 28 Mar 2023 06:59:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/17] post-cocci: adjust comments for recent repo_* migration
Date:   Tue, 28 Mar 2023 15:58:57 +0200
Message-Id: <patch-v2-16.17-f947bb69dee-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
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
index 1d05a8e945f..0ede8856562 100644
--- a/cache.h
+++ b/cache.h
@@ -435,7 +435,7 @@ void validate_cache_entries(const struct index_state *istate);
 /*
  * Bulk prefetch all missing cache entries that are not GITLINKs and that match
  * the given predicate. This function should only be called if
- * has_promisor_remote() returns true.
+ * repo_has_promisor_remote() returns true.
  */
 typedef int (*must_prefetch_predicate)(const struct cache_entry *);
 void prefetch_cache_entries(const struct index_state *istate,
@@ -1093,7 +1093,7 @@ void check_repository_format(struct repository_format *fmt);
  * terminated.
  *
  * The non-`_r` version returns a static buffer which remains valid until 4
- * more calls to find_unique_abbrev are made.
+ * more calls to repo_find_unique_abbrev are made.
  *
  * The `_r` variant writes to a buffer supplied by the caller, which must be at
  * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of bytes
diff --git a/commit.h b/commit.h
index d87d5cd2a09..69b2f376e9d 100644
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
index c759bedc269..6a0737b9c34 100644
--- a/diff.h
+++ b/diff.h
@@ -615,7 +615,7 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
 #define DIFF_STATUS_FILTER_BROKEN	'B'
 
 /*
- * This is different from find_unique_abbrev() in that
+ * This is different from repo_find_unique_abbrev() in that
  * it stuffs the result with dots for alignment.
  */
 const char *diff_aligned_abbrev(const struct object_id *sha1, int);
diff --git a/object-file.c b/object-file.c
index 5944f51a3e0..bd9741c7f36 100644
--- a/object-file.c
+++ b/object-file.c
@@ -269,7 +269,7 @@ int hash_algo_by_length(int len)
 
 /*
  * This is meant to hold a *small* number of objects that you would
- * want read_object_file() to be able to return, but yet you do not want
+ * want repo_read_object_file() to be able to return, but yet you do not want
  * to write them into the object store (e.g. a browse-only
  * application).
  */
diff --git a/object-store.h b/object-store.h
index 62a683af4d6..f9d225783ae 100644
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
@@ -406,7 +406,7 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
 /*
  * Enabling the object read lock allows multiple threads to safely call the
- * following functions in parallel: repo_read_object_file(), read_object_file(),
+ * following functions in parallel: repo_read_object_file(),
  * read_object_with_reference(), oid_object_info() and oid_object_info_extended().
  *
  * obj_read_lock() and obj_read_unlock() may also be used to protect other
diff --git a/pretty.c b/pretty.c
index 0ce6ab7e196..494932da20d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -721,7 +721,7 @@ const char *repo_logmsg_reencode(struct repository *r,
 		 * Otherwise, we still want to munge the encoding header in the
 		 * result, which will be done by modifying the buffer. If we
 		 * are using a fresh copy, we can reuse it. But if we are using
-		 * the cached copy from get_commit_buffer, we need to duplicate it
+		 * the cached copy from repo_get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
 		if (msg == get_cached_commit_buffer(r, commit, NULL))
diff --git a/refs.c b/refs.c
index 53240bcc07b..1e1c76d1eca 100644
--- a/refs.c
+++ b/refs.c
@@ -1823,7 +1823,7 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 			return NULL;
 
 		/*
-		 * dwim_ref() uses REF_ISBROKEN to distinguish between
+		 * repo_dwim_ref() uses REF_ISBROKEN to distinguish between
 		 * missing refs and refs that were present but invalid,
 		 * to complain about the latter to stderr.
 		 *
diff --git a/sequencer.c b/sequencer.c
index d0ad37700fd..84b07b818f0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -766,9 +766,9 @@ static int is_index_unchanged(struct repository *r)
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
@@ -5368,7 +5368,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
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

