Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A95EC8759
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 21:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjIGVwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbjIGVwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 17:52:13 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E221BC6
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 14:52:07 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59234aaca15so14585007b3.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1694123526; x=1694728326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CE1Ks7tMYMGJVUDbLeW0HTeeUS5WEmOyODNT2A77j7Q=;
        b=wHRAwwz61S6Q+jm5C+I4K/KsyzeAl16YMa9wj5kt2mOneTkINXnARwxou6qvCHlnIP
         sse4lLYnmGjIk8671xbcDHSafZDB/4GMf4rnTJj1wfLuCa2lps3kvSYY1SwRa3nDUtn+
         VoXLev9H+toZnIqXWc/8rV/Ro/EWD/qe8Y7E6rH54cP66Rs+A4NTHBKHzKDBMyoHsY27
         epb/nUlfDvt5xSXJyH/+Tn2FCY/kXYBtHNXSdl1uGTOaELmZzyVIF3Czi3WSMP9/SL8v
         a5Bn6t1G8pn4mG2XzZI9MpCk51lzJyEUsid/IG4S85pPCUGlwidGurjVeDoHWXKBod42
         eDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694123526; x=1694728326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE1Ks7tMYMGJVUDbLeW0HTeeUS5WEmOyODNT2A77j7Q=;
        b=X5zz0J9z/yZBr17l0MY3Zc4g+Z7RrcqGg8CCl02M+3uHaXxblgG66yiX/8eryv+JCt
         1Gk2UjPY+5atiQE82sxc6ZoQFxLPovzC28s+RaL8iqcA7UFSTBTanJRjpKIVJhThrrCc
         ioA8AKlIB14cWHQWmyVfhcEfeW4Q8Rrx2Mpfi6sEUKDGb7aygfw9euWBB0ws42PgzOjT
         o+QihcDAHkl984ndUmCcVyh3CMeFwVUgR43gV+MllB60ae3L3V7+YYQsHOpmQ8dtkQlX
         qIxNpLaXWMqLsJ9LSx+SRzRwd6dci8GsVJiL59+jIlrZLE2gbeOn6j0HZ8VFD0Ms0Qnu
         PS8g==
X-Gm-Message-State: AOJu0YyJSDONK1cCnAlHpIXZmnvF0E+PNLmOm3i0gHV/zFQL7PddQIBG
        de7Rb6WeH13vsD+LX1CgTh5wlqjqklElgenXocgvDg==
X-Google-Smtp-Source: AGHT+IEAhupRCuvPTbTb/Zk/EsQLBFrakEfK6u/v1DGe7VujoWl+HgfHIXO3miqNhZEMVj7KT+v6Zw==
X-Received: by 2002:a81:a195:0:b0:592:8893:3fa2 with SMTP id y143-20020a81a195000000b0059288933fa2mr908532ywg.29.1694123526216;
        Thu, 07 Sep 2023 14:52:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r3-20020a0de803000000b00586a09026casm97611ywe.34.2023.09.07.14.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 14:52:05 -0700 (PDT)
Date:   Thu, 7 Sep 2023 17:52:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/2] builtin/repack.c: implement support for
 `--cruft-max-size`
Message-ID: <7e4e42e1aacf2111f04a933c0725a8c81769f8d6.1694123506.git.me@ttaylorr.com>
References: <cover.1694123506.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694123506.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cruft packs are an alternative mechanism for storing a collection of
unreachable objects whose mtimes are recent enough to avoid being
pruned out of the repository.

When cruft packs were first introduced back in b757353676
(builtin/pack-objects.c: --cruft without expiration, 2022-05-20) and
a7d493833f (builtin/pack-objects.c: --cruft with expiration,
2022-05-20), the recommended workflow consisted of:

  - Repacking periodically, either by packing anything loose in the
    repository (via `git repack -d`) or producing a geometric sequence
    of packs (via `git repack --geometric=<d> -d`).

  - Every so often, splitting the repository into two packs, one cruft
    to store the unreachable objects, and another non-cruft pack to
    store the reachable objects.

