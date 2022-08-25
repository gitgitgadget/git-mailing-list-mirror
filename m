Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF75ECAA24
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 17:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiHYRKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 13:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242191AbiHYRKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 13:10:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A3B1116
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 10:09:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso3076066wmc.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1XUqulEAbfuanF9HTI7rgd+yjZP8NSS4WojtocDKMP8=;
        b=ciBbEyHeazBd1TyzANIYrxgPd3RzAxrBKQmDSHjfPuAWvNwNKAecb12ndyMqL8xqzN
         oF81h419wjM1S4M8EHT/g0R8HyMW+qoblQ62FrYgGu7jqQEUMqhHP+oIZscV/nd8+LeN
         vsQVie04w7Dks4vdNEoUfANbHmbiBaHQFUzVJ0DinujC0oFfOJRAEFKiv9WfD6bTAfcb
         CcoA+GY1giCdWdZvfebBryNO6waNSsVnYcZMB69J64ENeZFb/+lDHcaKQLYmW7fYYxpL
         2rAf0pQCdArBBfIFM49jqb2Kt6xeWCzoMzT1WxKZ1yhTS1NK3rIn2ONXtmsACXOU8sSC
         8RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1XUqulEAbfuanF9HTI7rgd+yjZP8NSS4WojtocDKMP8=;
        b=JY5d8dEvAS5R6w5b8EWJOY+KlCkplWx+49fxSNlkIaZUHg1imx8molkQ46tYqStQ3A
         oxkthXiI8U3xVGbTBqmNCLnTAYEsdnUEE8jwv/c1t6Ro8JyHqwAkKJlG5Q8THX2YD1g0
         9vvIhMVd/7RP5DjHbuYoll+X9GTSf4eQeGr8OtYZZYHs6FFvd9Q2/G2mV8x+9RV+KcTk
         qJDrY/mnNAamnL2HRu6siiE06EiwuriugPm1mX1eB2fGULlf2ji4ZAttNcgup4pH7lRR
         ZgUu2IYLsSeKpxR7uUqJpHa+3Lprp5c4Ad7nmeUuGxUCfLUuL9wuCGwEGrhuERjUpRhT
         Nbow==
X-Gm-Message-State: ACgBeo0tqM9NkbDxb5hFuUUpJ01uCbHgSExS/Fcgk93uYPmm5qtIzcI1
        dCCW3HaPjy++wgd2ogDzQm74Ay1KpRuKMA==
X-Google-Smtp-Source: AA6agR4ufEBzVeA5pauPbsBhgOGDfqAeCV2s0C3Tau51bhC22coyLVI3D2ldqse3PvY8YwxtnHdDFA==
X-Received: by 2002:a1c:2905:0:b0:3a6:2c63:14d with SMTP id p5-20020a1c2905000000b003a62c63014dmr2918061wmp.36.1661447393437;
        Thu, 25 Aug 2022 10:09:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bt4-20020a056000080400b0022583786cd9sm1583810wrb.111.2022.08.25.10.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:09:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] git-compat-util.h: use "UNUSED", not "UNUSED(var)"
Date:   Thu, 25 Aug 2022 19:09:48 +0200
Message-Id: <patch-1.2-b99c08903ad-20220825T170709Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g8741a0e3ea3
In-Reply-To: <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>
References: <xmqq1qt4486e.fsf@gitster.g> <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported in [1] the "UNUSED(var)" macro introduced in
2174b8c75de (Merge branch 'jk/unused-annotation' into next,
2022-08-24) breaks coccinelle's parsing of our sources in files where
it occurs.

Let's instead partially go with the approach suggested in [2] of
making this not take an argument. As noted in [1] "coccinelle" will
ignore such tokens in argument lists that it doesn't know about, and
it's less of a surprise to syntax highlighters.

This undoes the "help us notice when a parameter marked as unused is
actually use" part of 9b240347543 (git-compat-util: add UNUSED macro,
2022-08-19), a subsequent commit will further tweak the macro to
implement a replacement for that functionality.

1. https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220819.868rnk54ju.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c           |  2 +-
 archive-tar.c               |  4 ++--
 archive-zip.c               |  4 ++--
 archive.c                   |  2 +-
 attr.c                      |  4 ++--
 bisect.c                    |  6 +++---
 bloom.c                     |  4 ++--
 builtin/am.c                |  2 +-
 builtin/bisect--helper.c    | 12 ++++++------
 builtin/checkout.c          |  4 ++--
 builtin/commit-graph.c      |  2 +-
 builtin/config.c            |  6 +++---
 builtin/describe.c          |  4 ++--
 builtin/difftool.c          | 10 +++++-----
 builtin/fast-export.c       |  2 +-
 builtin/fast-import.c       |  2 +-
 builtin/fetch.c             |  8 ++++----
 builtin/fsck.c              | 12 ++++++------
 builtin/gc.c                |  4 ++--
 builtin/log.c               |  4 ++--
 builtin/ls-tree.c           | 10 +++++-----
 builtin/multi-pack-index.c  |  2 +-
 builtin/name-rev.c          |  2 +-
 builtin/pack-objects.c      | 12 ++++++------
 builtin/receive-pack.c      |  4 ++--
 builtin/reflog.c            |  4 ++--
 builtin/remote.c            | 14 +++++++-------
 builtin/repack.c            |  4 ++--
 builtin/rev-parse.c         |  4 ++--
 builtin/show-branch.c       |  6 +++---
 builtin/show-ref.c          |  6 +++---
 builtin/stash.c             | 12 ++++++------
 builtin/submodule--helper.c |  4 ++--
 color.c                     |  2 +-
 commit-graph.c              |  4 ++--
 commit.c                    |  6 +++---
 compat/terminal.c           |  2 +-
 config.c                    |  8 ++++----
 convert.c                   |  4 ++--
 delta-islands.c             |  4 ++--
 diff.c                      |  4 ++--
 dir.c                       |  4 ++--
 environment.c               |  4 ++--
 fetch-pack.c                | 12 ++++++------
 git-compat-util.h           | 12 ++++++------
 gpg-interface.c             |  2 +-
 hashmap.c                   | 10 +++++-----
 help.c                      |  4 ++--
 http-backend.c              |  2 +-
 ident.c                     |  2 +-
 ll-merge.c                  |  2 +-
 log-tree.c                  |  2 +-
 ls-refs.c                   |  2 +-
 merge-recursive.c           | 12 ++++++------
 name-hash.c                 |  4 ++--
 negotiator/default.c        |  4 ++--
 negotiator/skipping.c       |  4 ++--
 notes.c                     |  4 ++--
 object-name.c               | 12 ++++++------
 object-store.h              |  2 +-
 oidmap.c                    |  2 +-
 packfile.c                  |  2 +-
 pager.c                     |  2 +-
 patch-ids.c                 |  2 +-
 pretty.c                    |  2 +-
 range-diff.c                |  2 +-
 ref-filter.c                |  2 +-
 reflog.c                    | 18 +++++++++---------
 refs.c                      | 12 ++++++------
 refs/files-backend.c        | 14 +++++++-------
 refs/iterator.c             |  6 +++---
 refs/packed-backend.c       | 16 ++++++++--------
 remote.c                    | 24 ++++++++++++------------
 replace-object.c            |  4 ++--
 revision.c                  | 18 +++++++++---------
 send-pack.c                 |  2 +-
 sequencer.c                 |  4 ++--
 server-info.c               |  2 +-
 shallow.c                   | 10 +++++-----
 strbuf.c                    |  2 +-
 streaming.c                 |  6 +++---
 strmap.c                    |  4 ++--
 sub-process.c               |  4 ++--
 submodule-config.c          |  8 ++++----
 submodule.c                 | 12 ++++++------
 t/helper/test-config.c      |  2 +-
 t/helper/test-ref-store.c   |  4 ++--
 t/helper/test-userdiff.c    |  2 +-
 trailer.c                   |  4 ++--
 transport.c                 |  2 +-
 upload-pack.c               |  6 +++---
 walker.c                    |  6 +++---
 wt-status.c                 | 16 ++++++++--------
 93 files changed, 269 insertions(+), 269 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 2fcad676544..f071b2a1b4f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -430,7 +430,7 @@ struct pathname_entry {
 	struct file_item *item;
 };
 
-static int pathname_entry_cmp(const void *UNUSED(cmp_data),
+static int pathname_entry_cmp(const void *cmp_data UNUSED,
 			      const struct hashmap_entry *he1,
 			      const struct hashmap_entry *he2,
 			      const void *name)
diff --git a/archive-tar.c b/archive-tar.c
index 0d66a1e0a85..3e4822b6840 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -367,7 +367,7 @@ static struct archiver *find_tar_filter(const char *name, size_t len)
 }
 
 static int tar_filter_config(const char *var, const char *value,
-			     void *UNUSED(data))
+			     void *data UNUSED)
 {
 	struct archiver *ar;
 	const char *name;
@@ -421,7 +421,7 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 	return tar_filter_config(var, value, cb);
 }
 
-static int write_tar_archive(const struct archiver *UNUSED(ar),
+static int write_tar_archive(const struct archiver *ar UNUSED,
 			     struct archiver_args *args)
 {
 	int err = 0;
diff --git a/archive-zip.c b/archive-zip.c
index d63782dc31b..0456f1ebf15 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -613,12 +613,12 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 }
 
 static int archive_zip_config(const char *var, const char *value,
-			      void *UNUSED(data))
+			      void *data UNUSED)
 {
 	return userdiff_config(var, value);
 }
 
