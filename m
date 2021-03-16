Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C243DC43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99D264F91
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhCPVRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhCPVRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEF0C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v4so8174190wrp.13
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6NgjP2HIjVJd9+5WKWUw24ZAuJZNBpeiVFI3QTXTaxo=;
        b=r5TGlictJmZTI8E/d07tO1CL1/tgJhB7+n8+HVmtfFIBBJrO9bxu318Ao5OU53021t
         YEAkxawhSizhtq6iW5OYz9Td9zxKSpw+9/j4hiDjH0SueCE8whmV4pOfWWGYjPuM4IMe
         UjeJ+6uRFsPwzJSHsrLR1tiQx7SKlZK5MExoxfsI87dpXGpEnsDaQATPPb7R1cy+ba7u
         9DTtFmWiKzHljKWxlqijIQRJtwnvk3IH5E/VY8sO6P2wbTj3GJJhGkzmWuCH4Z01+f4D
         lXHs9rje4xlRPfzqIJ/EoVKtWfrZ75HRTH3UB3nCn3s9IGHRtHb7zTboL0CL7Ro1c8Wr
         zN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6NgjP2HIjVJd9+5WKWUw24ZAuJZNBpeiVFI3QTXTaxo=;
        b=VdUxpeC0pMBXZiCA9aARZyir4wRMaIWZPJ1/YDwAduuf8PFp8LCH8Bq5O9vyEAvJ/4
         GW8JJuE6iGL0ncuNcK6dTmuh59++mYcgZHJxa0/JikUo5hL2rYxRdlyHG3+bcRKkruBO
         qwDIePBZqz07Ztu9fecAJxpmP/qCOVxjtDRtB0oG0kWJMOMoFxF7EF/UefKwr0ZjBIzP
         QEEj80Aksn7Yth5Cjcof+3GICX057BgzPYmubMVuzC+UYMF1G3xNeIW+CCZa+svetPYr
         TLkwCzEnEy/ER9w8xR9btt/DuaSv2NLvW0Mlsw8fO447fwWM6pq6Q0dO0j+AZaxFIwjF
         isWg==
X-Gm-Message-State: AOAM530eNMtrAr8Imp9ppCOZ1WnbnAybKzAmjB0mzsILf3toErg2tojM
        LadLlZ5iThJ6UNZgB+4PEbTs5z3umbY=
X-Google-Smtp-Source: ABdhPJxwlEELR7NV3mAwZP01QN7EvPadyidxwiaAAf3gebP9wOyCBGPqB1eYDVxN0jD86goAHrbRdg==
X-Received: by 2002:adf:c752:: with SMTP id b18mr916687wrh.233.1615929438298;
        Tue, 16 Mar 2021 14:17:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b186sm476100wmc.44.2021.03.16.14.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:17 -0700 (PDT)
Message-Id: <628e16dd3fc7be96d40a7b3201573a71ae7fbbd6.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:49 +0000
Subject: [PATCH 01/27] *: remove 'const' qualifier for struct index_state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Several methods specify that they take a 'struct index_state' pointer
with the 'const' qualifier because they intend to only query the data,
not change it. However, we will be introducing a step very low in the
method stack that might modify a sparse-index to become a full index in
the case that our queries venture inside a sparse-directory entry.

This change only removes the 'const' qualifiers that are necessary for
the following change which will actually modify the implementation of
index_name_stage_pos().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 attr.c             | 14 +++++++-------
 attr.h             |  4 ++--
 builtin/ls-files.c | 10 +++++-----
 cache.h            |  6 +++---
 convert.c          | 26 +++++++++++++-------------
 convert.h          | 20 ++++++++++----------
 dir.c              | 12 ++++++------
 dir.h              |  8 ++++----
 merge-recursive.c  |  2 +-
 pathspec.c         |  6 +++---
 pathspec.h         |  6 +++---
 read-cache.c       | 10 +++++-----
 submodule.c        |  6 +++---
 submodule.h        |  6 +++---
 14 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/attr.c b/attr.c
index 4ef85d668b54..8de553293ee4 100644
--- a/attr.c
+++ b/attr.c
@@ -718,7 +718,7 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	return res;
 }
 
