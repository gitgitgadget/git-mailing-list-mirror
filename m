Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C23C7EE22
	for <git@archiver.kernel.org>; Tue, 16 May 2023 00:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbjEPAYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 20:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbjEPAYE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 20:24:04 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04BC5FD1
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:24:02 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba6f8e0b39cso6599852276.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684196642; x=1686788642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EupI+d1NJpRlA7tIDdCnRoF1N/gwSCayuoNeCBkn964=;
        b=p4QCkS5kDqk9LdUQRzhhmHGPka2RWh033VXsDzjCKk+1Yp1ABAGYPsinHnLm1TgZP6
         0VA/D/vx1l7b26xRs8gy0MJ6ss/NwcW0trVaRELa+WIaiblNuvGqmQrFbUX1TTEUHOJ6
         A2wFcM34F8+7EIFilMFVdafC5tsrE86UNqtCH2zcfEIN0AfuTVZlZcQJ1/9R6ykq1XYN
         Xv2XXZ1B2IPrOZbXuKywP8CQpaARVESz85DWsDx1Fi4jG1tZmKvRYgo2Vm0fzhOO+7BQ
         sAlZaUZ7NPZ0dxudoboOg1UBzABSSCVM5RZcPFZ3RhQ9vdxsEU+4w70bQpJL8ALGg6Je
         r25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684196642; x=1686788642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EupI+d1NJpRlA7tIDdCnRoF1N/gwSCayuoNeCBkn964=;
        b=lGUgiFA5C0eGKrewb9quv/xcmGyMohIXiejoJqdBFdHAAFgBcjXbrHFANPD2mgN4Bu
         Yqq2x6OAM07xdfjk7X6mHB3VPTAfF/jhQwAwjl9E8v5T+evHGGgTupD9NrdVKZi179pt
         o5Utpj3F3QS13xidd1Wg0lXJunLY78Fo4HV5sAgxDTZk3wX3vVfzff33ix3JhUx6EDoX
         rj3kyccZbfONagvAObr2JHnYGuMWKG7AWyqI/mlVabNKyagCYSGy3mlkhIjVTbjrVcW0
         TJztlxz6n+QENjf7vQZd0sx1itkWjlz4aOfKI6qdFbXLBUM3+IuwrsNn4hYLLpND0CKH
         ujLA==
X-Gm-Message-State: AC+VfDxIbBElJ8SEST9Row2W2Ll1c0ccBzifx8k6ycbJVldj2yfj4D8V
        z+5hsMVq4CRmNioGcf9aUFKvS5valDSSM6tIBWs+jw==
X-Google-Smtp-Source: ACHHUZ7Ov5CTadpZQgMDn59jnCnh8HMyxUSoefCrPYJ7CRgCJGfnUSPLAQxO3rB0ZL3f3SHnwLuiEQ==
X-Received: by 2002:a05:6902:1503:b0:b92:4b2f:1052 with SMTP id q3-20020a056902150300b00b924b2f1052mr42323340ybu.57.1684196641569;
        Mon, 15 May 2023 17:24:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m15-20020a0dca0f000000b0055aafcef659sm209399ywd.5.2023.05.15.17.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 17:24:01 -0700 (PDT)
Date:   Mon, 15 May 2023 20:23:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v4 0/2] gc: introduce `gc.recentObjectsHook`
Message-ID: <cover.1684196634.git.me@ttaylorr.com>
References: <cover.1683847221.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683847221.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another reworked version of the patch which introduced a new
configuration `gc.extraCruftTips` to keep additional objects when
pruning which might have otherwise aged out of the repository.

Notable changes since last time include:

  - updating the name of this configuration to "gc.recentObjectsHook",
  - significantly reworking the substantive patch's message
  - improved test coverage to cover more cases of loose object pruning,
    as well as `git prune`'s interaction with `gc.recentObjectsHook`.

(Again, since we're expecting -rc0, I don't expect a ton of movement on
this series before 2.41 is shipped, but I figured I'd share it out
anyways to get it off of my laptop).

