Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D6E748FB
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbjJBQzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbjJBQzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED322E8
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-534659061afso13452042a12.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265735; x=1696870535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Exkm0g9UlfEBlVv4FQte8xMmGskn5N+nolz1YqLcKQ=;
        b=mVQsUz1p8/+ck4zwVE2OBlVwkK1K/axOSOdUFFfCstaNU4QzepuJQkYJw2GIaMcKri
         Tw77EyfmWSXjFyHGhQ3vNfX28bgEZEC7OLo/bplrZOAKUlK3hK3OYhP3zSs10crAA5XC
         4nU2HCobm8lS9EYq/N01kZQ8QIW3ErMvcRzzRUPfzK/Q/E4TTih1wpUmTKts01SeP1pl
         bmvl6ElsVjKkBwP8/cXTiAOUttr0vWLdYedhVyonlwur3JiqEUYgrnkIMIIFKd3z8RkR
         vPSaPz5hCm8eihm4c6x++RnLKh97kQt5ajWNlfY0LLPH6tOBwimaWjxvpMnaZFTM0eSP
         xc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265735; x=1696870535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Exkm0g9UlfEBlVv4FQte8xMmGskn5N+nolz1YqLcKQ=;
        b=CSPpqPWfjfXT9kAQ1gQ1iREZmd4S8TI+XbGw36GonGEFpzZkUHuWnPWmMRAtYYefOw
         Z5Q4Gu7B7l+ydIQ9ZEgIH70Pmp6pMmpkuAoFgN/BEzPI6UiNKVmYHx6wLsoXJO5owIuW
         PNyDpI/cv3Lc491j/X6uDl5enQUzzOi8QtMFr8SWpMxtFsp/KhmSxT+G0fg4BeN07bSQ
         j0dhGrmmGU3o19dal6PVN7NmSQRCx2LI7qtYk3xo8dbfgcXb+iaWTTBab6VlHkF7S9Dg
         PG2X0/2OentEYn44ENLLOPwZh95ZgJLWsyb2PBRaRjaZGT7xgKptASX0maatAVd/s+lj
         0zpg==
X-Gm-Message-State: AOJu0YzMIUeSh4ta0TX/kEhkBNZbZXNk7mhCg3fi4r6dEk0IEL02T+/O
        0wXh9du1eXkirahG4EfVzLgj5Cn/DiUuWA==
X-Google-Smtp-Source: AGHT+IEdVKUP7nw/n1UJAOOpMLv3ztwtHynks4nGRJpRiaCtS5rMuXRQL1F4L9M3LCdiZlv27ksl0w==
X-Received: by 2002:a05:6402:785:b0:533:1832:f2b4 with SMTP id d5-20020a056402078500b005331832f2b4mr10877816edy.13.1696265734838;
        Mon, 02 Oct 2023 09:55:34 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:33 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 6/9] repack: add `--filter=<filter-spec>` option
Date:   Mon,  2 Oct 2023 18:55:01 +0200
Message-ID: <20231002165504.1325153-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option puts the objects specified by `<filter-spec>` into a
separate packfile.

This could be useful if, for example, some blobs take up a lot of
precious space on fast storage while they are rarely accessed. It could
make sense to move them into a separate cheaper, though slower, storage.

It's possible to find which new packfile contains the filtered out
objects using one of the following:

  - `git verify-pack -v ...`,
  - `test-tool find-pack ...`, which a previous commit added,
  - `--filter-to=<dir>`, which a following commit will add to specify
    where the pack containing the filtered out objects will be.

This feature is implemented by running `git pack-objects` twice in a
row. The first command is run with `--filter=<filter-spec>`, using the
specified filter. It packs objects while omitting the objects specified
by the filter. Then another `git pack-objects` command is launched using
`--stdin-packs`. We pass it all the previously existing packs into its
stdin, so that it will pack all the objects in the previously existing
packs. But we also pass into its stdin, the pack created by the previous
`git pack-objects --filter=<filter-spec>` command as well as the kept
packs, all prefixed with '^', so that the objects in these packs will be
omitted from the resulting pack. The result is that only the objects
filtered out by the first `git pack-objects` command are in the pack
resulting from the second `git pack-objects` command.

As the interactions with kept packs are a bit tricky, a few related
tests are added.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-repack.txt |  12 ++++
 builtin/repack.c             |  70 ++++++++++++++++++
 t/t7700-repack.sh            | 135 +++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4017157949..6d5bec7716 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -143,6 +143,18 @@ depth is 4095.
 	a larger and slower repository; see the discussion in
 	`pack.packSizeLimit`.
 
