Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227A2C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA34B64E31
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhBWC0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBWCZy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 21:25:54 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A978FC06178A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:13 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id l19so2488324qvz.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bGezaKpkys+uYjGATSDpW/8yRcGhgfjSrf7hsUh4kC0=;
        b=0NDz9Hr/L+izjMkyQfLkG6OctkLGNJf7dP7O6mc0TNAveuo4z7nmYJvTR6qHXMgd86
         cYuvZ34+V+gvKEYV9q84VwRWxRwPHVB+chCUDffzJypTvus+prM8d1u7qGOqsfU0EM3m
         WbHg03KoNa+EyqcVe/9aVycLlNV6v53DmTUyOVwDmNhyyF/KORJNRVFn+33P8JIxjERb
         3n3YT2kJSYiwuvuYIns21YJBvUEEDSBWsyKuJSA+oiBnj2wZIfx90Zy0ZB8OUUPzvwPm
         /QoG5Tbm3ZXw/2d9noorfr/SCye3CtfPv4pMZyiPuMVmfVDC7UAc+OwDANnEWA4CyZ/p
         u5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bGezaKpkys+uYjGATSDpW/8yRcGhgfjSrf7hsUh4kC0=;
        b=TU9vYfeUcvB8ERJfoQB+BPDVYM1Frs7wG8cHqvZ/YpTcoN01Kn+EDvYyEb3wfqDPLt
         BEiXSlQnYJeB4HS/FvLL4C4G+LO+J9Xd31Q/M+Ye3kGtSU0ZC3k9Z1Qh/PcIUIzDvRxr
         NmWdvBRtDlZl+gJ3+vwv384HNdBh32CH3l+ULJHj1ncX3hA3PbTidr66okQqut47Nz11
         WbifUy57MPKFUm9+s0PxGER1uutmU81VXN9tHFOyiWEMODI5lRDS+LIOitE9Mnd4R2VS
         Csnl6T+A86MHoIn5ckZUFc9WbDs3XX3lspnIxWrqD8jv2o88ydUpr5cKzJnibiHMvcBF
         MGgg==
X-Gm-Message-State: AOAM532zyEvLGc+TJuR40MVyTD007E1jKHywTM6SQTcWlUbeRv5Lskd+
        FpkC6x48//pNac5x/lyTKlgIdrOehSMAMYPR
X-Google-Smtp-Source: ABdhPJxKuLo8HS6cV6V4kiCEbI4Zqj3t7HUrdjh05im9ZsEg9FvNrFtRmixccp8laK92DV3O9evu5w==
X-Received: by 2002:a0c:b7a1:: with SMTP id l33mr21050256qve.17.1614047112276;
        Mon, 22 Feb 2021 18:25:12 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id q8sm13778728qkm.38.2021.02.22.18.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:25:11 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:25:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v4 3/8] builtin/pack-objects.c: add '--stdin-packs' option
Message-ID: <649cf9020bfdae9f48e3efbfbc52429cefd31432.1614047097.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614047097.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an upcoming commit, 'git repack' will want to create a pack comprised
of all of the objects in some packs (the included packs) excluding any
objects in some other packs (the excluded packs).

This caller could iterate those packs themselves and feed the objects it
finds to 'git pack-objects' directly over stdin, but this approach has a
few downsides:

  - It requires every caller that wants to drive 'git pack-objects' in
    this way to implement pack iteration themselves. This forces the
    caller to think about details like what order objects are fed to
    pack-objects, which callers would likely rather not do.

  - If the set of objects in included packs is large, it requires
    sending a lot of data over a pipe, which is inefficient.

  - The caller is forced to keep track of the excluded objects, too, and
    make sure that it doesn't send any objects that appear in both
    included and excluded packs.

But the biggest downside is the lack of a reachability traversal.
Because the caller passes in a list of objects directly, those objects
don't get a namehash assigned to them, which can have a negative impact
on the delta selection process, causing 'git pack-objects' to fail to
find good deltas even when they exist.

The caller could formulate a reachability traversal themselves, but the
only way to drive 'git pack-objects' in this way is to do a full
traversal, and then remove objects in the excluded packs after the
traversal is complete. This can be detrimental to callers who care
about performance, especially in repositories with many objects.

Introduce 'git pack-objects --stdin-packs' which remedies these four
concerns.

