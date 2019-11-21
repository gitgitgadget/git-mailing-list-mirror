Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9396BC43215
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5719A2068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuKxgmrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKUWFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37763 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKUWFF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so4113476wmf.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v7BNALQq5QzaAlOjzfT78+LGH1XjX6y+F3G1lsXugk4=;
        b=UuKxgmrJg/Zqs0aSN5+JvkvqRWSgWu4/xCBQwXLs4WxcHNa5KVVCO8EBzg4wNmf7eI
         GXRINXVxCTYK845yR6U3wWBVyiKmDTT4cJ7GOP2bxh6DI1JeaCJ4n2Qzqr90Kp2Wi9gQ
         G2I+nLS37CZFPEyZD4w2+2eJiK6KYTtLow9xX4in4naPbzZaOeFYNH86HBENbws59NpC
         kD0Vd3diJEGgC9IQCKoiSpuZvtN+rsBKiWGpBjVTXmqhBBxGHl1Ou/qNj8OWnN4leUCx
         BalaAzkvZVjpuWPQcKJe7inaRgxO/60sIdLAgMdKyvJl2tCEEcGoIdOTWOloTZeorskx
         qoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v7BNALQq5QzaAlOjzfT78+LGH1XjX6y+F3G1lsXugk4=;
        b=uHoUTD0ykIcjfExzgq8nxkIE1r5E3xNauVcWkRGsjqWfngMwzfOQlrJJBvPNpCdahN
         JUDOz1Fl9tFK108JeV38NAFLiKosutMpM1b1m/Vped04uOrgIWS/hbGxGCrk2apjD4Kh
         uWK3bd2yUpvzWbvAHT0Y6h059bGbmQNslS6Hm5LLQMPJx1Y0qU2pqUYci+XXLH5VYLfH
         fCYzWRwtmZg0vVB7dPQfTmVO+y4zPFRisUpzT2955tL1qHBYPI0DlYrLtt9A02iKz8Qs
         jJmqAaHNbRZ8yH9UFPjDGszCMs1zHi/kSpWtuPaF4DIiOXlBRPLgmQKqF4BNLEVHnBbH
         ptNg==
X-Gm-Message-State: APjAAAWwFgbilhFhcsjGJRRvhcOYSL522Ns2F44n6tpqtHOlL4GaNuwh
        J9GjUOtmaWkhXPpTmzbSytnZnrmM
X-Google-Smtp-Source: APXvYqy50kij9e2zQxhv4YEYW/cbgowLhwFTIqLyQJybhb9CuiHip9tsd5odPjGyePmnj848EezICw==
X-Received: by 2002:a1c:2048:: with SMTP id g69mr12914591wmg.121.1574373901671;
        Thu, 21 Nov 2019 14:05:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 76sm1203462wma.0.2019.11.21.14.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:01 -0800 (PST)
Message-Id: <eca0bbf930918bc0417c1ad73a9f75aee8c5cfb3.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:41 +0000
Subject: [PATCH v6 09/19] sparse-checkout: use hashmaps for cone patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The parent and recursive patterns allowed by the "cone mode"
option in sparse-checkout are restrictive enough that we
can avoid using the regex parsing. Everything is based on
prefix matches, so we can use hashsets to store the prefixes
from the sparse-checkout file. When checking a path, we can
strip path entries from the path and check the hashset for
an exact match.