Repositories may (out of band with the above) choose periodically to
prune out some unreachable objects which have aged out of the grace
period by generating a pack with `--cruft-expiration=<approxidate>`.

This allowed repositories to maintain relatively few packs on average,
and quarantine unreachable objects together in a cruft pack, avoiding
the pitfalls of holding unreachable objects as loose while they age out
(for more, see some of the details in 3d89a8c118
(Documentation/technical: add cruft-packs.txt, 2022-05-20)).

This all works, but can be costly from an I/O-perspective when a
repository has either (a) many unreachable objects, (b) prunes objects
relatively infrequently/never, or (c) both.

Since there is at most one cruft pack in the above scheme, each time we
update the cruft pack it must be rewritten from scratch. Because much of
the pack is reused, this is a relatively inexpensive operation from a
CPU-perspective, but is very costly in terms of I/O since we end up
rewriting basically the same pack (plus any new unreachable objects that
have entered the repository since the last time a cruft pack was
generated).

At the time, we decided against implementing more robust support for
multiple cruft packs. This patch implements that support which we were
lacking.

Introduce a new option `--cruft-max-size` which allows repositories to
accumulate cruft packs up to a given size, after which point a new
generation of cruft packs can accumulate until it reaches the maximum
size, and so on. To generate a new cruft pack, the process works like
so:

  - Sort a list of any existing cruft packs in ascending order of pack
    size.

  - Starting from the beginning of the list, group cruft packs together
    while the accumulated size is smaller than the maximum specified
    pack size.

  - Combine the objects in these cruft packs together into a new cruft
    pack, along with any other unreachable objects which have since
    entered the repository.

This limits the I/O churn up to a quadratic function of the value
specified by the `--cruft-max-size` option, instead of behaving
quadratically in the number of total unreachable objects.

When pruning unreachable objects, we bypass the new paths which combine
small cruft packs together, and instead start from scratch, passing in
the appropriate `--max-pack-size` down to `pack-objects`, putting it in
charge of keeping the resulting set of cruft packs sized correctly.

This may seem like further I/O churn, but in practice it isn't so bad.
We could prune old cruft packs for whom all or most objects are removed,
and then generate a new cruft pack with just the remaining set of
objects. But this additional complexity buys us relatively little,
because most objects end up being pruned anyway, so the I/O churn is
well contained.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/gc.txt  |   6 +
 Documentation/git-gc.txt     |   7 +
 Documentation/git-repack.txt |   9 ++
 builtin/gc.c                 |   8 ++
 builtin/repack.c             | 133 +++++++++++++++++--
 t/t6500-gc.sh                |  27 ++++
 t/t7704-repack-cruft.sh      | 245 +++++++++++++++++++++++++++++++++++
 7 files changed, 423 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index ca47eb2008..795fcfbb69 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -86,6 +86,12 @@ gc.cruftPacks::
 	linkgit:git-repack[1]) instead of as loose objects. The default
 	is `true`.
 
