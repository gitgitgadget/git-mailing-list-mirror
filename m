Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C38C67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiJXUdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiJXUdD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:33:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4A1C2EB1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:44:07 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y80so8487559iof.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbk8yZu7pCVPXdnyGUib8bHOGbXosux8adK7h7mGgTg=;
        b=ejxXcUxnPVEIGvVNWw/fl2Pir+uxY1tlG6r19veVH3mdrAJyYUAPUpiLekPVYw2DsF
         BzckxBIuRQQheyq9vStWrz5ApHtUD5nPDiojZJS2jxs3dgGjZ2u9gHuxu43y3iikhEXh
         EiqzoJKYrjcqpOmM+Q0CX4XxA40XjnRg3YzmLN+NbKNYuk8Mgu3M/HF3Y0hkPxmHhLGP
         x6yNPCEnGOTCkltF/s6sZTf+nDLXFp6dgmP2hQBC7F6+X2JsbSW1neRDmN7rpUKpvfxD
         41MwC0WqdwjRXWfSpe4PbtWo2wEFuODVmXYshGhLX6joJiFgHjnbikYOesVC6gXuXhwP
         NIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbk8yZu7pCVPXdnyGUib8bHOGbXosux8adK7h7mGgTg=;
        b=LkT6+ICMGvD+xoNpZn9MrJ5VwntGp5DaFC59KNj1AMfLl0ycsJV8fv9urhP5Wlu8xK
         nBVJxy1Q5hZ9jTbxdqSnoqleM/kHXkRJrezze/nc1pYeugko57AVDvpk/6t41actHl5P
         xPqvzaYe/ktH/fovuIgdCt8P1BSeduOx72jwxl7Tb5Ujmqs+/5ce5o/EL7BcPcRLh9uF
         8G0Jeq07KigZ+RtXEqBem5utj1WN9tubnukyHCoK/r8dCe4At9QJKwh83i99VPDR3DIX
         PlBQ05+NGvVEilZfiJRecRbMB0zgNeZ7r1neOBm0YvJ8dPim3weeCCBiJQiZUdXJ2rjS
         66iA==
X-Gm-Message-State: ACrzQf1LbOC+r6dbdeTMFsx3VqIdbyKQtGXCBYC3gkIC8w4RqJkRJCmh
        yqu7ak23AcV2jVtrN/spdYTx/oUiVaPCD0RP
X-Google-Smtp-Source: AMsMyM4a+VFp/Mj9lA1idfGAcQZtB3aHjkPKh1psN4DCcfNrSWn0wuk2kxF1sicryI9PBGEufXHHiw==
X-Received: by 2002:a6b:620f:0:b0:6bf:f49d:e7e9 with SMTP id f15-20020a6b620f000000b006bff49de7e9mr1061763iog.102.1666636993924;
        Mon, 24 Oct 2022 11:43:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b18-20020a026f52000000b003725d3b06a0sm90198jae.45.2022.10.24.11.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:43:13 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:43:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 4/4] builtin/repack.c: implement `--expire-to` for storing
 pruned objects
Message-ID: <6376d15c9c9adce883dba86ef5e5219f803aa9bf.1666636974.git.me@ttaylorr.com>
References: <cover.1666636974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666636974.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pruning objects with `--cruft`, `git repack` offers some
flexibility when selecting the set of which objects are pruned via the
`--cruft-expiration` option.

This is useful for expiring objects which are older than the grace
period, making races where to-be-pruned objects become reachable and
then ancestors of freshly pushed objects, leaving the repository in a
corrupt state after pruning substantially less likely [1].

But in practice, such races are impossible to avoid entirely, no matter
how long the grace period is. To prevent this race, it is often
advisable to temporarily put a repository into a read-only state. But in
practice, this is not always practical, and so some middle ground would
be nice.

This patch introduces a new option, `--expire-to`, which teaches `git
repack` to write an additional cruft pack containing just the objects
which were pruned from the repository. The caller can specify a
directory outside of the current repository as the destination for this
second cruft pack.

This makes it possible to prune objects from a repository, while still
holding onto a supplemental copy of them outside of the original
repository. Having this copy on-disk makes it substantially easier to
recover objects when the aforementioned race is encountered.