As a test, I created a cone-mode sparse-checkout file for the
Linux repository that actually includes every file. This was
constructed by taking every folder in the Linux repo and creating
the pattern pairs here:

	/$folder/
	!/$folder/*/

This resulted in a sparse-checkout file sith 8,296 patterns.
Running 'git read-tree -mu HEAD' on this file had the following
performance:

    core.sparseCheckout=false: 0.21 s (0.00 s)
     core.sparseCheckout=true: 3.75 s (3.50 s)
 core.sparseCheckoutCone=true: 0.23 s (0.01 s)

The times in parentheses above correspond to the time spent
in the first clear_ce_flags() call, according to the trace2
performance traces.

While this example is contrived, it demonstrates how these
patterns can slow the sparse-checkout feature.

Helped-by: Eric Wong <e@80x24.org>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 207 +++++++++++++++++++++++++++--
 dir.h                              |  31 +++++
 t/t1091-sparse-checkout-builtin.sh |  11 +-
 unpack-trees.c                     |   1 +
 4 files changed, 241 insertions(+), 9 deletions(-)

diff --git a/dir.c b/dir.c
index 61f559f980..dfabf9982f 100644
--- a/dir.c
+++ b/dir.c
@@ -611,6 +611,150 @@ void parse_path_pattern(const char **pattern,
 	*patternlen = len;
 }
 
+static int pl_hashmap_cmp(const void *unused_cmp_data,
+			  const struct hashmap_entry *a,
+			  const struct hashmap_entry *b,
+			  const void *key)
+{
+	const struct pattern_entry *ee1 =
+			container_of(a, struct pattern_entry, ent);
+	const struct pattern_entry *ee2 =
+			container_of(b, struct pattern_entry, ent);
+
+	size_t min_len = ee1->patternlen <= ee2->patternlen
+			 ? ee1->patternlen
+			 : ee2->patternlen;
+
+	return strncmp(ee1->pattern, ee2->pattern, min_len);
+}
+
+static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern *given)
+{
+	struct pattern_entry *translated;
+	char *truncated;
+	char *data = NULL;
+
+	if (!pl->use_cone_patterns)
+		return;
+
+	if (given->flags & PATTERN_FLAG_NEGATIVE &&
+	    given->flags & PATTERN_FLAG_MUSTBEDIR &&
+	    !strcmp(given->pattern, "/*")) {
+		pl->full_cone = 0;
+		return;
+	}
+
+	if (!given->flags && !strcmp(given->pattern, "/*")) {
+		pl->full_cone = 1;
+		return;
+	}
+
+	if (given->patternlen > 2 &&
+	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
+		if (!(given->flags & PATTERN_FLAG_NEGATIVE)) {
+			/* Not a cone pattern. */
+			pl->use_cone_patterns = 0;
+			warning(_("unrecognized pattern: '%s'"), given->pattern);
+			goto clear_hashmaps;
+		}
+
+		truncated = xstrdup(given->pattern);
+		truncated[given->patternlen - 2] = 0;
+
+		translated = xmalloc(sizeof(struct pattern_entry));
+		translated->pattern = truncated;
+		translated->patternlen = given->patternlen - 2;
+		hashmap_entry_init(&translated->ent,
+				   memhash(translated->pattern, translated->patternlen));
+
+		if (!hashmap_get_entry(&pl->recursive_hashmap,
+				       translated, ent, NULL)) {
+			/* We did not see the "parent" included */
+			warning(_("unrecognized negative pattern: '%s'"),
+				given->pattern);
+			free(truncated);
+			free(translated);
+			goto clear_hashmaps;
+		}
+
+		hashmap_add(&pl->parent_hashmap, &translated->ent);
+		hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
+		free(data);
+		return;
+	}
+
+	if (given->flags & PATTERN_FLAG_NEGATIVE) {
+		warning(_("unrecognized negative pattern: '%s'"),
+			given->pattern);
+		goto clear_hashmaps;
+	}
+
+	translated = xmalloc(sizeof(struct pattern_entry));
+
+	translated->pattern = xstrdup(given->pattern);
+	translated->patternlen = given->patternlen;
+	hashmap_entry_init(&translated->ent,
+			   memhash(translated->pattern, translated->patternlen));
+
+	hashmap_add(&pl->recursive_hashmap, &translated->ent);
+
+	if (hashmap_get_entry(&pl->parent_hashmap, translated, ent, NULL)) {
+		/* we already included this at the parent level */
+		warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
+			given->pattern);
+		hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
+		free(data);
+		free(translated);
+	}
+
+	return;
+
+clear_hashmaps:
+	warning(_("disabling cone pattern matching"));
+	hashmap_free_entries(&pl->parent_hashmap, struct pattern_entry, ent);
+	hashmap_free_entries(&pl->recursive_hashmap, struct pattern_entry, ent);
+	pl->use_cone_patterns = 0;
+}
+
+static int hashmap_contains_path(struct hashmap *map,
+				 struct strbuf *pattern)
+{
+	struct pattern_entry p;
+
+	/* Check straight mapping */
+	p.pattern = pattern->buf;
+	p.patternlen = pattern->len;
+	hashmap_entry_init(&p.ent, memhash(p.pattern, p.patternlen));
+	return !!hashmap_get_entry(map, &p, ent, NULL);
+}
+
+int hashmap_contains_parent(struct hashmap *map,
+			    const char *path,
+			    struct strbuf *buffer)
+{
+	char *slash_pos;
+
+	strbuf_setlen(buffer, 0);
+
+	if (path[0] != '/')
+		strbuf_addch(buffer, '/');
+
+	strbuf_addstr(buffer, path);
+
+	slash_pos = strrchr(buffer->buf, '/');
+
+	while (slash_pos > buffer->buf) {
+		strbuf_setlen(buffer, slash_pos - buffer->buf);
+
+		if (hashmap_contains_path(map, buffer))
+			return 1;
+
+		slash_pos = strrchr(buffer->buf, '/');
+	}
+
+	return 0;
+}
+
 void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos)
 {
@@ -635,6 +779,8 @@ void add_pattern(const char *string, const char *base,
 	ALLOC_GROW(pl->patterns, pl->nr + 1, pl->alloc);
 	pl->patterns[pl->nr++] = pattern;
 	pattern->pl = pl;
+
+	add_pattern_to_hashsets(pl, pattern);
 }
 
 static int read_skip_worktree_file_from_index(const struct index_state *istate,
@@ -860,6 +1006,9 @@ static int add_patterns_from_buffer(char *buf, size_t size,
 	int i, lineno = 1;
 	char *entry;
 
+	hashmap_init(&pl->recursive_hashmap, pl_hashmap_cmp, NULL, 0);
+	hashmap_init(&pl->parent_hashmap, pl_hashmap_cmp, NULL, 0);
+
 	pl->filebuf = buf;
 
 	if (skip_utf8_bom(&buf, size))
@@ -1096,16 +1245,58 @@ enum pattern_match_result path_matches_pattern_list(
 				struct index_state *istate)
 {
 	struct path_pattern *pattern;
-	pattern = last_matching_pattern_from_list(pathname, pathlen, basename,
-						  dtype, pl, istate);
-	if (pattern) {
-		if (pattern->flags & PATTERN_FLAG_NEGATIVE)
-			return NOT_MATCHED;
-		else
-			return MATCHED;
+	struct strbuf parent_pathname = STRBUF_INIT;
+	int result = NOT_MATCHED;
+	const char *slash_pos;
+
+	if (!pl->use_cone_patterns) {
+		pattern = last_matching_pattern_from_list(pathname, pathlen, basename,
+							dtype, pl, istate);
+		if (pattern) {
+			if (pattern->flags & PATTERN_FLAG_NEGATIVE)
+				return NOT_MATCHED;
+			else
+				return MATCHED;
+		}
+
+		return UNDECIDED;
+	}
+
+	if (pl->full_cone)
+		return MATCHED;
+
+	strbuf_addch(&parent_pathname, '/');
+	strbuf_add(&parent_pathname, pathname, pathlen);
+
+	if (hashmap_contains_path(&pl->recursive_hashmap,
+				  &parent_pathname)) {
+		result = MATCHED;
+		goto done;
+	}
+
+	slash_pos = strrchr(parent_pathname.buf, '/');
+
+	if (slash_pos == parent_pathname.buf) {
+		/* include every file in root */
+		result = MATCHED;
+		goto done;
 	}
 
-	return UNDECIDED;
+	strbuf_setlen(&parent_pathname, slash_pos - parent_pathname.buf);
+
+	if (hashmap_contains_path(&pl->parent_hashmap, &parent_pathname)) {
+		result = MATCHED;
+		goto done;
+	}
+
+	if (hashmap_contains_parent(&pl->recursive_hashmap,
+				    pathname,
+				    &parent_pathname))
+		result = MATCHED;
+
+done:
+	strbuf_release(&parent_pathname);
+	return result;
 }
 
 static struct path_pattern *last_matching_pattern_from_lists(
diff --git a/dir.h b/dir.h
index 2fbdef014f..f8edbca72b 100644
--- a/dir.h
+++ b/dir.h
@@ -4,6 +4,7 @@
 /* See Documentation/technical/api-directory-listing.txt */
 
 #include "cache.h"
+#include "hashmap.h"
 #include "strbuf.h"
 
 struct dir_entry {
@@ -37,6 +38,13 @@ struct path_pattern {
 	int srcpos;
 };
 
+/* used for hashmaps for cone patterns */
+struct pattern_entry {
+	struct hashmap_entry ent;
+	char *pattern;
+	size_t patternlen;
+};
+
 /*
  * Each excludes file will be parsed into a fresh exclude_list which
  * is appended to the relevant exclude_list_group (either EXC_DIRS or
@@ -55,6 +63,26 @@ struct pattern_list {
 	const char *src;
 
 	struct path_pattern **patterns;
+
+	/*
+	 * While scanning the excludes, we attempt to match the patterns
+	 * with a more restricted set that allows us to use hashsets for
+	 * matching logic, which is faster than the linear lookup in the
+	 * excludes array above. If non-zero, that check succeeded.
+	 */
+	unsigned use_cone_patterns;
+	unsigned full_cone;
+
+	/*
+	 * Stores paths where everything starting with those paths
+	 * is included.
+	 */
+	struct hashmap recursive_hashmap;
+
+	/*
+	 * Used to check single-level parents of blobs.
+	 */
+	struct hashmap parent_hashmap;
 };
 
 /*
@@ -271,6 +299,9 @@ int is_excluded(struct dir_struct *dir,
 		struct index_state *istate,
 		const char *name, int *dtype);
 
+int hashmap_contains_parent(struct hashmap *map,
+			    const char *path,
+			    struct strbuf *buffer);
 struct pattern_list *add_pattern_list(struct dir_struct *dir,
 				      int group_type, const char *src);
 int add_patterns_from_file_to_list(const char *fname, const char *base, int baselen,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 0b2715db52..1ed003ac1d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -151,7 +151,8 @@ test_expect_success 'set sparse-checkout using --stdin' '
 test_expect_success 'cone mode: match patterns' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	rm -rf repo/a repo/folder1 repo/folder2 &&
-	git -C repo read-tree -mu HEAD &&
+	git -C repo read-tree -mu HEAD 2>err &&
+	test_i18ngrep ! "disabling cone patterns" err &&
 	git -C repo reset --hard &&
 	ls repo >dir  &&
 	cat >expect <<-EOF &&
@@ -162,6 +163,14 @@ test_expect_success 'cone mode: match patterns' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: warn on bad pattern' '
+	test_when_finished mv sparse-checkout repo/.git/info/ &&
+	cp repo/.git/info/sparse-checkout . &&
+	echo "!/deep/deeper/*" >>repo/.git/info/sparse-checkout &&
+	git -C repo read-tree -mu HEAD 2>err &&
+	test_i18ngrep "unrecognized negative pattern" err
+'
+
 test_expect_success 'sparse-checkout disable' '
 	git -C repo sparse-checkout disable &&
 	test_path_is_missing repo/.git/info/sparse-checkout &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 01a05ff66d..a90d71845d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1482,6 +1482,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		char *sparse = git_pathdup("info/sparse-checkout");
+		pl.use_cone_patterns = core_sparse_checkout_cone;
 		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
 			o->skip_sparse_checkout = 1;
 		else
-- 
gitgitgadget

