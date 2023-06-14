Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18270EB64DB
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbjFNT0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbjFNT00 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20739268B
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so9249885e87.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770769; x=1689362769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHEbVw2TSqNSDCP7yXujcu/a0AJGha6JRAsdW72fgFc=;
        b=Z5Y7+1xHsncxYcV6iC6bW4A+vj19FWlikGQLUUE7AXfz61iUNkH6FkOqRfkouQABe3
         kSI5pQv0/A5Q4G98Ee1Jqwem0hgYmWcGpWiZsuvkg2aIXEcTzU13ZGRyBj2hI/7xjuay
         mEdhMA2HeQup/JtuhQjC4NmJJQDwO2BRK3aMi7e6ZL+2GZcaCSI+9St2eDxJ0eCgCY9T
         VQfTUdLmN6PJovTD/Hx05ysnpfhU0ll57teanPUldDAHIZ08wW+MmpFzO2BnUxfLI09c
         sJVRgQu9ROVCPoZGYEx3/lmA9wjzCFZqUS5YXA0i2SrRw9432Odci5eU0NONz5H3AdGY
         iJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770769; x=1689362769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHEbVw2TSqNSDCP7yXujcu/a0AJGha6JRAsdW72fgFc=;
        b=L9T1dbsVLFN6ofQ+IKA9lXbGQUl2XFlOS+qkbt8j57vPHC1dTPwEni3kGV8l2Inf4d
         uQIh+c3/ppcucOg7vkb+kHbYBlLrd3FSYHBwp2VuMdvxFiwGFlVgWzIbGKl3YliMNZoe
         frzzwigzDQVXcc3AlzQUCMMNNXHu8UKiyStAtek0+DoF4cCaQn/gcKkiDLBbSqO6bQXL
         q6KntcVj2F0sfwCuP9gpGEH9EqqH5H66Gb+3B3sltsah95EUyunm1/00nfS9mYGPNgXT
         mvgwQCMKG3lGFNoxF9caXGQhmlCX8Pz0xGK9+4KT/cka5EqJ6hqzyX6JsjL4JxJmOiqt
         xGSg==
X-Gm-Message-State: AC+VfDzttKiqRMpajXOuEfF7GZdMOl8ctcJB5WFPqC8d65WwCgYJwo8Q
        vpJO+pS3krq0yw8Ho1N2HwAucfSVwtY=
X-Google-Smtp-Source: ACHHUZ6vcvA+Biqp0HRLsvn56OMmqbc3mLyx+X/J41zjglmw8zvsYrVH8fQXCqip7s/X3W08UBdCag==
X-Received: by 2002:a19:e00b:0:b0:4f6:4c47:d5fe with SMTP id x11-20020a19e00b000000b004f64c47d5femr8318101lfg.14.1686770768634;
        Wed, 14 Jun 2023 12:26:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:26:07 -0700 (PDT)
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
Subject: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
Date:   Wed, 14 Jun 2023 21:25:38 +0200
Message-ID: <20230614192541.1599256-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After cloning with --filter=<filter-spec>, for example to avoid
getting unneeded large files on a user machine, it's possible
that some of these large files still get fetched for some reasons
(like checking out old branches) over time.

In this case the repo size could grow too much for no good reason and a
way to filter out some objects would be useful to remove the unneeded
large files.

Deleting objects right away could corrupt a repo though, so it might be
better to put those objects into a separate packfile instead of
deleting them. The separate pack could then be removed after checking
that all the objects in it are still available on a promisor remote it
can access.

Also splitting a packfile into 2 packs depending on a filter could be
useful in other usecases. For example some large blobs might take a lot
of precious space on fast storage while they are rarely accessed, and
it could make sense to move them in a separate cheaper, though slower,
storage.

This commit implements a new `--filter=<filter-spec>` option in
`git repack` that moves filtered out objects into a separate pack.

This is done by reading filtered out objects from `git pack-objects`'s
output and piping them into a separate `git pack-objects` process that
will put them into a separate packfile.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-repack.txt |  5 +++
 builtin/repack.c             | 75 ++++++++++++++++++++++++++++++++++--
 t/t7700-repack.sh            | 16 ++++++++
 3 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4017157949..aa29c7e648 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -143,6 +143,11 @@ depth is 4095.
 	a larger and slower repository; see the discussion in
 	`pack.packSizeLimit`.
 
