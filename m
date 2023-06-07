Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D298C7EE25
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 22:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjFGW6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjFGW6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 18:58:37 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1D910DE
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 15:58:22 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565aa2cc428so74718267b3.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686178701; x=1688770701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ApGFAzNygD0LAjmlKQ+IClUnaoHWKwO7eFmIw19bV0Q=;
        b=GnEBZhdsrWFZfTn1QAn7A7jYJqPUR1+WgEsY2yvNyKuc5pYqdbqJgvKIeYuV9H5W5Y
         etu7F0wNPPV00BK+inDNZfJEGqS100dUFWp6klFTHCXG9ozbjUs424604NqfFgTyloM5
         OeXmFBBfq3OZkR/I5XrzlJjLvmabScYEmJLkeF2LkbU1ZkQBTJGR2a0UXS4E07tgfvrg
         4TyV8we2MHQRf2sWxn5QSX1sGEhreZHiPi2h/yAKsr+2BAvfEAQdGgIQYuiLA+p+dtAO
         /x+XQ1Kam8xBkgLOkeKxfDhj3VnRPZXCocsppftfbG641TAXzXiKuV9NwN3o5vVebL/X
         uDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178701; x=1688770701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApGFAzNygD0LAjmlKQ+IClUnaoHWKwO7eFmIw19bV0Q=;
        b=YphBoPxySBmb/kcUn4PypqaZuIyMs0f31tCh5ExjRJSmrX3+5VSY26vXv+4seWGt4B
         B7QAQuA9009uzOeQOCXAZ3BwVBcx4L+YzxdYA/buBnDZBCgUnrg87ALrOV/HHwyKh6Ba
         uURIFpBSjz5IrbY+EhlwjzjPENM+PyPHUFBCt2NjRtLPtjz+loDG9tovXlcSqUTWsLiI
         YDJAJPiP758iXe9DtNW3oe9KZUGyRoS7cgw61QbROIAeN2phONKk63dDSmRyND3qPNTb
         es16GryEXWlbOPBQGBc19+Bf2i78zk2d0hWd/IMeKQFo40EO3JGjwl8vA6+jqlJwXuDK
         jOvg==
X-Gm-Message-State: AC+VfDwgnlqqauk/T8Ic8Sag62PqwPO2ZySLLFwKz7HJ6NJzwYb/xbka
        iLc2YGNhdyhL9HJ0kOMaiOkyoD6fE9XXzFUSCIqsQiMF
X-Google-Smtp-Source: ACHHUZ5Xvj7fd7JXNBwalhLgVqwrw8QIe0vAiFbMAVHBIQ4mUZcnfYZHH1QwhYkXf9aPx62L3GazrQ==
X-Received: by 2002:a81:df0a:0:b0:565:cff3:db09 with SMTP id c10-20020a81df0a000000b00565cff3db09mr7203401ywn.8.1686178701150;
        Wed, 07 Jun 2023 15:58:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j7-20020a816e07000000b00552df52450csm5062983ywc.88.2023.06.07.15.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:58:20 -0700 (PDT)
Date:   Wed, 7 Jun 2023 18:58:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Subject: [PATCH v5 2/2] gc: introduce `gc.recentObjectsHook`
Message-ID: <f661b54941a12c9bd8e226aebb4f0d53c10479c8.1686178684.git.me@ttaylorr.com>
References: <cover.1683847221.git.me@ttaylorr.com>
 <cover.1686178684.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686178684.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch introduces a new multi-valued configuration option,
`gc.recentObjectsHook` as a means to mark certain objects as recent (and
thus exempt from garbage collection), regardless of their age.

When performing a garbage collection operation on a repository with
unreachable objects, Git makes its decision on what to do with those
object(s) bed on how recent the objects are or not. Generally speaking,
unreachable-but-recent objects stay in the repository, and older objects
are discarded.

However, we have no convenient way to keep certain precious, unreachable
objects around in the repository, even if they have aged out and would
be pruned. Our options today consist of:

  - Point references at the reachability tips of any objects you
    consider precious, which may be undesirable or infeasible if there
    are many such objects.

  - Track them via the reflog, which may be undesirable since the
    reflog's lifetime is limited to that of the reference it's tracking
    (and callers may want to keep those unreachable objects around for
    longer).

  - Extend the grace period, which may keep around other objects that
    the caller *does* want to discard.

  - Manually modify the mtimes of objects you want to keep. If those
    objects are already loose, this is easy enough to do (you can just
    enumerate and `touch -m` each one).

    But if they are packed, you will either end up modifying the mtimes
    of *all* objects in that pack, or be forced to write out a loose
    copy of that object, both of which may be undesirable. Even worse,
    if they are in a cruft pack, that requires modifying its `*.mtimes`
    file by hand, since there is no exposed plumbing for this.

  - Force the caller to construct the pack of objects they want
    to keep themselves, and then mark the pack as kept by adding a
    ".keep" file. This works, but is burdensome for the caller, and
    having extra packs is awkward as you roll forward your cruft pack.

