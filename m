Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D9C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C67564E2F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBRDPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBRDO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:14:56 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0EC061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:16 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id o30so128467qtd.12
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tuDWOJd1C+wSI0ozdIWws7gBT/TtEslqsG85Zd3gPyY=;
        b=SCNjplQJHNeFIrejomERusTAYbhchMn3Jc10czSBWg0LSe+q6aXFuvfHyear7iMHdS
         buKE84SowRVgNxRmELRkbbI2Vat62o4K//63Q2lvDWCVNditBNP5LNcEf0seCDO1Wmxf
         EaHfTnnKiPbk8PBTau9egv5x9IbabJj+GxTY2iMPVrdnzQIJTT+FS7o0bJFbHRWX0ugW
         VDXo1QPTd7fbnb6am6tc/Fp8R8Fn6a263BqrNHlLvYUgPP3q7qodRxg0DhCO56qJbDxh
         iW/RGJus5JVxK4K/stRfPLdtK2BzT4M2I0Uk+ptALgVDIIF2Y6qs3UdyqK+n2siEnYDJ
         Sn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tuDWOJd1C+wSI0ozdIWws7gBT/TtEslqsG85Zd3gPyY=;
        b=GUJk326Ny72KznLw3Dz+NhvkXhxHf1s3wNkWHZ114VUQ4Djhg8puTRdjWRRFCwK55F
         vinscsZNt2A8aEmeu8brMVf3FTxzR1JdKzHok6cMHaMUkMjPqox5e/CYRuLLoEo1yIC6
         7iCwovVh6VOCQ3rK7DCt7k8sYbKJK2v4Npt+er7N/ji3+fBqtg6R6N/lqmWjVRXUsWbu
         09P2fjhGz9bKVmR9Wce6g8E7kVkq6cLLCXNn4gFSAp8QWsrfOZ83g6aX1fI7e1rsw3KU
         vFDartmLuvYckh7AA/BMlgnGnyLrxVdy9YDQvI82GdcaMaUvod9j4gMGT+DIizNbrvhk
         rU8w==
X-Gm-Message-State: AOAM53252V7P7pCjodi3Z+XubWtwKzQiTA6FSavhfS+2+Ay5dlTtmRr+
        hjBR4bI/D5m2UjhzEMPZFwtXkxA7KmcvDEK1
X-Google-Smtp-Source: ABdhPJybmTiVFSp6UAwrGRt5uPtVbvhi46dNVwz6vxl4J48E7uIsWv9KsKht7KGuUafd01e5f9nAlg==
X-Received: by 2002:ac8:490d:: with SMTP id e13mr2464853qtq.16.1613618054533;
        Wed, 17 Feb 2021 19:14:14 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1f29:6ff9:b466:8c60])
        by smtp.gmail.com with ESMTPSA id b65sm3102620qkd.120.2021.02.17.19.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:14:13 -0800 (PST)
Date:   Wed, 17 Feb 2021 22:14:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v3 0/8] repack: support repacking into a geometric sequence
Message-ID: <cover.1613618042.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another updated version of mine and Peff's series to add a new 'git
repack --geometric' mode which supports repacking a repository into a geometric
progression of packs by object count.

(A previous version of this series depended on 'jk/p5303-sed-portability-fix',
but that topic has since been merged to 'master'. This series has been updated
to apply based on 'master' accordingly).

The series has not changed substantially since v2, but a range-diff is included
below for convenience. The most notable change is the new tests in p5303 were
reworked to provide a more equivalent comparison.

Beyond that, some minor code clean-up (embedding the kept-pack cache, making the
'--no-kept-packs' option of 'rev-list' undocumented, etc) has been applied to
address Peff's review.

Thanks in advance for another look at this series. I'm hopeful that this version
is in a good state to be queued so that it can make the 2.31 release, and users
can start playing with it.

Jeff King (4):
  p5303: add missing &&-chains
  p5303: measure time to repack with keep
  builtin/pack-objects.c: rewrite honor-pack-keep logic
  packfile: add kept-pack cache for find_kept_pack_entry()