-static int write_zip_archive(const struct archiver *UNUSED(ar),
+static int write_zip_archive(const struct archiver *ar UNUSED,
 			     struct archiver_args *args)
 {
 	int err;
diff --git a/archive.c b/archive.c
index 8b165e935bd..61a79e4a227 100644
--- a/archive.c
+++ b/archive.c
@@ -382,7 +382,7 @@ struct path_exists_context {
 	struct archiver_args *args;
 };
 
-static int reject_entry(const struct object_id *UNUSED(oid),
+static int reject_entry(const struct object_id *oid UNUSED,
 			struct strbuf *base,
 			const char *filename, unsigned mode,
 			void *context)
diff --git a/attr.c b/attr.c
index 375b5c0dbf7..0b599334dd8 100644
--- a/attr.c
+++ b/attr.c
@@ -61,10 +61,10 @@ struct attr_hash_entry {
 };
 
 /* attr_hashmap comparison function */
-static int attr_hash_entry_cmp(const void *UNUSED(cmp_data),
+static int attr_hash_entry_cmp(const void *cmp_data UNUSED,
 			       const struct hashmap_entry *eptr,
 			       const struct hashmap_entry *entry_or_key,
-			       const void *UNUSED(keydata))
+			       const void *keydata UNUSED)
 {
 	const struct attr_hash_entry *a, *b;
 
diff --git a/bisect.c b/bisect.c
index 07ccd1bce61..fd581b85a72 100644
--- a/bisect.c
+++ b/bisect.c
@@ -441,7 +441,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 }
 
 static int register_ref(const char *refname, const struct object_id *oid,
-			int UNUSED(flags), void *UNUSED(cb_data))
+			int flags UNUSED, void *cb_data UNUSED)
 {
 	struct strbuf good_prefix = STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
@@ -1161,8 +1161,8 @@ int estimate_bisect_steps(int all)
 }
 
 static int mark_for_removal(const char *refname,
-			    const struct object_id *UNUSED(oid),
-			    int UNUSED(flag), void *cb_data)
+			    const struct object_id *oid UNUSED,
+			    int flag UNUSED, void *cb_data)
 {
 	struct string_list *refs = cb_data;
 	char *ref = xstrfmt("refs/bisect%s", refname);
diff --git a/bloom.c b/bloom.c
index 94fb97e60ed..d0730525da5 100644
--- a/bloom.c
+++ b/bloom.c
@@ -163,10 +163,10 @@ void init_bloom_filters(void)
 	init_bloom_filter_slab(&bloom_filters);
 }
 
-static int pathmap_cmp(const void *UNUSED(hashmap_cmp_fn_data),
+static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 		       const struct hashmap_entry *eptr,
 		       const struct hashmap_entry *entry_or_key,
-		       const void *UNUSED(keydata))
+		       const void *keydata UNUSED)
 {
 	const struct pathmap_hash_entry *e1, *e2;
 
diff --git a/builtin/am.c b/builtin/am.c
index 0811b9ff676..39fea248330 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2301,7 +2301,7 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 	return 0;
 }
 
-static int git_am_config(const char *k, const char *v, void *UNUSED(cb))
+static int git_am_config(const char *k, const char *v, void *cb UNUSED)
 {
 	int status;
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 87c8b2d818b..aa975bd9268 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -329,9 +329,9 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 	return 0;
 }
 
-static int inc_nr(const char *UNUSED(refname),
-		  const struct object_id *UNUSED(oid),
-		  int UNUSED(flag), void *cb_data)
+static int inc_nr(const char *refname UNUSED,
+		  const struct object_id *oid UNUSED,
+		  int flag UNUSED, void *cb_data)
 {
 	unsigned int *nr = (unsigned int *)cb_data;
 	(*nr)++;
@@ -519,7 +519,7 @@ static int bisect_append_log_quoted(const char **argv)
 }
 
 static int add_bisect_ref(const char *refname, const struct object_id *oid,
-			  int UNUSED(flags), void *cb)
+			  int flags UNUSED, void *cb)
 {
 	struct add_bisect_ref_data *data = cb;
 
@@ -1135,9 +1135,9 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
 	return res;
 }
 