+--filter=<filter-spec>::
+	Remove objects matching the filter specification from the
+	resulting packfile and put them into a separate packfile. Note
+	that objects used in the working directory are not filtered
+	out. So for the split to fully work, it's best to perform it
+	in a bare repo and to use the `-a` and `-d` options along with
+	this option.  Also `--no-write-bitmap-index` (or the
+	`repack.writebitmaps` config option set to `false`) should be
+	used otherwise writing bitmap index will fail, as it supposes
+	a single packfile containing all the objects. See
+	linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index 9ef0044384..c7b564192f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -21,6 +21,7 @@
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "refs.h"
+#include "list-objects-filter-options.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -56,6 +57,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	struct list_objects_filter_options filter_options;
 };
 
 static int repack_config(const char *var, const char *value,
@@ -836,6 +838,56 @@ static int finish_pack_objects_cmd(struct child_process *cmd,
 	return finish_command(cmd);
 }
 
+static int write_filtered_pack(const struct pack_objects_args *args,
+			       const char *destination,
+			       const char *pack_prefix,
+			       struct existing_packs *existing,
+			       struct string_list *names)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list_item *item;
+	FILE *in;
+	int ret;
+	const char *caret;
+	const char *scratch;
+	int local = skip_prefix(destination, packdir, &scratch);
+
+	prepare_pack_objects(&cmd, args, destination);
+
+	strvec_push(&cmd.args, "--stdin-packs");
+
+	if (!pack_kept_objects)
+		strvec_push(&cmd.args, "--honor-pack-keep");
+	for_each_string_list_item(item, &existing->kept_packs)
+		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
+
+	cmd.in = -1;
+
+	ret = start_command(&cmd);
+	if (ret)
+		return ret;
+
+	/*
+	 * Here 'names' contains only the pack(s) that were just
+	 * written, which is exactly the packs we want to keep. Also
+	 * 'existing_kept_packs' already contains the packs in
+	 * 'keep_pack_list'.
+	 */
+	in = xfdopen(cmd.in, "w");
+	for_each_string_list_item(item, names)
+		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
+	for_each_string_list_item(item, &existing->non_kept_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	for_each_string_list_item(item, &existing->cruft_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	caret = pack_kept_objects ? "" : "^";
+	for_each_string_list_item(item, &existing->kept_packs)
+		fprintf(in, "%s%s.pack\n", caret, item->string);
+	fclose(in);
+
+	return finish_pack_objects_cmd(&cmd, names, local);
+}
+
 static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *destination,
 			    const char *pack_prefix,
@@ -966,6 +1018,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&po_args.filter_options),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -979,6 +1032,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	list_objects_filter_init(&po_args.filter_options);
+
 	git_config(repack_config, &cruft_po_args);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
@@ -1119,6 +1174,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--incremental");
 	}
 
+	if (po_args.filter_options.choice)
+		strvec_pushf(&cmd.args, "--filter=%s",
+			     expand_list_objects_filter_spec(&po_args.filter_options));
+
 	if (geometry.split_factor)
 		cmd.in = -1;
 	else
@@ -1205,6 +1264,16 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (po_args.filter_options.choice) {
+		ret = write_filtered_pack(&po_args,
+					  packtmp,
+					  find_pack_prefix(packdir, packtmp),
+					  &existing,
+					  &names);
+		if (ret)
+			goto cleanup;
+	}
+
 	string_list_sort(&names);
 
 	close_object_store(the_repository->objects);
@@ -1297,6 +1366,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 1);
 	existing_packs_release(&existing);
 	free_pack_geometry(&geometry);