This patch introduces a new option to the above list via the
`gc.recentObjectsHook` configuration, which allows the caller to
specify a program (or set of programs) whose output is treated as a set
of objects to treat as recent, regardless of their true age.

The implementation is straightforward. Git enumerates recent objects via
`add_unseen_recent_objects_to_traversal()`, which enumerates loose and
packed objects, and eventually calls add_recent_object() on any objects
for which `want_recent_object()`'s conditions are met.

This patch modifies the recency condition from simply "is the mtime of
this object more recent than the cutoff?" to "[...] or, is this object
mentioned by at least one `gc.recentObjectsHook`?".

Depending on whether or not we are generating a cruft pack, this allows
the caller to do one of two things:

  - If generating a cruft pack, the caller is able to retain additional
    objects via the cruft pack, even if they would have otherwise been
    pruned due to their age.

  - If not generating a cruft pack, the caller is likewise able to
    retain additional objects as loose.

A potential alternative here is to introduce a new mode to alter the
contents of the reachable pack instead of the cruft one. One could
imagine a new option to `pack-objects`, say `--extra-reachable-tips`
that does the same thing as above, adding the visited set of objects
along the traversal to the pack.

But this has the unfortunate side-effect of altering the reachability
closure of that pack. If parts of the unreachable object graph mentioned
by one or more of the "extra reachable tips" programs is not closed,
then the resulting pack won't be either. This makes it impossible in the
general case to write out reachability bitmaps for that pack, since
closure is a requirement there.

Instead, keep these unreachable objects in the cruft pack (or set of
unreachable, loose objects) instead, to ensure that we can continue to
have a pack containing just reachable objects, which is always safe to
write a bitmap over.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/gc.txt          |  15 +++
 reachable.c                          |  79 ++++++++++++-
 t/t5304-prune.sh                     |  14 +++
 t/t5329-pack-objects-cruft.sh        | 171 +++++++++++++++++++++++++++
 t/t7701-repack-unpack-unreachable.sh |  31 +++++
 5 files changed, 307 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 7f95c866e1..ca47eb2008 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -130,6 +130,21 @@ or rebase occurring.  Since these changes are not part of the current
 project most users will want to expire them sooner, which is why the
 default is more aggressive than `gc.reflogExpire`.
 
+gc.recentObjectsHook::
+	When considering whether or not to remove an object (either when
+	generating a cruft pack or storing unreachable objects as
+	loose), use the shell to execute the specified command(s).
+	Interpret their output as object IDs which Git will consider as
+	"recent", regardless of their age. By treating their mtimes as
+	"now", any objects (and their descendants) mentioned in the
+	output will be kept regardless of their true age.
++
+Output must contain exactly one hex object ID per line, and nothing
+else. Objects which cannot be found in the repository are ignored.
+Multiple hooks are supported, but all must exit successfully, else the
+operation (either generating a cruft pack or unpacking unreachable
+objects) will be halted.
+
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
diff --git a/reachable.c b/reachable.c
index 7a42da5d39..60a7336b87 100644
--- a/reachable.c
+++ b/reachable.c
@@ -16,6 +16,8 @@
 #include "object-store.h"
 #include "pack-bitmap.h"
 #include "pack-mtimes.h"
