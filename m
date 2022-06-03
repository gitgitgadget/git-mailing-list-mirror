Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330C3C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347142AbiFCSky (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347230AbiFCSjG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5032826FA
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h5so11495907wrb.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEuiqLtIctBAQu/LqPfXZF5wFKtHXlmthNmIHjhYQlU=;
        b=buP+mXP6CSmRPsWOCydbn7r8ymYOHLOTKzvwAqd34vVfz3ggdyzHmsPBoUs3oVtwEK
         PjeQU7aGrkeElVLHX83zLvU9Re2UoMTMqcZnGjAglxJpDTL8ug32+S9ofeiAYJkXhxoW
         Iv6tbXUhxMaOy9qaC7i0h8//U12twpE+/4M6/SGUfWcwPD7ju5SvC9UJEnhcVnvpg8Gq
         UhiBa9/TB70s82OqM40k+3CiR+Kp8txr3IJt9I0uhTA4qjuXiEtBmSJoXzBAbTVIl1xF
         bq5gtLyPHJLMEWMkcsOKf40BoAPtOvxFR7dn2gmzENt9uYLQNGQmH3Ttra9LPTlR638d
         CGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEuiqLtIctBAQu/LqPfXZF5wFKtHXlmthNmIHjhYQlU=;
        b=3XMH/AUY2KY+ZHn2x0/pw/yBqg6hLsQsPBjgUIo1YDzp5ZZT5lg46BpQiortaLV2Mj
         7zAHt+VFfVpdNmD6W8W9lH7YZafJBB+zmC3wcA9+Jij6CDzNPSCjWKqpls3u73xi5nxf
         peGnggts0MGWLsLt4ebcM6vgglChH5OMN4nCQpZvyEK45jzY/IkJx0JEvFZztINfZ8Ip
         9f274FcBPrZyLvEoiaBpDOoC/Lez9teUc/SEraE2nHoiTaFywFr7KGWUax5R2UdhOMqH
         60t+EPkXymD4L6MeSOEBdGEkIUc1I5SUAT9bcx9S3HVZZTaSnutYSWTzmI/C2g902sgs
         jIrw==
X-Gm-Message-State: AOAM533FjMvZZeG6/ok+Ri1mLG3ey9BZObiGpL9bq7puABsMwUAo8SOb
        iB5YMUwlyXiDApL/mx2gLtKsJdgVYRKPJw==
X-Google-Smtp-Source: ABdhPJzqoE6oBIysCRBzT0ZIDWCqsGYBMyGxRf6Gw28Pk2bLk+zOMOi8LrDLPIDPTIHl3nmlLR97Pw==
X-Received: by 2002:a05:6000:2a9:b0:210:2530:be32 with SMTP id l9-20020a05600002a900b002102530be32mr9667568wry.153.1654281494624;
        Fri, 03 Jun 2022 11:38:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 15/15] config.mak.dev: add and use ASSERT_FOR_FANALYZER() macro
Date:   Fri,  3 Jun 2022 20:37:52 +0200
Message-Id: <RFC-patch-15.15-16bd2270b4c-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an ASSERT_FOR_FANALYZER() macro to quiet those -fanalyzer issues
that haven't been diagnosed yet to either change the code involved, or
to add an assert() or BUG() to it to placate GCC v12's -fanalyzer
mode.

As in the preceding commit we could also use -Wno-error=* here, which
was the initial implementation in config.mak.dev, i.e. something like:

	## -Wno-error=analyzer-null-dereference
	$(eval $(call fn_disable_analyzer, \
		-Wno-error=analyzer-null-dereference, \
		dir \
		gpg-interface \
		graph \
		range-diff \
		utf8 \
	))
	## -Wno-error=analyzer-null-dereference: pre-gcc12
	ifeq ($(filter gcc12,$(COMPILER_FEATURES)),)
	$(eval $(call fn_disable_analyzer, \
		-Wno-error=analyzer-null-dereference, \
		merge \
		builtin/name-rev \
	))
	endif

But any such approach will unfortunately quiet *all* in the relevant
files, including any new ones. Instead we want to quiet specific
issues involved with ASSERT_FOR_FANALYZER().

A drawback of this overall approach is that this only works under
e.g. CFLAGS=-O0, but not CFLAGS=-O3. The compiler takes the liberty to
re-arrange our code to get around these assert()s, and other new
issues will also crop up. All of this is expected (-fanalyzer is
subject to optimization passes, like most other options), but let's
focus on -O0 for now.