Taylor Blau (4):
  packfile: introduce 'find_kept_pack_entry()'
  revision: learn '--no-kept-objects'
  builtin/pack-objects.c: add '--stdin-packs' option
  builtin/repack.c: add '--geometric' option

 Documentation/git-pack-objects.txt |  10 +
 Documentation/git-repack.txt       |  22 ++
 builtin/pack-objects.c             | 329 ++++++++++++++++++++++++-----
 builtin/repack.c                   | 187 +++++++++++++++-
 object-store.h                     |   5 +
 packfile.c                         |  67 ++++++
 packfile.h                         |   5 +
 revision.c                         |  15 ++
 revision.h                         |   4 +
 t/perf/p5303-many-packs.sh         |  36 +++-
 t/t5300-pack-object.sh             |  97 +++++++++
 t/t6114-keep-packs.sh              |  69 ++++++
 t/t7703-repack-geometric.sh        | 137 ++++++++++++
 13 files changed, 921 insertions(+), 62 deletions(-)
 create mode 100755 t/t6114-keep-packs.sh
 create mode 100755 t/t7703-repack-geometric.sh

Range-diff against v2:
[rebased onto 'master']
13:  f7186147eb !  1:  aa94edf39b packfile: introduce 'find_kept_pack_entry()'
    @@ packfile.h: int packed_object_info(struct repository *r,

     +#define ON_DISK_KEEP_PACKS 1
     +#define IN_CORE_KEEP_PACKS 2
    -+#define ALL_KEEP_PACKS (ON_DISK_KEEP_PACKS | IN_CORE_KEEP_PACKS)
     +
      /*
       * Iff a pack file in the given repository contains the object named by sha1,
14:  ddc2896caa !  2:  82f6b45463 revision: learn '--no-kept-objects'
    @@ Commit message
         certain packs alone (for e.g., when doing a geometric repack that has
         some "large" packs which are kept in-core that it wants to leave alone).

    +    Note that this option is not guaranteed to produce exactly the set of
    +    objects that aren't in kept packs, since it's possible the traversal
    +    order may end up in a situation where a non-kept ancestor was "cut off"
    +    by a kept object (at which point we would stop traversing). But, we
    +    don't care about absolute correctness here, since this will eventually
    +    be used as a purely additive guide in an upcoming new repack mode.
    +
    +    Explicitly avoid documenting this new flag, since it is only used
    +    internally. In theory we could avoid even adding it rev-list, but being
    +    able to spell this option out on the command-line makes some special
    +    cases easier to test without promising to keep it behaving consistently
    +    forever. Those tricky cases are exercised in t6114.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

    - ## Documentation/rev-list-options.txt ##
    -@@ Documentation/rev-list-options.txt: ifdef::git-rev-list[]
    - 	Only useful with `--objects`; print the object IDs that are not
    - 	in packs.
    -
    -+--no-kept-objects[=<kind>]::
    -+	Halts the traversal as soon as an object in a kept pack is
    -+	found. If `<kind>` is `on-disk`, only packs with a corresponding
    -+	`*.keep` file are ignored. If `<kind>` is `in-core`, only packs
    -+	with their in-core kept state set are ignored. Otherwise, both
    -+	kinds of kept packs are ignored.
    -+
    - --object-names::
    - 	Only useful with `--objects`; print the names of the object IDs
    - 	that are found. This is the default behavior.
    -
    - ## list-objects.c ##
    -@@ list-objects.c: static void traverse_trees_and_blobs(struct traversal_context *ctx,
    - 			ctx->show_object(obj, name, ctx->show_data);
    - 			continue;
    - 		}
    -+		if (ctx->revs->no_kept_objects) {
    -+			struct pack_entry e;
    -+			if (find_kept_pack_entry(ctx->revs->repo, &obj->oid,
    -+						 ctx->revs->keep_pack_cache_flags,
    -+						 &e))
    -+				continue;
    -+		}
    - 		if (!path)
    - 			path = "";
    - 		if (obj->type == OBJ_TREE) {
    -
      ## revision.c ##
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
      		revs->unpacked = 1;
15:  c96b1bf995 !  3:  033e4e3f67 builtin/pack-objects.c: add '--stdin-packs' option
    @@ Documentation/git-pack-objects.txt: base-name::
      	can be useful to send new tags to native Git clients.

     +--stdin-packs::
    -+	Read the basenames of packfiles from the standard input, instead
    -+	of object names or revision arguments. The resulting pack
    -+	contains all objects listed in the included packs (those not
    -+	beginning with `^`), excluding any objects listed in the
    -+	excluded packs (beginning with `^`).
    ++	Read the basenames of packfiles (e.g., `pack-1234abcd.pack`)
    ++	from the standard input, instead of object names or revision
    ++	arguments. The resulting pack contains all objects listed in the
    ++	included packs (those not beginning with `^`), excluding any
    ++	objects listed in the excluded packs (beginning with `^`).
     ++
     +Incompatible with `--revs`, or options that imply `--revs` (such as
     +`--all`), with the exception of `--unpacked`, which is compatible.
    @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
      	return git_default_config(k, v, cb);
      }

    ++/* Counters for trace2 output when in --stdin-packs mode. */
     +static int stdin_packs_found_nr;
     +static int stdin_packs_hints_nr;
     +
    @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
     +
     +	display_progress(progress_state, ++nr_seen);
     +
    ++	if (have_duplicate_entry(oid, 0))
    ++		return 0;
    ++
     +	ofs = nth_packed_object_offset(p, pos);
    ++	if (!want_object_in_pack(oid, 0, &p, &ofs))
    ++		return 0;
     +
     +	oi.typep = &type;
     +	if (packed_object_info(the_repository, p, ofs, &oi) < 0)
    @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
     +		add_pending_oid(revs, NULL, oid, 0);
     +	}
     +
    -+	if (have_duplicate_entry(oid, 0))
    -+		return 0;
    -+
    -+	if (!want_object_in_pack(oid, 0, &p, &ofs))
    -+		return 0;
    -+
     +	stdin_packs_found_nr++;
     +
     +	create_object_entry(oid, type, 0, 0, 0, p, ofs);
    @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
     +
     +static void show_commit_pack_hint(struct commit *commit, void *_data)
     +{
    ++	/* nothing to do; commits don't have a namehash */
     +}
     +
     +static void show_object_pack_hint(struct object *object, const char *name,
    @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
     +	stdin_packs_hints_nr++;
     +}
     +
    ++static int pack_mtime_cmp(const void *_a, const void *_b)
    ++{
    ++	struct packed_git *a = ((const struct string_list_item*)_a)->util;
    ++	struct packed_git *b = ((const struct string_list_item*)_b)->util;
    ++
    ++	if (a->mtime < b->mtime)
    ++		return -1;
    ++	else if (b->mtime < a->mtime)
    ++		return 1;
    ++	else
    ++		return 0;
    ++}
    ++
     +static void read_packs_list_from_stdin(void)
     +{
     +	struct strbuf buf = STRBUF_INIT;
    @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
     +			die(_("could not find pack '%s'"), item->string);
     +		p->pack_keep_in_core = 1;
     +	}
    ++
    ++	/*
    ++	 * Order packs by ascending mtime; use QSORT directly to access the
    ++	 * string_list_item's ->util pointer, which string_list_sort() does not
    ++	 * provide.
    ++	 */
    ++	QSORT(include_packs.items, include_packs.nr, pack_mtime_cmp);
    ++
     +	for_each_string_list_item(item, &include_packs) {
     +		struct packed_git *p = item->util;
     +		if (!p)
16:  a46b7002b4 =  4:  f9a5faf773 p5303: add missing &&-chains
17:  b5081c01b5 !  5:  181c104a03 p5303: measure time to repack with keep
    @@ Metadata
      ## Commit message ##
         p5303: measure time to repack with keep

    -    This is the same as the regular repack test, except that we mark the
    -    single base pack as "kept" and use --assume-kept-packs-closed. The
    -    theory is that this should be faster than the normal repack, because
    -    we'll have fewer objects to traverse and process.
    +    Add two new tests to measure repack performance. Both test split the
    +    repository into synthetic "pushes", and then leave the remaining objects
    +    in a big base pack.

    -    Here are some timings on a recent clone of the kernel. In the
    -    single-pack case, there is nothing do since there are no non-excluded
    -    packs:
    +    The first new test marks an empty pack as "kept" and then passes
    +    --honor-pack-keep to avoid including objects in it. That doesn't change
    +    the resulting pack, but it does let us compare to the normal repack case
    +    to see how much overhead we add to check whether objects are kept or
    +    not.

    -      5303.5: repack (1)                          57.42(54.88+10.64)
    -      5303.6: repack with --stdin-packs (1)       0.01(0.01+0.00)
    +    The other test is of --stdin-packs, which gives us a sense of how that
    +    number scales based on the number of packs we provide as input. In each
    +    of those tests, the empty pack isn't considered, but the residual pack
    +    (objects that were left over and not included in one of the synthetic
    +    push packs) is marked as kept.

    -    and in the 50-pack case, it is much faster to use `--stdin-packs`, since
    -    we avoid having to consider any objects in the excluded pack:
    +    (Note that in the single-pack case of the --stdin-packs test, there is
    +    nothing do since there are no non-excluded packs).

    -      5303.10: repack (50)                        71.26(88.24+4.96)
    -      5303.11: repack with --stdin-packs (50)     3.49(11.82+0.28)
    +    Here are some timings on a recent clone of the kernel:

    -    but our improvements vanish as we approach 1000 packs.
    +      5303.5: repack (1)                          57.26(54.59+10.84)
    +      5303.6: repack with kept (1)                57.33(54.80+10.51)

    -      5303.15: repack (1000)                      215.64(491.33+14.80)
    -      5303.16: repack with --stdin-packs (1000)   198.79(380.51+7.97)
    +    in the 50-pack case, things start to slow down:
    +
    +      5303.11: repack (50)                        71.54(88.57+4.84)
    +      5303.12: repack with kept (50)              85.12(102.05+4.94)
    +
    +    and by the time we hit 1,000 packs, things are substantially worse, even
    +    though the resulting pack produced is the same:
    +
    +      5303.17: repack (1000)                      216.87(490.79+14.57)
    +      5303.18: repack with kept (1000)            665.63(938.87+15.76)
    +
    +    Likewise, the scaling is pretty extreme on --stdin-packs:
    +
    +      5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)
    +      5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)
    +      5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)

         That's because the code paths around handling .keep files are known to
         scale badly; they look in every single pack file to find each object.
    @@ t/perf/p5303-many-packs.sh: repack_into_n () {
     +		git pack-objects --delta-base-offset --revs staging/pack
     +	) &&
     +	test_export base_pack &&
    ++
    ++	# create an empty packfile
    ++	empty_pack=$(git pack-objects staging/pack </dev/null) &&
    ++	test_export empty_pack &&

      	# and then incrementals between each pair of commits
      	last= &&
    @@ t/perf/p5303-many-packs.sh: do
      		  --stdout </dev/null >/dev/null
      	'
     +
    ++	test_perf "repack with kept ($nr_packs)" '
    ++		git pack-objects --keep-true-parents \
    ++		  --keep-pack=pack-$empty_pack.pack \
    ++		  --honor-pack-keep --non-empty --all \
    ++		  --reflog --indexed-objects --delta-base-offset \
    ++		  --stdout </dev/null >/dev/null
    ++	'
    ++
     +	test_perf "repack with --stdin-packs ($nr_packs)" '
     +		git pack-objects \
     +		  --keep-true-parents \