-static int get_first_good(const char *UNUSED(refname),
+static int get_first_good(const char *refname UNUSED,
 			  const struct object_id *oid,
-			  int UNUSED(flag), void *cb_data)
+			  int flag UNUSED, void *cb_data)
 {
 	oidcpy(cb_data, oid);
 	return 1;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d18c8c886e9..2a132392fbe 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -125,7 +125,7 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
-		       const char *pathname, unsigned mode, void *UNUSED(context))
+		       const char *pathname, unsigned mode, void *context UNUSED)
 {
 	int len;
 	struct cache_entry *ce;
@@ -990,7 +990,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 static int add_pending_uninteresting_ref(const char *refname,
 					 const struct object_id *oid,
-					 int UNUSED(flags), void *cb_data)
+					 int flags UNUSED, void *cb_data)
 {
 	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
 	return 0;
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ea923ea33ad..aaa1b5b9600 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -179,7 +179,7 @@ static int write_option_max_new_filters(const struct option *opt,
 }
 
 static int git_commit_graph_write_config(const char *var, const char *value,
-					 void *UNUSED(cb))
+					 void *cb UNUSED)
 {
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
 		write_opts.max_new_filters = git_config_int(var, value);
diff --git a/builtin/config.c b/builtin/config.c
index bdc8b1d1a89..753e5fac297 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -208,7 +208,7 @@ static void show_config_scope(struct strbuf *buf)
 }
 
 static int show_all_config(const char *key_, const char *value_,
-			   void *UNUSED(cb))
+			   void *cb UNUSED)
 {
 	if (show_origin || show_scope) {
 		struct strbuf buf = STRBUF_INIT;
@@ -460,7 +460,7 @@ static const char *get_colorbool_slot;
 static char parsed_color[COLOR_MAXLEN];
 
 static int git_get_color_config(const char *var, const char *value,
-				void *UNUSED(cb))
+				void *cb UNUSED)
 {
 	if (!strcmp(var, get_color_slot)) {
 		if (!value)
@@ -492,7 +492,7 @@ static int get_colorbool_found;
 static int get_diff_color_found;
 static int get_color_ui_found;
 static int git_get_colorbool_config(const char *var, const char *value,
-				    void *UNUSED(data))
+				    void *data UNUSED)
 {
 	if (!strcmp(var, get_colorbool_slot))
 		get_colorbool_found = git_config_colorbool(var, value);
diff --git a/builtin/describe.c b/builtin/describe.c
index 084fa00f2a5..e17c4b4c69b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -63,7 +63,7 @@ static const char *prio_names[] = {
 	N_("head"), N_("lightweight"), N_("annotated"),
 };
 
-static int commit_name_neq(const void *UNUSED(cmp_data),
+static int commit_name_neq(const void *cmp_data UNUSED,
 			   const struct hashmap_entry *eptr,
 			   const struct hashmap_entry *entry_or_key,
 			   const void *peeled)
@@ -141,7 +141,7 @@ static void add_to_known_names(const char *path,
 }
 
 static int get_name(const char *path, const struct object_id *oid,
-		    int UNUSED(flag), void *UNUSED(cb_data))
+		    int flag UNUSED, void *cb_data UNUSED)
 {
 	int is_tag = 0;
 	struct object_id peeled;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index a570200e66a..f780ebfd55f 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -125,10 +125,10 @@ struct working_tree_entry {
 	char path[FLEX_ARRAY];
 };
 
-static int working_tree_entry_cmp(const void *UNUSED(cmp_data),
+static int working_tree_entry_cmp(const void *cmp_data UNUSED,
 				  const struct hashmap_entry *eptr,
 				  const struct hashmap_entry *entry_or_key,
-				  const void *UNUSED(keydata))
+				  const void *keydata UNUSED)
 {
 	const struct working_tree_entry *a, *b;
 
@@ -148,10 +148,10 @@ struct pair_entry {
 	const char path[FLEX_ARRAY];
 };
 
-static int pair_cmp(const void *UNUSED(cmp_data),
+static int pair_cmp(const void *cmp_data UNUSED,
 		    const struct hashmap_entry *eptr,
 		    const struct hashmap_entry *entry_or_key,
-		    const void *UNUSED(keydata))
+		    const void *keydata UNUSED)
 {
 	const struct pair_entry *a, *b;
 
@@ -184,7 +184,7 @@ struct path_entry {
 	char path[FLEX_ARRAY];
 };
 
-static int path_entry_cmp(const void *UNUSED(cmp_data),
+static int path_entry_cmp(const void *cmp_data UNUSED,
 			  const struct hashmap_entry *eptr,
 			  const struct hashmap_entry *entry_or_key,
 			  const void *key)
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index bb05b50a5a0..ab5b0ff610a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -119,7 +119,7 @@ struct anonymized_entry_key {
 	size_t orig_len;
 };
 
-static int anonymized_entry_cmp(const void *UNUSED(cmp_data),
+static int anonymized_entry_cmp(const void *cmp_data UNUSED,
 				const struct hashmap_entry *eptr,
 				const struct hashmap_entry *entry_or_key,
 				const void *keydata)
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 76ed0c2db9c..7134683ab93 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -46,7 +46,7 @@ struct object_entry {
 		depth : DEPTH_BITS;
 };
 
-static int object_entry_hashcmp(const void *UNUSED(map_data),
+static int object_entry_hashcmp(const void *map_data UNUSED,
 				const struct hashmap_entry *eptr,
 				const struct hashmap_entry *entry_or_key,
 				const void *keydata)
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5fddaef4804..7f5b0f4c2a3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -301,7 +301,7 @@ struct refname_hash_entry {
 	char refname[FLEX_ARRAY];
 };
 
-static int refname_hash_entry_cmp(const void *UNUSED(hashmap_cmp_fn_data),
+static int refname_hash_entry_cmp(const void *hashmap_cmp_fn_data UNUSED,
 				  const struct hashmap_entry *eptr,
 				  const struct hashmap_entry *entry_or_key,
 				  const void *keydata)
@@ -329,7 +329,7 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 
 static int add_one_refname(const char *refname,
 			   const struct object_id *oid,
-			   int UNUSED(flag), void *cbdata)
+			   int flag UNUSED, void *cbdata)
 {
 	struct hashmap *refname_map = cbdata;
 
@@ -1462,9 +1462,9 @@ static void set_option(struct transport *transport, const char *name, const char
 }
 
 
-static int add_oid(const char *UNUSED(refname),
+static int add_oid(const char *refname UNUSED,
 		   const struct object_id *oid,
-		   int UNUSED(flags), void *cb_data)
+		   int flags UNUSED, void *cb_data)
 {
 	struct oid_array *oids = cb_data;
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 31d3da8954b..f7916f06ed5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -488,9 +488,9 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 }
 
 static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				  const char *UNUSED(email),
-				  timestamp_t timestamp, int UNUSED(tz),
-				  const char *UNUSED(message), void *cb_data)
+				  const char *email UNUSED,
+				  timestamp_t timestamp, int tz UNUSED,
+				  const char *message UNUSED, void *cb_data)
 {
 	const char *refname = cb_data;
 
@@ -504,8 +504,8 @@ static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid
 }
 
 static int fsck_handle_reflog(const char *logname,
-			      const struct object_id *UNUSED(oid),
-			      int UNUSED(flag), void *cb_data)
+			      const struct object_id *oid UNUSED,
+			      int flag UNUSED, void *cb_data)
 {
 	struct strbuf refname = STRBUF_INIT;
 
@@ -516,7 +516,7 @@ static int fsck_handle_reflog(const char *logname,
 }
 
 static int fsck_handle_ref(const char *refname, const struct object_id *oid,
-			   int UNUSED(flag), void *UNUSED(cb_data))
+			   int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object *obj;
 
diff --git a/builtin/gc.c b/builtin/gc.c
index e4ede128c92..2d093211855 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -782,9 +782,9 @@ struct cg_auto_data {
 	int limit;
 };
 
-static int dfs_on_ref(const char *UNUSED(refname),
+static int dfs_on_ref(const char *refname UNUSED,
 		      const struct object_id *oid,
-		      int UNUSED(flags),
+		      int flags UNUSED,
 		      void *cb_data)
 {
 	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
diff --git a/builtin/log.c b/builtin/log.c
index 79a2e4d0bbb..3f9a6e8cf20 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -645,8 +645,8 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 	return 0;
 }
 
-static int show_tree_object(const struct object_id *UNUSED(oid),
-			    struct strbuf *UNUSED(base),
+static int show_tree_object(const struct object_id *oid UNUSED,
+			    struct strbuf *base UNUSED,
 			    const char *pathname, unsigned mode,
 			    void *context)
 {
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 48df337605f..c3ea09281af 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -142,7 +142,7 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 }
 
 static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
-			 const char *pathname, unsigned mode, void *UNUSED(context))
+			 const char *pathname, unsigned mode, void *context UNUSED)
 {
 	size_t baselen;
 	int recurse = 0;
@@ -213,7 +213,7 @@ static void show_tree_common_default_long(struct strbuf *base,
 
 static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 			     const char *pathname, unsigned mode,
-			     void *UNUSED(context))
+			     void *context UNUSED)
 {
 	int early;
 	int recurse;
@@ -231,7 +231,7 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 
 static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 			  const char *pathname, unsigned mode,
-			  void *UNUSED(context))
+			  void *context UNUSED)
 {
 	int early;
 	int recurse;
@@ -261,7 +261,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 
 static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 			       const char *pathname, unsigned mode,
-			       void *UNUSED(context))
+			       void *context UNUSED)
 {
 	int early;
 	int recurse;
@@ -282,7 +282,7 @@ static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 
 static int show_tree_object(const struct object_id *oid, struct strbuf *base,
 			    const char *pathname, unsigned mode,
-			    void *UNUSED(context))
+			    void *context UNUSED)
 {
 	int early;
 	int recurse;
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 8d156766afe..b3a3f0a571a 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -78,7 +78,7 @@ static struct option *add_common_options(struct option *prev)
 }
 
 static int git_multi_pack_index_write_config(const char *var, const char *value,
-					     void *UNUSED(cb))
+					     void *cb UNUSED)
 {
 	if (!strcmp(var, "pack.writebitmaphashcache")) {
 		if (git_config_bool(var, value))
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c4dc143c4b7..15535e914a6 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -345,7 +345,7 @@ static int cmp_by_tag_and_age(const void *a_, const void *b_)
 }
 
 static int name_ref(const char *path, const struct object_id *oid,
-		    int UNUSED(flags), void *cb_data)
+		    int flags UNUSED, void *cb_data)
 {
 	struct object *o = parse_object(the_repository, oid);
 	struct name_ref_data *data = cb_data;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index eb93e5c8fe9..8fd2794a324 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -759,8 +759,8 @@ static enum write_one_status write_one(struct hashfile *f,
 	return WRITE_ONE_WRITTEN;
 }
 
-static int mark_tagged(const char *UNUSED(path), const struct object_id *oid,
-		       int UNUSED(flag), void *UNUSED(cb_data))
+static int mark_tagged(const char *path UNUSED, const struct object_id *oid,
+		       int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id peeled;
 	struct object_entry *entry = packlist_find(&to_pack, oid);
@@ -3035,8 +3035,8 @@ static void add_tag_chain(const struct object_id *oid)
 	}
 }
 
-static int add_ref_tag(const char *UNUSED(tag), const struct object_id *oid,
-		       int UNUSED(flag), void *UNUSED(cb_data))
+static int add_ref_tag(const char *tag UNUSED, const struct object_id *oid,
+		       int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id peeled;
 
@@ -3952,8 +3952,8 @@ static void record_recent_commit(struct commit *commit, void *data)
 
 static int mark_bitmap_preferred_tip(const char *refname,
 				     const struct object_id *oid,
-				     int UNUSED(flags),
-				     void *UNUSED(data))
+				     int flags UNUSED,
+				     void *data UNUSED)
 {
 	struct object_id peeled;
 	struct object *object;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6882d526e67..44bcea3a5b3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -291,7 +291,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 }
 
 static int show_ref_cb(const char *path_full, const struct object_id *oid,
-		       int UNUSED(flag), void *data)
+		       int flag UNUSED, void *data)
 {
 	struct oidset *seen = data;
 	const char *path = strip_namespace(path_full);
@@ -465,7 +465,7 @@ static void rp_error(const char *err, ...)
 	va_end(params);
 }
 
-static int copy_to_sideband(int in, int UNUSED(out), void *UNUSED(arg))
+static int copy_to_sideband(int in, int out UNUSED, void *arg UNUSED)
 {
 	char data[128];
 	int keepalive_active = 0;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 63f9a233571..8f2da0b65b9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -56,8 +56,8 @@ struct worktree_reflogs {
 	struct string_list reflogs;
 };
 
-static int collect_reflog(const char *ref, const struct object_id *UNUSED(oid),
-			  int UNUSED(flags), void *cb_data)
+static int collect_reflog(const char *ref, const struct object_id *oid UNUSED,
+			  int flags UNUSED, void *cb_data)
 {
 	struct worktree_reflogs *cb = cb_data;
 	struct worktree *worktree = cb->worktree;
diff --git a/builtin/remote.c b/builtin/remote.c
index 87dda7c37bd..24cd809d240 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -265,7 +265,7 @@ static const char *abbrev_ref(const char *name, const char *prefix)
 #define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
 
 static int config_read_branches(const char *key, const char *value,
-				void *UNUSED(data))
+				void *data UNUSED)
 {
 	const char *orig_key = key;
 	char *name;
@@ -539,8 +539,8 @@ struct branches_for_remote {
 };
 
 static int add_branch_for_removal(const char *refname,
-				  const struct object_id *UNUSED(oid),
-				  int UNUSED(flags), void *cb_data)
+				  const struct object_id *oid UNUSED,
+				  int flags UNUSED, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec_item refspec;
@@ -582,8 +582,8 @@ struct rename_info {
 };
 
 static int read_remote_branches(const char *refname,
-				const struct object_id *UNUSED(oid),
-				int UNUSED(flags), void *cb_data)
+				const struct object_id *oid UNUSED,
+				int flags UNUSED, void *cb_data)
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf buf = STRBUF_INIT;
@@ -956,7 +956,7 @@ static void free_remote_ref_states(struct ref_states *states)
 }
 
 static int append_ref_to_tracked_list(const char *refname,
-				      const struct object_id *UNUSED(oid),
+				      const struct object_id *oid UNUSED,
 				      int flags, void *cb_data)
 {
 	struct ref_states *states = cb_data;
@@ -1486,7 +1486,7 @@ static int prune(int argc, const char **argv)
 	return result;
 }
 
-static int get_remote_default(const char *key, const char *UNUSED(value), void *priv)
+static int get_remote_default(const char *key, const char *value UNUSED, void *priv)
 {
 	if (strcmp(key, "remotes.default") == 0) {
 		int *found = priv;
diff --git a/builtin/repack.c b/builtin/repack.c
index ff952dec48d..a5bacc77974 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -514,9 +514,9 @@ struct midx_snapshot_ref_data {
 	int preferred;
 };
 
-static int midx_snapshot_ref_one(const char *UNUSED(refname),
+static int midx_snapshot_ref_one(const char *refname UNUSED,
 				 const struct object_id *oid,
-				 int UNUSED(flag), void *_data)
+				 int flag UNUSED, void *_data)
 {
 	struct midx_snapshot_ref_data *data = _data;
 	struct object_id peeled;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 3c448d438bc..e5d70ee6d2d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -196,7 +196,7 @@ static int show_default(void)
 }
 
 static int show_reference(const char *refname, const struct object_id *oid,
-			  int UNUSED(flag), void *UNUSED(cb_data))
+			  int flag UNUSED, void *cb_data UNUSED)
 {
 	if (ref_excluded(ref_excludes, refname))
 		return 0;
@@ -205,7 +205,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 }
 
 static int anti_reference(const char *refname, const struct object_id *oid,
-			  int UNUSED(flag), void *UNUSED(cb_data))
+			  int flag UNUSED, void *cb_data UNUSED)
 {
 	show_rev(REVERSED, oid, refname);
 	return 0;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 3ec011bea43..d3f5715e3e3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -404,7 +404,7 @@ static int append_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_head_ref(const char *refname, const struct object_id *oid,
-			   int UNUSED(flag), void *UNUSED(cb_data))
+			   int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id tmp;
 	int ofs = 11;
@@ -419,7 +419,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_remote_ref(const char *refname, const struct object_id *oid,
-			     int UNUSED(flag), void *UNUSED(cb_data))
+			     int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id tmp;
 	int ofs = 13;
@@ -434,7 +434,7 @@ static int append_remote_ref(const char *refname, const struct object_id *oid,
 }
 
 static int append_tag_ref(const char *refname, const struct object_id *oid,
-			  int UNUSED(flag), void *UNUSED(cb_data))
+			  int flag UNUSED, void *cb_data UNUSED)
 {
 	if (!starts_with(refname, "refs/tags/"))
 		return 0;
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 97465372200..48569061087 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -47,7 +47,7 @@ static void show_one(const char *refname, const struct object_id *oid)
 }
 
 static int show_ref(const char *refname, const struct object_id *oid,
-		    int UNUSED(flag), void *UNUSED(cbdata))
+		    int flag UNUSED, void *cbdata UNUSED)
 {
 	if (show_head && !strcmp(refname, "HEAD"))
 		goto match;
@@ -78,8 +78,8 @@ static int show_ref(const char *refname, const struct object_id *oid,
 }
 
 static int add_existing(const char *refname,
-			const struct object_id *UNUSED(oid),
-			int UNUSED(flag), void *cbdata)
+			const struct object_id *oid UNUSED,
+			int flag UNUSED, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	string_list_insert(list, refname);
diff --git a/builtin/stash.c b/builtin/stash.c
index a741b920b32..3492aff751a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -638,12 +638,12 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int reject_reflog_ent(struct object_id *UNUSED(ooid),
-			     struct object_id *UNUSED(noid),
-			     const char *UNUSED(email),
-			     timestamp_t UNUSED(timestamp),
-			     int UNUSED(tz), const char *UNUSED(message),
-			     void *UNUSED(cb_data))
+static int reject_reflog_ent(struct object_id *ooid UNUSED,
+			     struct object_id *noid UNUSED,
+			     const char *email UNUSED,
+			     timestamp_t timestamp UNUSED,
+			     int tz UNUSED, const char *message UNUSED,
+			     void *cb_data UNUSED)
 {
 	return 1;
 }
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e24e721458d..88df6c5017d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -622,9 +622,9 @@ static void print_status(unsigned int flags, char state, const char *path,
 	printf("\n");
 }
 
-static int handle_submodule_head_ref(const char *UNUSED(refname),
+static int handle_submodule_head_ref(const char *refname UNUSED,
 				     const struct object_id *oid,
-				     int UNUSED(flags),
+				     int flags UNUSED,
 				     void *cb_data)
 {
 	struct object_id *output = cb_data;
diff --git a/color.c b/color.c
index 04ad0a8bf75..f05d8a81d72 100644
--- a/color.c
+++ b/color.c
@@ -415,7 +415,7 @@ int want_color_fd(int fd, int var)
 	return var;
 }
 
-int git_color_config(const char *var, const char *value, void *UNUSED(cb))
+int git_color_config(const char *var, const char *value, void *cb UNUSED)
 {
 	if (!strcmp(var, "color.ui")) {
 		git_use_color_default = git_config_colorbool(var, value);
diff --git a/commit-graph.c b/commit-graph.c
index 1ab5c3233ff..97dd1001ece 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1639,9 +1639,9 @@ struct refs_cb_data {
 	struct progress *progress;
 };
 
-static int add_ref_to_set(const char *UNUSED(refname),
+static int add_ref_to_set(const char *refname UNUSED,
 			  const struct object_id *oid,
-			  int UNUSED(flags), void *cb_data)
+			  int flags UNUSED, void *cb_data)
 {
 	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
diff --git a/commit.c b/commit.c
index cb20082736d..89b8efc6116 100644
--- a/commit.c
+++ b/commit.c
@@ -951,9 +951,9 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 }
 
 static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				  const char *UNUSED(ident),
-				  timestamp_t UNUSED(timestamp), int UNUSED(tz),
-				  const char *UNUSED(message), void *cbdata)
+				  const char *ident UNUSED,
+				  timestamp_t timestamp UNUSED, int tz UNUSED,
+				  const char *message UNUSED, void *cbdata)
 {
 	struct rev_collect *revs = cbdata;
 
diff --git a/compat/terminal.c b/compat/terminal.c
index 0b0caae8571..ea490a7ced4 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -477,7 +477,7 @@ struct escape_sequence_entry {
 	char sequence[FLEX_ARRAY];
 };
 
-static int sequence_entry_cmp(const void *UNUSED(hashmap_cmp_fn_data),
+static int sequence_entry_cmp(const void *hashmap_cmp_fn_data UNUSED,
 			      const struct escape_sequence_entry *e1,
 			      const struct escape_sequence_entry *e2,
 			      const void *keydata)
diff --git a/config.c b/config.c
index c92f1efd6bf..cbb5a3bab74 100644
--- a/config.c
+++ b/config.c
@@ -362,8 +362,8 @@ static void populate_remote_urls(struct config_include_data *inc)
 	current_parsing_scope = store_scope;
 }
 
-static int forbid_remote_url(const char *var, const char *UNUSED(value),
-			     void *UNUSED(data))
+static int forbid_remote_url(const char *var, const char *value UNUSED,
+			     void *data UNUSED)
 {
 	const char *remote_name;
 	size_t remote_name_len;
@@ -2338,10 +2338,10 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	return 0;
 }
 
-static int config_set_element_cmp(const void *UNUSED(cmp_data),
+static int config_set_element_cmp(const void *cmp_data UNUSED,
 				  const struct hashmap_entry *eptr,
 				  const struct hashmap_entry *entry_or_key,
-				  const void *UNUSED(keydata))
+				  const void *keydata UNUSED)
 {
 	const struct config_set_element *e1, *e2;
 
diff --git a/convert.c b/convert.c
index 25d89fa83ba..95e6a5244fc 100644
--- a/convert.c
+++ b/convert.c
@@ -619,7 +619,7 @@ struct filter_params {
 	const char *path;
 };
 
-static int filter_buffer_or_fd(int UNUSED(in), int out, void *data)
+static int filter_buffer_or_fd(int in UNUSED, int out, void *data)
 {
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
@@ -1008,7 +1008,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	return 0;
 }
 
-static int read_convert_config(const char *var, const char *value, void *UNUSED(cb))
+static int read_convert_config(const char *var, const char *value, void *cb UNUSED)
 {
 	const char *key, *name;
 	size_t namelen;
diff --git a/delta-islands.c b/delta-islands.c
index c64333f9de2..26f9e99e1a9 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -316,7 +316,7 @@ static regex_t *island_regexes;
 static unsigned int island_regexes_alloc, island_regexes_nr;
 static const char *core_island_name;
 
-static int island_config_callback(const char *k, const char *v, void *UNUSED(cb))
+static int island_config_callback(const char *k, const char *v, void *cb UNUSED)
 {
 	if (!strcmp(k, "pack.island")) {
 		struct strbuf re = STRBUF_INIT;
@@ -365,7 +365,7 @@ static void add_ref_to_island(const char *island_name, const struct object_id *o
 }
 
 static int find_island_for_ref(const char *refname, const struct object_id *oid,
-			       int UNUSED(flags), void *UNUSED(data))
+			       int flags UNUSED, void *data UNUSED)
 {
 	/*
 	 * We should advertise 'ARRAY_SIZE(matches) - 2' as the max,
diff --git a/diff.c b/diff.c
index 7c7d53d2771..f19bc766289 100644
--- a/diff.c
+++ b/diff.c
@@ -265,7 +265,7 @@ void init_diff_ui_defaults(void)
 }
 
 int git_diff_heuristic_config(const char *var, const char *value,
-			      void *UNUSED(cb))
+			      void *cb UNUSED)
 {
 	if (!strcmp(var, "diff.indentheuristic"))
 		diff_indent_heuristic = git_config_bool(var, value);
@@ -917,7 +917,7 @@ struct interned_diff_symbol {
 static int interned_diff_symbol_cmp(const void *hashmap_cmp_fn_data,
 				    const struct hashmap_entry *eptr,
 				    const struct hashmap_entry *entry_or_key,
-				    const void *UNUSED(keydata))
+				    const void *keydata UNUSED)
 {
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
 	const struct emitted_diff_symbol *a, *b;
diff --git a/dir.c b/dir.c
index 42f8ee06e09..a2ec4f652ba 100644
--- a/dir.c
+++ b/dir.c
@@ -655,10 +655,10 @@ void parse_path_pattern(const char **pattern,
 	*patternlen = len;
 }
 
-int pl_hashmap_cmp(const void *UNUSED(cmp_data),
+int pl_hashmap_cmp(const void *cmp_data UNUSED,
 		   const struct hashmap_entry *a,
 		   const struct hashmap_entry *b,
-		   const void *UNUSED(key))
+		   const void *key UNUSED)
 {
 	const struct pattern_entry *ee1 =
 			container_of(a, struct pattern_entry, ent);
diff --git a/environment.c b/environment.c
index a0ceb6d6558..c94480f92f4 100644
--- a/environment.c
+++ b/environment.c
@@ -333,10 +333,10 @@ static void set_git_dir_1(const char *path)
 	setup_git_env(path);
 }
 
-static void update_relative_gitdir(const char *UNUSED(name),
+static void update_relative_gitdir(const char *name UNUSED,
 				   const char *old_cwd,
 				   const char *new_cwd,
-				   void *UNUSED(data))
+				   void *data UNUSED)
 {
 	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
 	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
diff --git a/fetch-pack.c b/fetch-pack.c
index 9f2933e868a..633718099b7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -176,9 +176,9 @@ static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 	return 0;
 }
 
-static int rev_list_insert_ref_oid(const char *UNUSED(refname),
+static int rev_list_insert_ref_oid(const char *refname UNUSED,
 				   const struct object_id *oid,
-				   int UNUSED(flag),
+				   int flag UNUSED,
 				   void *cb_data)
 {
 	return rev_list_insert_ref(cb_data, oid);
@@ -582,10 +582,10 @@ static int mark_complete(const struct object_id *oid)
 	return 0;
 }
 
-static int mark_complete_oid(const char *UNUSED(refname),
+static int mark_complete_oid(const char *refname UNUSED,
 			     const struct object_id *oid,
-			     int UNUSED(flag),
-			     void *UNUSED(cb_data))
+			     int flag UNUSED,
+			     void *cb_data UNUSED)
 {
 	return mark_complete(oid);
 }
@@ -823,7 +823,7 @@ static int everything_local(struct fetch_pack_args *args,
 	return retval;
 }
 
-static int sideband_demux(int UNUSED(in), int out, void *data)
+static int sideband_demux(int in UNUSED, int out, void *data)
 {
 	int *xd = data;
 	int ret;
diff --git a/git-compat-util.h b/git-compat-util.h
index a9690126bb0..5ea7be97493 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -190,9 +190,9 @@ struct strbuf;
 #define _SGI_SOURCE 1
 
 #if defined(__GNUC__)
-#define UNUSED(var) UNUSED_##var __attribute__((unused))
+#define UNUSED __attribute__((unused))
 #else
-#define UNUSED(var) UNUSED_##var
+#define UNUSED
 #endif
 
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
@@ -403,9 +403,9 @@ typedef uintmax_t timestamp_t;
 #endif
 
 #ifndef platform_core_config
-static inline int noop_core_config(const char *UNUSED(var),
-				   const char *UNUSED(value),
-				   void *UNUSED(cb))
+static inline int noop_core_config(const char *var UNUSED,
+				   const char *value UNUSED,
+				   void *cb UNUSED)
 {
 	return 0;
 }
@@ -499,7 +499,7 @@ static inline void extract_id_from_env(const char *env, uid_t *id)
 }
 
 static inline int is_path_owned_by_current_uid(const char *path,
-					       struct strbuf *UNUSED(report))
+					       struct strbuf *report UNUSED)
 {
 	struct stat st;
 	uid_t euid;
diff --git a/gpg-interface.c b/gpg-interface.c
index 721d69bf42a..9aa714bdeea 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -699,7 +699,7 @@ void set_signing_key(const char *key)
 	configured_signing_key = xstrdup(key);
 }
 
-int git_gpg_config(const char *var, const char *value, void *UNUSED(cb))
+int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
 {
 	struct gpg_format *fmt = NULL;
 	char *fmtname = NULL;
diff --git a/hashmap.c b/hashmap.c
index 763aa1d8a37..cf5fea87eb0 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -142,10 +142,10 @@ static inline struct hashmap_entry **find_entry_ptr(const struct hashmap *map,
 	return e;
 }
 
-static int always_equal(const void *UNUSED(cmp_data),
-			const struct hashmap_entry *UNUSED(entry1),
-			const struct hashmap_entry *UNUSED(entry2),
-			const void *UNUSED(keydata))
+static int always_equal(const void *cmp_data UNUSED,
+			const struct hashmap_entry *entry1 UNUSED,
+			const struct hashmap_entry *entry2 UNUSED,
+			const void *keydata UNUSED)
 {
 	return 0;
 }
@@ -313,7 +313,7 @@ struct pool_entry {
 	unsigned char data[FLEX_ARRAY];
 };
 
-static int pool_entry_cmp(const void *UNUSED(cmp_data),
+static int pool_entry_cmp(const void *cmp_data UNUSED,
 			  const struct hashmap_entry *eptr,
 			  const struct hashmap_entry *entry_or_key,
 			  const void *keydata)
diff --git a/help.c b/help.c
index c5b5848188f..ec670d5f68b 100644
--- a/help.c
+++ b/help.c
@@ -782,8 +782,8 @@ struct similar_ref_cb {
 };
 
 static int append_similar_ref(const char *refname,
-			      const struct object_id *UNUSED(oid),
-			      int UNUSED(flags), void *cb_data)
+			      const struct object_id *oid UNUSED,
+			      int flags UNUSED, void *cb_data)
 {
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
 	char *branch = strrchr(refname, '/') + 1;
diff --git a/http-backend.c b/http-backend.c
index 20db0ea6208..6eb3b2fe51c 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -505,7 +505,7 @@ static void run_service(const char **argv, int buffer_input)
 }
 
 static int show_text_ref(const char *name, const struct object_id *oid,
-			 int UNUSED(flag), void *cb_data)
+			 int flag UNUSED, void *cb_data)
 {
 	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
diff --git a/ident.c b/ident.c
index 48745a1f0e9..6de76f9421d 100644
--- a/ident.c
+++ b/ident.c
@@ -668,7 +668,7 @@ static int set_ident(const char *var, const char *value)
 	return 0;
 }
 
-int git_ident_config(const char *var, const char *value, void *UNUSED(data))
+int git_ident_config(const char *var, const char *value, void *data UNUSED)
 {
 	if (!strcmp(var, "user.useconfigonly")) {
 		ident_use_config_only = git_config_bool(var, value);
diff --git a/ll-merge.c b/ll-merge.c
index 9f3ae1f8fe1..8955d7e1f6e 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -250,7 +250,7 @@ static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
 static const char *default_ll_merge;
 
 static int read_merge_config(const char *var, const char *value,
-			     void *UNUSED(cb))
+			     void *cb UNUSED)
 {
 	struct ll_merge_driver *fn;
 	const char *key, *name;
diff --git a/log-tree.c b/log-tree.c
index 114bd80365e..ccdbf08feba 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -135,7 +135,7 @@ static int ref_filter_match(const char *refname,
 }
 
 static int add_ref_decoration(const char *refname, const struct object_id *oid,
-			      int UNUSED(flags),
+			      int flags UNUSED,
 			      void *cb_data)
 {
 	struct object *obj;
diff --git a/ls-refs.c b/ls-refs.c
index e54b883e879..fa0d01b47c1 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -137,7 +137,7 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 }
 
 static int ls_refs_config(const char *var, const char *value,
-			  void *UNUSED(data))
+			  void *data UNUSED)
 {
 	/*
 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
diff --git a/merge-recursive.c b/merge-recursive.c
index 08c1c36d334..4ddd3adea00 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -45,7 +45,7 @@ struct path_hashmap_entry {
 	char path[FLEX_ARRAY];
 };
 
-static int path_hashmap_cmp(const void *UNUSED(cmp_data),
+static int path_hashmap_cmp(const void *cmp_data UNUSED,
 			    const struct hashmap_entry *eptr,
 			    const struct hashmap_entry *entry_or_key,
 			    const void *keydata)
@@ -89,10 +89,10 @@ static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
 	return hashmap_get_entry(hashmap, &key, ent, NULL);
 }
 
-static int dir_rename_cmp(const void *UNUSED(cmp_data),
+static int dir_rename_cmp(const void *cmp_data UNUSED,
 			  const struct hashmap_entry *eptr,
 			  const struct hashmap_entry *entry_or_key,
-			  const void *UNUSED(keydata))
+			  const void *keydata UNUSED)
 {
 	const struct dir_rename_entry *e1, *e2;
 
@@ -134,10 +134,10 @@ static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
 	return hashmap_get_entry(hashmap, &key, ent, NULL);
 }
 
-static int collision_cmp(const void *UNUSED(cmp_data),
+static int collision_cmp(const void *cmp_data UNUSED,
 			 const struct hashmap_entry *eptr,
 			 const struct hashmap_entry *entry_or_key,
-			 const void *UNUSED(keydata))
+			 const void *keydata UNUSED)
 {
 	const struct collision_entry *e1, *e2;
 
@@ -456,7 +456,7 @@ static void unpack_trees_finish(struct merge_options *opt)
 	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
 }
 
-static int save_files_dirs(const struct object_id *UNUSED(oid),
+static int save_files_dirs(const struct object_id *oid UNUSED,
 			   struct strbuf *base, const char *path,
 			   unsigned int mode, void *context)
 {
diff --git a/name-hash.c b/name-hash.c
index d0da6db5646..cd009c7c8ae 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -18,7 +18,7 @@ struct dir_entry {
 	char name[FLEX_ARRAY];
 };
 
-static int dir_entry_cmp(const void *UNUSED(cmp_data),
+static int dir_entry_cmp(const void *cmp_data UNUSED,
 			 const struct hashmap_entry *eptr,
 			 const struct hashmap_entry *entry_or_key,
 			 const void *keydata)
@@ -120,7 +120,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		add_dir_entry(istate, ce);
 }
 
-static int cache_entry_cmp(const void *UNUSED(cmp_data),
+static int cache_entry_cmp(const void *cmp_data UNUSED,
 			   const struct hashmap_entry *eptr,
 			   const struct hashmap_entry *entry_or_key,
 			   const void *remove)
diff --git a/negotiator/default.c b/negotiator/default.c
index 10f0a46e624..b7e79feaf04 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -36,8 +36,8 @@ static void rev_list_push(struct negotiation_state *ns,
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       int UNUSED(flag),
-		       void *UNUSED(cb_data))
+		       int flag UNUSED,
+		       void *cb_data UNUSED)
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index f2aa58af923..c4398f5ae15 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -72,8 +72,8 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
-		       int UNUSED(flag),
-		       void *UNUSED(cb_data))
+		       int flag UNUSED,
+		       void *cb_data UNUSED)
 {
 	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
 
diff --git a/notes.c b/notes.c
index 3be98e70851..94074afe17a 100644
--- a/notes.c
+++ b/notes.c
@@ -925,8 +925,8 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 }
 
 static int string_list_add_one_ref(const char *refname,
-				   const struct object_id *UNUSED(oid),
-				   int UNUSED(flag), void *cb)
+				   const struct object_id *oid UNUSED,
+				   int flag UNUSED, void *cb)
 {
 	struct string_list *refs = cb;
 	if (!unsorted_string_list_has_string(refs, refname))
diff --git a/object-name.c b/object-name.c
index 3f7fce83224..2dd1a0f56e1 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1306,7 +1306,7 @@ struct handle_one_ref_cb {
 };
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  int UNUSED(flag),
+			  int flag UNUSED,
 			  void *cb_data)
 {
 	struct handle_one_ref_cb *cb = cb_data;
@@ -1385,11 +1385,11 @@ struct grab_nth_branch_switch_cbdata {
 	struct strbuf *sb;
 };
 
-static int grab_nth_branch_switch(struct object_id *UNUSED(ooid),
-				  struct object_id *UNUSED(noid),
-				  const char *UNUSED(email),
-				  timestamp_t UNUSED(timestamp),
-				  int UNUSED(tz),
+static int grab_nth_branch_switch(struct object_id *ooid UNUSED,
+				  struct object_id *noid UNUSED,
+				  const char *email UNUSED,
+				  timestamp_t timestamp UNUSED,
+				  int tz UNUSED,
 				  const char *message, void *cb_data)
 {
 	struct grab_nth_branch_switch_cbdata *cb = cb_data;
diff --git a/object-store.h b/object-store.h
index cf5494af807..1be57abaf10 100644
--- a/object-store.h
+++ b/object-store.h
@@ -141,7 +141,7 @@ struct packed_git {
 
 struct multi_pack_index;
 
-static inline int pack_map_entry_cmp(const void *UNUSED(cmp_data),
+static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
 				     const struct hashmap_entry *entry,
 				     const struct hashmap_entry *entry2,
 				     const void *keydata)
diff --git a/oidmap.c b/oidmap.c
index 32aeb0526fe..49965fe8568 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "oidmap.h"
 
-static int oidmap_neq(const void *UNUSED(hashmap_cmp_fn_data),
+static int oidmap_neq(const void *hashmap_cmp_fn_data UNUSED,
 		      const struct hashmap_entry *e1,
 		      const struct hashmap_entry *e2,
 		      const void *keydata)
diff --git a/packfile.c b/packfile.c
index d7cf8382dee..bee8583119e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1392,7 +1392,7 @@ static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
 	return a->p == b->p && a->base_offset == b->base_offset;
 }
 
-static int delta_base_cache_hash_cmp(const void *UNUSED(cmp_data),
+static int delta_base_cache_hash_cmp(const void *cmp_data UNUSED,
 				     const struct hashmap_entry *va,
 				     const struct hashmap_entry *vb,
 				     const void *vkey)
diff --git a/pager.c b/pager.c
index 19c016ff549..b66bbff2785 100644
--- a/pager.c
+++ b/pager.c
@@ -39,7 +39,7 @@ static void wait_for_pager_signal(int signo)
 }
 
 static int core_pager_config(const char *var, const char *value,
-			     void *UNUSED(data))
+			     void *data UNUSED)
 {
 	if (!strcmp(var, "core.pager"))
 		return git_config_string(&pager_program, var, value);
diff --git a/patch-ids.c b/patch-ids.c
index cdfa5135490..46c6a8f3eab 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -38,7 +38,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 static int patch_id_neq(const void *cmpfn_data,
 			const struct hashmap_entry *eptr,
 			const struct hashmap_entry *entry_or_key,
-			const void *UNUSED(keydata))
+			const void *keydata UNUSED)
 {
 	/* NEEDSWORK: const correctness? */
 	struct diff_options *opt = (void *)cmpfn_data;
diff --git a/pretty.c b/pretty.c
index 584026b7469..f0277bd42b9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -44,7 +44,7 @@ static void save_user_format(struct rev_info *rev, const char *cp, int is_tforma
 }
 
 static int git_pretty_formats_config(const char *var, const char *value,
-				     void *UNUSED(cb))
+				     void *cb UNUSED)
 {
 	struct cmt_fmt_map *commit_format = NULL;
 	const char *name;
diff --git a/range-diff.c b/range-diff.c
index 1528fdd0db8..462710ffe40 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -224,7 +224,7 @@ static int read_patches(const char *range, struct string_list *list,
 	return ret;
 }
 
-static int patch_util_cmp(const void *UNUSED(cmp_data),
+static int patch_util_cmp(const void *cmp_data UNUSED,
 			  const struct patch_util *a,
 			  const struct patch_util *b,
 			  const char *keydata)
diff --git a/ref-filter.c b/ref-filter.c
index baf252b77d6..fd1cb14b0f1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -89,7 +89,7 @@ struct ref_to_worktree_entry {
 	struct worktree *wt; /* key is wt->head_ref */
 };
 
-static int ref_to_worktree_map_cmpfnc(const void *UNUSED(lookupdata),
+static int ref_to_worktree_map_cmpfnc(const void *lookupdata UNUSED,
 				      const struct hashmap_entry *eptr,
 				      const struct hashmap_entry *kptr,
 				      const void *keydata_aka_refname)
diff --git a/reflog.c b/reflog.c
index 56ea3ba7624..d258fd31995 100644
--- a/reflog.c
+++ b/reflog.c
@@ -240,9 +240,9 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
  * Return true iff the specified reflog entry should be expired.
  */
 int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
-			     const char *UNUSED(email),
-			     timestamp_t timestamp, int UNUSED(tz),
-			     const char *UNUSED(message), void *cb_data)
+			     const char *email UNUSED,
+			     timestamp_t timestamp, int tz UNUSED,
+			     const char *message UNUSED, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit *old_commit, *new_commit;
@@ -295,7 +295,7 @@ int should_expire_reflog_ent_verbose(struct object_id *ooid,
 	return expire;
 }
 
-static int push_tip_to_list(const char *UNUSED(refname),
+static int push_tip_to_list(const char *refname UNUSED,
 			    const struct object_id *oid,
 			    int flags, void *cb_data)
 {
@@ -380,11 +380,11 @@ void reflog_expiry_cleanup(void *cb_data)
 	}
 }
 
-int count_reflog_ent(struct object_id *UNUSED(ooid),
-		     struct object_id *UNUSED(noid),
-		     const char *UNUSED(email),
-		     timestamp_t timestamp, int UNUSED(tz),
-		     const char *UNUSED(message), void *cb_data)
+int count_reflog_ent(struct object_id *ooid UNUSED,
+		     struct object_id *noid UNUSED,
+		     const char *email UNUSED,
+		     timestamp_t timestamp, int tz UNUSED,
+		     const char *message UNUSED, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cb = cb_data;
 	if (!cb->expire_total || timestamp < cb->expire_total)
diff --git a/refs.c b/refs.c
index 5012bba3578..b1b3077ecc5 100644
--- a/refs.c
+++ b/refs.c
@@ -359,7 +359,7 @@ struct warn_if_dangling_data {
 };
 
 static int warn_if_dangling_symref(const char *refname,
-				   const struct object_id *UNUSED(oid),
+				   const struct object_id *oid UNUSED,
 				   int flags, void *cb_data)
 {
 	struct warn_if_dangling_data *d = cb_data;
@@ -894,7 +894,7 @@ static void set_read_ref_cutoffs(struct read_ref_at_cb *cb,
 }
 
 static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
-			   const char *UNUSED(email),
+			   const char *email UNUSED,
 			   timestamp_t timestamp, int tz,
 			   const char *message, void *cb_data)
 {
@@ -936,9 +936,9 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 	return cb->found_it;
 }
 
-static int read_ref_at_ent_newest(struct object_id *UNUSED(ooid),
+static int read_ref_at_ent_newest(struct object_id *ooid UNUSED,
 				  struct object_id *noid,
-				  const char *UNUSED(email),
+				  const char *email UNUSED,
 				  timestamp_t timestamp, int tz,
 				  const char *message, void *cb_data)
 {
@@ -951,7 +951,7 @@ static int read_ref_at_ent_newest(struct object_id *UNUSED(ooid),
 }
 
 static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
-				  const char *UNUSED(email),
+				  const char *email UNUSED,
 				  timestamp_t timestamp, int tz,
 				  const char *message, void *cb_data)
 {
@@ -1815,7 +1815,7 @@ struct ref_store_hash_entry
 	char name[FLEX_ARRAY];
 };
 
-static int ref_store_hash_cmp(const void *UNUSED(cmp_data),
+static int ref_store_hash_cmp(const void *cmp_data UNUSED,
 			      const struct hashmap_entry *eptr,
 			      const struct hashmap_entry *entry_or_key,
 			      const void *keydata)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 13bfdb7701d..e4009b3c421 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2202,8 +2202,8 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
-static int files_reflog_iterator_peel(struct ref_iterator *UNUSED(ref_iterator),
-				      struct object_id *UNUSED(peeled))
+static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
+				      struct object_id *peeled UNUSED)
 {
 	BUG("ref_iterator_peel() called for reflog_iterator");
 }
@@ -2257,7 +2257,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
 static enum iterator_selection reflog_iterator_select(
 	struct ref_iterator *iter_worktree,
 	struct ref_iterator *iter_common,
-	void *UNUSED(cb_data))
+	void *cb_data UNUSED)
 {
 	if (iter_worktree) {
 		/*
@@ -2985,7 +2985,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 static int files_transaction_abort(struct ref_store *ref_store,
 				   struct ref_transaction *transaction,
-				   struct strbuf *UNUSED(err))
+				   struct strbuf *err UNUSED)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, 0, "ref_transaction_abort");
@@ -2995,8 +2995,8 @@ static int files_transaction_abort(struct ref_store *ref_store,
 }
 
 static int ref_present(const char *refname,
-		       const struct object_id *UNUSED(oid),
-		       int UNUSED(flags),
+		       const struct object_id *oid UNUSED,
+		       int flags UNUSED,
 		       void *cb_data)
 {
 	struct string_list *affected_refnames = cb_data;
@@ -3261,7 +3261,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	return -1;
 }
 
-static int files_init_db(struct ref_store *ref_store, struct strbuf *UNUSED(err))
+static int files_init_db(struct ref_store *ref_store, struct strbuf *err UNUSED)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
diff --git a/refs/iterator.c b/refs/iterator.c
index e34921db729..c9fd0bcaf90 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -51,8 +51,8 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator_abort(ref_iterator);
 }
 
-static int empty_ref_iterator_peel(struct ref_iterator *UNUSED(ref_iterator),
-				   struct object_id *UNUSED(peeled))
+static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
+				   struct object_id *peeled UNUSED)
 {
 	BUG("peel called for empty iterator");
 }
@@ -238,7 +238,7 @@ struct ref_iterator *merge_ref_iterator_begin(
  */
 static enum iterator_selection overlay_iterator_select(
 		struct ref_iterator *front, struct ref_iterator *back,
-		void *UNUSED(cb_data))
+		void *cb_data UNUSED)
 {
 	int cmp;
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a45bb686f0b..43cdb97f8b3 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -726,7 +726,7 @@ static struct snapshot *get_snapshot(struct packed_ref_store *refs)
 }
 
 static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
-			       struct object_id *oid, struct strbuf *UNUSED(referent),
+			       struct object_id *oid, struct strbuf *referent UNUSED,
 			       unsigned int *type, int *failure_errno)
 {
 	struct packed_ref_store *refs =
@@ -1078,8 +1078,8 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 static const char PACKED_REFS_HEADER[] =
 	"# pack-refs with: peeled fully-peeled sorted \n";
 
-static int packed_init_db(struct ref_store *UNUSED(ref_store),
-			  struct strbuf *UNUSED(err))
+static int packed_init_db(struct ref_store *ref_store UNUSED,
+			  struct strbuf *err UNUSED)
 {
 	/* Nothing to do. */
 	return 0;
@@ -1474,7 +1474,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 
 static int packed_transaction_abort(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
-				    struct strbuf *UNUSED(err))
+				    struct strbuf *err UNUSED)
 {
 	struct packed_ref_store *refs = packed_downcast(
 			ref_store,
@@ -1513,7 +1513,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 	return ret;
 }
 
-static int packed_initial_transaction_commit(struct ref_store *UNUSED(ref_store),
+static int packed_initial_transaction_commit(struct ref_store *ref_store UNUSED,
 					    struct ref_transaction *transaction,
 					    struct strbuf *err)
 {
@@ -1569,8 +1569,8 @@ static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 	return ret;
 }
 
-static int packed_pack_refs(struct ref_store *UNUSED(ref_store),
-			    unsigned int UNUSED(flags))
+static int packed_pack_refs(struct ref_store *ref_store UNUSED,
+			    unsigned int flags UNUSED)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
@@ -1580,7 +1580,7 @@ static int packed_pack_refs(struct ref_store *UNUSED(ref_store),
 	return 0;
 }
 
-static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *UNUSED(ref_store))
+static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store UNUSED)
 {
 	return empty_ref_iterator_begin();
 }
diff --git a/remote.c b/remote.c
index ef12aba91dc..60869beebe7 100644
--- a/remote.c
+++ b/remote.c
@@ -86,7 +86,7 @@ struct remotes_hash_key {
 	int len;
 };
 
-static int remotes_hash_cmp(const void *UNUSED(cmp_data),
+static int remotes_hash_cmp(const void *cmp_data UNUSED,
 			    const struct hashmap_entry *eptr,
 			    const struct hashmap_entry *entry_or_key,
 			    const void *keydata)
@@ -170,7 +170,7 @@ struct branches_hash_key {
 	int len;
 };
 
-static int branches_hash_cmp(const void *UNUSED(cmp_data),
+static int branches_hash_cmp(const void *cmp_data UNUSED,
 			     const struct hashmap_entry *eptr,
 			     const struct hashmap_entry *entry_or_key,
 			     const void *keydata)
@@ -2320,7 +2320,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 }
 
 static int one_local_ref(const char *refname, const struct object_id *oid,
-			 int UNUSED(flag),
+			 int flag UNUSED,
 			 void *cb_data)
 {
 	struct ref ***local_tail = cb_data;
@@ -2577,22 +2577,22 @@ struct check_and_collect_until_cb_data {
 };
 
 /* Get the timestamp of the latest entry. */
-static int peek_reflog(struct object_id *UNUSED(o_oid),
-		       struct object_id *UNUSED(n_oid),
-		       const char *UNUSED(ident),
-		       timestamp_t timestamp, int UNUSED(tz),
-		       const char *UNUSED(message), void *cb_data)
+static int peek_reflog(struct object_id *o_oid UNUSED,
+		       struct object_id *n_oid UNUSED,
+		       const char *ident UNUSED,
+		       timestamp_t timestamp, int tz UNUSED,
+		       const char *message UNUSED, void *cb_data)
 {
 	timestamp_t *ts = cb_data;
 	*ts = timestamp;
 	return 1;
 }
 
-static int check_and_collect_until(struct object_id *UNUSED(o_oid),
+static int check_and_collect_until(struct object_id *o_oid UNUSED,
 				   struct object_id *n_oid,
-				   const char *UNUSED(ident),
-				   timestamp_t timestamp, int UNUSED(tz),
-				   const char *UNUSED(message), void *cb_data)
+				   const char *ident UNUSED,
+				   timestamp_t timestamp, int tz UNUSED,
+				   const char *message UNUSED, void *cb_data)
 {
 	struct commit *commit;
 	struct check_and_collect_until_cb_data *cb = cb_data;
diff --git a/replace-object.c b/replace-object.c
index 17810e5a3ac..320be2522d8 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -9,8 +9,8 @@
 static int register_replace_ref(struct repository *r,
 				const char *refname,
 				const struct object_id *oid,
-				int UNUSED(flag),
-				void *UNUSED(cb_data))
+				int flag UNUSED,
+				void *cb_data UNUSED)
 {
 	/* Get sha1 from refname */
 	const char *slash = strrchr(refname, '/');
diff --git a/revision.c b/revision.c
index 5eb71e32d0d..5451a698ec3 100644
--- a/revision.c
+++ b/revision.c
@@ -119,10 +119,10 @@ struct path_and_oids_entry {
 	struct oidset trees;
 };
 
-static int path_and_oids_cmp(const void *UNUSED(hashmap_cmp_fn_data),
+static int path_and_oids_cmp(const void *hashmap_cmp_fn_data UNUSED,
 			     const struct hashmap_entry *eptr,
 			     const struct hashmap_entry *entry_or_key,
-			     const void *UNUSED(keydata))
+			     const void *keydata UNUSED)
 {
 	const struct path_and_oids_entry *e1, *e2;
 
@@ -1543,7 +1543,7 @@ int ref_excluded(struct string_list *ref_excludes, const char *path)
 }
 
 static int handle_one_ref(const char *path, const struct object_id *oid,
-			  int UNUSED(flag),
+			  int flag UNUSED,
 			  void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
@@ -1619,10 +1619,10 @@ static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 }
 
 static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				 const char *UNUSED(email),
-				 timestamp_t UNUSED(timestamp),
-				 int UNUSED(tz),
-				 const char *UNUSED(message),
+				 const char *email UNUSED,
+				 timestamp_t timestamp UNUSED,
+				 int tz UNUSED,
+				 const char *message UNUSED,
 				 void *cb_data)
 {
 	handle_one_reflog_commit(ooid, cb_data);
@@ -1631,8 +1631,8 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int handle_one_reflog(const char *refname_in_wt,
-			     const struct object_id *UNUSED(oid),
-			     int UNUSED(flag), void *cb_data)
+			     const struct object_id *oid UNUSED,
+			     int flag UNUSED, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct strbuf refname = STRBUF_INIT;
diff --git a/send-pack.c b/send-pack.c
index 7e99c64e6b8..f2e19838c9c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -266,7 +266,7 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 	return ret;
 }
 
-static int sideband_demux(int UNUSED(in), int out, void *data)
+static int sideband_demux(int in UNUSED, int out, void *data)
 {
 	int *fd = data, ret;
 	if (async_with_fork())
diff --git a/sequencer.c b/sequencer.c
index e5b52651f88..3ac82f9ebed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5254,7 +5254,7 @@ struct labels_entry {
 	char label[FLEX_ARRAY];
 };
 
-static int labels_cmp(const void *UNUSED(fndata),
+static int labels_cmp(const void *fndata UNUSED,
 		      const struct hashmap_entry *eptr,
 		      const struct hashmap_entry *entry_or_key, const void *key)
 {
@@ -6132,7 +6132,7 @@ struct subject2item_entry {
 	char subject[FLEX_ARRAY];
 };
 
-static int subject2item_cmp(const void *UNUSED(fndata),
+static int subject2item_cmp(const void *fndata UNUSED,
 			    const struct hashmap_entry *eptr,
 			    const struct hashmap_entry *entry_or_key,
 			    const void *key)
diff --git a/server-info.c b/server-info.c
index d99d9d5f619..0ec6c0c1654 100644
--- a/server-info.c
+++ b/server-info.c
@@ -147,7 +147,7 @@ static int update_info_file(char *path,
 }
 
 static int add_info_ref(const char *path, const struct object_id *oid,
-			int UNUSED(flag),
+			int flag UNUSED,
 			void *cb_data)
 {
 	struct update_info_ctx *uic = cb_data;
diff --git a/shallow.c b/shallow.c
index 71ab04f935c..17f9bcdb5f3 100644
--- a/shallow.c
+++ b/shallow.c
@@ -604,10 +604,10 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 	free(tmp);
 }
 
-static int mark_uninteresting(const char *UNUSED(refname),
+static int mark_uninteresting(const char *refname UNUSED,
 			      const struct object_id *oid,
-			      int UNUSED(flags),
-			      void *UNUSED(cb_data))
+			      int flags UNUSED,
+			      void *cb_data UNUSED)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
@@ -717,9 +717,9 @@ struct commit_array {
 	int nr, alloc;
 };
 
-static int add_ref(const char *UNUSED(refname),
+static int add_ref(const char *refname UNUSED,
 		   const struct object_id *oid,
-		   int UNUSED(flags),
+		   int flags UNUSED,
 		   void *cb_data)
 {
 	struct commit_array *ca = cb_data;
diff --git a/strbuf.c b/strbuf.c
index dd9eb85527a..0890b1405c5 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -436,7 +436,7 @@ void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
 
 size_t strbuf_expand_literal_cb(struct strbuf *sb,
 				const char *placeholder,
-				void *context)
+				void *context UNUSED)
 {
 	int ch;
 
diff --git a/streaming.c b/streaming.c
index 4b34e2a748d..7b2f8b2b938 100644
--- a/streaming.c
+++ b/streaming.c
@@ -328,9 +328,9 @@ static int close_istream_pack_non_delta(struct git_istream *st)
 }
 
 static int open_istream_pack_non_delta(struct git_istream *st,
-				       struct repository *UNUSED(r),
-				       const struct object_id *UNUSED(oid),
-				       enum object_type *UNUSED(type))
+				       struct repository *r UNUSED,
+				       const struct object_id *oid UNUSED,
+				       enum object_type *type UNUSED)
 {
 	struct pack_window *window;
 	enum object_type in_pack_type;
diff --git a/strmap.c b/strmap.c
index 4e79734e4f9..c7b9c52174c 100644
--- a/strmap.c
+++ b/strmap.c
@@ -2,10 +2,10 @@
 #include "strmap.h"
 #include "mem-pool.h"
 
-int cmp_strmap_entry(const void *UNUSED(hashmap_cmp_fn_data),
+int cmp_strmap_entry(const void *hashmap_cmp_fn_data UNUSED,
 		     const struct hashmap_entry *entry1,
 		     const struct hashmap_entry *entry2,
-		     const void *UNUSED(keydata))
+		     const void *keydata UNUSED)
 {
 	const struct strmap_entry *e1, *e2;
 
diff --git a/sub-process.c b/sub-process.c
index bd6a372a670..6d4232294db 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -5,10 +5,10 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 
-int cmd2process_cmp(const void *UNUSED(cmp_data),
+int cmd2process_cmp(const void *cmp_data UNUSED,
 		    const struct hashmap_entry *eptr,
 		    const struct hashmap_entry *entry_or_key,
-		    const void *UNUSED(keydata))
+		    const void *keydata UNUSED)
 {
 	const struct subprocess_entry *e1, *e2;
 
diff --git a/submodule-config.c b/submodule-config.c
index d7a8ca0269a..cd7ee236a12 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -38,10 +38,10 @@ enum lookup_type {
 	lookup_path
 };
 
-static int config_path_cmp(const void *UNUSED(cmp_data),
+static int config_path_cmp(const void *cmp_data UNUSED,
 			   const struct hashmap_entry *eptr,
 			   const struct hashmap_entry *entry_or_key,
-			   const void *UNUSED(keydata))
+			   const void *keydata UNUSED)
 {
 	const struct submodule_entry *a, *b;
 
@@ -52,10 +52,10 @@ static int config_path_cmp(const void *UNUSED(cmp_data),
 	       !oideq(&a->config->gitmodules_oid, &b->config->gitmodules_oid);
 }
 
-static int config_name_cmp(const void *UNUSED(cmp_data),
+static int config_name_cmp(const void *cmp_data UNUSED,
 			   const struct hashmap_entry *eptr,
 			   const struct hashmap_entry *entry_or_key,
-			   const void *UNUSED(keydata))
+			   const void *keydata UNUSED)
 {
 	const struct submodule_entry *a, *b;
 
diff --git a/submodule.c b/submodule.c
index 597a347f859..7455b618ead 100644
--- a/submodule.c
+++ b/submodule.c
@@ -214,7 +214,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 
 /* Cheap function that only determines if we're interested in submodules at all */
 int git_default_submodule_config(const char *var, const char *value,
-				 void *UNUSED(cb))
+				 void *cb UNUSED)
 {
 	if (!strcmp(var, "submodule.recurse")) {
 		int v = git_config_bool(var, value) ?
@@ -941,9 +941,9 @@ static void free_submodules_data(struct string_list *submodules)
 	string_list_clear(submodules, 1);
 }
 
-static int has_remote(const char *UNUSED(refname),
-		      const struct object_id *UNUSED(oid),
-		      int UNUSED(flags), void *UNUSED(cb_data))
+static int has_remote(const char *refname UNUSED,
+		      const struct object_id *oid UNUSED,
+		      int flags UNUSED, void *cb_data UNUSED)
 {
 	return 1;
 }
@@ -1245,9 +1245,9 @@ int push_unpushed_submodules(struct repository *r,
 	return ret;
 }
 
-static int append_oid_to_array(const char *UNUSED(ref),
+static int append_oid_to_array(const char *ref UNUSED,
 			       const struct object_id *oid,
-			       int UNUSED(flags), void *data)
+			       int flags UNUSED, void *data)
 {
 	struct oid_array *array = data;
 	oid_array_append(array, oid);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index ddd538b838d..4ba9eb65606 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -37,7 +37,7 @@
  *
  */
 
-static int iterate_cb(const char *var, const char *value, void *UNUSED(data))
+static int iterate_cb(const char *var, const char *value, void *data UNUSED)
 {
 	static int nr;
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 8f930ad358c..ae8a5648daf 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -161,7 +161,7 @@ static int cmd_rename_ref(struct ref_store *refs, const char **argv)
 }
 
 static int each_ref(const char *refname, const struct object_id *oid,
-		    int flags, void *UNUSED(cb_data))
+		    int flags, void *cb_data UNUSED)
 {
 	printf("%s %s 0x%x\n", oid_to_hex(oid), refname, flags);
 	return 0;
@@ -207,7 +207,7 @@ static int cmd_for_each_reflog(struct ref_store *refs, const char **argv)
 
 static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 		       const char *committer, timestamp_t timestamp,
-		       int tz, const char *msg, void *UNUSED(cb_data))
+		       int tz, const char *msg, void *cb_data UNUSED)
 {
 	printf("%s %s %s %" PRItime " %+05d%s%s", oid_to_hex(old_oid),
 	       oid_to_hex(new_oid), committer, timestamp, tz,
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index 64538a0c203..a2b56b9cae5 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -12,7 +12,7 @@ static int driver_cb(struct userdiff_driver *driver,
 	return 0;
 }
 
-static int cmd__userdiff_config(const char *var, const char *value, void *UNUSED(cb))
+static int cmd__userdiff_config(const char *var, const char *value, void *cb UNUSED)
 {
 	if (userdiff_config(var, value) < 0)
 		return -1;
diff --git a/trailer.c b/trailer.c
index a1e80478ab0..0fd5b142a37 100644
--- a/trailer.c
+++ b/trailer.c
@@ -479,7 +479,7 @@ static struct {
 };
 
 static int git_trailer_default_config(const char *conf_key, const char *value,
-				      void *UNUSED(cb))
+				      void *cb UNUSED)
 {
 	const char *trailer_item, *variable_name;
 
@@ -511,7 +511,7 @@ static int git_trailer_default_config(const char *conf_key, const char *value,
 }
 
 static int git_trailer_config(const char *conf_key, const char *value,
-			      void *UNUSED(cb))
+			      void *cb UNUSED)
 {
 	const char *trailer_item, *variable_name;
 	struct arg_item *item;
diff --git a/transport.c b/transport.c
index 551cad22dd3..999212df976 100644
--- a/transport.c
+++ b/transport.c
@@ -142,7 +142,7 @@ static void get_refs_from_bundle_inner(struct transport *transport)
 
 static struct ref *get_refs_from_bundle(struct transport *transport,
 					int for_push,
-					struct transport_ls_refs_options *UNUSED(transport_options))
+					struct transport_ls_refs_options *transport_options UNUSED)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
diff --git a/upload-pack.c b/upload-pack.c
index b2cbca1e8bc..3bdbd142b73 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1170,7 +1170,7 @@ static int mark_our_ref(const char *refname, const char *refname_full,
 }
 
 static int check_ref(const char *refname_full, const struct object_id *oid,
-		     int UNUSED(flag), void *UNUSED(cb_data))
+		     int flag UNUSED, void *cb_data UNUSED)
 {
 	const char *refname = strip_namespace(refname_full);
 
@@ -1194,7 +1194,7 @@ static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
 }
 
 static int send_ref(const char *refname, const struct object_id *oid,
-		    int UNUSED(flag), void *cb_data)
+		    int flag UNUSED, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
@@ -1237,7 +1237,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 }
 
 static int find_symref(const char *refname,
-		       const struct object_id *UNUSED(oid),
+		       const struct object_id *oid UNUSED,
 		       int flag, void *cb_data)
 {
 	const char *symref_target;
diff --git a/walker.c b/walker.c
index f945d021f8c..99d0e0eae04 100644
--- a/walker.c
+++ b/walker.c
@@ -215,10 +215,10 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 	return -1;
 }
 
-static int mark_complete(const char *UNUSED(path),
+static int mark_complete(const char *path UNUSED,
 			 const struct object_id *oid,
-			 int UNUSED(flag),
-			 void *UNUSED(cb_data))
+			 int flag UNUSED,
+			 void *cb_data UNUSED)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
 							       oid, 1);
diff --git a/wt-status.c b/wt-status.c
index 38d0900aa94..5813174896c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -947,11 +947,11 @@ static void wt_longstatus_print_changed(struct wt_status *s)
 	wt_longstatus_print_trailer(s);
 }
 
-static int stash_count_refs(struct object_id *UNUSED(ooid),
-			    struct object_id *UNUSED(noid),
-			    const char *UNUSED(email),
-			    timestamp_t UNUSED(timestamp), int UNUSED(tz),
-			    const char *UNUSED(message), void *cb_data)
+static int stash_count_refs(struct object_id *ooid UNUSED,
+			    struct object_id *noid UNUSED,
+			    const char *email UNUSED,
+			    timestamp_t timestamp UNUSED, int tz UNUSED,
+			    const char *message UNUSED, void *cb_data)
 {
 	int *c = cb_data;
 	(*c)++;
@@ -1614,10 +1614,10 @@ struct grab_1st_switch_cbdata {
 	struct object_id noid;
 };
 
-static int grab_1st_switch(struct object_id *UNUSED(ooid),
+static int grab_1st_switch(struct object_id *ooid UNUSED,
 			   struct object_id *noid,
-			   const char *UNUSED(email),
-			   timestamp_t UNUSED(timestamp), int UNUSED(tz),
+			   const char *email UNUSED,
+			   timestamp_t timestamp UNUSED, int tz UNUSED,
 			   const char *message, void *cb_data)
 {
 	struct grab_1st_switch_cbdata *cb = cb_data;
-- 
2.37.2.1279.g8741a0e3ea3

