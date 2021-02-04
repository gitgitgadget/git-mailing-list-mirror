Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F07C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413FD64F60
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBDEAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 23:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhBDD7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 22:59:47 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835E7C061786
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 19:59:07 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id u20so2134342qku.7
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 19:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C3aX1kDNL1j8DMYscR/OHAqVTlH9xuS3LfmdKgRqZ2Y=;
        b=MOGl4szdtY9dsEQfjHSx82tni5dDn5sGuNYo1530ln9TlyItSCW9z7Zu9VkHKJhzf0
         HZn811QanGHHxz0XkmoO8YE5GbXwXx60Jo1QKZWBPmo4ae39x5lLU9LUaERO5qS84Ii7
         gxgJjkSSiRYhQxP88KgH3deyZ7IXVqTfOA32GcWB+F1iXSwkClzMUxrBlZrzE2JNxsG0
         5YfQeYV2s2adZOxyrRMYNtahvmThJnQfcrZUQ7A8X7xJDhyormrLX9Bc0imXrRirbzVd
         QBTNSAMf5D3gDC+6O+HqD79HV5kToCXL1kdMb3LSLVk4Dv8s5aOTBriUseYwA32KXI4P
         jCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C3aX1kDNL1j8DMYscR/OHAqVTlH9xuS3LfmdKgRqZ2Y=;
        b=OLyPbX6jL+Ke3wcBoZ+DBSxjeGEoVrU2hiPbN0+KVkxUbe6OLcbdWEFZkzSThYCtDG
         GN+S76URqQcmfT6HFpP+XT6ncoKcYuY7eYYIhUc92ApuRN9SDAzrZ4COX7vbCAKjewSj
         s375HKmQmCwORZwpJsJWwx364npNNnA+wbYQoQjPE7F183a2DuOF3wZaOoZf/Hpj48Gh
         V8DqVfbRz7plmiFfuDZRE6XJ95NxlbJvN5pMvU4sT+qfV/oxrkY1xGaug6VPa7gfQoJw
         c96P0X7I9wXZXrJYsg55Cefnh0mvINIRr3+t4eYIOktKBb30S+n6Ii5O0kBaGECykJ41
         36Iw==
X-Gm-Message-State: AOAM530mU8kbj5jaeKBhTU2kja1AWiqSIMmZmwntRqr6XJXZ0PkiHT+G
        wR6zBsYlh/35UQczC1OUGjVGv8lU+v3XZg==
X-Google-Smtp-Source: ABdhPJz5Gjk4uFiA5dVlzbF+7z5HN5lKiXrkEzxdBzcpv6wOEzZyRjxCmYXMQR83dQh3AI31jHa/7A==
X-Received: by 2002:a37:9d97:: with SMTP id g145mr6124989qke.300.1612411146233;
        Wed, 03 Feb 2021 19:59:06 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id m2sm4034241qke.117.2021.02.03.19.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:59:05 -0800 (PST)
Date:   Wed, 3 Feb 2021 22:59:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v2 3/8] builtin/pack-objects.c: add '--stdin-packs' option
Message-ID: <c96b1bf99582beefb96c3774b13a4f5a12fc61cc.1612411124.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612411123.git.me@ttaylorr.com>
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
 builtin/pack-objects.c             | 176 ++++++++++++++++++++++++++++-
 t/t5300-pack-object.sh             |  97 ++++++++++++++++
 3 files changed, 281 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 54d715ead1..92733f6bf5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -85,6 +85,16 @@ base-name::
 	reference was included in the resulting packfile.  This
 	can be useful to send new tags to native Git clients.
 
+--stdin-packs::
+	Read the basenames of packfiles from the standard input, instead
+	of object names or revision arguments. The resulting pack
+	contains all objects listed in the included packs (those not
+	beginning with `^`), excluding any objects listed in the
+	excluded packs (beginning with `^`).
++
+Incompatible with `--revs`, or options that imply `--revs` (such as
+`--all`), with the exception of `--unpacked`, which is compatible.
+
 --window=<n>::
 --depth=<n>::
 	These two options affect how the objects contained in
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 13cde5896a..6d19eb000a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2979,6 +2979,164 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, cb);
 }
 
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
+	ofs = nth_packed_object_offset(p, pos);
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
+	if (have_duplicate_entry(oid, 0))
+		return 0;
+
+	if (!want_object_in_pack(oid, 0, &p, &ofs))
+		return 0;
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
@@ -3482,6 +3640,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	struct strvec rp = STRVEC_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
+	int stdin_packs = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -3532,6 +3691,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT_F(0, "indexed-objects", &rev_list_index,
 			      N_("include objects referred to by the index"),
 			      1, PARSE_OPT_NONEG),
+		OPT_BOOL(0, "stdin-packs", &stdin_packs,
+			 N_("read packs from stdin")),
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
 			 N_("output pack to stdout")),
 		OPT_BOOL(0, "include-tag", &include_tag,
@@ -3636,7 +3797,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		use_internal_rev_list = 1;
 		strvec_push(&rp, "--indexed-objects");
 	}
-	if (rev_list_unpacked) {
+	if (rev_list_unpacked && !stdin_packs) {
 		use_internal_rev_list = 1;
 		strvec_push(&rp, "--unpacked");
 	}
@@ -3681,8 +3842,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
@@ -3741,7 +3907,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
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
2.30.0.533.g2f8b6b552f.dirty

