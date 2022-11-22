Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B86C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiKVRzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiKVRyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:54:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8927E01
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:52:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ha10so1195243ejb.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLgYBs3NWgPdVoVu2i5We0ZYFDx96ydJ3C06IhvtWz4=;
        b=jirS1lG6UqGGEDoWh9NdRp1OZkvBdETbJAVigqaXteXank/qRoHiidCDv3TlxMTRaZ
         uiwIcmnqMCTzeMJgWixW0U5I7amXBXf2BxBjjESkTyl1VReGHmXooULLCtPHRvuGUdCt
         hJXgT2h7kZye0ASLJ6Hl/aKZWykAMce6bDdVvRC/+zyIQJjjhOJyDqD2SL+KetN97sUp
         pEC1HODmxpOKi3RnHAATzN3tzXxisKyxCSRO1halFuTROKmazY94DBWNrcKb+H3ovXHO
         MnDpjB9qDZ6iy0KnBIs+h04JzKSyEBG5RXfhL3pjnqPzIO5VVMSgpfnLlO3WEUWTvNlt
         /U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLgYBs3NWgPdVoVu2i5We0ZYFDx96ydJ3C06IhvtWz4=;
        b=4dN6EzChBCKAGcc47StpmvxiI/NNyE9Wk0nOFgRgn86MDcnDWASQsbbwktIyPVDUaF
         7HB/NB1xuggy/zsMKjvk1VS2Ayi9c7uinapMatxQB/RqNxgVYk5Pdxykc/48QsgVKFX8
         5gozLJI8MsnJ0sbRA5sOg87LZjry34hTyRhmujjj7ry06NTm1rmMcTMUVD+VA5zYjxcj
         rOyS9bx1cxtMpBwZBLo76AzAdiyZloSsQOlaOZlZ7lyGv9vgNAfqGVsHUvpwu1aNLrRw
         5OBMTxM72zf0GAGQ6cdC4/nAP+gfhA4nvQhF1j8Vz8YJAEKofpfH/70xJDYZ6Fh1y4Am
         rPJw==
X-Gm-Message-State: ANoB5pmn5UNi/L8xyh5NFnj3KGVQMmPBdZbvLleA1z2uWUcSk19mcnqX
        Uko+NvVMdWkBGBAQr/dkGkAirrQVpZQ=
X-Google-Smtp-Source: AA0mqf5vao6B+jX2ruMfGHGXPKB8wqLIIL4uis+/tLveKg7ohsdZEbp7eVX4AIinvMHypSq025CfHg==
X-Received: by 2002:a17:906:4c92:b0:78d:ad29:396f with SMTP id q18-20020a1709064c9200b0078dad29396fmr20710633eju.165.1669139559332;
        Tue, 22 Nov 2022 09:52:39 -0800 (PST)
Received: from Precision-5550.. ([2a04:cec0:1182:5ffb:b420:3bec:4f4c:e712])
        by smtp.gmail.com with ESMTPSA id i10-20020aa7c9ca000000b00461a6997c5dsm6618204edt.83.2022.11.22.09.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 09:52:38 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/2] repack: add --filter=<filter-spec> option
Date:   Tue, 22 Nov 2022 18:51:50 +0100
Message-Id: <20221122175150.366828-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.1.475.g7216a7bc05
In-Reply-To: <20221122175150.366828-1-christian.couder@gmail.com>
References: <20221025122856.20204-1-christian.couder@gmail.com>
 <20221122175150.366828-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <chriscool@tuxfamily.org>

After cloning with --filter=<filter-spec>, for example to avoid
getting unneeded large files on a user machine, it's possible
that some of these large files still get fetched for some reasons
(like checking out old branches) over time.

In this case the repo size could grow too much for no good reason
and `git repack --filter=<filter-spec>` would be useful to remove
the unneeded large files.

This command could be dangerous to use though, as it might remove
local objects that haven't been pushed which would lose data and
corrupt the repo. On a server, this command could also corrupt a
repo unless ALL the removed objects aren't already available in
another remote that clients can access.

To mitigate that risk, we check that a promisor remote has at
least been configured.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-repack.txt |  8 ++++++++
 builtin/repack.c             | 28 +++++++++++++++++++++-------
 t/t7700-repack.sh            | 15 +++++++++++++++
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4017157949..2539ee0a02 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -143,6 +143,14 @@ depth is 4095.
 	a larger and slower repository; see the discussion in
 	`pack.packSizeLimit`.
 
+--filter=<filter-spec>::
+	Omits certain objects (usually blobs) from the resulting
+	packfile. WARNING: this could easily corrupt the current repo
+	and lose data if ANY of the omitted objects hasn't been already
+	pushed to a remote. Be very careful about objects that might
+	have been created locally! See linkgit:git-rev-list[1] for valid
+	`<filter-spec>` forms.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index 65eb1b8bd2..3586d97f3f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -49,6 +49,7 @@ struct pack_objects_args {
 	const char *depth;
 	const char *threads;
 	const char *max_pack_size;
+	const char *filter;
 	int no_reuse_delta;
 	int no_reuse_object;
 	int quiet;
@@ -163,6 +164,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
 		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+	if (args->filter)
+		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
 	if (args->no_reuse_delta)
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
@@ -234,6 +237,13 @@ static struct generated_pack_data *populate_pack_exts(const char *name)
 	return data;
 }
 
+static void write_promisor_file_1(char *p)
+{
+	char *promisor_name = mkpathdup("%s-%s.promisor", packtmp, p);
+	write_promisor_file(promisor_name, NULL, 0);
+	free(promisor_name);
+}
+
 static void repack_promisor_objects(const struct pack_objects_args *args,
 				    struct string_list *names)
 {
@@ -265,7 +275,6 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		struct string_list_item *item;
-		char *promisor_name;
 
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
@@ -282,13 +291,8 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		 * concatenate the contents of all .promisor files instead of
 		 * just creating a new empty file.
 		 */
-		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
-					  line.buf);
-		write_promisor_file(promisor_name, NULL, 0);
-
+		write_promisor_file_1(line.buf);
 		item->util = populate_pack_exts(item->string);
-
-		free(promisor_name);
 	}
 	fclose(out);
 	if (finish_command(&cmd))
@@ -800,6 +804,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
+				N_("object filtering")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -834,6 +840,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-k");
 	}
 
+	if (po_args.filter && !has_promisor_remote())
+		die("a promisor remote must be setup\n"
+		    "Also please push all the objects "
+		    "that might be filtered to that remote!\n"
+		    "Otherwise they will be lost!");
+
 	if (write_bitmaps < 0) {
 		if (!write_midx &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
@@ -971,6 +983,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
 		item = string_list_append(&names, line.buf);
+		if (po_args.filter)
+			write_promisor_file_1(line.buf);
 		item->util = populate_pack_exts(item->string);
 	}
 	fclose(out);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index c630e0d52d..fef144bace 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -237,6 +237,21 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'repacking with a filter works' '
+	test_when_finished "rm -rf server client" &&
+	test_create_repo server &&
+	git -C server config uploadpack.allowFilter true &&
+	git -C server config uploadpack.allowAnySHA1InWant true &&
+	test_commit -C server 1 &&
+	git clone --bare --no-local server client &&
+	git -C client config remote.origin.promisor true &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	test $(grep "^?" objects | wc -l) = 0 &&
+	git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	test $(grep "^?" objects | wc -l) = 1
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.38.1.475.g7216a7bc05

