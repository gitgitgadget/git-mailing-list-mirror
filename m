Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8CDC77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbjEKXUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbjEKXUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:20:42 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A776187
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:20:33 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9d881ad689so11661734276.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683847233; x=1686439233;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qBgUsA3Fh3VvQMfDfN2A755OZz9LTs24wyL5N9H+7k=;
        b=o1SrZ17AlXwFRhzMIJiFEHUs/+KTUOhoDnFRM6lGKubr1PSWTeoYXMvMlMZNMoxZO+
         wiYXng6eEm6tMFfpxkAM6bK3i4WeF/vAaQhF6L/U4AwKUqmeu+9hUc4Tpr/jm3tef9TU
         8aS0xEnhnoZ7DMmWh8bWzSjcdIUthvf7xDGKTUe95BcxMKbS4A4icqMkSdoi1Mzlzar3
         SxQyoMLDmdCJzJgw4Re0oKf+bSTtR7FM6JpEx18AXUM0rIGXsAG2ezZQh93UNaRh+lZi
         pehSd+QdIju1gv0HYt1HTI2ycErucBpTGxecxNWZQh0sBs9sKS1qGWkMIAOqXSjqTuoE
         MClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683847233; x=1686439233;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qBgUsA3Fh3VvQMfDfN2A755OZz9LTs24wyL5N9H+7k=;
        b=QCN3o0c+JhqDG1OOfTqPau/4HQLAXwrfWAJcjLB8kswjdEkV/gUZFFMa5qY1GB27tm
         9npLYS8rU2n8NA5SUZmv4UVm136fY+POVf2bzXLTHrIykm7JVlvtj6zHtAOFs0GY0Tm3
         YLoY0ZgE8aEExRv/qKhyxSVYVPUb6ydcB3J5X8IqFldGpsk6ag4S4ZgOskNN7wTHKyp9
         v7bGoxxIY2hh2NuO9yxzkwJ/v25d+x1JKgRkyrZZxD46S97C5FmiKZF7qRZWqCoDg/a7
         vwwzRp7ayBj5Rb43eKKV1ueeMcc94SZZHb799jX58rHrDPYfLhSmrx2rPg21UVlyceCy
         jNNw==
X-Gm-Message-State: AC+VfDwCRpww2jilMUZdXlE5/50/tD4rnA/7D9mvGfnq/cm0JwBM1YaM
        pkFjTZfzRT77EceuO7YN0ncXaGna8GC203hfbW94kg==
X-Google-Smtp-Source: ACHHUZ6WnTCgySyC8pom6LgQg3KNY3vxM5tEgF0X9reekce70fmwedPpPGBGQok2FVTYwoeMBRgYWQ==
X-Received: by 2002:a25:446:0:b0:ba1:dfba:1d12 with SMTP id 67-20020a250446000000b00ba1dfba1d12mr26328996ybe.29.1683847232585;
        Thu, 11 May 2023 16:20:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v16-20020a25c510000000b00b7767ca7496sm4681164ybe.51.2023.05.11.16.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:20:32 -0700 (PDT)
Date:   Thu, 11 May 2023 19:20:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] pack-objects: introduce `pack.extraRecentObjectsHook`
Message-ID: <cover.1683847221.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reworked version of the patch which introduced a new
configuration `pack.extraCruftTips` to keep additional objects from
pruning during a cruft pack-generating GC.

The third round was significantly more complicated than necessary, and I
think this round represents a couple of improvements thanks to a very
helpful set of reviews from Junio and Peff:

  - The new code does not change the existing cruft pack implementation
    whatsoever. This is nice, since cruft packs will be the default in
    the next release, so changing that implementation carries additional
    risk.

  - The new code is also not specific to cruft packs, meaning that you
    can do things like:

        $ git -c pack.extraRecentObjectsHook=... \
          repack -Ad --unpack-unreachable=1.hour.ago

    and have it write out loose copies of any object(s) mentioned by one
    or more of the configured hooks.

I am hopeful that others think this version is in a good spot. As in
earlier rounds, I would appreciate an extra careful review on this
topic, because of the changing default I mentioned earlier.

Thanks in advance for your review.