-static struct attr_stack *read_attr_from_index(const struct index_state *istate,
+static struct attr_stack *read_attr_from_index(struct index_state *istate,
 					       const char *path,
 					       int macro_ok)
 {
@@ -748,7 +748,7 @@ static struct attr_stack *read_attr_from_index(const struct index_state *istate,
 	return res;
 }
 
-static struct attr_stack *read_attr(const struct index_state *istate,
+static struct attr_stack *read_attr(struct index_state *istate,
 				    const char *path, int macro_ok)
 {
 	struct attr_stack *res = NULL;
@@ -840,7 +840,7 @@ static void push_stack(struct attr_stack **attr_stack_p,
 	}
 }
 
-static void bootstrap_attr_stack(const struct index_state *istate,
+static void bootstrap_attr_stack(struct index_state *istate,
 				 struct attr_stack **stack)
 {
 	struct attr_stack *e;
@@ -878,7 +878,7 @@ static void bootstrap_attr_stack(const struct index_state *istate,
 	push_stack(stack, e, NULL, 0);
 }
 
-static void prepare_attr_stack(const struct index_state *istate,
+static void prepare_attr_stack(struct index_state *istate,
 			       const char *path, int dirlen,
 			       struct attr_stack **stack)
 {
@@ -1078,7 +1078,7 @@ static void determine_macros(struct all_attrs_item *all_attrs,
  * If check->check_nr is non-zero, only attributes in check[] are collected.
  * Otherwise all attributes are collected.
  */
-static void collect_some_attrs(const struct index_state *istate,
+static void collect_some_attrs(struct index_state *istate,
 			       const char *path,
 			       struct attr_check *check)
 {
@@ -1107,7 +1107,7 @@ static void collect_some_attrs(const struct index_state *istate,
 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
 
-void git_check_attr(const struct index_state *istate,
+void git_check_attr(struct index_state *istate,
 		    const char *path,
 		    struct attr_check *check)
 {
@@ -1124,7 +1124,7 @@ void git_check_attr(const struct index_state *istate,
 	}
 }
 
-void git_all_attrs(const struct index_state *istate,
+void git_all_attrs(struct index_state *istate,
 		   const char *path, struct attr_check *check)
 {
 	int i;
diff --git a/attr.h b/attr.h
index 404548f028a8..3732505edae8 100644
--- a/attr.h
+++ b/attr.h
@@ -190,14 +190,14 @@ void attr_check_free(struct attr_check *check);
  */
 const char *git_attr_name(const struct git_attr *);
 
-void git_check_attr(const struct index_state *istate,
+void git_check_attr(struct index_state *istate,
 		    const char *path, struct attr_check *check);
 
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
-void git_all_attrs(const struct index_state *istate,
+void git_all_attrs(struct index_state *istate,
 		   const char *path, struct attr_check *check);
 
 enum git_attr_direction {
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 13bcc2d84735..76a0d35c1a01 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -57,7 +57,7 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_eolinfo(const struct index_state *istate,
+static void write_eolinfo(struct index_state *istate,
 			  const struct cache_entry *ce, const char *path)
 {
 	if (show_eol) {
@@ -122,7 +122,7 @@ static void print_debug(const struct cache_entry *ce)
 	}
 }
 
-static void show_dir_entry(const struct index_state *istate,
+static void show_dir_entry(struct index_state *istate,
 			   const char *tag, struct dir_entry *ent)
 {
 	int len = max_prefix_len;
@@ -139,7 +139,7 @@ static void show_dir_entry(const struct index_state *istate,
 	write_name(ent->name);
 }
 
-static void show_other_files(const struct index_state *istate,
+static void show_other_files(struct index_state *istate,
 			     const struct dir_struct *dir)
 {
 	int i;
@@ -152,7 +152,7 @@ static void show_other_files(const struct index_state *istate,
 	}
 }
 
-static void show_killed_files(const struct index_state *istate,
+static void show_killed_files(struct index_state *istate,
 			      const struct dir_struct *dir)
 {
 	int i;
@@ -254,7 +254,7 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 	}
 }
 
-static void show_ru_info(const struct index_state *istate)
+static void show_ru_info(struct index_state *istate)
 {
 	struct string_list_item *item;
 
diff --git a/cache.h b/cache.h
index 4ca6cd7f782c..f244e6ac90fd 100644
--- a/cache.h
+++ b/cache.h
@@ -800,7 +800,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
  * index_name_pos(&index, "f", 1) -> -3
  * index_name_pos(&index, "g", 1) -> -5
  */
-int index_name_pos(const struct index_state *, const char *name, int namelen);
+int index_name_pos(struct index_state *, const char *name, int namelen);
 
 /*
  * Some functions return the negative complement of an insert position when a
@@ -850,8 +850,8 @@ int add_file_to_index(struct index_state *, const char *path, int flags);
 int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
-int index_name_is_other(const struct index_state *, const char *, int);
-void *read_blob_data_from_index(const struct index_state *, const char *, unsigned long *);
+int index_name_is_other(struct index_state *, const char *, int);
+void *read_blob_data_from_index(struct index_state *, const char *, unsigned long *);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/convert.c b/convert.c
index ee360c2f07ce..20b19abffa36 100644
--- a/convert.c
+++ b/convert.c
@@ -138,7 +138,7 @@ static const char *gather_convert_stats_ascii(const char *data, unsigned long si
 	}
 }
 
-const char *get_cached_convert_stats_ascii(const struct index_state *istate,
+const char *get_cached_convert_stats_ascii(struct index_state *istate,
 					   const char *path)
 {
 	const char *ret;
@@ -222,7 +222,7 @@ static void check_global_conv_flags_eol(const char *path,
 	}
 }
 
-static int has_crlf_in_index(const struct index_state *istate, const char *path)
+static int has_crlf_in_index(struct index_state *istate, const char *path)
 {
 	unsigned long sz;
 	void *data;
@@ -496,7 +496,7 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 	return 1;
 }
 
-static int crlf_to_git(const struct index_state *istate,
+static int crlf_to_git(struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, int conv_flags)
@@ -1307,7 +1307,7 @@ struct conv_attrs {
 
 static struct attr_check *check;
 
-static void convert_attrs(const struct index_state *istate,
+static void convert_attrs(struct index_state *istate,
 			  struct conv_attrs *ca, const char *path)
 {
 	struct attr_check_item *ccheck = NULL;
@@ -1369,7 +1369,7 @@ void reset_parsed_attributes(void)
 	user_convert_tail = NULL;
 }
 
-int would_convert_to_git_filter_fd(const struct index_state *istate, const char *path)
+int would_convert_to_git_filter_fd(struct index_state *istate, const char *path)
 {
 	struct conv_attrs ca;
 
@@ -1388,7 +1388,7 @@ int would_convert_to_git_filter_fd(const struct index_state *istate, const char
 	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN, NULL, NULL);
 }
 
-const char *get_convert_attr_ascii(const struct index_state *istate, const char *path)
+const char *get_convert_attr_ascii(struct index_state *istate, const char *path)
 {
 	struct conv_attrs ca;
 
@@ -1414,7 +1414,7 @@ const char *get_convert_attr_ascii(const struct index_state *istate, const char
 	return "";
 }
 
-int convert_to_git(const struct index_state *istate,
+int convert_to_git(struct index_state *istate,
 		   const char *path, const char *src, size_t len,
 		   struct strbuf *dst, int conv_flags)
 {
@@ -1448,7 +1448,7 @@ int convert_to_git(const struct index_state *istate,
 	return ret | ident_to_git(src, len, dst, ca.ident);
 }
 
-void convert_to_git_filter_fd(const struct index_state *istate,
+void convert_to_git_filter_fd(struct index_state *istate,
 			      const char *path, int fd, struct strbuf *dst,
 			      int conv_flags)
 {
@@ -1466,7 +1466,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	ident_to_git(dst->buf, dst->len, dst, ca.ident);
 }
 
-static int convert_to_working_tree_internal(const struct index_state *istate,
+static int convert_to_working_tree_internal(struct index_state *istate,
 					    const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing,
@@ -1510,7 +1510,7 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
 	return ret | ret_filter;
 }
 
-int async_convert_to_working_tree(const struct index_state *istate,
+int async_convert_to_working_tree(struct index_state *istate,
 				  const char *path, const char *src,
 				  size_t len, struct strbuf *dst,
 				  const struct checkout_metadata *meta,
@@ -1519,7 +1519,7 @@ int async_convert_to_working_tree(const struct index_state *istate,
 	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
 }
 
-int convert_to_working_tree(const struct index_state *istate,
+int convert_to_working_tree(struct index_state *istate,
 			    const char *path, const char *src,
 			    size_t len, struct strbuf *dst,
 			    const struct checkout_metadata *meta)
@@ -1527,7 +1527,7 @@ int convert_to_working_tree(const struct index_state *istate,
 	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, NULL);
 }
 
-int renormalize_buffer(const struct index_state *istate, const char *path,
+int renormalize_buffer(struct index_state *istate, const char *path,
 		       const char *src, size_t len, struct strbuf *dst)
 {
 	int ret = convert_to_working_tree_internal(istate, path, src, len, dst, 1, NULL, NULL);
@@ -1964,7 +1964,7 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
  * Note that you would be crazy to set CRLF, smudge/clean or ident to a
  * large binary blob you would want us not to slurp into the memory!
  */
-struct stream_filter *get_stream_filter(const struct index_state *istate,
+struct stream_filter *get_stream_filter(struct index_state *istate,
 					const char *path,
 					const struct object_id *oid)
 {
diff --git a/convert.h b/convert.h
index e29d1026a686..0f7c8a1f0446 100644
--- a/convert.h
+++ b/convert.h
@@ -65,41 +65,41 @@ struct checkout_metadata {
 
 extern enum eol core_eol;
 extern char *check_roundtrip_encoding;
-const char *get_cached_convert_stats_ascii(const struct index_state *istate,
+const char *get_cached_convert_stats_ascii(struct index_state *istate,
 					   const char *path);
 const char *get_wt_convert_stats_ascii(const char *path);
-const char *get_convert_attr_ascii(const struct index_state *istate,
+const char *get_convert_attr_ascii(struct index_state *istate,
 				   const char *path);
 
 /* returns 1 if *dst was used */
-int convert_to_git(const struct index_state *istate,
+int convert_to_git(struct index_state *istate,
 		   const char *path, const char *src, size_t len,
 		   struct strbuf *dst, int conv_flags);
-int convert_to_working_tree(const struct index_state *istate,
+int convert_to_working_tree(struct index_state *istate,
 			    const char *path, const char *src,
 			    size_t len, struct strbuf *dst,
 			    const struct checkout_metadata *meta);
-int async_convert_to_working_tree(const struct index_state *istate,
+int async_convert_to_working_tree(struct index_state *istate,
 				  const char *path, const char *src,
 				  size_t len, struct strbuf *dst,
 				  const struct checkout_metadata *meta,
 				  void *dco);
 int async_query_available_blobs(const char *cmd,
 				struct string_list *available_paths);
-int renormalize_buffer(const struct index_state *istate,
+int renormalize_buffer(struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *dst);
-static inline int would_convert_to_git(const struct index_state *istate,
+static inline int would_convert_to_git(struct index_state *istate,
 				       const char *path)
 {
 	return convert_to_git(istate, path, NULL, 0, NULL, 0);
 }
 /* Precondition: would_convert_to_git_filter_fd(path) == true */
-void convert_to_git_filter_fd(const struct index_state *istate,
+void convert_to_git_filter_fd(struct index_state *istate,
 			      const char *path, int fd,
 			      struct strbuf *dst,
 			      int conv_flags);
-int would_convert_to_git_filter_fd(const struct index_state *istate,
+int would_convert_to_git_filter_fd(struct index_state *istate,
 				   const char *path);
 
 /*
@@ -133,7 +133,7 @@ void reset_parsed_attributes(void);
 
 struct stream_filter; /* opaque */
 
-struct stream_filter *get_stream_filter(const struct index_state *istate,
+struct stream_filter *get_stream_filter(struct index_state *istate,
 					const char *path,
 					const struct object_id *);
 void free_stream_filter(struct stream_filter *);
diff --git a/dir.c b/dir.c
index fd8aa7c40faa..5b00dfb5b144 100644
--- a/dir.c
+++ b/dir.c
@@ -306,7 +306,7 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
  * [1] Only if DO_MATCH_DIRECTORY is passed; otherwise, this is NOT a match.
  * [2] Only if DO_MATCH_LEADING_PATHSPEC is passed; otherwise, not a match.
  */
-static int match_pathspec_item(const struct index_state *istate,
+static int match_pathspec_item(struct index_state *istate,
 			       const struct pathspec_item *item, int prefix,
 			       const char *name, int namelen, unsigned flags)
 {
@@ -429,7 +429,7 @@ static int match_pathspec_item(const struct index_state *istate,
  * pathspec did not match any names, which could indicate that the
  * user mistyped the nth pathspec.
  */
-static int do_match_pathspec(const struct index_state *istate,
+static int do_match_pathspec(struct index_state *istate,
 			     const struct pathspec *ps,
 			     const char *name, int namelen,
 			     int prefix, char *seen,
@@ -500,7 +500,7 @@ static int do_match_pathspec(const struct index_state *istate,
 	return retval;
 }
 
-static int match_pathspec_with_flags(const struct index_state *istate,
+static int match_pathspec_with_flags(struct index_state *istate,
 				     const struct pathspec *ps,
 				     const char *name, int namelen,
 				     int prefix, char *seen, unsigned flags)
@@ -516,7 +516,7 @@ static int match_pathspec_with_flags(const struct index_state *istate,
 	return negative ? 0 : positive;
 }
 
-int match_pathspec(const struct index_state *istate,
+int match_pathspec(struct index_state *istate,
 		   const struct pathspec *ps,
 		   const char *name, int namelen,
 		   int prefix, char *seen, int is_dir)
@@ -529,7 +529,7 @@ int match_pathspec(const struct index_state *istate,
 /**
  * Check if a submodule is a superset of the pathspec
  */
-int submodule_path_match(const struct index_state *istate,
+int submodule_path_match(struct index_state *istate,
 			 const struct pathspec *ps,
 			 const char *submodule_name,
 			 char *seen)
@@ -892,7 +892,7 @@ void add_pattern(const char *string, const char *base,
 	add_pattern_to_hashsets(pl, pattern);
 }
 
-static int read_skip_worktree_file_from_index(const struct index_state *istate,
+static int read_skip_worktree_file_from_index(struct index_state *istate,
 					      const char *path,
 					      size_t *size_out, char **data_out,
 					      struct oid_stat *oid_stat)
diff --git a/dir.h b/dir.h
index facfae47402a..51cb0e217247 100644
--- a/dir.h
+++ b/dir.h
@@ -354,7 +354,7 @@ int count_slashes(const char *s);
 int simple_length(const char *match);
 int no_wildcard(const char *string);
 char *common_prefix(const struct pathspec *pathspec);
-int match_pathspec(const struct index_state *istate,
+int match_pathspec(struct index_state *istate,
 		   const struct pathspec *pathspec,
 		   const char *name, int namelen,
 		   int prefix, char *seen, int is_dir);
@@ -492,12 +492,12 @@ int git_fnmatch(const struct pathspec_item *item,
 		const char *pattern, const char *string,
 		int prefix);
 
-int submodule_path_match(const struct index_state *istate,
+int submodule_path_match(struct index_state *istate,
 			 const struct pathspec *ps,
 			 const char *submodule_name,
 			 char *seen);
 
-static inline int ce_path_match(const struct index_state *istate,
+static inline int ce_path_match(struct index_state *istate,
 				const struct cache_entry *ce,
 				const struct pathspec *pathspec,
 				char *seen)
@@ -506,7 +506,7 @@ static inline int ce_path_match(const struct index_state *istate,
 			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
 }
 
-static inline int dir_path_match(const struct index_state *istate,
+static inline int dir_path_match(struct index_state *istate,
 				 const struct dir_entry *ent,
 				 const struct pathspec *pathspec,
 				 int prefix, char *seen)
diff --git a/merge-recursive.c b/merge-recursive.c
index 3d9207455b3a..b8de7a704eae 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2987,7 +2987,7 @@ static int blob_unchanged(struct merge_options *opt,
 	struct strbuf obuf = STRBUF_INIT;
 	struct strbuf abuf = STRBUF_INIT;
 	int ret = 0; /* assume changed for safety */
-	const struct index_state *idx = opt->repo->index;
+	struct index_state *idx = opt->repo->index;
 
 	if (a->mode != o->mode)
 		return 0;
diff --git a/pathspec.c b/pathspec.c
index 7a229d8d22f2..b6e333965cb4 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -20,7 +20,7 @@
  * to use find_pathspecs_matching_against_index() instead.
  */
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
-					const struct index_state *istate,
+					struct index_state *istate,
 					char *seen)
 {
 	int num_unmatched = 0, i;
@@ -51,7 +51,7 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
  * given pathspecs achieves against all items in the index.
  */
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate)
+					    struct index_state *istate)
 {
 	char *seen = xcalloc(pathspec->nr, 1);
 	add_pathspec_matches_against_index(pathspec, istate, seen);
@@ -702,7 +702,7 @@ void clear_pathspec(struct pathspec *pathspec)
 	pathspec->nr = 0;
 }
 
-int match_pathspec_attrs(const struct index_state *istate,
+int match_pathspec_attrs(struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item)
 {
diff --git a/pathspec.h b/pathspec.h
index 454ce364fac7..2ccc8080b6cc 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -150,11 +150,11 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 }
 
 void add_pathspec_matches_against_index(const struct pathspec *pathspec,
-					const struct index_state *istate,
+					struct index_state *istate,
 					char *seen);
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
-					    const struct index_state *istate);
-int match_pathspec_attrs(const struct index_state *istate,
+					    struct index_state *istate);
+int match_pathspec_attrs(struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
 
diff --git a/read-cache.c b/read-cache.c
index b9c08773466c..dfec221d9128 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -548,7 +548,7 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
 	return 0;
 }
 
-static int index_name_stage_pos(const struct index_state *istate, const char *name, int namelen, int stage)
+static int index_name_stage_pos(struct index_state *istate, const char *name, int namelen, int stage)
 {
 	int first, last;
 
@@ -569,7 +569,7 @@ static int index_name_stage_pos(const struct index_state *istate, const char *na
 	return -first-1;
 }
 
-int index_name_pos(const struct index_state *istate, const char *name, int namelen)
+int index_name_pos(struct index_state *istate, const char *name, int namelen)
 {
 	return index_name_stage_pos(istate, name, namelen, 0);
 }
@@ -3380,8 +3380,8 @@ int repo_read_index_unmerged(struct repository *repo)
  * We helpfully remove a trailing "/" from directories so that
  * the output of read_directory can be used as-is.
  */
-int index_name_is_other(const struct index_state *istate, const char *name,
-		int namelen)
+int index_name_is_other(struct index_state *istate, const char *name,
+			int namelen)
 {
 	int pos;
 	if (namelen && name[namelen - 1] == '/')
@@ -3399,7 +3399,7 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 	return 1;
 }
 
-void *read_blob_data_from_index(const struct index_state *istate,
+void *read_blob_data_from_index(struct index_state *istate,
 				const char *path, unsigned long *size)
 {
 	int pos, len;
diff --git a/submodule.c b/submodule.c
index 9767ba9893cc..83809a4f7bd2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -33,7 +33,7 @@ static struct oid_array ref_tips_after_fetch;
  * will be disabled because we can't guess what might be configured in
  * .gitmodules unless the user resolves the conflict.
  */
-int is_gitmodules_unmerged(const struct index_state *istate)
+int is_gitmodules_unmerged(struct index_state *istate)
 {
 	int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
 	if (pos < 0) { /* .gitmodules not found or isn't merged */
@@ -301,7 +301,7 @@ int is_submodule_populated_gently(const char *path, int *return_error_code)
 /*
  * Dies if the provided 'prefix' corresponds to an unpopulated submodule
  */
-void die_in_unpopulated_submodule(const struct index_state *istate,
+void die_in_unpopulated_submodule(struct index_state *istate,
 				  const char *prefix)
 {
 	int i, prefixlen;
@@ -331,7 +331,7 @@ void die_in_unpopulated_submodule(const struct index_state *istate,
 /*
  * Dies if any paths in the provided pathspec descends into a submodule
  */
-void die_path_inside_submodule(const struct index_state *istate,
+void die_path_inside_submodule(struct index_state *istate,
 			       const struct pathspec *ps)
 {
 	int i, j;
diff --git a/submodule.h b/submodule.h
index 4ac6e31cf1f7..84640c49c114 100644
--- a/submodule.h
+++ b/submodule.h
@@ -39,7 +39,7 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
-int is_gitmodules_unmerged(const struct index_state *istate);
+int is_gitmodules_unmerged(struct index_state *istate);
 int is_writing_gitmodules_ok(void);
 int is_staging_gitmodules_ok(struct index_state *istate);
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
@@ -60,9 +60,9 @@ int is_submodule_active(struct repository *repo, const char *path);
  * Otherwise the return error code is the same as of resolve_gitdir_gently.
  */
 int is_submodule_populated_gently(const char *path, int *return_error_code);
-void die_in_unpopulated_submodule(const struct index_state *istate,
+void die_in_unpopulated_submodule(struct index_state *istate,
 				  const char *prefix);
-void die_path_inside_submodule(const struct index_state *istate,
+void die_path_inside_submodule(struct index_state *istate,
 			       const struct pathspec *ps);
 enum submodule_update_type parse_submodule_update_type(const char *value);
 int parse_submodule_update_strategy(const char *value,
-- 
gitgitgadget