+--filter=<filter-spec>::
+	Remove objects matching the filter specification from the
+	resulting packfile and put them into a separate packfile. See
+	linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index f1adacf1d0..b13d7196de 100644
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
@@ -167,6 +168,10 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
 		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+	if (args->filter) {
+		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
+		strvec_pushf(&cmd->args, "--print-filtered");
+	}
 	if (args->no_reuse_delta)
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
@@ -703,13 +708,21 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static void pack_filtered(const char *oid_hex, struct child_process *cmd)
+{
+	write_oid_hex_cmd(oid_hex, cmd,
+			  _("could not start pack-objects to pack filtered objects"));
+}
+
 static int finish_pack_objects_cmd(struct child_process *cmd,
 				   struct string_list *names,
-				   const char *destination)
+				   const char *destination,
+				   struct child_process *pack_filtered_cmd)
 {
 	int local = 1;
 	FILE *out;
 	struct strbuf line = STRBUF_INIT;
+	int filtered_start = 0;
 
 	if (destination) {
 		const char *scratch;
@@ -720,9 +733,20 @@ static int finish_pack_objects_cmd(struct child_process *cmd,
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		struct string_list_item *item;
 
+		if (!filtered_start && pack_filtered_cmd && !strcmp(line.buf, "------")) {
+			filtered_start = 1;
+			continue;
+		}
+
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only "
 			      "from pack-objects."));
+
+		if (pack_filtered_cmd && filtered_start) {
+			pack_filtered(line.buf, pack_filtered_cmd);
+			continue;
+		}
+
 		/*
 		 * Avoid putting packs written outside of the repository in the
 		 * list of names.
@@ -791,9 +815,44 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 		fprintf(in, "%s.pack\n", item->string);
 	fclose(in);
 
-	return finish_pack_objects_cmd(&cmd, names, destination);
+	return finish_pack_objects_cmd(&cmd, names, destination, NULL);
 }
 
+/*
+ * Prepare the command that will pack objects that have been filtered
+ * out from the original pack, so that they will end up in a separate
+ * pack.
+ */
+static void prepare_pack_filtered_cmd(struct child_process *cmd,
+				      const struct pack_objects_args *args,
+				      const char *destination)
+{
+	/* We need to copy args to modify it */
+	struct pack_objects_args new_args = *args;
+
+	/* No need to filter again */
+	new_args.filter = NULL;
+
+	prepare_pack_objects(cmd, &new_args, destination);
+	cmd->in = -1;
+}
+
+static void finish_pack_filtered_cmd(struct child_process *cmd,
+				     struct string_list *names)
+{
+	if (cmd->in == -1) {
+		/* No packed objects; cmd was never started */
+		child_process_clear(cmd);
+		return;
+	}
+
+	close(cmd->in);
+
+	if (finish_pack_objects_cmd(cmd, names, NULL, NULL))
+		die(_("could not finish pack-objects to pack filtered objects"));
+}
+
+
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -817,6 +876,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
+	struct child_process pack_filtered_cmd = CHILD_PROCESS_INIT;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -858,6 +918,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
+				N_("object filtering")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -1011,6 +1073,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--incremental");
 	}
 
+	if (po_args.filter)
+		prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, packtmp);
+
 	if (geometry)
 		cmd.in = -1;
 	else
@@ -1034,7 +1099,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		fclose(in);
 	}
 
-	ret = finish_pack_objects_cmd(&cmd, &names, NULL);
+	ret = finish_pack_objects_cmd(&cmd, &names, NULL,
+				      po_args.filter ? &pack_filtered_cmd : NULL);
 	if (ret)
 		goto cleanup;
 
@@ -1102,6 +1168,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (po_args.filter)
+		finish_pack_filtered_cmd(&pack_filtered_cmd, &names);
+
 	string_list_sort(&names);
 
 	close_object_store(the_repository->objects);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index faa739eeb9..9e7654090f 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -270,6 +270,22 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
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
2.41.0.37.gae45d9845e