+#include "config.h"
+#include "run-command.h"
 
 struct connectivity_progress {
 	struct progress *progress;
@@ -67,12 +69,75 @@ struct recent_data {
 	timestamp_t timestamp;
 	report_recent_object_fn *cb;
 	int ignore_in_core_kept_packs;
+
+	struct oidset extra_recent_oids;
+	int extra_recent_oids_loaded;
 };
 
+static int run_one_gc_recent_objects_hook(struct oidset *set,
+					    const char *args)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	FILE *out;
+	int ret = 0;
+
+	cmd.use_shell = 1;
+	cmd.out = -1;
+
+	strvec_push(&cmd.args, args);
+
+	if (start_command(&cmd))
+		return -1;
+
+	out = xfdopen(cmd.out, "r");
+	while (strbuf_getline(&buf, out) != EOF) {
+		struct object_id oid;
+		const char *rest;
+
+		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
+			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
+			break;
+		}
+
+		oidset_insert(set, &oid);
+	}
+
+	fclose(out);
+	ret |= finish_command(&cmd);
+
+	strbuf_release(&buf);
+	return ret;
+}
+
+static void load_gc_recent_objects(struct recent_data *data)
+{
+	const struct string_list *programs;
+	int ret = 0;
+	size_t i;
+
+	data->extra_recent_oids_loaded = 1;
+
+	if (git_config_get_string_multi("gc.recentobjectshook", &programs))
+		return;
+
+	for (i = 0; i < programs->nr; i++) {
+		ret = run_one_gc_recent_objects_hook(&data->extra_recent_oids,
+						       programs->items[i].string);
+		if (ret)
+			die(_("unable to enumerate additional recent objects"));
+	}
+}
+
 static int obj_is_recent(const struct object_id *oid, timestamp_t mtime,
 			 struct recent_data *data)
 {
-	return mtime > data->timestamp;
+	if (mtime > data->timestamp)
+		return 1;
+
+	if (!data->extra_recent_oids_loaded)
+		load_gc_recent_objects(data);
+	return oidset_contains(&data->extra_recent_oids, oid);
 }
 
 static void add_recent_object(const struct object_id *oid,
@@ -199,16 +264,24 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	data.cb = cb;
 	data.ignore_in_core_kept_packs = ignore_in_core_kept_packs;
 
+	oidset_init(&data.extra_recent_oids, 0);
+	data.extra_recent_oids_loaded = 0;
+
 	r = for_each_loose_object(add_recent_loose, &data,
 				  FOR_EACH_OBJECT_LOCAL_ONLY);
 	if (r)
-		return r;
+		goto done;
 
 	flags = FOR_EACH_OBJECT_LOCAL_ONLY | FOR_EACH_OBJECT_PACK_ORDER;
 	if (ignore_in_core_kept_packs)
 		flags |= FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS;
 
-	return for_each_packed_object(add_recent_packed, &data, flags);
+	r = for_each_packed_object(add_recent_packed, &data, flags);
+
+done:
+	oidset_clear(&data.extra_recent_oids);
+
+	return r;
 }
 
 static int mark_object_seen(const struct object_id *oid,
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index f367327441..b4df545e5a 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -350,4 +350,18 @@ test_expect_success 'old reachable-from-recent retained with bitmaps' '
 	test_must_fail git cat-file -e $to_drop
 '
 
+test_expect_success 'gc.recentObjectsHook' '
+	add_blob &&
+	test-tool chmtime =-86500 $BLOB_FILE &&
+
+	write_script precious-objects <<-EOF &&
+	echo $BLOB
+	EOF
+	test_config gc.recentObjectsHook ./precious-objects &&
+
+	git prune --expire=now &&
+
+	git cat-file -p $BLOB
+'
+
 test_done
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 303f7a5d84..45667d4999 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -739,4 +739,175 @@ test_expect_success 'cruft objects are freshend via loose' '
 	)
 '
 