+gc.cruftMaxSize::
+	Limit the size of new cruft packs when repacking. When
+	specified in addition to `--cruft-max-size`, the command line
+	option takes priority. See the `--cruft-max-size` option of
+	linkgit:git-repack[1].
+
 gc.pruneExpire::
 	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'
 	(and 'repack --cruft --cruft-expiration 2.weeks.ago' if using
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 90806fd26a..8a90d684a7 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -59,6 +59,13 @@ be performed as well.
 	cruft pack instead of storing them as loose objects. `--cruft`
 	is on by default.
 
+--cruft-max-size=<n>::
+	When packing unreachable objects into a cruft pack, limit the
+	size of new cruft packs to be at most `<n>`. Overrides any
+	value specified via the `gc.cruftMaxSize` configuration. See
+	the `--cruft-max-size` option of linkgit:git-repack[1] for
+	more.
+
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4017157949..23fd203d79 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -74,6 +74,15 @@ to the new separate pack will be written.
 	immediately instead of waiting for the next `git gc` invocation.
 	Only useful with `--cruft -d`.
 
+--cruft-max-size=<n>::
+	Repack cruft objects into packs as large as `<n>` before
+	creating new packs. As long as there are enough cruft packs
+	smaller than `<n>`, repacking will cause a new cruft pack to
+	be created containing objects from any combined cruft packs,
+	along with any new unreachable objects. Cruft packs larger
+	than `<n>` will not be modified. Only useful with `--cruft
+	-d`.
+
 --expire-to=<dir>::
 	Write a cruft pack containing pruned objects (if any) to the
 	directory `<dir>`. This option is useful for keeping a copy of
diff --git a/builtin/gc.c b/builtin/gc.c
index 1f53b66c7b..b6640abd35 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -52,6 +52,7 @@ static const char * const builtin_gc_usage[] = {
 static int pack_refs = 1;
 static int prune_reflogs = 1;
 static int cruft_packs = 1;
+static char *cruft_max_size;
 static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
@@ -163,6 +164,7 @@ static void gc_config(void)
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_bool("gc.cruftpacks", &cruft_packs);
+	git_config_get_string("gc.cruftmaxsize", &cruft_max_size);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
@@ -347,6 +349,9 @@ static void add_repack_all_option(struct string_list *keep_pack)
 		strvec_push(&repack, "--cruft");
 		if (prune_expire)
 			strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);
+		if (cruft_max_size)
+			strvec_pushf(&repack, "--cruft-max-size=%s",
+				     cruft_max_size);
 	} else {
 		strvec_push(&repack, "-A");
 		if (prune_expire)
@@ -575,6 +580,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			N_("prune unreferenced objects"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
 		OPT_BOOL(0, "cruft", &cruft_packs, N_("pack unreferenced objects separately")),
+		OPT_STRING(0, "cruft-max-size", &cruft_max_size,
+			   N_("bytes"),
+			   N_("with --cruft, limit the size of new cruft packs")),
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
 			   PARSE_OPT_NOCOMPLETE),
diff --git a/builtin/repack.c b/builtin/repack.c
index 44cb261371..56e7f5f43d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -26,6 +26,9 @@
 #define LOOSEN_UNREACHABLE 2
 #define PACK_CRUFT 4
 
+#define DELETE_PACK ((void*)(uintptr_t)1)
+#define RETAIN_PACK ((uintptr_t)(1<<1))
+
 static int pack_everything;
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -113,6 +116,11 @@ static int has_existing_non_kept_packs(const struct existing_packs *existing)
 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
 }
 
+static int pack_is_retained(struct string_list_item *item)
+{
+	return (uintptr_t)item->util & RETAIN_PACK;
+}
+
 static void mark_packs_for_deletion_1(struct string_list *names,
 				      struct string_list *list)
 {
@@ -125,17 +133,39 @@ static void mark_packs_for_deletion_1(struct string_list *names,
 		if (len < hexsz)
 			continue;
 		sha1 = item->string + len - hexsz;
-		/*
-		 * Mark this pack for deletion, which ensures that this
-		 * pack won't be included in a MIDX (if `--write-midx`
-		 * was given) and that we will actually delete this pack
-		 * (if `-d` was given).
-		 */
-		if (!string_list_has_string(names, sha1))
-			item->util = (void*)1;
+
+		if (pack_is_retained(item)) {
+			item->util = NULL;
+		} else if (!string_list_has_string(names, sha1)) {
+			/*
+			 * Mark this pack for deletion, which ensures
+			 * that this pack won't be included in a MIDX
+			 * (if `--write-midx` was given) and that we
+			 * will actually delete this pack (if `-d` was
+			 * given).
+			 */
+			item->util = DELETE_PACK;
+		}
 	}
 }
 
