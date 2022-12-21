Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0EAC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiLUEF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiLUEFK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:05:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D4E13F79
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:05:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z10so3188282wrh.10
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJyirdsxnImNtJstD+riPG7ko/oyU+3fQZOjE+zAGSE=;
        b=DC75VJ0iqY9frDQkBRoYaKvhw7GGytATqgJGWfCqleP3rvwXTtY35/061rRljE9KCW
         dySJIxSqxuuoZkdZqkOgzK8Znayakopu5en7mG6GB3QsOIIS/1pq0XZ2Z+qwaxaLNz3e
         GtBJvGTwW63sAj5w+MQfPIDlRzIQyIQkk/WC21VlTc7vBe89V5j/LOboiZy35VWt0GVh
         OzjwvxycUXQv+voqPl1sdrpJVdvb7i1k0yn32khRPF3R0Emh+v3ITzQ1IrafH/RFJdBY
         DHtxQMyKwlirNwqd74YjKp3XXeZVjsnLcQemBIUrLzqNCnXtSuUselUrWIDwpAtU6DmJ
         28BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJyirdsxnImNtJstD+riPG7ko/oyU+3fQZOjE+zAGSE=;
        b=i8ZR7h8MWQx+w7/rElIjxUEkCM/ysvgl/bi2d27lXlYRMJIQwzwkoFks2/IjUrQbkA
         XCZOJkHyaYQDqN+YgqhiINQRJ/ja7YvOEP0lBOGJ2Dw7UF+BD3N4KPpnaAx42iQ+RnfM
         V1Lkp3OmpbLQyAqRxPhJJjcexcnKFY12ljKrwZDG4HeP9ZqDnfBnEYbat1gy/YQr93D8
         Rz6BrqOU6++twraY2LNTqNO77uLtEWwsfNTbIc/Sut8TimceZSWFYycZggwYtIokIrnf
         8HDkWxACd2o7BYh/6vGXmwGFfqNBLmhPs4c2NvU+VJA/WAjSFBYEFzu9d8eykYE9YvoE
         qFZw==
X-Gm-Message-State: AFqh2kq0f2HlpwQcDzGLVp1DdvwxtkWpCBdy4BK157uiIq0pVBKDrZDL
        /nJeLViJmUnNuZYxHVPEN4tYo896d5s=
X-Google-Smtp-Source: AMrXdXvYco5cBz7ypYaAGxFZnHWdmnD4WoXUG+pTnHC5yLbF4UbqDLncRlrSPIoqNTW51l+3YfTPqg==
X-Received: by 2002:a5d:4acb:0:b0:242:844a:70a5 with SMTP id y11-20020a5d4acb000000b00242844a70a5mr43500wrs.35.1671595507501;
        Tue, 20 Dec 2022 20:05:07 -0800 (PST)
Received: from Precision-5550.. ([2a04:cec0:1195:e411:35ab:b445:697e:1e87])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d4e09000000b00236c1f2cecesm16462298wrt.81.2022.12.20.20.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:05:06 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/3] repack: add --filter=<filter-spec> option
Date:   Wed, 21 Dec 2022 05:04:45 +0100
Message-Id: <20221221040446.2860985-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.39.0.59.g6bb98b4b00
In-Reply-To: <20221221040446.2860985-1-christian.couder@gmail.com>
References: <20221122175150.366828-1-christian.couder@gmail.com>
 <20221221040446.2860985-1-christian.couder@gmail.com>
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
index c1402ad038..8e5ac9c171 100644
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
 	strbuf_release(&line);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 4aabe98139..3a6ad9f623 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -253,6 +253,21 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
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
+	test $(grep -c "^?" objects) = 0 &&
+	git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	test $(grep -c "^?" objects) = 1
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.39.0.59.g395bcb85bc.dirty