Commentary on specific cases:

 * builtin/name-rev.c: Since 45a14f578e1 (Revert "name-rev: release
   unused name strings", 2022-04-22) GCC v12's -fanalyzer has complained
   about this code, per René's analysis in [1] it's incorrect to do
   so. So let's add an ASSERT_FOR_FANALYZER() to placate it.

 * graph.c: In 0f0f389f120 (graph: tidy up display of left-skewed
   merges, 2019-10-15) a previous "assert" was removed, and another
   unconditional deference of the return value of
   first_interesting_parent() was added without checking it. Since it
   can return NULL let's add ASSERT_FOR_FANALYZER()'s here to note for
   -fanalyzer that we won't be dereferencing these in practice.

1. https://lore.kernel.org/git/dece627d-ccf8-2375-0c50-c59637e561d3@web.de/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/name-rev.c |  1 +
 config.mak.dev     |  4 ++++
 dir.c              |  1 +
 git-compat-util.h  | 16 ++++++++++++++++
 gpg-interface.c    |  2 ++
 graph.c            |  2 ++
 line-log.c         |  2 ++
 unpack-trees.c     |  1 +
 utf8.c             |  1 +
 9 files changed, 30 insertions(+)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 02ea9d16330..419159961b9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -223,6 +223,7 @@ static void name_rev(struct commit *start_commit,
 			if (commit_is_before_cutoff(parent))
 				continue;
 
+			ASSERT_FOR_FANALYZER(name);
 			if (parent_number > 1) {
 				generation = 0;
 				distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
diff --git a/config.mak.dev b/config.mak.dev
index d6f5be92297..1d47fc04163 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -83,6 +83,10 @@ endif
 
 DEVELOPER_CFLAGS += -fanalyzer
 
+ifeq ($(filter no-suppress-analyzer,$(DEVOPTS)),)
+DEVELOPER_CFLAGS += -DSUPPRESS_FSANITIZER
+endif
+
 ## -fanalyzer exists exists as of gcc10, but versions older than gcc12
 ## have a lot of false positives.
 ifeq ($(filter gcc12,$(COMPILER_FEATURES)),)
diff --git a/dir.c b/dir.c
index 3633c0852ee..c80b584b4a7 100644
--- a/dir.c
+++ b/dir.c
@@ -3781,6 +3781,7 @@ static void invalidate_one_directory(struct untracked_cache *uc,
 				     struct untracked_cache_dir *ucd)
 {
 	uc->dir_invalidated++;
+	ASSERT_FOR_FANALYZER(ucd);
 	ucd->valid = 0;
 	ucd->untracked_nr = 0;
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 96293b6c43a..a553884c048 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -984,6 +984,21 @@ static inline unsigned long cast_size_t_to_ulong(size_t a)
 	return (unsigned long)a;
 }
 
+/**
+ * Transitory helper macro to quiet currently known GCC -fsanitizer
+ * issues.
+ *
+ * We lie to it and say that we're confident that the given "expr" to
+ * ASSERT_FOR_FANALYZER() cannot be NULL (or 0). Those
+ * grandfathered-in issues should be fixed, but at least we're
+ * stemming the tide.
+ */
+#ifdef SUPPRESS_FSANITIZER
+#define ASSERT_FOR_FANALYZER(expr) assert((expr))
+#else
+#define ASSERT_FOR_FANALYZER(expr) do {} while (0)
+#endif
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))
@@ -1037,6 +1052,7 @@ int xstrncmpz(const char *s, const char *t, size_t len);
 	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
 static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
 {
+	ASSERT_FOR_FANALYZER(dst);
 	if (n)
 		memcpy(dst, src, st_mult(size, n));
 }
diff --git a/gpg-interface.c b/gpg-interface.c
index 280f1fa1a58..9cba3b86e45 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -242,6 +242,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 					next = strchrnul(line, ' ');
 					replace_cstring(&sigc->key, line, next);
 					/* Do we have signer information? */
+					ASSERT_FOR_FANALYZER(next);
 					if (*next && (sigcheck_gpg_status[i].flags & GPG_STATUS_UID)) {
 						line = next + 1;
 						next = strchrnul(line, '\n');
@@ -283,6 +284,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 					 */
 					limit = strchrnul(line, '\n');
 					for (j = 9; j > 0; j--) {
+						ASSERT_FOR_FANALYZER(next);
 						if (!*next || limit <= next)
 							break;
 						line = next + 1;
diff --git a/graph.c b/graph.c
index 568b6e7cd41..39f7e95d4ab 100644
--- a/graph.c
+++ b/graph.c
@@ -1105,6 +1105,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			seen_this = 1;
 
 			for (j = 0; j < graph->num_parents; j++) {
+				ASSERT_FOR_FANALYZER(parents);
 				par_column = graph_find_new_column_by_commit(graph, parents->item);
 				assert(par_column >= 0);
 
@@ -1138,6 +1139,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			}
 		}
 
+		ASSERT_FOR_FANALYZER(first_parent);
 		if (col_commit == first_parent->item)
 			parent_col = col;
 	}
diff --git a/line-log.c b/line-log.c
index 51d93310a4d..1295f46deaf 100644
--- a/line-log.c
+++ b/line-log.c
@@ -154,6 +154,7 @@ static void range_set_union(struct range_set *out,
 	while (i < a->nr || j < b->nr) {
 		struct range *new_range;
 		if (i < a->nr && j < b->nr) {
+			ASSERT_FOR_FANALYZER(rb);
 			if (ra[i].start < rb[j].start)
 				new_range = &ra[i++];
 			else if (ra[i].start > rb[j].start)
@@ -166,6 +167,7 @@ static void range_set_union(struct range_set *out,
 			new_range = &ra[i++];
 		else                       /* a exhausted */
 			new_range = &rb[j++];
+		ASSERT_FOR_FANALYZER(new_range);
 		if (new_range->start == new_range->end)
 			; /* empty range */
 		else if (!out->nr || out->ranges[out->nr-1].end < new_range->start) {
diff --git a/unpack-trees.c b/unpack-trees.c
index a1d0ff3a4d3..b6e10b05a00 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2195,6 +2195,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	char *pathbuf;
 	int cnt = 0;
 
+	ASSERT_FOR_FANALYZER(ce);
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct object_id oid;
 		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", &oid);
diff --git a/utf8.c b/utf8.c
index de4ce5c0e68..3ffc0a97f3b 100644
--- a/utf8.c
+++ b/utf8.c
@@ -130,6 +130,7 @@ static ucs_char_t pick_one_utf8_char(const char **start, size_t *remainder_p)
 	 */
 	remainder = (remainder_p ? *remainder_p : 999);
 
+	ASSERT_FOR_FANALYZER(remainder < 1 || s);
 	if (remainder < 1) {
 		goto invalid;
 	} else if (*s < 0x80) {
-- 
2.36.1.1124.g577fa9c2ebd