+static void retain_cruft_pack(struct existing_packs *existing,
+			      struct packed_git *cruft)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+
+	strbuf_addstr(&buf, pack_basename(cruft));
+	strbuf_strip_suffix(&buf, ".pack");
+
+	item = string_list_lookup(&existing->cruft_packs, buf.buf);
+	if (!item)
+		BUG("could not find cruft pack '%s'", pack_basename(cruft));
+
+	item->util = (void*)RETAIN_PACK;
+	strbuf_release(&buf);
+}
+
 static void mark_packs_for_deletion(struct existing_packs *existing,
 				    struct string_list *names)
 
@@ -217,6 +247,8 @@ static void collect_pack_filenames(struct existing_packs *existing,
 	}
 
 	string_list_sort(&existing->kept_packs);
+	string_list_sort(&existing->non_kept_packs);
+	string_list_sort(&existing->cruft_packs);
 	strbuf_release(&buf);
 }
 
@@ -799,6 +831,72 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static int existing_cruft_pack_cmp(const void *va, const void *vb)
+{
+	struct packed_git *a = *(struct packed_git **)va;
+	struct packed_git *b = *(struct packed_git **)vb;
+
+	if (a->pack_size < b->pack_size)
+		return -1;
+	if (a->pack_size > b->pack_size)
+		return 1;
+	return 0;
+}
+
+static void collapse_small_cruft_packs(FILE *in, unsigned long max_size,
+				       struct existing_packs *existing)
+{
+	struct packed_git **existing_cruft, *p;
+	struct strbuf buf = STRBUF_INIT;
+	unsigned long total_size = 0;
+	size_t existing_cruft_nr = 0;
+	size_t i;
+
+	ALLOC_ARRAY(existing_cruft, existing->cruft_packs.nr);
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		if (!(p->is_cruft && p->pack_local))
+			continue;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(p));
+		strbuf_strip_suffix(&buf, ".pack");
+
+		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
+			continue;
+
+		if (existing_cruft_nr >= existing->cruft_packs.nr)
+			BUG("too many cruft packs (found %"PRIuMAX", but knew "
+			    "of %"PRIuMAX")",
+			    (uintmax_t)existing_cruft_nr + 1,
+			    (uintmax_t)existing->cruft_packs.nr);
+		existing_cruft[existing_cruft_nr++] = p;
+	}
+
+	QSORT(existing_cruft, existing_cruft_nr, existing_cruft_pack_cmp);
+
+	for (i = 0; i < existing_cruft_nr; i++) {
+		off_t proposed;
+
+		p = existing_cruft[i];
+		proposed = st_add(total_size, p->pack_size);
+
+		if (proposed <= max_size) {
+			total_size = proposed;
+			fprintf(in, "-%s\n", pack_basename(p));
+		} else {
+			retain_cruft_pack(existing, p);
+			fprintf(in, "%s\n", pack_basename(p));
+		}
+	}
+
+	for (i = 0; i < existing->non_kept_packs.nr; i++)
+		fprintf(in, "-%s.pack\n",
+			existing->non_kept_packs.items[i].string);
+
+	strbuf_release(&buf);
+}
+
 static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *destination,
 			    const char *pack_prefix,
@@ -846,10 +944,18 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
 		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
-	for_each_string_list_item(item, &existing->non_kept_packs)
-		fprintf(in, "-%s.pack\n", item->string);
-	for_each_string_list_item(item, &existing->cruft_packs)
-		fprintf(in, "-%s.pack\n", item->string);
+	if (args->max_pack_size && !cruft_expiration) {
+		unsigned long max_pack_size;
+		if (!git_parse_ulong(args->max_pack_size, &max_pack_size))
+			return error(_("could not parse --cruft-max-size: '%s'"),
+				     args->max_pack_size);
+		collapse_small_cruft_packs(in, max_pack_size, existing);
+	} else {
+		for_each_string_list_item(item, &existing->non_kept_packs)
+			fprintf(in, "-%s.pack\n", item->string);
+		for_each_string_list_item(item, &existing->cruft_packs)
+			fprintf(in, "-%s.pack\n", item->string);
+	}
 	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
