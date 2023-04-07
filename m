Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08884C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbjDGHZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbjDGHZU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A427A5FB
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:25:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l12so41583623wrm.10
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9gQ2z7BlbZD5MQRDAhyZ+Q1fAvPiUX4YUmtuhbuWHQ=;
        b=HmD6nP2hihx9nDDnLopVZNBeLAPgSuJ+0PXBFout82tAaQ1lhzW4ok0FxCDaK/vi/i
         R/VZDtPkDDV3ypRVakXUhOfTq3nq4EagQq1o7bDj1EG/CkqpA45I3Ydpan4bENym7VqO
         deaLLSt4fgW3mOnZLu6Vt+P+uov1yFdf/KPbed50MXcij4Zti9hf7os2ML6EFt4Iya8h
         6wMx01E7NVNJ2SEp0FdpszwUPMMzuRGdrJ+a3lPMkru6nPpYXzPqfip9ZetkU6AlnbX3
         hflCTvVxOZ0mpx4ZE5yj6tPhgYXD3rkdW5AKu5C1xhBrflbQo2s6ed05Ft346YIeGofZ
         UJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9gQ2z7BlbZD5MQRDAhyZ+Q1fAvPiUX4YUmtuhbuWHQ=;
        b=yvHVSFweC96WufYsF7pmr3EYK2xI3TxM/uMks+xIKVbZtCkR2ue/4+ErKWUjZMKHUB
         2kioWgHSEuWjNAItUaa1kqu1a/Odws7g/o1P99ocCrl3z/w9jWqVY32xhYiQOJtSGEJ8
         01GraXIgCvbBalJMO8m2rQ7IZtj9VLobWSJpoc8U38vTiAN/ckw4o8J/wGliLWiAZdYY
         A0ORlUOOFeGNqUsUPZflVKSatVNTFFaOQfIQ0XzRRIKcOqspNHew/A68KRVQtdDE/PZj
         WEibWt6vLte4QtvkX7ceTCr3kiuQU/yU+XUT2nJOxO9e7dmDgFOpD/q58lHRuAVJnyWN
         c0Ag==
X-Gm-Message-State: AAQBX9d0iMmmKDQXnbtLCQGyl070K5D4SE6X4vdS0QXlON1dcsFt8svC
        CmlZPpE4+AzU8Hb2jJh/vdLURfENEtVbgA==
X-Google-Smtp-Source: AKy350YdV499oHPgwWaxyGJaKlgtC0dSQOKTkxvOtVXwJVjyZT/auqnxidd1B0yQXcxC3loAyRj/Cw==
X-Received: by 2002:adf:e846:0:b0:2c7:efb:dded with SMTP id d6-20020adfe846000000b002c70efbddedmr637745wrn.24.1680852292986;
        Fri, 07 Apr 2023 00:24:52 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 14/14] replay: stop assuming replayed branches do not diverge
Date:   Fri,  7 Apr 2023 09:24:15 +0200
Message-Id: <20230407072415.1360068-15-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The replay command is able to replay multiple branches but when some of
them are based on other replayed branches, their commit should be
replayed onto already replayed commits.

For this purpose, let's store the replayed commit and its original
commit in a key value store, so that we can easily find and reused a
replayed commit instead of the original one.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c         | 44 ++++++++++++++++++++++++++--------
 t/t3650-replay-basics.sh | 52 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 63b3ad518e..71815d5ca3 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -216,20 +216,33 @@ static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
 	strset_clear(&rinfo.positive_refs);
 }
 
+static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
+				    struct commit *commit,
+				    struct commit *fallback)
+{
+	khint_t pos = kh_get_oid_map(replayed_commits, commit->object.oid);
+	if (pos == kh_end(replayed_commits))
+		return fallback;
+	return kh_value(replayed_commits, pos);
+}
+
 static struct commit *pick_regular_commit(struct commit *pickme,
-					  struct commit *last_commit,
+					  kh_oid_map_t *replayed_commits,
+					  struct commit *onto,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result)
 {
-	struct commit *base;
+	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree;
 
 	base = pickme->parents->item;
+	replayed_base = mapped_commit(replayed_commits, base, onto);
 
+	result->tree = get_commit_tree(replayed_base);
 	pickme_tree = get_commit_tree(pickme);
 	base_tree = get_commit_tree(base);
 
-	merge_opt->branch1 = short_commit_name(last_commit);
+	merge_opt->branch1 = short_commit_name(replayed_base);
 	merge_opt->branch2 = short_commit_name(pickme);
 	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
 
@@ -243,7 +256,7 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 	merge_opt->ancestor = NULL;
 	if (!result->clean)
 		return NULL;
-	return create_commit(result->tree, pickme, last_commit);
+	return create_commit(result->tree, pickme, replayed_base);
 }
 
 int cmd_replay(int argc, const char **argv, const char *prefix)