'git pack-objects --stdin-packs' expects a list of pack names on stdin,
where 'pack-xyz.pack' denotes that pack as included, and
'^pack-xyz.pack' denotes it as excluded. The resulting pack includes all
objects that are present in at least one included pack, and aren't
present in any excluded pack.

To address the delta selection problem, 'git pack-objects --stdin-packs'
works as follows. First, it assembles a list of objects that it is going
to pack, as above. Then, a reachability traversal is started, whose tips
are any commits mentioned in included packs. Upon visiting an object, we
find its corresponding object_entry in the to_pack list, and set its
namehash parameter appropriately.

To avoid the traversal visiting more objects than it needs to, the
traversal is halted upon encountering an object which can be found in an
excluded pack (by marking the excluded packs as kept in-core, and
passing --no-kept-objects=in-core to the revision machinery).

This can cause the traversal to halt early, for example if an object in
an included pack is an ancestor of ones in excluded packs. But stopping
early is OK, since filling in the namehash fields of objects in the
to_pack list is only additive (i.e., having it helps the delta selection
process, but leaving it blank doesn't impact the correctness of the
resulting pack).

Even still, it is unlikely that this hurts us much in practice, since
the 'git repack --geometric' caller (which is introduced in a later
commit) marks small packs as included, and large ones as excluded.
During ordinary use, the small packs usually represent pushes after a
large repack, and so are unlikely to be ancestors of objects that
already exist in the repository.

(I found it convenient while developing this patch to have 'git
pack-objects' report the number of objects which were visited and got
their namehash fields filled in during traversal. This is also included
in the below patch via trace2 data lines).

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.txt |  10 ++
 builtin/pack-objects.c             | 202 ++++++++++++++++++++++++++++-
 t/t5300-pack-object.sh             |  97 ++++++++++++++
 3 files changed, 307 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 54d715ead1..df533c3b19 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -85,6 +85,16 @@ base-name::
 	reference was included in the resulting packfile.  This
 	can be useful to send new tags to native Git clients.
 
+--stdin-packs::
+	Read the basenames of packfiles (e.g., `pack-1234abcd.pack`)
+	from the standard input, instead of object names or revision
+	arguments. The resulting pack contains all objects listed in the
+	included packs (those not beginning with `^`), excluding any
+	objects listed in the excluded packs (beginning with `^`).
++
+Incompatible with `--revs`, or options that imply `--revs` (such as
+`--all`), with the exception of `--unpacked`, which is compatible.
+
 --window=<n>::
 --depth=<n>::
 	These two options affect how the objects contained in
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d62aaf59a..6ee8e40665 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2986,6 +2986,190 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, cb);
 }
 
