Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25402C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJLNwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJLNwR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:52:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77FB61B11
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:52:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1286741wmb.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53spqZpDiPruAYD3KZryzlHvG7q1FXbKidPR7awV7jE=;
        b=lkFlRgs3q89NdN0GHvSjfy7lijjtpeV6EptSVjeBpKjzetX0356g0xkCfPWcdOQyz4
         RrcISoGRhEzN/pOiymNfLnnsSjLTzRdNqthjPZ8a0/IBYBDyLFPG75C8aH0F1Ip/Mka6
         d/ugRm5TkoB4iawYbU0keP2I5yZ53Luek7d6ROIma9sdhBlWyWDsqg8Gdp1wwNdlUBtk
         FFTWp7lytFAdsKPrrSnuVZzpNrqP9dTxT2eZZ5qirhmG44p88Zdf93N9d9ETtzNiX3X1
         jBL//7Gcv8wl8LRJIWLmWH7OY2ru6qI2ICxm93uwMdJaXShgH/L4kkRwXAuCfuDVl2Cx
         zxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53spqZpDiPruAYD3KZryzlHvG7q1FXbKidPR7awV7jE=;
        b=YOrJTfz0BIdm5E7UaMNQqaJ6H/4SML70v2UfD03NoU2slrHUo1wt3rxiqKK88bykX2
         ScU2Bi05ldWj5PBcbW4DDi2n6zIjFfXlO+m5F77PGRvTtpimeVE0f3e9ql7vHKQteaPj
         8Px6fDtcoYs/L4ujiJni4LGr4uouefHha1u2riyXROTReMyfuTMlKBT9MBTNgP1a3HWV
         f0nLcHs959fasuXPwhioJ0rVlHgSt790uHpJnV+AViN7NVgO1JBedCQPMmz7YswcDwXE
         avr7qOT0lSEnk/Xuhjq2iQEgsOjMCCuOJOWSAqvxy+CYuSiK814MGlKF9qQndXrQSARo
         j8vg==
X-Gm-Message-State: ACrzQf2KYqhTp358pSfRp+9+EZrloMAXsKb280QT7c8+fVkP7BHUupU6
        bUUrINV7WzefG0N/X7X598Jgcq4hCls=
X-Google-Smtp-Source: AMsMyM7fd1qBqp6CQjI7u2zIe42btcRTiaduMJRb9v33gn6HA8Cb5RrMaLfJt3lIO9vBcgIJhbtzEA==
X-Received: by 2002:a05:600c:3585:b0:3b4:a308:1581 with SMTP id p5-20020a05600c358500b003b4a3081581mr2937319wmq.77.1665582733910;
        Wed, 12 Oct 2022 06:52:13 -0700 (PDT)
Received: from Precision-5550.. ([2a01:e0a:595:6400::ae22:851d])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000180500b0022f40a2d06esm11396284wrh.35.2022.10.12.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:52:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] repack: add --filter=<filter-spec> option
Date:   Wed, 12 Oct 2022 15:51:13 +0200
Message-Id: <20221012135114.294680-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.0.4.g7f9724c7bf.dirty
In-Reply-To: <20221012135114.294680-1-christian.couder@gmail.com>
References: <20221012135114.294680-1-christian.couder@gmail.com>
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
corrupt the repo. On a server this command could also corrupt a
repo unless ALL the removed objects aren't already available in
another remote that clients can access.

To avoid as much as possible data to be lost and repos to be
corrupted, let's warn users and ask them to confirm that they
really want to use this command.

If no terminal is used, let's just die() for now. A follow-up
commit will introduce a --force option that will allow using
this option when no terminal is available.

It will be easier to test that --filter is working correctly
in the follow-up commit that adds --force, so let's just test
that we die() if no terminal is used for now.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-repack.txt |  7 ++++++
 builtin/repack.c             | 41 ++++++++++++++++++++++++++++++------
 t/t7700-repack.sh            |  5 +++++
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0bf13893d8..230f176e10 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -137,6 +137,13 @@ depth is 4095.
 	a larger and slower repository; see the discussion in
 	`pack.packSizeLimit`.
 
+--filter=<filter-spec>::
+	Omits certain objects (usually blobs) from the resulting
+	packfile. WARNING: this could easily corrupt the current repo
+	and lose data if ANY of the omitted objects hasn't been
+	already pushed to a remote. See linkgit:git-rev-list[1] for
+	valid `<filter-spec>` forms.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index a5bacc7797..0a93f38da4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -17,6 +17,7 @@
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "refs.h"
+#include "prompt.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -50,6 +51,7 @@ struct pack_objects_args {
 	const char *depth;
 	const char *threads;
 	const char *max_pack_size;
+	const char *filter;
 	int no_reuse_delta;
 	int no_reuse_object;
 	int quiet;
@@ -201,6 +203,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
 		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+	if (args->filter)
+		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
 	if (args->no_reuse_delta)
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
@@ -268,6 +272,13 @@ static unsigned populate_pack_exts(char *name)
 	return ret;
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
@@ -299,7 +310,6 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		struct string_list_item *item;
-		char *promisor_name;
 
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
@@ -316,13 +326,8 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		 * concatenate the contents of all .promisor files instead of
 		 * just creating a new empty file.
 		 */
-		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
-					  line.buf);
-		write_promisor_file(promisor_name, NULL, 0);
-
+		write_promisor_file_1(line.buf);
 		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
-
-		free(promisor_name);
 	}
 	fclose(out);
 	if (finish_command(&cmd))
@@ -786,6 +791,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
+				N_("object filtering")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -818,6 +825,24 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-k");
 	}
 
+	if (po_args.filter) {
+		const char *yesno;
+
+		if (!isatty(STDIN_FILENO))
+			die (_("Repacking with a filter is not allowed "
+			       "yet unless a terminal is used!"));
+
+		/*
+		 * TRANSLATORS: Make sure to include [y] and [N] in your translation.
+		 * The program will only accept English input at this point.
+		 */
+		yesno = git_prompt(_("Repacking with a filter will lose data and corrupt the repo\n"
+				     "if ANY of the filtered out object hasn't been already pushed!\n"
+				     "Repack with a filter anyway [y/N]? "), PROMPT_ECHO);
+		if (tolower(*yesno) != 'y')
+			exit(1);
+	}
+
 	if (write_bitmaps < 0) {
 		if (!write_midx &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
@@ -955,6 +980,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
 		string_list_append(&names, line.buf);
+		if (po_args.filter)
+			write_promisor_file_1(line.buf);
 	}
 	fclose(out);
 	ret = finish_command(&cmd);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index ca45c4cd2c..f8764d1dd9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -237,6 +237,11 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'repacking with a filter is not allowed' '
+	test_must_fail git repack -a -d --filter=blob:none 2>actual &&
+	test_i18ngrep "Repacking with a filter is not allowed" actual
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.38.0.4.g7f9724c7bf.dirty