Thanks in advance for your review.

Taylor Blau (2):
  reachable.c: extract `obj_is_recent()`
  gc: introduce `gc.recentObjectsHook`

 Documentation/config/gc.txt          |  13 ++
 reachable.c                          |  85 ++++++++++++-
 t/t5304-prune.sh                     |  14 +++
 t/t5329-pack-objects-cruft.sh        | 171 +++++++++++++++++++++++++++
 t/t7701-repack-unpack-unreachable.sh |  31 +++++
 5 files changed, 311 insertions(+), 3 deletions(-)

Range-diff against v3:
1:  f5f3b0f334 = 1:  9c1b59c8cf reachable.c: extract `obj_is_recent()`
2:  2ce8a79fa4 ! 2:  18e50d2517 builtin/pack-objects.c: introduce `pack.recentObjectsHook`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    builtin/pack-objects.c: introduce `pack.recentObjectsHook`
    +    gc: introduce `gc.recentObjectsHook`
     
         This patch introduces a new multi-valued configuration option,
    -    `pack.recentObjectsHook` as a means to mark certain objects as recent,
    -    regardless of their age.
    +    `gc.recentObjectsHook` as a means to mark certain objects as recent (and
    +    thus exempt from garbage collection), regardless of their age.
     
    -    Depending on whether or not we are generating a cruft pack, this allows
    -    the caller to do one of two things:
    +    When performing a garbage collection operation on a repository with
    +    unreachable objects, Git makes its decision on what to do with those
    +    object(s) bed on how recent the objects are or not. Generally speaking,
    +    unreachable-but-recent objects stay in the repository, and older objects
    +    are discarded.
     
    -      - If generating a cruft pack, the caller is able to retain additional
    -        objects via the cruft pack, even if they would have otherwise been
    -        pruned due to their age.
    +    However, we have no convenient way to keep certain precious, unreachable
    +    objects around in the repository, even if they have aged out and would
    +    be pruned. Our options today consist of:
     
    -      - If not generating a cruft pack, the caller is likewise able to
    -        retain additional objects as loose.
    +      - Point references at the reachability tips of any objects you
    +        consider precious, which may be undesirable or infeasible.
     
    -    There is currently no option to be able to keep around certain objects
    -    that have otherwise aged out of the grace period. The only way to retain
    -    those objects is:
    -
    -      - to point a reference at them, which may be undesirable or
    -        infeasible,
    -
    -      - to track them via the reflog, which may be undesirable since the
    +      - Track them via the reflog, which may be undesirable since the
             reflog's lifetime is limited to that of the reference it's tracking
             (and callers may want to keep those unreachable objects around for
    -        longer)
    +        longer).
     
    -      - to extend the grace period, which may keep around other objects that
    -        the caller *does* want to discard,
    +      - Extend the grace period, which may keep around other objects that
    +        the caller *does* want to discard.
     
    -      - or, to force the caller to construct the pack of objects they want
    +      - Manually modify the mtimes of objects you want to keep. If those
    +        objects are already loose, this is easy enough to do (you can just
    +        enumerate and `touch -m` each one).
    +
    +        But if they are packed, you will either end up modifying the mtimes
    +        of *all* objects in that pack, or be forced to write out a loose
    +        copy of that object, both of which may be undesirable. Even worse,
    +        if they are in a cruft pack, that requires modifying its `*.mtimes`
    +        file by hand, since there is no exposed plumbing for this.
    +
    +      - Force the caller to construct the pack of objects they want
             to keep themselves, and then mark the pack as kept by adding a
    -        ".keep" file.
    +        ".keep" file. This works, but is burdensome for the caller, and
    +        having extra packs is awkward as you roll forward your cruft pack.
     
    -    This patch introduces a new configuration, `pack.recentObjectsHook`
    -    which allows the caller to specify a program (or set of programs) whose
    -    output is treated as a set of objects to treat as recent, regardless of
    -    their true age.
    +    This patch introduces a new option to the above list via the
    +    `gc.recentObjectsHook` configuration, which allows the caller to
    +    specify a program (or set of programs) whose output is treated as a set
    +    of objects to treat as recent, regardless of their true age.
     
    -    The implementation is straightforward. In either case (cruft packs or
    -    not), Git enumerates recent objects via
    -    `add_unseen_recent_objects_to_traversal()`. That enumerates loose and
    +    The implementation is straightforward. Git enumerates recent objects via
    +    `add_unseen_recent_objects_to_traversal()`, which enumerates loose and
         packed objects, and eventually calls add_recent_object() on any objects
         for which `want_recent_object()`'s conditions are met.
     
         This patch modifies the recency condition from simply "is the mtime of
         this object more recent than the cutoff?" to "[...] or, is this object
    -    mentioned by at least one `pack.recentObjectsHook`?".
    +    mentioned by at least one `gc.recentObjectsHook`?".
     
    -    We then add those as tips to another reachability traversal (along with
    -    any recent objects, if pruning), marking every object along the way
    -    (either adding it to the cruft pack, or writing it out as a loose
    -    object).
    +    Depending on whether or not we are generating a cruft pack, this allows
    +    the caller to do one of two things:
    +
    +      - If generating a cruft pack, the caller is able to retain additional
    +        objects via the cruft pack, even if they would have otherwise been
    +        pruned due to their age.
    +
    +      - If not generating a cruft pack, the caller is likewise able to
    +        retain additional objects as loose.
     
         A potential alternative here is to introduce a new mode to alter the
         contents of the reachable pack instead of the cruft one. One could
    @@ Commit message
         Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## Documentation/config/pack.txt ##
    -@@ Documentation/config/pack.txt: pack.deltaCacheLimit::
    - 	result once the best match for all objects is found.
    - 	Defaults to 1000. Maximum value is 65535.
    + ## Documentation/config/gc.txt ##
    +@@ Documentation/config/gc.txt: or rebase occurring.  Since these changes are not part of the current
    + project most users will want to expire them sooner, which is why the
    + default is more aggressive than `gc.reflogExpire`.
      
    -+pack.recentObjectsHook::
    ++gc.recentObjectsHook::
     +	When considering the recency of an object (e.g., when generating
     +	a cruft pack or storing unreachable objects as loose), use the
     +	shell to execute the specified command(s). Interpret their
    @@ Documentation/config/pack.txt: pack.deltaCacheLimit::
     +operation (either generating a cruft pack or unpacking unreachable
     +objects) will be halted.
     +
    - pack.threads::
    - 	Specifies the number of threads to spawn when searching for best
    - 	delta matches.  This requires that linkgit:git-pack-objects[1]
    -
    - ## builtin/pack-objects.c ##
    -@@
    - #include "pack-mtimes.h"
    - #include "parse-options.h"
    - #include "wrapper.h"
    -+#include "run-command.h"
    - 
    - /*
    -  * Objects we are going to pack are collected in the `to_pack` structure.
    + gc.rerereResolved::
    + 	Records of conflicted merge you resolved earlier are
    + 	kept for this many days when 'git rerere gc' is run.
     
      ## reachable.c ##
     @@
    @@ reachable.c: struct recent_data {
     +	int extra_recent_oids_loaded;
      };
      
    -+static int run_one_pack_recent_objects_hook(struct oidset *set,
    ++static int run_one_gc_recent_objects_hook(struct oidset *set,
     +					    const char *args)
     +{
     +	struct child_process cmd = CHILD_PROCESS_INIT;
    @@ reachable.c: struct recent_data {
     +
     +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
     +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
    -+			goto done;
    ++			break;
     +		}
     +
     +		oidset_insert(set, &oid);
     +	}
     +
    -+	ret = finish_command(&cmd);
    ++	fclose(out);
    ++	ret |= finish_command(&cmd);
     +
    -+done:
    -+	if (out)
    -+		fclose(out);
     +	strbuf_release(&buf);
    -+	child_process_clear(&cmd);
    -+
     +	return ret;
     +}
     +
    -+static void load_pack_recent_objects(struct recent_data *data)
    ++static void load_gc_recent_objects(struct recent_data *data)
     +{
     +	const struct string_list *programs;
     +	int ret = 0;
    @@ reachable.c: struct recent_data {
     +
     +	data->extra_recent_oids_loaded = 1;
     +
    -+	if (git_config_get_string_multi("pack.recentobjectshook", &programs))
    ++	if (git_config_get_string_multi("gc.recentobjectshook", &programs))
     +		return;
     +
     +	for (i = 0; i < programs->nr; i++) {
    -+		ret = run_one_pack_recent_objects_hook(&data->extra_recent_oids,
    ++		ret = run_one_gc_recent_objects_hook(&data->extra_recent_oids,
     +						       programs->items[i].string);
     +		if (ret)
    -+			break;
    ++			die(_("unable to enumerate additional cruft tips"));
     +	}
    -+
    -+	if (ret)
    -+		die(_("unable to enumerate additional cruft tips"));
     +}
     +
      static int obj_is_recent(const struct object_id *oid, timestamp_t mtime,
    @@ reachable.c: struct recent_data {
     +		return 1;
     +
     +	if (!data->extra_recent_oids_loaded)
    -+		load_pack_recent_objects(data);
    ++		load_gc_recent_objects(data);
     +	return oidset_contains(&data->extra_recent_oids, oid);
      }
      
      static void add_recent_object(const struct object_id *oid,
    -@@ reachable.c: static int want_recent_object(struct recent_data *data,
    - 			      const struct object_id *oid)
    - {
    - 	if (data->ignore_in_core_kept_packs &&
    --	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS))
    -+	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS)) {
    -+		if (!data->extra_recent_oids_loaded)
    -+			load_pack_recent_objects(data);
    -+		if (oidset_contains(&data->extra_recent_oids, oid))
    -+			return 1;
    -+
    - 		return 0;
    -+	}
    - 	return 1;
    - }
    - 
     @@ reachable.c: int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
      	data.cb = cb;
      	data.ignore_in_core_kept_packs = ignore_in_core_kept_packs;
    @@ reachable.c: int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
      
      static int mark_object_seen(const struct object_id *oid,
     
    + ## t/t5304-prune.sh ##
    +@@ t/t5304-prune.sh: test_expect_success 'old reachable-from-recent retained with bitmaps' '
    + 	test_must_fail git cat-file -e $to_drop
    + '
    + 
    ++test_expect_success 'gc.recentObjectsHook' '
    ++	add_blob &&
    ++	test-tool chmtime =-86500 $BLOB_FILE &&
    ++
    ++	write_script precious-objects <<-EOF &&
    ++	echo $BLOB
    ++	EOF
    ++	test_config gc.recentObjectsHook ./precious-objects &&
    ++
    ++	git prune --expire=now &&
    ++
    ++	git cat-file -p $BLOB
    ++'
    ++
    + test_done
    +
      ## t/t5329-pack-objects-cruft.sh ##
     @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend via loose' '
      	)
      '
      
    -+test_expect_success 'additional cruft tips may be specified via pack.extraCruftTips' '
    ++test_expect_success 'gc.recentObjectsHook' '
     +	git init repo &&
     +	test_when_finished "rm -fr repo" &&
     +	(
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +		write_script extra-tips <<-EOF &&
     +		echo $cruft_old
     +		EOF
    -+		git config pack.recentObjectsHook ./extra-tips &&
    ++		git config gc.recentObjectsHook ./extra-tips &&
     +
     +		git repack --cruft --cruft-expiration=now -d &&
     +
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +		test_cmp cruft.expect cruft.actual &&
     +
     +		# Ensure that the "old" objects are removed after
    -+		# dropping the pack.extraCruftTips hook.
    -+		git config --unset pack.recentObjectsHook &&
    ++		# dropping the gc.recentObjectsHook hook.
    ++		git config --unset gc.recentObjectsHook &&
     +		git repack --cruft --cruft-expiration=now -d &&
     +
     +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +	)
     +'
     +
    -+test_expect_success 'multi-valued pack.extraCruftTips' '
    ++test_expect_success 'multi-valued gc.recentObjectsHook' '
     +	git init repo &&
     +	test_when_finished "rm -fr repo" &&
     +	(
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +
     +		# ensure that each extra cruft tip is saved by its
     +		# respective hook
    -+		git config --add pack.recentObjectsHook ./extra-tips.a &&
    -+		git config --add pack.recentObjectsHook ./extra-tips.b &&
    ++		git config --add gc.recentObjectsHook ./extra-tips.a &&
    ++		git config --add gc.recentObjectsHook ./extra-tips.b &&
     +		git repack --cruft --cruft-expiration=now -d &&
     +
     +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +		test_cmp cruft.expect cruft.actual &&
     +
     +		# ensure that a dirty exit halts cruft pack generation
    -+		git config --add pack.recentObjectsHook ./extra-tips.c &&
    ++		git config --add gc.recentObjectsHook ./extra-tips.c &&
     +		test_must_fail git repack --cruft --cruft-expiration=now -d 2>err &&
     +		grep "unable to enumerate additional cruft tips" err &&
     +
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +	)
     +'
     +
    -+test_expect_success 'additional cruft blobs via pack.extraCruftTips' '
    ++test_expect_success 'additional cruft blobs via gc.recentObjectsHook' '
     +	git init repo &&
     +	test_when_finished "rm -fr repo" &&
     +	(
    @@ t/t5329-pack-objects-cruft.sh: test_expect_success 'cruft objects are freshend v
     +		write_script extra-tips <<-EOF &&
     +		echo $blob
     +		EOF
    -+		git config pack.recentObjectsHook ./extra-tips &&
    ++		git config gc.recentObjectsHook ./extra-tips &&
     +
     +		git repack --cruft --cruft-expiration=now -d &&
     +
    @@ t/t7701-repack-unpack-unreachable.sh: test_expect_success 'do not bother looseni
      	test_must_fail git cat-file -p $obj2
      '
      
    -+test_expect_success 'extra recent tips are kept regardless of age' '
    ++test_expect_success 'gc.recentObjectsHook' '
     +	obj1=$(echo one | git hash-object -w --stdin) &&
     +	obj2=$(echo two | git hash-object -w --stdin) &&
    ++	obj3=$(echo three | git hash-object -w --stdin) &&
     +	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
     +	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
    ++	pack3=$(echo $obj3 | git pack-objects .git/objects/pack/pack) &&
     +	git prune-packed &&
     +
     +	git cat-file -p $obj1 &&
     +	git cat-file -p $obj2 &&
    ++	git cat-file -p $obj3 &&
     +
    -+	write_script extra-tips <<-EOF &&
    -+	echo $obj2
    ++	git tag -a -m tag obj2-tag $obj2 &&
    ++	obj2_tag="$(git rev-parse obj2-tag)" &&
    ++
    ++	write_script precious-objects <<-EOF &&
    ++	echo $obj2_tag
     +	EOF
    -+	git config pack.recentObjectsHook ./extra-tips &&
    ++	git config gc.recentObjectsHook ./precious-objects &&
     +
     +	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
    ++	test-tool chmtime =-86400 .git/objects/pack/pack-$pack3.pack &&
     +	git repack -A -d --unpack-unreachable=1.hour.ago &&
     +
     +	git cat-file -p $obj1 &&
    -+	git cat-file -p $obj2
    ++	git cat-file -p $obj2 &&
    ++	git cat-file -p $obj2_tag &&
    ++	test_must_fail git cat-file -p $obj3
     +'
     +
      test_expect_success 'keep packed objects found only in index' '
-- 
2.40.1.558.g18e50d2517