@@ -259,6 +272,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct merge_options merge_opt;
 	struct merge_result result;
 	struct strset *update_refs = NULL;
+	kh_oid_map_t *replayed_commits;
 	int ret = 0;
 
 	const char * const replay_usage[] = {
@@ -312,18 +326,20 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
-
-	result.tree = get_commit_tree(onto);
 	last_commit = onto;
+	replayed_commits = kh_init_oid_map();
 	while ((commit = get_revision(&revs))) {
 		const struct name_decoration *decoration;
+		khint_t pos;
+		int hr;
 
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		last_commit = pick_regular_commit(commit, last_commit, &merge_opt, &result);
+		last_commit = pick_regular_commit(commit, replayed_commits, onto,
+						  &merge_opt, &result);
 
 		if (!last_commit) {
 			/* TODO: handle conflicts in sparse worktree instead */
@@ -350,6 +366,13 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&commit->object.oid));
 		}
 
+		/* Record commit -> last_commit mapping */
+		pos = kh_put_oid_map(replayed_commits, commit->object.oid, &hr);
+		if (hr == 0)
+			BUG("Duplicate rewritten commit: %s\n",
+			    oid_to_hex(&commit->object.oid));
+		kh_value(replayed_commits, pos) = last_commit;
+
 		/* Update any necessary branches */
 		if (advance_name)
 			continue;
@@ -379,13 +402,14 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	/* Cleanup */
 	merge_finalize(&merge_opt, &result);
-	ret = result.clean;
-
-cleanup:
+	kh_destroy_oid_map(replayed_commits);
 	if (update_refs) {
 		strset_clear(update_refs);
 		free(update_refs);
 	}
+	ret = result.clean;
+
+cleanup:
 	release_revisions(&revs);
 
 	/* Return */
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 976032ad18..b13bb7502c 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -105,4 +105,56 @@ test_expect_success 'using replay to also rebase a contained branch' '
 	test_cmp expect result
 '
 
+test_expect_success 'using replay to rebase multiple divergent branches' '
+	git replay --onto main ^topic1 topic2 topic4 >result &&
+
+	test_line_count = 2 result &&
+	cut -f 3 -d " " result >new-branch-tips &&
+
+	git log --format=%s $(head -n 1 new-branch-tips) >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual &&
+
+	git log --format=%s $(tail -n 1 new-branch-tips) >actual &&
+	test_write_lines J I M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic2 " >expect &&
+	printf "%s " $(head -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic2 >>expect &&
+	printf "update refs/heads/topic4 " >>expect &&
+	printf "%s " $(tail -n 1 new-branch-tips) >>expect &&
+	git rev-parse topic4 >>expect &&
+
+	test_cmp expect result
+'
+
+test_expect_success 'using replay to rebase multiple divergent branches, including contained ones' '
+	git replay --contained --onto main ^main topic2 topic3 topic4 >result &&
+
+	test_line_count = 4 result &&
+	cut -f 3 -d " " result >new-branch-tips &&
+
+	>expect &&
+	for i in 2 1 3 4
+	do
+		printf "update refs/heads/topic$i " >>expect &&
+		printf "%s " $(grep topic$i result | cut -f 3 -d " ") >>expect &&
+		git rev-parse topic$i >>expect || return 1
+	done &&
+
+	test_cmp expect result &&
+
+	test_write_lines F C M L B A >expect1 &&
+	test_write_lines E D C M L B A >expect2 &&
+	test_write_lines H G F C M L B A >expect3 &&
+	test_write_lines J I M L B A >expect4 &&
+
+	for i in 1 2 3 4
+	do
+		git log --format=%s $(grep topic$i result | cut -f 3 -d " ") >actual &&
+		test_cmp expect$i actual || return 1
+	done
+'
+
 test_done
-- 
2.40.0.228.gb2eb5bb98e