@@ -912,6 +1018,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				   PACK_CRUFT),
 		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
 				N_("with --cruft, expire objects older than this")),
+		OPT_STRING(0, "cruft-max-size", &cruft_po_args.max_pack_size,
+				N_("bytes"),
+				N_("with --cruft, limit the size of new cruft packs")),
 		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
 		OPT_BOOL('f', NULL, &po_args.no_reuse_delta,
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 69509d0c11..5e737c47be 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -303,6 +303,33 @@ test_expect_success 'gc.bigPackThreshold ignores cruft packs' '
 	)
 '
 
+cruft_max_size_opts="git repack -d -l --cruft --cruft-expiration=2.weeks.ago"
+
+test_expect_success 'setup for --cruft-max-size tests' '
+	git init cruft--max-size &&
+	(
+		cd cruft--max-size &&
+		prepare_cruft_history
+	)
+'
+
+test_expect_success '--cruft-max-size sets appropriate repack options' '
+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size \
+		gc --cruft --cruft-max-size=1M &&
+	test_subcommand $cruft_max_size_opts --cruft-max-size=1M <trace2.txt
+'
+
+test_expect_success 'gc.cruftMaxSize sets appropriate repack options' '
+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt \
+		git -C cruft--max-size -c gc.cruftMaxSize=2M gc --cruft &&
+	test_subcommand $cruft_max_size_opts --cruft-max-size=2M <trace2.txt &&
+
+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt \
+		git -C cruft--max-size -c gc.cruftMaxSize=2M gc --cruft \
+		--cruft-max-size=3M &&
+	test_subcommand $cruft_max_size_opts --cruft-max-size=3M <trace2.txt
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index d91fcf1af1..e0de09b77b 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -5,6 +5,7 @@ test_description='git repack works correctly'
 . ./test-lib.sh
 
 objdir=.git/objects
+packdir=$objdir/pack
 
 test_expect_success '--expire-to stores pruned objects (now)' '
 	git init expire-to-now &&
@@ -127,4 +128,248 @@ test_expect_success '--expire-to stores pruned objects (5.minutes.ago)' '
 	)
 '
 
