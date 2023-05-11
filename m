Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C109C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbjEKXVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbjEKXUs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:20:48 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617F5BA5
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:20:40 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a10577911so134650177b3.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683847240; x=1686439240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84bBjBfb1BYoIxMhshTQlIgVwjOOBPnE4psE0L3Prjg=;
        b=u85qPmpv/tIbEYT/9p1yNb/N6qvEJ4TNvZa72bAwyaMkyqQ+ecvexy7n6qxZ4/+gKy
         RJcFidAUQzfN1V/BAWM3V6Z6Y+FoFQLW0WyUpgqAoTvjkq9dhv9yudJQcXPYYqDNiZsv
         V4XeSdkJEPXtO+mUto4D7yfmv8OTM84oyIlF9HxewBPV8Yu3VIJC5eCuA5D4TwiMO8O8
         Yk/k3I1hzS3vCI0mE/G1mvne+D4Ut0p+bYNeTVUQt17gXP9a9WoqdvxtoVMNXVoykUdu
         7Ymq3uNFWQujDRdOQJWToHVy9HGxszZ5qQCFnquZFpZxJjRqPM3pbCLeY7sZTU0OmaSj
         2vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683847240; x=1686439240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84bBjBfb1BYoIxMhshTQlIgVwjOOBPnE4psE0L3Prjg=;
        b=Gq5O/gBS69GnqveUfKnXWQKD5cyJ3grYdQLzBnekj/n2hJh3vH9eljfJsj9R2fxpj0
         v9MaeHteex+MS6TEJaaDRI1QmwjHavl2T1ZGyZT5Q7jn8UDixni6C3Mwl7m1s2b3wPU6
         QvoG0jqRR/1u2rqGkP+8UMeD3rUfPgnt+64/GyV/RNak29zgERGDfVYNVtOd7mdsYoxK
         Mt5EnJ+FEl0TqDX7nzpddNauDhfxWgxb6zkEbnK7Yg2RBWQ2m14BzOXPtEUeBg6zoB/I
         +yRS41oUQ/3YOrpuDgnn8Auv+EUPFZUmEHYyIGZ7eh8Ux/Q5OUH8bknDwjuf8Jra7FkX
         ybFQ==
X-Gm-Message-State: AC+VfDzgkPogHw2GCVjZ0gSmpYQPtEZSKle8kKBglPWdz3EtfBD3hfQ2
        BwF7yrUJMRS/c48kP4Uq66g5tCU2s1iP8QaFWOQd6g==
X-Google-Smtp-Source: ACHHUZ4G5QWz+/LeMrjybUPOf3YQuvlEDR2Li15x2rSQuHLrI9dBBDooaY+D0w3T+fqZRXlzMhrdmQ==
X-Received: by 2002:a0d:e701:0:b0:559:d495:7cc7 with SMTP id q1-20020a0de701000000b00559d4957cc7mr21516203ywe.5.1683847238859;
        Thu, 11 May 2023 16:20:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u81-20020a0deb54000000b0054f8b201c70sm5205909ywe.108.2023.05.11.16.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:20:38 -0700 (PDT)
Date:   Thu, 11 May 2023 19:20:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
References: <cover.1683847221.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683847221.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch introduces a new multi-valued configuration option,
`pack.recentObjectsHook` as a means to mark certain objects as recent,
regardless of their age.

Depending on whether or not we are generating a cruft pack, this allows
the caller to do one of two things:

  - If generating a cruft pack, the caller is able to retain additional
    objects via the cruft pack, even if they would have otherwise been
    pruned due to their age.

  - If not generating a cruft pack, the caller is likewise able to
    retain additional objects as loose.

There is currently no option to be able to keep around certain objects
that have otherwise aged out of the grace period. The only way to retain
those objects is:

  - to point a reference at them, which may be undesirable or
    infeasible,

  - to track them via the reflog, which may be undesirable since the
    reflog's lifetime is limited to that of the reference it's tracking
    (and callers may want to keep those unreachable objects around for
    longer)

  - to extend the grace period, which may keep around other objects that
    the caller *does* want to discard,

  - or, to force the caller to construct the pack of objects they want
    to keep themselves, and then mark the pack as kept by adding a
    ".keep" file.

This patch introduces a new configuration, `pack.recentObjectsHook`
which allows the caller to specify a program (or set of programs) whose
output is treated as a set of objects to treat as recent, regardless of
their true age.

The implementation is straightforward. In either case (cruft packs or
not), Git enumerates recent objects via
`add_unseen_recent_objects_to_traversal()`. That enumerates loose and
packed objects, and eventually calls add_recent_object() on any objects
for which `want_recent_object()`'s conditions are met.

This patch modifies the recency condition from simply "is the mtime of
this object more recent than the cutoff?" to "[...] or, is this object
mentioned by at least one `pack.recentObjectsHook`?".

We then add those as tips to another reachability traversal (along with
any recent objects, if pruning), marking every object along the way
(either adding it to the cruft pack, or writing it out as a loose
object).

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
 Documentation/config/pack.txt        |  13 ++
 builtin/pack-objects.c               |   1 +
 reachable.c                          |  94 ++++++++++++++-
 t/t5329-pack-objects-cruft.sh        | 171 +++++++++++++++++++++++++++
 t/t7701-repack-unpack-unreachable.sh |  22 ++++
 5 files changed, 297 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index d4c7c9d4e4..560cb42223 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -67,6 +67,19 @@ pack.deltaCacheLimit::
 	result once the best match for all objects is found.
 	Defaults to 1000. Maximum value is 65535.
 