+/* Counters for trace2 output when in --stdin-packs mode. */
+static int stdin_packs_found_nr;
+static int stdin_packs_hints_nr;
+
+static int add_object_entry_from_pack(const struct object_id *oid,
+				      struct packed_git *p,
+				      uint32_t pos,
+				      void *_data)
+{
+	struct rev_info *revs = _data;
+	struct object_info oi = OBJECT_INFO_INIT;
+	off_t ofs;
+	enum object_type type;
+
+	display_progress(progress_state, ++nr_seen);
+
+	if (have_duplicate_entry(oid, 0))
+		return 0;
+
+	ofs = nth_packed_object_offset(p, pos);
+	if (!want_object_in_pack(oid, 0, &p, &ofs))
+		return 0;
+
+	oi.typep = &type;
+	if (packed_object_info(the_repository, p, ofs, &oi) < 0)
+		die(_("could not get type of object %s in pack %s"),
+		    oid_to_hex(oid), p->pack_name);
+	else if (type == OBJ_COMMIT) {
+		/*
+		 * commits in included packs are used as starting points for the
+		 * subsequent revision walk
+		 */
+		add_pending_oid(revs, NULL, oid, 0);
+	}
+
+	stdin_packs_found_nr++;
+
+	create_object_entry(oid, type, 0, 0, 0, p, ofs);
+
+	return 0;
+}
+
+static void show_commit_pack_hint(struct commit *commit, void *_data)
+{
+	/* nothing to do; commits don't have a namehash */
+}
+
+static void show_object_pack_hint(struct object *object, const char *name,
+				  void *_data)
+{
+	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
+	if (!oe)
+		return;
+
+	/*
+	 * Our 'to_pack' list was constructed by iterating all objects packed in
+	 * included packs, and so doesn't have a non-zero hash field that you
+	 * would typically pick up during a reachability traversal.
+	 *
+	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
+	 * here using a now in order to perhaps improve the delta selection
+	 * process.
+	 */
+	oe->hash = pack_name_hash(name);
+	oe->no_try_delta = name && no_try_delta(name);
+
+	stdin_packs_hints_nr++;
+}
+
+static int pack_mtime_cmp(const void *_a, const void *_b)
+{
+	struct packed_git *a = ((const struct string_list_item*)_a)->util;
+	struct packed_git *b = ((const struct string_list_item*)_b)->util;
+
+	/*
+	 * order packs by descending mtime so that objects are laid out
+	 * roughly as newest-to-oldest
+	 */
+	if (a->mtime < b->mtime)
+		return 1;
+	else if (b->mtime < a->mtime)
+		return -1;
+	else
+		return 0;
+}
+
+static void read_packs_list_from_stdin(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list include_packs = STRING_LIST_INIT_DUP;
+	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
+	struct string_list_item *item = NULL;
+
+	struct packed_git *p;
+	struct rev_info revs;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	/*
+	 * Use a revision walk to fill in the namehash of objects in the include
+	 * packs. To save time, we'll avoid traversing through objects that are
+	 * in excluded packs.
+	 *
+	 * That may cause us to avoid populating all of the namehash fields of
+	 * all included objects, but our goal is best-effort, since this is only
+	 * an optimization during delta selection.
+	 */
+	revs.no_kept_objects = 1;
+	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+	revs.blob_objects = 1;
+	revs.tree_objects = 1;
+	revs.tag_objects = 1;
+
+	while (strbuf_getline(&buf, stdin) != EOF) {
+		if (!buf.len)
+			continue;
+
+		if (*buf.buf == '^')
+			string_list_append(&exclude_packs, buf.buf + 1);
+		else
+			string_list_append(&include_packs, buf.buf);
+
+		strbuf_reset(&buf);
+	}
+
+	string_list_sort(&include_packs);
+	string_list_sort(&exclude_packs);
+
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		const char *pack_name = pack_basename(p);
+
+		item = string_list_lookup(&include_packs, pack_name);
+		if (!item)
+			item = string_list_lookup(&exclude_packs, pack_name);
+
+		if (item)
+			item->util = p;
+	}
+
+	/*
+	 * First handle all of the excluded packs, marking them as kept in-core
+	 * so that later calls to add_object_entry() discards any objects that
+	 * are also found in excluded packs.
+	 */
+	for_each_string_list_item(item, &exclude_packs) {
+		struct packed_git *p = item->util;
+		if (!p)
+			die(_("could not find pack '%s'"), item->string);
+		p->pack_keep_in_core = 1;
+	}
+
+	/*
+	 * Order packs by ascending mtime; use QSORT directly to access the
+	 * string_list_item's ->util pointer, which string_list_sort() does not
+	 * provide.
+	 */
+	QSORT(include_packs.items, include_packs.nr, pack_mtime_cmp);
+
+	for_each_string_list_item(item, &include_packs) {
+		struct packed_git *p = item->util;
+		if (!p)
+			die(_("could not find pack '%s'"), item->string);
+		for_each_object_in_pack(p,
+					add_object_entry_from_pack,
+					&revs,
+					FOR_EACH_OBJECT_PACK_ORDER);
+	}
+
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+	traverse_commit_list(&revs,
+			     show_commit_pack_hint,
+			     show_object_pack_hint,
+			     NULL);
+
+	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
+			   stdin_packs_found_nr);
+	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
+			   stdin_packs_hints_nr);
+
+	strbuf_release(&buf);
+	string_list_clear(&include_packs, 0);
+	string_list_clear(&exclude_packs, 0);
+}
+
 static void read_object_list_from_stdin(void)
 {
 	char line[GIT_MAX_HEXSZ + 1 + PATH_MAX + 2];
@@ -3489,6 +3673,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	struct strvec rp = STRVEC_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
+	int stdin_packs = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -3539,6 +3724,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT_F(0, "indexed-objects", &rev_list_index,
 			      N_("include objects referred to by the index"),
 			      1, PARSE_OPT_NONEG),
+		OPT_BOOL(0, "stdin-packs", &stdin_packs,
+			 N_("read packs from stdin")),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
 			 N_("output pack to stdout")),
 		OPT_BOOL(0, "include-tag", &include_tag,
@@ -3645,7 +3832,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		use_internal_rev_list = 1;
 		strvec_push(&rp, "--indexed-objects");
 	}