+	list_objects_filter_release(&po_args.filter_options);
 
 	return ret;
 }
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 27b66807cd..39e89445fd 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -327,6 +327,141 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'repacking with a filter works' '
+	git -C bare.git repack -a -d &&
+	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
+	git -C bare.git -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
+	test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
+	commit_pack=$(test-tool -C bare.git find-pack -c 1 HEAD) &&
+	blob_pack=$(test-tool -C bare.git find-pack -c 1 HEAD:file1) &&
+	test "$commit_pack" != "$blob_pack" &&
+	tree_pack=$(test-tool -C bare.git find-pack -c 1 HEAD^{tree}) &&
+	test "$tree_pack" = "$commit_pack" &&
+	blob_pack2=$(test-tool -C bare.git find-pack -c 1 HEAD:file2) &&
+	test "$blob_pack2" = "$blob_pack"
+'
+
+test_expect_success '--filter fails with --write-bitmap-index' '
+	test_must_fail \
+		env GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -C bare.git repack -a -d --write-bitmap-index --filter=blob:none
+'
+
+test_expect_success 'repacking with two filters works' '
+	git init two-filters &&
+	(
+		cd two-filters &&
+		mkdir subdir &&
+		test_commit foo &&
+		test_commit subdir_bar subdir/bar &&
+		test_commit subdir_baz subdir/baz
+	) &&
+	git clone --no-local --bare two-filters two-filters.git &&
+	(
+		cd two-filters.git &&
+		test_stdout_line_count = 1 ls objects/pack/*.pack &&
+		git -c repack.writebitmaps=false repack -a -d \
+			--filter=blob:none --filter=tree:1 &&
+		test_stdout_line_count = 2 ls objects/pack/*.pack &&
+		commit_pack=$(test-tool find-pack -c 1 HEAD) &&
+		blob_pack=$(test-tool find-pack -c 1 HEAD:foo.t) &&
+		root_tree_pack=$(test-tool find-pack -c 1 HEAD^{tree}) &&
+		subdir_tree_hash=$(git ls-tree --object-only HEAD -- subdir) &&
+		subdir_tree_pack=$(test-tool find-pack -c 1 "$subdir_tree_hash") &&
+
+		# Root tree and subdir tree are not in the same packfiles
+		test "$commit_pack" != "$blob_pack" &&
+		test "$commit_pack" = "$root_tree_pack" &&
+		test "$blob_pack" = "$subdir_tree_pack"
+	)
+'
+
+prepare_for_keep_packs () {
+	git init keep-packs &&
+	(
+		cd keep-packs &&
+		test_commit foo &&
+		test_commit bar
+	) &&
+	git clone --no-local --bare keep-packs keep-packs.git &&
+	(
+		cd keep-packs.git &&
+
+		# Create two packs
+		# The first pack will contain all of the objects except one blob
+		git rev-list --objects --all >objs &&
+		grep -v "bar.t" objs | git pack-objects pack &&
+		# The second pack will contain the excluded object and be kept
+		packid=$(grep "bar.t" objs | git pack-objects pack) &&
+		>pack-$packid.keep &&
+
+		# Replace the existing pack with the 2 new ones
+		rm -f objects/pack/pack* &&
+		mv pack-* objects/pack/
+	)
+}
+
+test_expect_success '--filter works with .keep packs' '
+	prepare_for_keep_packs &&
+	(
+		cd keep-packs.git &&
+
+		foo_pack=$(test-tool find-pack -c 1 HEAD:foo.t) &&
+		bar_pack=$(test-tool find-pack -c 1 HEAD:bar.t) &&
+		head_pack=$(test-tool find-pack -c 1 HEAD) &&
+
+		test "$foo_pack" != "$bar_pack" &&
+		test "$foo_pack" = "$head_pack" &&
+
+		git -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
+
+		foo_pack_1=$(test-tool find-pack -c 1 HEAD:foo.t) &&
+		bar_pack_1=$(test-tool find-pack -c 1 HEAD:bar.t) &&
+		head_pack_1=$(test-tool find-pack -c 1 HEAD) &&
+
+		# Object bar is still only in the old .keep pack
+		test "$foo_pack_1" != "$foo_pack" &&
+		test "$bar_pack_1" = "$bar_pack" &&
+		test "$head_pack_1" != "$head_pack" &&
+
+		test "$foo_pack_1" != "$bar_pack_1" &&
+		test "$foo_pack_1" != "$head_pack_1" &&
+		test "$bar_pack_1" != "$head_pack_1"
+	)
+'
+
+test_expect_success '--filter works with --pack-kept-objects and .keep packs' '
+	rm -rf keep-packs keep-packs.git &&
+	prepare_for_keep_packs &&
+	(
+		cd keep-packs.git &&
+
+		foo_pack=$(test-tool find-pack -c 1 HEAD:foo.t) &&
+		bar_pack=$(test-tool find-pack -c 1 HEAD:bar.t) &&
+		head_pack=$(test-tool find-pack -c 1 HEAD) &&
+
+		test "$foo_pack" != "$bar_pack" &&
+		test "$foo_pack" = "$head_pack" &&
+
+		git -c repack.writebitmaps=false repack -a -d --filter=blob:none \
+			--pack-kept-objects &&
+
+		foo_pack_1=$(test-tool find-pack -c 1 HEAD:foo.t) &&
+		test-tool find-pack -c 2 HEAD:bar.t >bar_pack_1 &&
+		head_pack_1=$(test-tool find-pack -c 1 HEAD) &&
+
+		test "$foo_pack_1" != "$foo_pack" &&
+		test "$foo_pack_1" != "$bar_pack" &&
+		test "$head_pack_1" != "$head_pack" &&
+
+		# Object bar is in both the old .keep pack and the new
+		# pack that contained the filtered out objects
+		grep "$bar_pack" bar_pack_1 &&
+		grep "$foo_pack_1" bar_pack_1 &&
+		test "$foo_pack_1" != "$head_pack_1"
+	)
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.42.0.305.g5bfd918c90