18:  c3868c7df9 !  6:  67af143fd1 builtin/pack-objects.c: rewrite honor-pack-keep logic
    @@ Commit message
         packs are actually kept.

         Note that we have to re-order the logic a bit here; we can deal with the
    -    "kept" situation completely, and then just fall back to the "--local"
    -    question. It might be worth having a similar optimized function to look
    -    at only local packs.
    +    disqualifying situations first (e.g., finding the object in a non-local
    +    pack with --local), then "kept" situation(s), and then just fall back to
    +    other "--local" conditions.

         Here are the results from p5303 (measurements again taken on the
         kernel):

    -      Test                                        HEAD^                    HEAD
    +      Test                                        HEAD^                   HEAD
           -----------------------------------------------------------------------------------------------
    -      5303.5: repack (1)                          57.42(54.88+10.64)       57.44(54.71+10.78) +0.0%
    -      5303.6: repack with --stdin-packs (1)       0.01(0.01+0.00)          0.01(0.00+0.01) +0.0%
    -      5303.10: repack (50)                        71.26(88.24+4.96)        71.32(88.38+4.90) +0.1%
    -      5303.11: repack with --stdin-packs (50)     3.49(11.82+0.28)         3.43(11.81+0.22) -1.7%
    -      5303.15: repack (1000)                      215.64(491.33+14.80)     215.59(493.75+14.62) -0.0%
    -      5303.16: repack with --stdin-packs (1000)   198.79(380.51+7.97)      131.44(314.24+8.11) -33.9%
    -
    -    So our --stdin-packs case with many packs is now finally faster than the
    -    non-keep case (because it gets the speed benefit of looking at fewer
    -    objects, but not as big a penalty for looking at many packs).
    +      5303.5: repack (1)                          57.26(54.59+10.84)      57.34(54.66+10.88) +0.1%
    +      5303.6: repack with kept (1)                57.33(54.80+10.51)      57.38(54.83+10.49) +0.1%
    +      5303.11: repack (50)                        71.54(88.57+4.84)       71.70(88.99+4.74) +0.2%
    +      5303.12: repack with kept (50)              85.12(102.05+4.94)      72.58(89.61+4.78) -14.7%
    +      5303.17: repack (1000)                      216.87(490.79+14.57)    217.19(491.72+14.25) +0.1%
    +      5303.18: repack with kept (1000)            665.63(938.87+15.76)    246.12(520.07+14.93) -63.0%
    +
    +    and the --stdin-packs timings:
    +
    +      5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)         0.00(0.00+0.00) -100.0%
    +      5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)        3.43(11.75+0.24) -2.8%
    +      5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)     130.50(307.15+7.66) -33.4%
    +
    +    So our repack with an empty .keep pack is roughly as fast as one without
    +    a .keep pack up to 50 packs. But the --stdin-packs case scales a little
    +    better, too.
    +
    +    Notably, it is faster than a repack of the same size and a kept pack. It
    +    looks at fewer objects, of course, but the penalty for looking at many
    +    packs isn't as costly.

         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    @@ builtin/pack-objects.c: static int have_duplicate_entry(const struct object_id *
      	if (exclude)
      		return 1;
     @@ builtin/pack-objects.c: static int want_found_object(int exclude, struct packed_git *p)
    + 	 * make sure no copy of this object appears in _any_ pack that makes us
    + 	 * to omit the object, so we need to check all the packs.
    + 	 *
    +-	 * We can however first check whether these options can possible matter;
    ++	 * We can however first check whether these options can possibly matter;
    + 	 * if they do not matter we know we want the object in generated pack.
      	 * Otherwise, we signal "-1" at the end to tell the caller that we do
      	 * not know either way, and it needs to check more packs.
      	 */
     -	if (!ignore_packed_keep_on_disk &&
     -	    !ignore_packed_keep_in_core &&
     -	    (!local || !have_non_local_packs))
    +-		return 1;
    +
    ++	/*
    ++	 * Objects in packs borrowed from elsewhere are discarded regardless of
    ++	 * if they appear in other packs that weren't borrowed.
    ++	 */
    + 	if (local && !p->pack_local)
    + 		return 0;
    +-	if (p->pack_local &&
    +-	    ((ignore_packed_keep_on_disk && p->pack_keep) ||
    +-	     (ignore_packed_keep_in_core && p->pack_keep_in_core)))
    +-		return 0;
     +
     +	/*
    -+	 * Handle .keep first, as we have a fast(er) path there.
    ++	 * Then handle .keep first, as we have a fast(er) path there.
     +	 */
     +	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core) {
     +		/*
    @@ builtin/pack-objects.c: static int want_found_object(int exclude, struct packed_
     +	 * keep-packs, or the object is not in one. Keep checking other
     +	 * conditions...
     +	 */
    -+
     +	if (!local || !have_non_local_packs)
    - 		return 1;
    --
    - 	if (local && !p->pack_local)
    - 		return 0;
    --	if (p->pack_local &&
    --	    ((ignore_packed_keep_on_disk && p->pack_keep) ||
    --	     (ignore_packed_keep_in_core && p->pack_keep_in_core)))
    --		return 0;
    ++		return 1;

      	/* we don't know yet; keep looking for more packs */
      	return -1;
19:  f1c07324f6 !  7:  e9e04b95e7 packfile: add kept-pack cache for find_kept_pack_entry()
    @@ Commit message
           - we don't have to worry about any packed_git being removed; we always
             keep the old structs around, even after reprepare_packed_git()

    +    We do defensively invalidate the cache in case the set of kept packs
    +    being asked for changes (e.g., only in-core kept packs were cached, but
    +    suddenly the caller also wants on-disk kept packs, too). In theory we
    +    could build all three caches and switch between them, but it's not
    +    necessary, since this patch (and series) never changes the set of kept
    +    packs that it wants to inspect from the cache.
    +
    +    So that "optimization" is more about being defensive in the face of
    +    future changes than it is about asking for multiple kinds of kept packs
    +    in this patch.
    +
         Here are p5303 results (as always, measured against the kernel):

           Test                                        HEAD^                   HEAD
    -      ----------------------------------------------------------------------------------------------
    -      5303.5: repack (1)                          57.44(54.71+10.78)      57.06(54.29+10.96) -0.7%
    -      5303.6: repack with --stdin-packs (1)       0.01(0.00+0.01)         0.01(0.01+0.00) +0.0%
    -      5303.10: repack (50)                        71.32(88.38+4.90)       71.47(88.60+5.04) +0.2%
    -      5303.11: repack with --stdin-packs (50)     3.43(11.81+0.22)        3.49(12.21+0.26) +1.7%
    -      5303.15: repack (1000)                      215.59(493.75+14.62)    217.41(495.36+14.85) +0.8%
    -      5303.16: repack with --stdin-packs (1000)   131.44(314.24+8.11)     126.75(309.88+8.09) -3.6%
    +      -----------------------------------------------------------------------------------------------
    +      5303.5: repack (1)                          57.34(54.66+10.88)      56.98(54.36+10.98) -0.6%
    +      5303.6: repack with kept (1)                57.38(54.83+10.49)      57.17(54.97+10.26) -0.4%
    +      5303.11: repack (50)                        71.70(88.99+4.74)       71.62(88.48+5.08) -0.1%
    +      5303.12: repack with kept (50)              72.58(89.61+4.78)       71.56(88.80+4.59) -1.4%
    +      5303.17: repack (1000)                      217.19(491.72+14.25)    217.31(490.82+14.53) +0.1%
    +      5303.18: repack with kept (1000)            246.12(520.07+14.93)    217.08(490.37+15.10) -11.8%
    +
    +    and the --stdin-packs case, which scales a little bit better (although
    +    not by that much even at 1,000 packs):
    +
    +      5303.7: repack with --stdin-packs (1)       0.00(0.00+0.00)         0.00(0.00+0.00) =
    +      5303.13: repack with --stdin-packs (50)     3.43(11.75+0.24)        3.43(11.69+0.30) +0.0%
    +      5303.19: repack with --stdin-packs (1000)   130.50(307.15+7.66)     125.13(301.36+8.04) -4.1%

         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

    - ## builtin/pack-objects.c ##
    -@@ builtin/pack-objects.c: static int want_found_object(const struct object_id *oid, int exclude,
    - 		 */
    - 		unsigned flags = 0;
    - 		if (ignore_packed_keep_on_disk)
    --			flags |= ON_DISK_KEEP_PACKS;
    -+			flags |= CACHE_ON_DISK_KEEP_PACKS;
    - 		if (ignore_packed_keep_in_core)
    --			flags |= IN_CORE_KEEP_PACKS;
    -+			flags |= CACHE_IN_CORE_KEEP_PACKS;
    -
    - 		if (ignore_packed_keep_on_disk && p->pack_keep)
    - 			return 0;
    -@@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
    - 	 * an optimization during delta selection.
    - 	 */
    - 	revs.no_kept_objects = 1;
    --	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
    -+	revs.keep_pack_cache_flags |= CACHE_IN_CORE_KEEP_PACKS;
    - 	revs.blob_objects = 1;
    - 	revs.tree_objects = 1;
    - 	revs.tag_objects = 1;
    -
      ## object-store.h ##
    -@@ object-store.h: static inline int pack_map_entry_cmp(const void *unused_cmp_data,
    - 	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
    - }
    -
    -+#define CACHE_ON_DISK_KEEP_PACKS 1
    -+#define CACHE_IN_CORE_KEEP_PACKS 2
    -+
    -+struct kept_pack_cache {
    -+	struct packed_git **packs;
    -+	unsigned flags;
    -+};
    -+
    - struct raw_object_store {
    - 	/*
    - 	 * Set of all object directories; the main directory is first (and
     @@ object-store.h: struct raw_object_store {
      	/* A most-recently-used ordered version of the packed_git list. */
      	struct list_head packed_git_mru;

    -+	struct kept_pack_cache *kept_pack_cache;
    ++	struct {
    ++		struct packed_git **packs;
    ++		unsigned flags;
    ++	} kept_pack_cache;
     +
      	/*
      	 * A map of packfiles to packed_git structs for tracking which
    @@ packfile.c: static int find_one_pack_entry(struct repository *r,
     +					     unsigned flags)
      {
     -	return find_one_pack_entry(r, oid, e, 0);
    -+	if (!r->objects->kept_pack_cache)
    ++	if (!r->objects->kept_pack_cache.packs)
     +		return;
    -+	if (r->objects->kept_pack_cache->flags == flags)
    ++	if (r->objects->kept_pack_cache.flags == flags)
     +		return;
    -+	free(r->objects->kept_pack_cache->packs);
    -+	FREE_AND_NULL(r->objects->kept_pack_cache);
    ++	FREE_AND_NULL(r->objects->kept_pack_cache.packs);
    ++	r->objects->kept_pack_cache.flags = 0;
     +}
     +
     +static struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
     +{
     +	maybe_invalidate_kept_pack_cache(r, flags);
     +
    -+	if (!r->objects->kept_pack_cache) {
    ++	if (!r->objects->kept_pack_cache.packs) {
     +		struct packed_git **packs = NULL;
     +		size_t nr = 0, alloc = 0;
     +		struct packed_git *p;
    @@ packfile.c: static int find_one_pack_entry(struct repository *r,
     +		 * the non-kept version.
     +		 */
     +		for (p = get_all_packs(r); p; p = p->next) {
    -+			if ((p->pack_keep && (flags & CACHE_ON_DISK_KEEP_PACKS)) ||
    -+			    (p->pack_keep_in_core && (flags & CACHE_IN_CORE_KEEP_PACKS))) {
    ++			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
    ++			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
     +				ALLOC_GROW(packs, nr + 1, alloc);
     +				packs[nr++] = p;
     +			}
    @@ packfile.c: static int find_one_pack_entry(struct repository *r,
     +		ALLOC_GROW(packs, nr + 1, alloc);
     +		packs[nr] = NULL;
     +
    -+		r->objects->kept_pack_cache = xmalloc(sizeof(*r->objects->kept_pack_cache));
    -+		r->objects->kept_pack_cache->packs = packs;
    -+		r->objects->kept_pack_cache->flags = flags;
    ++		r->objects->kept_pack_cache.packs = packs;
    ++		r->objects->kept_pack_cache.flags = flags;
     +	}
     +
    -+	return r->objects->kept_pack_cache->packs;
    ++	return r->objects->kept_pack_cache.packs;
      }

      int find_kept_pack_entry(struct repository *r,
    @@ packfile.c: int find_kept_pack_entry(struct repository *r,
      }

      int has_object_pack(const struct object_id *oid)
    -@@ packfile.c: int has_object_pack(const struct object_id *oid)
    - 	return find_pack_entry(the_repository, oid, &e);
    - }
    -
    --int has_object_kept_pack(const struct object_id *oid, unsigned flags)
    -+int has_object_kept_pack(const struct object_id *oid,
    -+			 unsigned flags)
    - {
    - 	struct pack_entry e;
    - 	return find_kept_pack_entry(the_repository, oid, flags, &e);
    -
    - ## packfile.h ##
    -@@ packfile.h: int packed_object_info(struct repository *r,
    - void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
    - const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
    -
    --#define ON_DISK_KEEP_PACKS 1
    --#define IN_CORE_KEEP_PACKS 2
    --#define ALL_KEEP_PACKS (ON_DISK_KEEP_PACKS | IN_CORE_KEEP_PACKS)
    --
    - /*
    -  * Iff a pack file in the given repository contains the object named by sha1,
    -  * return true and store its location to e.
    -
    - ## revision.c ##
    -@@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
    - 		die(_("--unpacked=<packfile> no longer supported"));
    - 	} else if (!strcmp(arg, "--no-kept-objects")) {
    - 		revs->no_kept_objects = 1;
    --		revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
    --		revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
    -+		revs->keep_pack_cache_flags |= CACHE_IN_CORE_KEEP_PACKS;
    -+		revs->keep_pack_cache_flags |= CACHE_ON_DISK_KEEP_PACKS;
    - 	} else if (skip_prefix(arg, "--no-kept-objects=", &optarg)) {
    - 		revs->no_kept_objects = 1;
    - 		if (!strcmp(optarg, "in-core"))
    --			revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
    -+			revs->keep_pack_cache_flags |= CACHE_IN_CORE_KEEP_PACKS;
    - 		if (!strcmp(optarg, "on-disk"))
    --			revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
    -+			revs->keep_pack_cache_flags |= CACHE_ON_DISK_KEEP_PACKS;
    - 	} else if (!strcmp(arg, "-r")) {
    - 		revs->diff = 1;
    - 		revs->diffopt.flags.recursive = 1;
20:  d5561585c2 !  8:  bd492ec142 builtin/repack.c: add '--geometric' option
    @@ Documentation/git-repack.txt: depth is 4095.
     +	contains at least `<factor>` times the number of objects as the
     +	next-largest pack.
     ++
    -+`git repack` ensures this by determining a "cut" of packfiles that need to be
    -+repacked into one in order to ensure a geometric progression. It picks the
    -+smallest set of packfiles such that as many of the larger packfiles (by count of
    -+objects contained in that pack) may be left intact.
    ++`git repack` ensures this by determining a "cut" of packfiles that need
    ++to be repacked into one in order to ensure a geometric progression. It
    ++picks the smallest set of packfiles such that as many of the larger
    ++packfiles (by count of objects contained in that pack) may be left
    ++intact.
    +++
    ++Unlike other repack modes, the set of objects to pack is determined
    ++uniquely by the set of packs being "rolled-up"; in other words, the
    ++packs determined to need to be combined in order to restore a geometric
    ++progression.
    +++
    ++Loose objects are implicitly included in this "roll-up", without respect
    ++to their reachability. This is subject to change in the future. This
    ++option (implying a drastically different repack mode) is not guarenteed
    ++to work with all other combinations of option to `git repack`).
     +
      Configuration
      -------------
--
2.30.0.667.g81c0cbc6fd
