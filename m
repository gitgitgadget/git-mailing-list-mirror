Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E44FEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGEGI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGEGIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:08:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BD10C3
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:08:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso5154590e87.0
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537318; x=1691129318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rxke6fCOdCy2XjLu7dBwvEluN1rgbayU02IXErc9ffM=;
        b=r0edIGKb7SeeRAyVKQdYFd4D4axUNigoPtLCVXKV6g+kEQHxFryehpbNYexVb5pn3O
         Qwc8YIYoUR1lEso5Bn2Z6LLa/5BLUBrH5ER4aZkp4zk9x/9IjRAlGItUXDk2WsV9mAhU
         LM3i+KpKsARPQBoZKBUkE2dUJ+Sp3MRfM/e9Z9ojEESNHqSXuw1SpFZStFPDvcRv3DPN
         0K8zneHa7vna8OpW9uXg9ER3umdnidmAVAUz4CF0VZXFsF2EEzl6PxynZmeEm9WNByQV
         qYbwznKVkA4jU83CihEzmBYG6ZIra7OzNkw/vz2Anl10DtAeQPqDVC8neX5Jdyl4Znpl
         VjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537318; x=1691129318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rxke6fCOdCy2XjLu7dBwvEluN1rgbayU02IXErc9ffM=;
        b=SyhnuycwfuTmLpi3t3mvw5SWCgLmDTZxngUZhupHtDFZhseRMSXDw/eSeJ48w3bD35
         1GtGsrZq2vIsgbxsv1n+ix9sRnVQcEWs/8sukmU2wThJqDKd0u2RfrTqLfZgxBhGCukj
         Z4Z/XYOBmHH94b48eowkDiKFTSsYRYEXU05KaOw3nt6hoGDCcrgiQgGJ6rSWl7uFHfQk
         //R/aF2h1p9ADH+CRA15we38bLIx9lOMhrhKb/Wg4W5HVeIdGaXxssQ+WYaQU61+Pe3y
         hzafqAsc44vx/5Fvduv06Ckwzmgem8EvJN050zUg+DJReHvFlh3kegxBo4JMWik6VJ/w
         BdMw==
X-Gm-Message-State: ABy/qLYkrrQgLz0KWT+I80Rhod/jyP7CaMhtjg+S+jZLfEOtDU6J6ZJ1
        l9EMtysKdBQaE6L4B0XePiqyMaxMZ6s=
X-Google-Smtp-Source: APBJJlErVFAgfa63Y4QwI4gCEux0NBjpV9tFomfAqyrvttdcmkLp2nfCDpI1bSGjYOmaBURzri749A==
X-Received: by 2002:a05:6512:3490:b0:4fb:9da2:6cec with SMTP id v16-20020a056512349000b004fb9da26cecmr9872734lfr.7.1688537317467;
        Tue, 04 Jul 2023 23:08:37 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:f6a2:3135:7895:378b])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm1087762wmi.23.2023.07.04.23.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:08:36 -0700 (PDT)
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
Subject: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
Date:   Wed,  5 Jul 2023 08:08:09 +0200
Message-ID: <20230705060812.2865188-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.244.g8cb3faa74c
In-Reply-To: <20230705060812.2865188-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option puts the objects specified by `<filter-spec>` into a
separate packfile.

This could be useful if, for example, some large blobs take a lot of
precious space on fast storage while they are rarely accessed. It could
make sense to move them into a separate cheaper, though slower, storage.

In other use cases it might make sense to put all the blobs into
separate storage.

This is done by running two `git pack-objects` commands. The first one
is run with `--filter=<filter-spec>`, using the specified filter. It
packs objects while omitting the objects specified by the filter.
Then another `git pack-objects` command is launched using
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
 Documentation/git-repack.txt |  9 +++++
 builtin/repack.c             | 67 ++++++++++++++++++++++++++++++++++++
 t/t7700-repack.sh            | 16 +++++++++
 3 files changed, 92 insertions(+)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4017157949..d702553033 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -143,6 +143,15 @@ depth is 4095.
 	a larger and slower repository; see the discussion in
 	`pack.packSizeLimit`.
 
+--filter=<filter-spec>::
+	Remove objects matching the filter specification from the
+	resulting packfile and put them into a separate packfile. Note
+	that objects used in the working directory are not filtered
+	out. So for the split to fully work, it's best to perform it
+	in a bare repo and to use the `-a` and `-d` options along with
+	this option.  See linkgit:git-rev-list[1] for valid
+	`<filter-spec>` forms.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index 4e5afee8d8..e2661b956c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -54,6 +54,7 @@ struct pack_objects_args {
 	const char *depth;
 	const char *threads;
 	const char *max_pack_size;
+	const char *filter;
 	int no_reuse_delta;
 	int no_reuse_object;
 	int quiet;
@@ -174,6 +175,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
 		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+	if (args->filter)
+		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
 	if (args->no_reuse_delta)
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
@@ -734,6 +737,57 @@ static int finish_pack_objects_cmd(struct child_process *cmd,
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
@@ -866,6 +920,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
+				N_("object filtering")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -1105,6 +1161,17 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
index af79266c58..66589e4217 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -293,6 +293,22 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
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
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.41.0.244.g8cb3faa74c