Taylor Blau (2):
  reachable.c: extract `obj_is_recent()`
  builtin/pack-objects.c: introduce `pack.recentObjectsHook`

 Documentation/config/pack.txt        |  13 ++
 builtin/pack-objects.c               |   1 +
 reachable.c                          | 100 +++++++++++++++-
 t/t5329-pack-objects-cruft.sh        | 171 +++++++++++++++++++++++++++
 t/t7701-repack-unpack-unreachable.sh |  22 ++++
 5 files changed, 303 insertions(+), 4 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  f5f3b0f334 reachable.c: extract `obj_is_recent()`
1:  da1711b13b ! 2:  2ce8a79fa4 builtin/pack-objects.c: introduce `pack.extraCruftTips`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    builtin/pack-objects.c: introduce `pack.extraCruftTips`
    +    builtin/pack-objects.c: introduce `pack.recentObjectsHook`
     
         This patch introduces a new multi-valued configuration option,
    -    `pack.extraCruftTips` as an alternative means to mark certain objects in
    -    the cruft pack as rescued, even if they would otherwise be pruned.
    +    `pack.recentObjectsHook` as a means to mark certain objects as recent,
    +    regardless of their age.
     
    -    Traditionally, cruft packs are generated in one of two ways:
    +    Depending on whether or not we are generating a cruft pack, this allows
    +    the caller to do one of two things:
     
    -      - When not pruning, all packed and loose objects which do not appear
    -        in the any of the packs which wil remain (as indicated over stdin,
    -        with `--cruft`) are packed separately into a cruft pack.
    +      - If generating a cruft pack, the caller is able to retain additional
    +        objects via the cruft pack, even if they would have otherwise been
    +        pruned due to their age.
     
    -      - When pruning, the above process happens, with two additional tweaks.
    -        Instead of adding every object into the cruft pack, only objects
    -        which have mtime that is within the grace period are kept. In
    -        addition, a "rescuing" traversal is performed over the remaining
    -        cruft objects to keep around cruft objects which would have aged out
    -        of the repository, but are reachable from other cruft objects which
    -        have not yet aged out.
    +      - If not generating a cruft pack, the caller is likewise able to
    +        retain additional objects as loose.
     
    -    This works well for repositories which have all of their "interesting"
    -    objects worth keeping around reachable via at least one reference.
    -
    -    However, there is no option to be able to keep around certain objects
    +    There is currently no option to be able to keep around certain objects
         that have otherwise aged out of the grace period. The only way to retain
         those objects is:
     
           - to point a reference at them, which may be undesirable or
             infeasible,
    +
           - to track them via the reflog, which may be undesirable since the
             reflog's lifetime is limited to that of the reference it's tracking
             (and callers may want to keep those unreachable objects around for
             longer)
    +
           - to extend the grace period, which may keep around other objects that
             the caller *does* want to discard,
    +
           - or, to force the caller to construct the pack of objects they want
             to keep themselves, and then mark the pack as kept by adding a
             ".keep" file.
     
    -    This patch introduces a new configuration, `pack.extraCruftTips` which
    -    allows the caller to specify a program (or set of programs) whose output
    -    is treated as a set of objects to treat as "kept", even if they are
    -    unreachable and have aged out of the retention period.
    +    This patch introduces a new configuration, `pack.recentObjectsHook`
    +    which allows the caller to specify a program (or set of programs) whose
    +    output is treated as a set of objects to treat as recent, regardless of
    +    their true age.
     
    -    The implementation is straightforward: after determining the set of
    -    objects to pack into the cruft pack (either by calling
    -    `enumerate_cruft_objects()` or `enumerate_and_traverse_cruft_objects()`)
    -    we figure out if there are any program(s) we need to consult in order to
    -    determine if there are any objects which we need to "rescue". We then
    -    add those as tips to another reachability traversal, marking every
    -    object along the way as cruft (and thus retaining it in the cruft pack).
    +    The implementation is straightforward. In either case (cruft packs or
    +    not), Git enumerates recent objects via
    +    `add_unseen_recent_objects_to_traversal()`. That enumerates loose and
    +    packed objects, and eventually calls add_recent_object() on any objects
    +    for which `want_recent_object()`'s conditions are met.
    +
    +    This patch modifies the recency condition from simply "is the mtime of
    +    this object more recent than the cutoff?" to "[...] or, is this object
    +    mentioned by at least one `pack.recentObjectsHook`?".
    +
    +    We then add those as tips to another reachability traversal (along with
    +    any recent objects, if pruning), marking every object along the way
    +    (either adding it to the cruft pack, or writing it out as a loose
    +    object).
     
         A potential alternative here is to introduce a new mode to alter the
         contents of the reachable pack instead of the cruft one. One could
    -    imagine a new option to `pack-objects`, say `--extra-tips` that does the
    -    same thing as above, adding the visited set of objects along the
    -    traversal to the pack.
    +    imagine a new option to `pack-objects`, say `--extra-reachable-tips`
    +    that does the same thing as above, adding the visited set of objects
    +    along the traversal to the pack.
     
         But this has the unfortunate side-effect of altering the reachability
         closure of that pack. If parts of the unreachable object graph mentioned
    -    by one or more of the "extra tips" programs is not closed, then the
    -    resulting pack won't be either. This makes it impossible in the general
    -    case to write out reachability bitmaps for that pack, since closure is a
    -    requirement there.
    +    by one or more of the "extra reachable tips" programs is not closed,
    +    then the resulting pack won't be either. This makes it impossible in the
    +    general case to write out reachability bitmaps for that pack, since
    +    closure is a requirement there.
     
    -    Instead, keep these unreachable objects in the cruft pack instead, to
    -    ensure that we can continue to have a pack containing just reachable
    -    objects, which is always safe to write a bitmap over.
    +    Instead, keep these unreachable objects in the cruft pack (or set of
    +    unreachable, loose objects) instead, to ensure that we can continue to
    +    have a pack containing just reachable objects, which is always safe to
    +    write a bitmap over.
     
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/config/pack.txt ##
    @@ Documentation/config/pack.txt: pack.deltaCacheLimit::
      	result once the best match for all objects is found.
      	Defaults to 1000. Maximum value is 65535.
      
    -+pack.extraCruftTips::
    -+	When generating a cruft pack, use the shell to execute the
    -+	specified command(s), and interpret their output as additional
    -+	tips of objects to keep in the cruft pack, regardless of their
    -+	age.
    ++pack.recentObjectsHook::
    ++	When considering the recency of an object (e.g., when generating
    ++	a cruft pack or storing unreachable objects as loose), use the
    ++	shell to execute the specified command(s). Interpret their
    ++	output as object IDs which Git will consider as "recent",
    ++	regardless of their age.
     ++
     +Output must contain exactly one hex object ID per line, and nothing
     +else. Objects which cannot be found in the repository are ignored.
    -+Multiple hooks are supported, but all must exit successfully, else no
    -+cruft pack will be generated.
    ++Multiple hooks are supported, but all must exit successfully, else the
    ++operation (either generating a cruft pack or unpacking unreachable
    ++objects) will be halted.
     +
      pack.threads::
      	Specifies the number of threads to spawn when searching for best
    @@ builtin/pack-objects.c
      
      /*
       * Objects we are going to pack are collected in the `to_pack` structure.
    -@@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
    - 	stop_progress(&progress_state);
    - }
    +
    + ## reachable.c ##
    +@@
    + #include "object-store.h"
    + #include "pack-bitmap.h"
    + #include "pack-mtimes.h"
    ++#include "config.h"
    ++#include "run-command.h"
      
    -+static int enumerate_extra_cruft_tips_1(struct rev_info *revs, const char *args)
    + struct connectivity_progress {
    + 	struct progress *progress;
    +@@ reachable.c: struct recent_data {
    + 	timestamp_t timestamp;
    + 	report_recent_object_fn *cb;
    + 	int ignore_in_core_kept_packs;
    ++
    ++	struct oidset extra_recent_oids;
    ++	int extra_recent_oids_loaded;
    + };
    + 
    ++static int run_one_pack_recent_objects_hook(struct oidset *set,
    ++					    const char *args)
     +{
     +	struct child_process cmd = CHILD_PROCESS_INIT;
     +	struct strbuf buf = STRBUF_INIT;
    -+	FILE *out = NULL;
    ++	FILE *out;
     +	int ret = 0;
     +
     +	cmd.use_shell = 1;
     +	cmd.out = -1;
     +
     +	strvec_push(&cmd.args, args);
    -+	strvec_pushv(&cmd.env, (const char **)local_repo_env);
     +
    -+	if (start_command(&cmd)) {
    -+		ret = -1;
    -+		goto done;
    -+	}
    ++	if (start_command(&cmd))
    ++		return -1;
     +
     +	out = xfdopen(cmd.out, "r");
    -+	while (strbuf_getline_lf(&buf, out) != EOF) {
    ++	while (strbuf_getline(&buf, out) != EOF) {
     +		struct object_id oid;
    -+		struct object *obj;
     +		const char *rest;
     +
     +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
    @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
     +			goto done;
     +		}
     +
    -+		obj = parse_object(the_repository, &oid);
    -+		if (!obj)
    -+			continue;
    -+
    -+		display_progress(progress_state, ++nr_seen);
    -+		add_pending_object(revs, obj, "");
    ++		oidset_insert(set, &oid);
     +	}
     +
     +	ret = finish_command(&cmd);
    @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
     +	return ret;
     +}
     +
    -+static int enumerate_extra_cruft_tips(void)
    ++static void load_pack_recent_objects(struct recent_data *data)
     +{
    -+	struct rev_info revs;
     +	const struct string_list *programs;
     +	int ret = 0;
     +	size_t i;
     +
    -+	if (git_config_get_string_multi("pack.extracrufttips", &programs))
    -+		return ret;
    ++	data->extra_recent_oids_loaded = 1;
     +
    -+	repo_init_revisions(the_repository, &revs, NULL);
    ++	if (git_config_get_string_multi("pack.recentobjectshook", &programs))
    ++		return;
     +
    -+	revs.tag_objects = 1;
    -+	revs.tree_objects = 1;
    -+	revs.blob_objects = 1;
    -+
    -+	revs.include_check = cruft_include_check;
    -+	revs.include_check_obj = cruft_include_check_obj;
    -+
    -+	revs.ignore_missing_links = 1;
    -+
    -+	if (progress)
    -+		progress_state = start_progress(_("Enumerating extra cruft tips"), 0);
    -+	nr_seen = 0;
     +	for (i = 0; i < programs->nr; i++) {
    -+		ret = enumerate_extra_cruft_tips_1(&revs,
    -+						   programs->items[i].string);
    ++		ret = run_one_pack_recent_objects_hook(&data->extra_recent_oids,
    ++						       programs->items[i].string);
     +		if (ret)
     +			break;
     +	}
    -+	stop_progress(&progress_state);
     +
     +	if (ret)
     +		die(_("unable to enumerate additional cruft tips"));
    -+
    -+	if (prepare_revision_walk(&revs))
    -+		die(_("revision walk setup failed"));
    -+	if (progress)
    -+		progress_state = start_progress(_("Traversing extra cruft objects"), 0);
    -+	nr_seen = 0;
    -+
    -+	/*
    -+	 * Retain all objects reachable from extra tips via
    -+	 * show_cruft_commit(), and show_cruft_object(), regardless of
    -+	 * their mtime.
    -+	 */
    -+	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);
    -+	stop_progress(&progress_state);
    -+
    -+	return ret;
     +}
     +
    - static void read_cruft_objects(void)
    + static int obj_is_recent(const struct object_id *oid, timestamp_t mtime,
    + 			 struct recent_data *data)
      {
    - 	struct strbuf buf = STRBUF_INIT;
    -@@ builtin/pack-objects.c: static void read_cruft_objects(void)
    - 	else
    - 		enumerate_cruft_objects();
    +-	return mtime > data->timestamp;
    ++	if (mtime > data->timestamp)
    ++		return 1;
    ++
    ++	if (!data->extra_recent_oids_loaded)
    ++		load_pack_recent_objects(data);
    ++	return oidset_contains(&data->extra_recent_oids, oid);
    + }
    + 
    + static void add_recent_object(const struct object_id *oid,
    +@@ reachable.c: static int want_recent_object(struct recent_data *data,
    + 			      const struct object_id *oid)
    + {
    + 	if (data->ignore_in_core_kept_packs &&
    +-	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS))
    ++	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS)) {
    ++		if (!data->extra_recent_oids_loaded)
    ++			load_pack_recent_objects(data);
    ++		if (oidset_contains(&data->extra_recent_oids, oid))
    ++			return 1;
    ++
    + 		return 0;
    ++	}
    + 	return 1;
    + }
    + 
    +@@ reachable.c: int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
    + 	data.cb = cb;
    + 	data.ignore_in_core_kept_packs = ignore_in_core_kept_packs;
      
    -+	enumerate_extra_cruft_tips();
    ++	oidset_init(&data.extra_recent_oids, 0);
    ++	data.extra_recent_oids_loaded = 0;
     +
    - 	strbuf_release(&buf);
    - 	string_list_clear(&discard_packs, 0);
    - 	string_list_clear(&fresh_packs, 0);
    + 	r = for_each_loose_object(add_recent_loose, &data,
    + 				  FOR_EACH_OBJECT_LOCAL_ONLY);
    + 	if (r)
    +-		return r;
    ++		goto done;
    + 
    + 	flags = FOR_EACH_OBJECT_LOCAL_ONLY | FOR_EACH_OBJECT_PACK_ORDER;
    + 	if (ignore_in_core_kept_packs)
    + 		flags |= FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS;
    + 
    +-	return for_each_packed_object(add_recent_packed, &data, flags);
    ++	r = for_each_packed_object(add_recent_packed, &data, flags);
    ++
    ++done:
    ++	oidset_clear(&data.extra_recent_oids);
    ++
    ++	return r;
    + }
    + 
    + static int mark_object_seen(const struct object_id *oid,
     
      ## t/t5329-pack-objects-cruft.sh ##
     @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend via loose' '
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +		write_script extra-tips <<-EOF &&
     +		echo $cruft_old
     +		EOF
    -+		git config pack.extraCruftTips ./extra-tips &&
    ++		git config pack.recentObjectsHook ./extra-tips &&
     +
     +		git repack --cruft --cruft-expiration=now -d &&
     +
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +
     +		# Ensure that the "old" objects are removed after
     +		# dropping the pack.extraCruftTips hook.
    -+		git config --unset pack.extraCruftTips &&
    ++		git config --unset pack.recentObjectsHook &&
     +		git repack --cruft --cruft-expiration=now -d &&
     +
     +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +
     +		# ensure that each extra cruft tip is saved by its
     +		# respective hook
    -+		git config --add pack.extraCruftTips ./extra-tips.a &&
    -+		git config --add pack.extraCruftTips ./extra-tips.b &&
    ++		git config --add pack.recentObjectsHook ./extra-tips.a &&
    ++		git config --add pack.recentObjectsHook ./extra-tips.b &&
     +		git repack --cruft --cruft-expiration=now -d &&
     +
     +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +		test_cmp cruft.expect cruft.actual &&
     +
     +		# ensure that a dirty exit halts cruft pack generation
    -+		git config --add pack.extraCruftTips ./extra-tips.c &&
    -+		test_must_fail git repack --cruft -d 2>err &&
    ++		git config --add pack.recentObjectsHook ./extra-tips.c &&
    ++		test_must_fail git repack --cruft --cruft-expiration=now -d 2>err &&
     +		grep "unable to enumerate additional cruft tips" err &&
     +
     +		# and that the existing cruft pack is left alone
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +		write_script extra-tips <<-EOF &&
     +		echo $blob
     +		EOF
    -+		git config pack.extraCruftTips ./extra-tips &&
    ++		git config pack.recentObjectsHook ./extra-tips &&
     +
     +		git repack --cruft --cruft-expiration=now -d &&
     +
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +'
     +
      test_done
    +
    + ## t/t7701-repack-unpack-unreachable.sh ##
    +@@ t/t7701-repack-unpack-unreachable.sh: test_expect_success 'do not bother loosening old objects' '
    + 	test_must_fail git cat-file -p $obj2
    + '
    + 
    ++test_expect_success 'extra recent tips are kept regardless of age' '
    ++	obj1=$(echo one | git hash-object -w --stdin) &&
    ++	obj2=$(echo two | git hash-object -w --stdin) &&
    ++	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
    ++	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
    ++	git prune-packed &&
    ++
    ++	git cat-file -p $obj1 &&
    ++	git cat-file -p $obj2 &&
    ++
    ++	write_script extra-tips <<-EOF &&
    ++	echo $obj2
    ++	EOF
    ++	git config pack.recentObjectsHook ./extra-tips &&
    ++
    ++	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
    ++	git repack -A -d --unpack-unreachable=1.hour.ago &&
    ++
    ++	git cat-file -p $obj1 &&
    ++	git cat-file -p $obj2
    ++'
    ++
    + test_expect_success 'keep packed objects found only in index' '
    + 	echo my-unique-content >file &&
    + 	git add file &&
-- 
2.40.1.554.g2ce8a79fa4