+generate_random_blob() {
+	test-tool genrandom "$@" >blob &&
+	git hash-object -w -t blob blob &&
+	rm blob
+}
+
+pack_random_blob () {
+	generate_random_blob "$@" &&
+	git repack -d -q >/dev/null
+}
+
+generate_cruft_pack () {
+	pack_random_blob "$@" >/dev/null &&
+
+	ls $packdir/pack-*.pack | xargs -n 1 basename >in &&
+	pack="$(git pack-objects --cruft $packdir/pack <in)" &&
+	git prune-packed &&
+
+	echo "$packdir/pack-$pack.mtimes"
+}
+
+test_expect_success '--cruft-max-size creates new packs when above threshold' '
+	git init cruft-max-size-large &&
+	(
+		cd cruft-max-size-large &&
+		test_commit base &&
+
+		foo="$(pack_random_blob foo $((1*1024*1024)))" &&
+		git repack --cruft -d &&
+		cruft_foo="$(ls $packdir/pack-*.mtimes)" &&
+
+		bar="$(pack_random_blob bar $((1*1024*1024)))" &&
+		git repack --cruft -d --cruft-max-size=1M &&
+		cruft_bar="$(ls $packdir/pack-*.mtimes | grep -v $cruft_foo)" &&
+
+		test-tool pack-mtimes $(basename "$cruft_foo") >foo.objects &&
+		test-tool pack-mtimes $(basename "$cruft_bar") >bar.objects &&
+
+		grep "^$foo" foo.objects &&
+		test_line_count = 1 foo.objects &&
+		grep "^$bar" bar.objects &&
+		test_line_count = 1 bar.objects
+	)
+'
+
+test_expect_success '--cruft-max-size combines existing packs when below threshold' '
+	git init cruft-max-size-small &&
+	(
+		cd cruft-max-size-small &&
+		test_commit base &&
+
+		foo="$(pack_random_blob foo $((1*1024*1024)))" &&
+		git repack --cruft -d &&
+
+		bar="$(pack_random_blob bar $((1*1024*1024)))" &&
+		git repack --cruft -d --cruft-max-size=10M &&
+
+		cruft=$(ls $packdir/pack-*.mtimes) &&
+		test-tool pack-mtimes $(basename "$cruft") >cruft.objects &&
+
+		grep "^$foo" cruft.objects &&
+		grep "^$bar" cruft.objects &&
+		test_line_count = 2 cruft.objects
+	)
+'
+
+test_expect_success '--cruft-max-size combines smaller packs first' '
+	git init cruft-max-size-consume-small &&
+	(
+		cd cruft-max-size-consume-small &&
+
+		test_commit base &&
+		git repack -ad &&
+
+		cruft_foo="$(generate_cruft_pack foo 524288)" &&    # 0.5 MiB
+		cruft_bar="$(generate_cruft_pack bar 524288)" &&    # 0.5 MiB
+		cruft_baz="$(generate_cruft_pack baz 1048576)" &&   # 1.0 MiB
+		cruft_quux="$(generate_cruft_pack quux 1572864)" && # 1.5 MiB
+
+		test-tool pack-mtimes "$(basename $cruft_foo)" >expect.raw &&
+		test-tool pack-mtimes "$(basename $cruft_bar)" >>expect.raw &&
+		sort expect.raw >expect.objects &&
+
+		# repacking with `--cruft-max-size=2M` should combine
+		# both 0.5 MiB packs together, instead of, say, one of
+		# the 0.5 MiB packs with the 1.0 MiB pack
+		ls $packdir/pack-*.mtimes | sort >cruft.before &&
+		git repack -d --cruft --cruft-max-size=2M &&
+		ls $packdir/pack-*.mtimes | sort >cruft.after &&
+
+		comm -13 cruft.before cruft.after >cruft.new &&
+		comm -23 cruft.before cruft.after >cruft.removed &&
+
+		test_line_count = 1 cruft.new &&
+		test_line_count = 2 cruft.removed &&
+
+		# the two smaller packs should be rolled up first
+		printf "%s\n" $cruft_foo $cruft_bar | sort >expect.removed &&
+		test_cmp expect.removed cruft.removed &&
+
+		# ...and contain the set of objects rolled up
+		test-tool pack-mtimes "$(basename $(cat cruft.new))" >actual.raw &&
+		sort actual.raw >actual.objects &&
+
+		test_cmp expect.objects actual.objects
+	)
+'
+
+test_expect_success 'setup --cruft-max-size with freshened objects' '
+	git init cruft-max-size-freshen &&
+	(
+		cd cruft-max-size-freshen &&
+
+		test_commit base &&
+		git repack -ad &&
+
+		foo="$(generate_random_blob foo 64)" &&
+		test-tool chmtime --get -10000 \
+			"$objdir/$(test_oid_to_path "$foo")" >foo.mtime &&
+
+		git repack --cruft -d &&
+
+		cruft="$(ls $packdir/pack-*.mtimes)" &&
+		test-tool pack-mtimes "$(basename $cruft)" >actual &&
+		echo "$foo $(cat foo.mtime)" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--cruft-max-size with freshened objects (loose)' '
+	(
+		cd cruft-max-size-freshen &&
+
+		# regenerate the object, setting its mtime to be more recent
+		foo="$(generate_random_blob foo 64)" &&
+		test-tool chmtime --get -100 \
+			"$objdir/$(test_oid_to_path "$foo")" >foo.mtime &&
+
+		git repack --cruft -d &&
+
+		cruft="$(ls $packdir/pack-*.mtimes)" &&
+		test-tool pack-mtimes "$(basename $cruft)" >actual &&
+		echo "$foo $(cat foo.mtime)" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--cruft-max-size with freshened objects (packed)' '
+	(
+		cd cruft-max-size-freshen &&
+
+		# regenerate the object and store it in a packfile,
+		# setting its mtime to be more recent
+		#
+		# store it alongside another cruft object so that we
+		# do not create an identical copy of the existing
+		# cruft pack (which contains $foo).
+		foo="$(generate_random_blob foo 64)" &&
+		bar="$(generate_random_blob bar 64)" &&
+		foo_pack="$(printf "%s\n" $foo $bar | git pack-objects $packdir/pack)" &&
+		git prune-packed &&
+
+		test-tool chmtime --get -10 \
+			"$packdir/pack-$foo_pack.pack" >foo.mtime &&
+
+		git repack --cruft -d &&
+
+		cruft="$(ls $packdir/pack-*.mtimes)" &&
+		test-tool pack-mtimes "$(basename $cruft)" >actual &&
+		echo "$foo $(cat foo.mtime)" >expect.raw &&
+		echo "$bar $(cat foo.mtime)" >>expect.raw &&
+		sort expect.raw >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--cruft-max-size with pruning' '
+	git init cruft-max-size-prune &&
+	(
+		cd cruft-max-size-prune &&
+
+		test_commit base &&
+		foo="$(generate_random_blob foo $((1024*1024)))" &&
+		bar="$(generate_random_blob bar $((1024*1024)))" &&
+		baz="$(generate_random_blob baz $((1024*1024)))" &&
+
+		test-tool chmtime -10000 "$objdir/$(test_oid_to_path "$foo")" &&
+
+		git repack -d --cruft --cruft-max-size=1M &&
+
+		# backdate the mtimes of all cruft packs to validate
+		# that they were rewritten as a result of pruning
+		ls $packdir/pack-*.mtimes | sort >cruft.before &&
+		for cruft in $(cat cruft.before)
+		do
+			mtime="$(test-tool chmtime --get -10000 "$cruft")" &&
+			echo $cruft $mtime >>mtimes || return 1
+		done &&
+
+		# repack (and prune) with a --cruft-max-size to ensure
+		# that we appropriately split the resulting set of packs
+		git repack -d --cruft --cruft-max-size=1M \
+			--cruft-expiration=10.seconds.ago &&
+		ls $packdir/pack-*.mtimes | sort >cruft.after &&
+
+		for cruft in $(cat cruft.after)
+		do
+			old_mtime="$(grep $cruft mtimes | cut -d" " -f2)" &&
+			new_mtime="$(test-tool chmtime --get $cruft)" &&
+			test $old_mtime -lt $new_mtime || return 1
+		done &&
+
+		test_line_count = 3 cruft.before &&
+		test_line_count = 2 cruft.after &&
+		test_must_fail git cat-file -e $foo &&
+		git cat-file -e $bar &&
+		git cat-file -e $baz
+	)
+'
+
+test_expect_success '--cruft-max-size ignores non-local packs' '
+	repo="cruft-max-size-non-local" &&
+	git init $repo &&
+	(
+		cd $repo &&
+		test_commit base &&
+		generate_random_blob foo 64 &&
+		git repack --cruft -d
+	) &&
+
+	git clone --reference=$repo $repo $repo-alt &&
+	(
+		cd $repo-alt &&
+
+		test_commit other &&
+		generate_random_blob bar 64 &&
+
+		# ensure that we do not attempt to pick up packs from
+		# the non-alternated repository, which would result in a
+		# crash
+		git repack --cruft --cruft-max-size=1M -d
+	)
+'
+
 test_done
-- 
2.42.0.138.g7e4e42e1aa