+test_expect_success 'gc.recentObjectsHook' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		# Create a handful of objects.
+		#
+		#   - one reachable commit, "base", designated for the reachable
+		#     pack
+		#   - one unreachable commit, "cruft.discard", which is marked
+		#     for deletion
+		#   - one unreachable commit, "cruft.old", which would be marked
+		#     for deletion, but is rescued as an extra cruft tip
+		#   - one unreachable commit, "cruft.new", which is not marked
+		#     for deletion
+		test_commit base &&
+		git branch -M main &&
+
+		git checkout --orphan discard &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.discard &&
+
+		git checkout --orphan old &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.old &&
+		cruft_old="$(git rev-parse HEAD)" &&
+
+		git checkout --orphan new &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.new &&
+		cruft_new="$(git rev-parse HEAD)" &&
+
+		git checkout main &&
+		git branch -D discard old new &&
+		git reflog expire --all --expire=all &&
+
+		# mark cruft.old with an mtime that is many minutes
+		# older than the expiration period, and mark cruft.new
+		# with an mtime that is in the future (and thus not
+		# eligible for pruning).
+		test-tool chmtime -2000 "$objdir/$(test_oid_to_path $cruft_old)" &&
+		test-tool chmtime +1000 "$objdir/$(test_oid_to_path $cruft_new)" &&
+
+		# Write the list of cruft objects we expect to
+		# accumulate, which is comprised of everything reachable
+		# from cruft.old and cruft.new, but not cruft.discard.
+		git rev-list --objects --no-object-names \
+			$cruft_old $cruft_new >cruft.raw &&
+		sort cruft.raw >cruft.expect &&
+
+		# Write the script to list extra tips, which are limited
+		# to cruft.old, in this case.
+		write_script extra-tips <<-EOF &&
+		echo $cruft_old
+		EOF
+		git config gc.recentObjectsHook ./extra-tips &&
+
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft | sort >cruft.actual &&
+		test_cmp cruft.expect cruft.actual &&
+
+		# Ensure that the "old" objects are removed after
+		# dropping the gc.recentObjectsHook hook.
+		git config --unset gc.recentObjectsHook &&
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft | sort >cruft.actual &&
+
+		git rev-list --objects --no-object-names $cruft_new >cruft.raw &&
+		cp cruft.expect cruft.old &&
+		sort cruft.raw >cruft.expect &&
+		test_cmp cruft.expect cruft.actual &&
+
+		# ensure objects which are no longer in the cruft pack were
+		# removed from the repository
+		for object in $(comm -13 cruft.expect cruft.old)
+		do
+			test_must_fail git cat-file -t $object || return 1
+		done
+	)
+'
+
+test_expect_success 'multi-valued gc.recentObjectsHook' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+		git branch -M main &&
+
+		git checkout --orphan cruft.a &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.a &&
+		cruft_a="$(git rev-parse HEAD)" &&
+
+		git checkout --orphan cruft.b &&
+		git rm -fr . &&
+		test_commit --no-tag cruft.b &&
+		cruft_b="$(git rev-parse HEAD)" &&
+
+		git checkout main &&
+		git branch -D cruft.a cruft.b &&
+		git reflog expire --all --expire=all &&
+
+		echo "echo $cruft_a" | write_script extra-tips.a &&
+		echo "echo $cruft_b" | write_script extra-tips.b &&
+		echo "false" | write_script extra-tips.c &&
+
+		git rev-list --objects --no-object-names $cruft_a $cruft_b \
+			>cruft.raw &&
+		sort cruft.raw >cruft.expect &&
+
+		# ensure that each extra cruft tip is saved by its
+		# respective hook
+		git config --add gc.recentObjectsHook ./extra-tips.a &&
+		git config --add gc.recentObjectsHook ./extra-tips.b &&
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft | sort >cruft.actual &&
+		test_cmp cruft.expect cruft.actual &&
+
+		# ensure that a dirty exit halts cruft pack generation
+		git config --add gc.recentObjectsHook ./extra-tips.c &&
+		test_must_fail git repack --cruft --cruft-expiration=now -d 2>err &&
+		grep "unable to enumerate additional recent objects" err &&
+
+		# and that the existing cruft pack is left alone
+		test_path_is_file "$mtimes"
+	)
+'
+
+test_expect_success 'additional cruft blobs via gc.recentObjectsHook' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit base &&
+
+		blob=$(echo "unreachable" | git hash-object -w --stdin) &&
+
+		# mark the unreachable blob we wrote above as having
+		# aged out of the retention period
+		test-tool chmtime -2000 "$objdir/$(test_oid_to_path $blob)" &&
+
+		# Write the script to list extra tips, which is just the
+		# extra blob as above.
+		write_script extra-tips <<-EOF &&
+		echo $blob
+		EOF
+		git config gc.recentObjectsHook ./extra-tips &&
+
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft >actual &&
+		echo $blob >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index ebb267855f..ba428c18a8 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -113,6 +113,37 @@ test_expect_success 'do not bother loosening old objects' '
 	test_must_fail git cat-file -p $obj2
 '
 
+test_expect_success 'gc.recentObjectsHook' '
+	obj1=$(echo one | git hash-object -w --stdin) &&
+	obj2=$(echo two | git hash-object -w --stdin) &&
+	obj3=$(echo three | git hash-object -w --stdin) &&
+	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
+	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
+	pack3=$(echo $obj3 | git pack-objects .git/objects/pack/pack) &&
+	git prune-packed &&
+
+	git cat-file -p $obj1 &&
+	git cat-file -p $obj2 &&
+	git cat-file -p $obj3 &&
+
+	git tag -a -m tag obj2-tag $obj2 &&
+	obj2_tag="$(git rev-parse obj2-tag)" &&
+
+	write_script precious-objects <<-EOF &&
+	echo $obj2_tag
+	EOF
+	git config gc.recentObjectsHook ./precious-objects &&
+
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack3.pack &&
+	git repack -A -d --unpack-unreachable=1.hour.ago &&
+
+	git cat-file -p $obj1 &&
+	git cat-file -p $obj2 &&
+	git cat-file -p $obj2_tag &&
+	test_must_fail git cat-file -p $obj3
+'
+
 test_expect_success 'keep packed objects found only in index' '
 	echo my-unique-content >file &&
 	git add file &&
-- 
2.41.0.2.gaaae24b3a6.dirty
