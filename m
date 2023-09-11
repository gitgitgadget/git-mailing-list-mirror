Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3DCA0EC2
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349140AbjIKVcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241349AbjIKPHE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:07:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A67FA
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso5734955a12.3
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444816; x=1695049616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKQC3nctpngMKsYr5nRFZ8uBScUwlPNwwxQMuOv8qsg=;
        b=g0KfKFBp3TjWIa5/hXxKipRViqFZAuF8YnC2Db5PaIPv5I7x8SIyqWl1n1NmfjyJHD
         FBiHIiXZ4PLCVnNPdavqetNRo8hD2JioMuKltMJOQTetoNsNAcueagcXbPh8Vzo7XwMr
         PPPitPPJBB7eRGAHdG2y7whXx6EEVyner74yzSRYFmZgBAjF0qTOA+FwOU2pcRscAY1K
         kdNTKXdsGd82og5AEUYmHxP07UOUfSmEtnaJxPP0PkEeoput1VGFXW/A5qPPJNfByZ3K
         YMiOS1WBebx9AjRF2XEUzQ7yaZFPc5OwGnOMPSbDMAxDfuq2+Gp+OQ1FjS+JdY8ufqn5
         2e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444816; x=1695049616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKQC3nctpngMKsYr5nRFZ8uBScUwlPNwwxQMuOv8qsg=;
        b=Ckl2GdzomRmKLURFvVhJdVOkwY1Gqrb5yrcj7aJI7NTsaHpxIeU1OaEipstxEMn/Im
         JA/rwjocxwuIm1QglC00NA5UJKcKV12AH5LzHAQIzdQRYv2AOm2Kt3Lf73nqfl7n/Ocq
         aAabF+K2V43nrm2EqJ0S3H9MjmiLAkee9VooB1jcSQJIKPpXCP0ZVTT3hb5AjZT17/Gd
         RNnoMEEECL65KKeaQqlBBTWXSuPgCaPwDzFZC6o7oA3JLttv6UCv8X4I4/Jn0itqtdCw
         EccYmNf9oaDVw2MogshKq3MzTS7lEBt+g8TJrPw6EVm4sRhK4QZCi/aSRbOH1yMIvAZX
         mU8Q==
X-Gm-Message-State: AOJu0YwCRPxMM+91b4RGNHuXIjs5KdtmUfjUH3GdatguZlzM06AS7o0z
        UvnIceR7UDozjci0omyVdF0F5R6nZyk=
X-Google-Smtp-Source: AGHT+IHYwMs6Pmyc/I19GOnRGLz41zFVIupJ/H1E0+1BEu0wWHTznuHd/2CeRoSkYd2kBfVzqYlpUQ==
X-Received: by 2002:a17:906:cc13:b0:9a2:eb6e:2cf3 with SMTP id ml19-20020a170906cc1300b009a2eb6e2cf3mr9495087ejb.0.1694444816129;
        Mon, 11 Sep 2023 08:06:56 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1085:31e2:f2be:e47a:b382:4542])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5485617ejc.28.2023.09.11.08.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:06:55 -0700 (PDT)
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
Subject: [PATCH v6 6/9] repack: add `--filter=<filter-spec>` option
Date:   Mon, 11 Sep 2023 17:06:15 +0200
Message-ID: <20230911150618.129737-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.167.gd6ff314189
In-Reply-To: <20230911150618.129737-1-christian.couder@gmail.com>
References: <20230812000011.1227371-1-christian.couder@gmail.com>
 <20230911150618.129737-1-christian.couder@gmail.com>
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

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-repack.txt |  12 ++++
 builtin/repack.c             |  73 +++++++++++++++++++
 t/t7700-repack.sh            | 135 +++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)

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
index 8de3009b9f..ac70698a41 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -21,6 +21,7 @@
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "refs.h"
+#include "list-objects-filter-options.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -57,6 +58,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	struct list_objects_filter_options filter_options;
 };
 
 static int repack_config(const char *var, const char *value,
@@ -725,6 +727,57 @@ static int finish_pack_objects_cmd(struct child_process *cmd,
 	return finish_command(cmd);
 }
 
+static int write_filtered_pack(const struct pack_objects_args *args,
+			       const char *destination,
+			       const char *pack_prefix,
+			       struct string_list *keep_pack_list,
+			       struct string_list *names,
+			       struct string_list *existing_packs,
+			       struct string_list *existing_kept_packs)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list_item *item;
+	FILE *in;
+	int ret, i;
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
+	for (i = 0; i < keep_pack_list->nr; i++)
+		strvec_pushf(&cmd.args, "--keep-pack=%s",
+			     keep_pack_list->items[i].string);
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
+	for_each_string_list_item(item, existing_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	caret = pack_kept_objects ? "" : "^";
+	for_each_string_list_item(item, existing_kept_packs)
+		fprintf(in, "%s%s.pack\n", caret, item->string);
+	fclose(in);
+
+	return finish_pack_objects_cmd(&cmd, names, local);
+}
+
 static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *destination,
 			    const char *pack_prefix,
@@ -855,6 +908,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&po_args.filter_options),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -868,6 +922,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	list_objects_filter_init(&po_args.filter_options);
+
 	git_config(repack_config, &cruft_po_args);
 
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
@@ -1008,6 +1064,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--incremental");
 	}
 
+	if (po_args.filter_options.choice)
+		strvec_pushf(&cmd.args, "--filter=%s",
+			     expand_list_objects_filter_spec(&po_args.filter_options));
+
 	if (geometry.split_factor)
 		cmd.in = -1;
 	else
@@ -1096,6 +1156,18 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (po_args.filter_options.choice) {
+		ret = write_filtered_pack(&po_args,
+					  packtmp,
+					  find_pack_prefix(packdir, packtmp),
+					  &keep_pack_list,
+					  &names,
+					  &existing_nonkept_packs,
+					  &existing_kept_packs);
+		if (ret)
+			goto cleanup;
+	}
+
 	string_list_sort(&names);
 
 	close_object_store(the_repository->objects);
@@ -1230,6 +1302,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
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
2.42.0.167.gd6ff314189

