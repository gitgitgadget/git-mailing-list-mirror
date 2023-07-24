Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731AAC001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 08:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjGXI75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjGXI7p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 04:59:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B615D137
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977e0fbd742so662690966b.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189182; x=1690793982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpm73t/Fx3pCkHAtgHrzYskc/SByoOkgJguPBGbzJVk=;
        b=HSSRWNFZ3+w3IK8zmhzL3o9EW3BuZhP8quyzsrINnyHu62nTuKZ/ejQzXBsEnFS7CG
         /fJwWMLhKQIZzTAKLkHZN+kwkdKyu0dPMelkx+T1ogxs6/11avKowJ88d6bxtrVfTEEJ
         tx1lIdUYvjqkg7bLb58hBzKsb0FxNFHzW2KBKO1CsW8bk2wePKt5VDEf+rVOl6oHU7oA
         zqHmmJtu1nvAnlxcE2ngaB7JU4j0N0OuGABvDTHrMcDFO9UgqLGST/q/dmbzSKi2xErW
         N0VPtG9RNmAEFXEMOh1aPQzwcz+Onx8UNNU4ip7Qh74cVyYtNuoGgmSERptOIIcqq3Yr
         EhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189182; x=1690793982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpm73t/Fx3pCkHAtgHrzYskc/SByoOkgJguPBGbzJVk=;
        b=A/j7OkdFXPpHn2RcEd5ds2GfhaPXFa5kxPH16Qf6YRneqxthz4EkBaHrc130wDRtpo
         R99kT6XfoyvIMNPKez7l9obH/BAteIOXthE8XQo+s90JCdg90KzMmwVjhpKazVGOKIsC
         XDSOwpVBtqHhkM8DGHiAZxPwum43WLClQ4nUgE0YGtXSTDMSuTZFUbg6NZ4t27b8EOnP
         eWYSiCf/d5sgclP/+TjvXeBCvkprGOfePqEJ9XWpRDSqG0gTOKqPPt9XbCttxjAjerfC
         MjRMHghN9grnSJFmEmXBrjh5K8pjgXcs25p+ADJpVszg2OQStS4SObJK7YyKoc3EvOgr
         TPnw==
X-Gm-Message-State: ABy/qLYn5NlMsUnPqAmaj+rLOiU35RceRnLvPCUcBUdZvAbIbPKel3Nt
        DxeiG/r2BTcVkdNjxAl7fT/1UvhR2aE=
X-Google-Smtp-Source: APBJJlEnCBTVTuZ1BN+bsg27MiJHxKkvvxFOl357GUkcmJMWiMSy5RpKIA//MSbTkGgUMsigsPCfMw==
X-Received: by 2002:a17:906:314f:b0:993:f540:5bb1 with SMTP id e15-20020a170906314f00b00993f5405bb1mr8374665eje.41.1690189181725;
        Mon, 24 Jul 2023 01:59:41 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:11c4:4096:3d09:3950:f280:5ec1])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm6506665ejb.11.2023.07.24.01.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:59:41 -0700 (PDT)
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
Subject: [PATCH v3 5/8] repack: add `--filter=<filter-spec>` option
Date:   Mon, 24 Jul 2023 10:59:06 +0200
Message-ID: <20230724085909.3831831-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.384.ged66511823
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option puts the objects specified by `<filter-spec>` into a
separate packfile.

This could be useful if, for example, some large blobs take up a lot of
precious space on fast storage while they are rarely accessed. It could
make sense to move them into a separate cheaper, though slower, storage.

In other use cases it might make sense to put all the blobs into
separate storage.

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

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-repack.txt | 12 +++++++
 builtin/repack.c             | 67 ++++++++++++++++++++++++++++++++++++
 t/t7700-repack.sh            | 24 +++++++++++++
 3 files changed, 103 insertions(+)

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
index 21e3b89f27..2c81b7738e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -53,6 +53,7 @@ struct pack_objects_args {
 	const char *depth;
 	const char *threads;
 	const char *max_pack_size;
+	const char *filter;
 	int no_reuse_delta;
 	int no_reuse_object;
 	int quiet;
@@ -166,6 +167,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
 		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+	if (args->filter)
+		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
 	if (args->no_reuse_delta)
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
@@ -726,6 +729,57 @@ static int finish_pack_objects_cmd(struct child_process *cmd,
 	return finish_command(cmd);
 }
 
+static int write_filtered_pack(const struct pack_objects_args *args,
+			       const char *destination,
+			       const char *pack_prefix,
+			       struct string_list *names,
+			       struct string_list *existing_packs,
+			       struct string_list *existing_kept_packs)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list_item *item;
+	FILE *in;
+	int ret;
+	const char *scratch;
+	int local = skip_prefix(destination, packdir, &scratch);
+
+	/* We need to copy 'args' to modify it */
+	struct pack_objects_args new_args = *args;
+
+	/* No need to filter again */
+	new_args.filter = NULL;
+
+	prepare_pack_objects(&cmd, &new_args, destination);
+
+	strvec_push(&cmd.args, "--stdin-packs");
+
+	cmd.in = -1;
+
+	ret = start_command(&cmd);
+	if (ret)
+		return ret;
+
+	/*
+	 * names has a confusing double use: it both provides the list
+	 * of just-written new packs, and accepts the name of the
+	 * filtered pack we are writing.
+	 *
+	 * By the time it is read here, it contains only the pack(s)
+	 * that were just written, which is exactly the set of packs we
+	 * want to consider kept.
+	 */
+	in = xfdopen(cmd.in, "w");
+	for_each_string_list_item(item, names)
+		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
+	for_each_string_list_item(item, existing_packs)
+		fprintf(in, "%s.pack\n", item->string);
+	for_each_string_list_item(item, existing_kept_packs)
+		fprintf(in, "^%s.pack\n", item->string);
+	fclose(in);
+
+	return finish_pack_objects_cmd(&cmd, names, local);
+}
+
 static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *destination,
 			    const char *pack_prefix,
@@ -858,6 +912,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
+				N_("object filtering")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -1097,6 +1153,17 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (po_args.filter) {
+		ret = write_filtered_pack(&po_args,
+					  packtmp,
+					  find_pack_prefix(),
+					  &names,
+					  &existing_nonkept_packs,
+					  &existing_kept_packs);
+		if (ret)
+			goto cleanup;
+	}
+
 	string_list_sort(&names);
 
 	close_object_store(the_repository->objects);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 27b66807cd..0a2c73bca7 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -327,6 +327,30 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'repacking with a filter works' '
+	git -C bare.git repack -a -d &&
+	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
+	git -C bare.git -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
+	test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
+	commit_pack=$(test-tool -C bare.git find-pack HEAD) &&
+	test -n "$commit_pack" &&
+	blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
+	test -n "$blob_pack" &&
+	test "$commit_pack" != "$blob_pack" &&
+	tree_pack=$(test-tool -C bare.git find-pack HEAD^{tree}) &&
+	test "$tree_pack" = "$commit_pack" &&
+	blob_pack2=$(test-tool -C bare.git find-pack HEAD:file2) &&
+	test "$blob_pack2" = "$blob_pack"
+'
+
+test_expect_success '--filter fails with --write-bitmap-index' '
+	test_must_fail git -C bare.git repack -a -d --write-bitmap-index \
+		--filter=blob:none &&
+
+	git -C bare.git repack -a -d --no-write-bitmap-index \
+		--filter=blob:none
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.41.0.384.ged66511823