`--expire-to` is implemented in a somewhat convoluted manner, which is
to take advantage of the fact that the first time `write_cruft_pack()`
is called, it adds the name of the cruft pack to the `names` string
list. That means the second time we call `write_cruft_pack()`, objects
in the previously-written cruft pack will be excluded.

As long as the caller ensures that no objects are expired during the
second pass, this is sufficient to generate a cruft pack containing all
objects which don't appear in any of the new packs written by `git
repack`, including the cruft pack. In other words, all of the objects
which are about to be pruned from the repository.

It is important to note that the destination in `--expire-to` does not
necessarily need to be a Git repository (though it can be) Notably, the
expired packs do not contain all ancestors of expired objects. So if the
source repository contains something like:

              <unreachable>
             /
    C1 --- C2
      \
       refs/heads/master

where C2 is unreachable, but has a parent (C1) which is reachable, and
C2 would be pruned, then the expiry pack will contain only C2, not C1.

[1]: https://lore.kernel.org/git/20190319001829.GL29661@sigill.intra.peff.net/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-repack.txt |   6 ++
 builtin/repack.c             |  40 ++++++++++++
 t/t7700-repack.sh            | 121 +++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0bf13893d8..4017157949 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -74,6 +74,12 @@ to the new separate pack will be written.
 	immediately instead of waiting for the next `git gc` invocation.
 	Only useful with `--cruft -d`.
 
+--expire-to=<dir>::
+	Write a cruft pack containing pruned objects (if any) to the
+	directory `<dir>`. This option is useful for keeping a copy of
+	any pruned objects in a separate directory as a backup. Only
+	useful with `--cruft -d`.
+
 -l::
 	Pass the `--local` option to 'git pack-objects'. See
 	linkgit:git-pack-objects[1].
diff --git a/builtin/repack.c b/builtin/repack.c
index a5386ac893..3bc18e0b2f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -702,6 +702,10 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	 * By the time it is read here, it contains only the pack(s)
 	 * that were just written, which is exactly the set of packs we
 	 * want to consider kept.
+	 *
+	 * If `--expire-to` is given, the double-use served by `names`
+	 * ensures that the pack written to `--expire-to` excludes any
+	 * objects contained in the cruft pack.
 	 */
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, names)
@@ -755,6 +759,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int geometric_factor = 0;
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
+	const char *expire_to = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -804,6 +809,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			    N_("find a geometric progression with factor <N>")),
 		OPT_BOOL('m', "write-midx", &write_midx,
 			   N_("write a multi-pack index of the resulting packs")),
+		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
+			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_END()
 	};
 
@@ -1000,6 +1007,39 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				       &existing_kept_packs);
 		if (ret)
 			return ret;
+
+		if (delete_redundant && expire_to) {
+			/*
+			 * If `--expire-to` is given with `-d`, it's possible
+			 * that we're about to prune some objects. With cruft
+			 * packs, pruning is implicit: any objects from existing
+			 * packs that weren't picked up by new packs are removed
+			 * when their packs are deleted.
+			 *
+			 * Generate an additional cruft pack, with one twist:
+			 * `names` now includes the name of the cruft pack
+			 * written in the previous step. So the contents of
+			 * _this_ cruft pack exclude everything contained in the
+			 * existing cruft pack (that is, all of the unreachable
+			 * objects which are no older than
+			 * `--cruft-expiration`).
+			 *
+			 * To make this work, cruft_expiration must become NULL
+			 * so that this cruft pack doesn't actually prune any
+			 * objects. If it were non-NULL, this call would always
+			 * generate an empty pack (since every object not in the
+			 * cruft pack generated above will have an mtime older
+			 * than the expiration).
+			 */
+			ret = write_cruft_pack(&cruft_po_args, expire_to,
+					       pack_prefix,
+					       NULL,
+					       &names,
+					       &existing_nonkept_packs,
+					       &existing_kept_packs);
+			if (ret)
+				return ret;
+		}
 	}
 
 	string_list_sort(&names);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index ca45c4cd2c..17ee6fc2cc 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -482,4 +482,125 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '
 	test_server_info_missing
 '
 
+test_expect_success '--expire-to stores pruned objects (now)' '
+	git init expire-to-now &&
+	(
+		cd expire-to-now &&
+
+		git branch -M main &&
+
+		test_commit base &&
+
+		git checkout -b cruft &&
+		test_commit --no-tag cruft &&
+
+		git rev-list --objects --no-object-names main..cruft >moved.raw &&
+		sort moved.raw >moved.want &&
+
+		git rev-list --all --objects --no-object-names >expect.raw &&
+		sort expect.raw >expect &&
+
+		git checkout main &&
+		git branch -D cruft &&
+		git reflog expire --all --expire=all &&
+
+		git init --bare expired.git &&
+		git repack -d \
+			--cruft --cruft-expiration="now" \
+			--expire-to="expired.git/objects/pack/pack" &&
+
+		expired="$(ls expired.git/objects/pack/pack-*.idx)" &&
+		test_path_is_file "${expired%.idx}.mtimes" &&
+
+		# Since the `--cruft-expiration` is "now", the effective
+		# behavior is to move _all_ unreachable objects out to
+		# the location in `--expire-to`.
+		git show-index <$expired >expired.raw &&
+		cut -d" " -f2 expired.raw | sort >expired.objects &&
+		git rev-list --all --objects --no-object-names \
+			>remaining.objects &&
+
+		# ...in other words, the combined contents of this
+		# repository and expired.git should be the same as the
+		# set of objects we started with.
+		cat expired.objects remaining.objects | sort >actual &&
+		test_cmp expect actual &&
+
+		# The "moved" objects (i.e., those in expired.git)
+		# should be the same as the cruft objects which were
+		# expired in the previous step.
+		test_cmp moved.want expired.objects
+	)
+'
+
+test_expect_success '--expire-to stores pruned objects (5.minutes.ago)' '
+	git init expire-to-5.minutes.ago &&
+	(
+		cd expire-to-5.minutes.ago &&
+
+		git branch -M main &&
+
+		test_commit base &&
+
+		# Create two classes of unreachable objects, one which
+		# is older than 5 minutes (stale), and another which is
+		# newer (recent).
+		for kind in stale recent
+		do
+			git checkout -b $kind main &&
+			test_commit --no-tag $kind || return 1
+		done &&
+
+		git rev-list --objects --no-object-names main..stale >in &&
+		stale="$(git pack-objects $objdir/pack/pack <in)" &&
+		mtime="$(test-tool chmtime --get =-600 $objdir/pack/pack-$stale.pack)" &&
+
+		# expect holds the set of objects we expect to find in
+		# this repository after repacking
+		git rev-list --objects --no-object-names recent >expect.raw &&
+		sort expect.raw >expect &&
+
+		# moved.want holds the set of objects we expect to find
+		# in expired.git
+		git rev-list --objects --no-object-names main..stale >out &&
+		sort out >moved.want &&
+
+		git checkout main &&
+		git branch -D stale recent &&
+		git reflog expire --all --expire=all &&
+		git prune-packed &&
+
+		git init --bare expired.git &&
+		git repack -d \
+			--cruft --cruft-expiration=5.minutes.ago \
+			--expire-to="expired.git/objects/pack/pack" &&
+
+		# Some of the remaining objects in this repository are
+		# unreachable, so use `cat-file --batch-all-objects`
+		# instead of `rev-list` to get their names
+		git cat-file --batch-all-objects --batch-check="%(objectname)" \
+			>remaining.objects &&
+		sort remaining.objects >actual &&
+		test_cmp expect actual &&
+
+		(
+			cd expired.git &&
+
+			expired="$(ls objects/pack/pack-*.mtimes)" &&
+			test-tool pack-mtimes $(basename $expired) >out &&
+			cut -d" " -f1 out | sort >../moved.got &&
+
+			# Ensure that there are as many objects with the
+			# expected mtime as were moved to expired.git.
+			#
+			# In other words, ensure that the recorded
+			# mtimes of any moved objects was written
+			# correctly.
+			grep " $mtime$" out >matching &&
+			test_line_count = $(wc -l <../moved.want) matching
+		) &&
+		test_cmp moved.want moved.got
+	)
+'
+
 test_done
-- 
2.38.0.16.g393fd4c6db