-	if (rev_list_unpacked) {
+	if (rev_list_unpacked && !stdin_packs) {
 		use_internal_rev_list = 1;
 		strvec_push(&rp, "--unpacked");
 	}
@@ -3690,8 +3877,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (filter_options.choice) {
 		if (!pack_to_stdout)
 			die(_("cannot use --filter without --stdout"));
+		if (stdin_packs)
+			die(_("cannot use --filter with --stdin-packs"));
 	}
 
+	if (stdin_packs && use_internal_rev_list)
+		die(_("cannot use internal rev list with --stdin-packs"));
+
 	/*
 	 * "soft" reasons not to use bitmaps - for on-disk repack by default we want
 	 *
@@ -3750,7 +3942,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (progress)
 		progress_state = start_progress(_("Enumerating objects"), 0);
-	if (!use_internal_rev_list)
+	if (stdin_packs) {
+		/* avoids adding objects in excluded packs */
+		ignore_packed_keep_in_core = 1;
+		read_packs_list_from_stdin();
+		if (rev_list_unpacked)
+			add_unreachable_loose_objects();
+	} else if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
 		get_object_list(rp.nr, rp.v);
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 392201cabd..7138a54595 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -532,4 +532,101 @@ test_expect_success 'prefetch objects' '
 	test_line_count = 1 donelines
 '
 
+test_expect_success 'setup for --stdin-packs tests' '
+	git init stdin-packs &&
+	(
+		cd stdin-packs &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		for id in A B C
+		do
+			git pack-objects .git/objects/pack/pack-$id \
+				--incremental --revs <<-EOF
+			refs/tags/$id
+			EOF
+		done &&
+
+		ls -la .git/objects/pack
+	)
+'
+
+test_expect_success '--stdin-packs with excluded packs' '
+	(
+		cd stdin-packs &&
+
+		PACK_A="$(basename .git/objects/pack/pack-A-*.pack)" &&
+		PACK_B="$(basename .git/objects/pack/pack-B-*.pack)" &&
+		PACK_C="$(basename .git/objects/pack/pack-C-*.pack)" &&
+
+		git pack-objects test --stdin-packs <<-EOF &&
+		$PACK_A
+		^$PACK_B
+		$PACK_C
+		EOF
+
+		(
+			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
+			git show-index <$(ls .git/objects/pack/pack-C-*.idx)
+		) >expect.raw &&
+		git show-index <$(ls test-*.idx) >actual.raw &&
+
+		cut -d" " -f2 <expect.raw | sort >expect &&
+		cut -d" " -f2 <actual.raw | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs is incompatible with --filter' '
+	(
+		cd stdin-packs &&
+		test_must_fail git pack-objects --stdin-packs --stdout \
+			--filter=blob:none </dev/null 2>err &&
+		test_i18ngrep "cannot use --filter with --stdin-packs" err
+	)
+'
+
+test_expect_success '--stdin-packs is incompatible with --revs' '
+	(
+		cd stdin-packs &&
+		test_must_fail git pack-objects --stdin-packs --revs out \
+			</dev/null 2>err &&
+		test_i18ngrep "cannot use internal rev list with --stdin-packs" err
+	)
+'
+
+test_expect_success '--stdin-packs with loose objects' '
+	(
+		cd stdin-packs &&
+
+		PACK_A="$(basename .git/objects/pack/pack-A-*.pack)" &&
+		PACK_B="$(basename .git/objects/pack/pack-B-*.pack)" &&
+		PACK_C="$(basename .git/objects/pack/pack-C-*.pack)" &&
+
+		test_commit D && # loose
+
+		git pack-objects test2 --stdin-packs --unpacked <<-EOF &&
+		$PACK_A
+		^$PACK_B
+		$PACK_C
+		EOF
+
+		(
+			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
+			git show-index <$(ls .git/objects/pack/pack-C-*.idx) &&
+			git rev-list --objects --no-object-names \
+				refs/tags/C..refs/tags/D
+
+		) >expect.raw &&
+		ls -la . &&
+		git show-index <$(ls test2-*.idx) >actual.raw &&
+
+		cut -d" " -f2 <expect.raw | sort >expect &&
+		cut -d" " -f2 <actual.raw | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.30.0.667.g81c0cbc6fd