+pack.recentObjectsHook::
+	When considering the recency of an object (e.g., when generating
+	a cruft pack or storing unreachable objects as loose), use the
+	shell to execute the specified command(s). Interpret their
+	output as object IDs which Git will consider as "recent",
+	regardless of their age.
++
+Output must contain exactly one hex object ID per line, and nothing
+else. Objects which cannot be found in the repository are ignored.
+Multiple hooks are supported, but all must exit successfully, else the
+operation (either generating a cruft pack or unpacking unreachable
+objects) will be halted.
+
 pack.threads::
 	Specifies the number of threads to spawn when searching for best
 	delta matches.  This requires that linkgit:git-pack-objects[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a5b466839b..bd6ad016d6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -44,6 +44,7 @@
 #include "pack-mtimes.h"
 #include "parse-options.h"
 #include "wrapper.h"
+#include "run-command.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
diff --git a/reachable.c b/reachable.c
index 7a42da5d39..4cca6fe93f 100644
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
@@ -67,12 +69,82 @@ struct recent_data {
 	timestamp_t timestamp;
 	report_recent_object_fn *cb;
 	int ignore_in_core_kept_packs;
+
+	struct oidset extra_recent_oids;
+	int extra_recent_oids_loaded;
 };
 
+static int run_one_pack_recent_objects_hook(struct oidset *set,
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
+			goto done;
+		}
+
+		oidset_insert(set, &oid);
+	}
+
+	ret = finish_command(&cmd);
+
+done:
+	if (out)
+		fclose(out);
+	strbuf_release(&buf);
+	child_process_clear(&cmd);
+
+	return ret;
+}
+
+static void load_pack_recent_objects(struct recent_data *data)
+{
+	const struct string_list *programs;
+	int ret = 0;
+	size_t i;
+
+	data->extra_recent_oids_loaded = 1;
+
+	if (git_config_get_string_multi("pack.recentobjectshook", &programs))
+		return;
+
+	for (i = 0; i < programs->nr; i++) {
+		ret = run_one_pack_recent_objects_hook(&data->extra_recent_oids,
+						       programs->items[i].string);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		die(_("unable to enumerate additional cruft tips"));
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
+		load_pack_recent_objects(data);
+	return oidset_contains(&data->extra_recent_oids, oid);
 }
 
 static void add_recent_object(const struct object_id *oid,
@@ -126,8 +198,14 @@ static int want_recent_object(struct recent_data *data,
 			      const struct object_id *oid)
 {
 	if (data->ignore_in_core_kept_packs &&
-	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS))
+	    has_object_kept_pack(oid, IN_CORE_KEEP_PACKS)) {
+		if (!data->extra_recent_oids_loaded)
+			load_pack_recent_objects(data);
+		if (oidset_contains(&data->extra_recent_oids, oid))
+			return 1;
+
 		return 0;
+	}
 	return 1;
 }
 
@@ -199,16 +277,24 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
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
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 303f7a5d84..ffd6c2eeb6 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -739,4 +739,175 @@ test_expect_success 'cruft objects are freshend via loose' '
 	)
 '
 
+test_expect_success 'additional cruft tips may be specified via pack.extraCruftTips' '
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
+		git config pack.recentObjectsHook ./extra-tips &&
+
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft | sort >cruft.actual &&
+		test_cmp cruft.expect cruft.actual &&
+
+		# Ensure that the "old" objects are removed after
+		# dropping the pack.extraCruftTips hook.
+		git config --unset pack.recentObjectsHook &&
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
+test_expect_success 'multi-valued pack.extraCruftTips' '
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
+		git config --add pack.recentObjectsHook ./extra-tips.a &&
+		git config --add pack.recentObjectsHook ./extra-tips.b &&
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft | sort >cruft.actual &&
+		test_cmp cruft.expect cruft.actual &&
+
+		# ensure that a dirty exit halts cruft pack generation
+		git config --add pack.recentObjectsHook ./extra-tips.c &&
+		test_must_fail git repack --cruft --cruft-expiration=now -d 2>err &&
+		grep "unable to enumerate additional cruft tips" err &&
+
+		# and that the existing cruft pack is left alone
+		test_path_is_file "$mtimes"
+	)
+'
+
+test_expect_success 'additional cruft blobs via pack.extraCruftTips' '
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
+		git config pack.recentObjectsHook ./extra-tips &&
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
index ebb267855f..d2eea6e754 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -113,6 +113,28 @@ test_expect_success 'do not bother loosening old objects' '
 	test_must_fail git cat-file -p $obj2
 '
 
+test_expect_success 'extra recent tips are kept regardless of age' '
+	obj1=$(echo one | git hash-object -w --stdin) &&
+	obj2=$(echo two | git hash-object -w --stdin) &&
+	pack1=$(echo $obj1 | git pack-objects .git/objects/pack/pack) &&
+	pack2=$(echo $obj2 | git pack-objects .git/objects/pack/pack) &&
+	git prune-packed &&
+
+	git cat-file -p $obj1 &&
+	git cat-file -p $obj2 &&
+
+	write_script extra-tips <<-EOF &&
+	echo $obj2
+	EOF
+	git config pack.recentObjectsHook ./extra-tips &&
+
+	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
+	git repack -A -d --unpack-unreachable=1.hour.ago &&
+
+	git cat-file -p $obj1 &&
+	git cat-file -p $obj2
+'
+
 test_expect_success 'keep packed objects found only in index' '
 	echo my-unique-content >file &&
 	git add file &&
-- 
2.40.1.554.g2ce8a79fa4
