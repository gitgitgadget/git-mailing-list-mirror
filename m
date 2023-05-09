Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C89C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 17:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjEIRzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjEIRyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 13:54:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271235251
        for <git@vger.kernel.org>; Tue,  9 May 2023 10:54:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-306dbad5182so3988355f8f.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683654869; x=1686246869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV1zsvnwe94PShKyVPQs+cWCtjxGB87QW7yoaH/jiSI=;
        b=Pb8NppPN5Fuyn0UnZkBs4ty6f1OFROjyPhorc8nt4rnEfdt5DqKGuj3iRlWoxcksa9
         1L5BGBuZCoBvQYSHN5WXKdD/GhjhV9HJ3GEVTLnI/T2dUqs1xaNDko7VwUmbm4+HmCW2
         v3fAdAih+1RodbGdwDf+ydje9v2g3zQeAc3fwvLNUzw1jmAjWIZgEjy/fFlu2tZjFiVW
         VrqhIfZkyw8PkUxUzZsCD/brtmUv4UA61SDgcUa7Sp6LF+cWZy039jsBK3FvMnNj43I6
         CcAwawFrHBIRJSEeSCPuQRvMPPFTojT97dzWEgPO770WS5qRruKdqbP7sL0ng2VKMAc5
         SAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654869; x=1686246869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV1zsvnwe94PShKyVPQs+cWCtjxGB87QW7yoaH/jiSI=;
        b=iuHXaDpcXSBmuOF5/mtTiuRChBao91FMBcG87tgwzyQFTIYWbSrkvNo50FEt9wMkSh
         lZJUO32c3DqAGPaBwRozGM9S5jVbdd3i1gymfE2B6DLY9ZbT9NxuAK+YTmaMH/k3ysO4
         3zrGUVPFPipoT6AB5kCvmakGQSrUHopWILjrSyIZJCKEOHsIEH4cG7M6BGYLjFYhHV3B
         p7nCPvjDWsuc57XphPo6apZOay2STQ2V6FrtI7W8nFnTZ3fXtB20yQ3H876FWrSYtnP6
         mgEcWja3NKc+p1SOveu5d1jvXaWGuihJuqHJYWCzuNwX9Mjsjc4iVPjJIOmKoA3JTp88
         z3AA==
X-Gm-Message-State: AC+VfDyEEjRvKK3p4pYOJdR9AWf7ZY/lqkOCX2sEVtIkgK7SAbQGs/Sn
        vR1ihlp3UppgOu7/U2pZrnIqVEXlJRs=
X-Google-Smtp-Source: ACHHUZ5Lv67ePd5pBuJe66rUx9kSUReH6ELNhYVV2l2GT9HZ1yNHx5xx42iRl3tkdEaymPBeHdmNkg==
X-Received: by 2002:a5d:4d4f:0:b0:306:3da7:f33c with SMTP id a15-20020a5d4d4f000000b003063da7f33cmr8913161wru.63.1683654868758;
        Tue, 09 May 2023 10:54:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:df87:46e2:83de:c1fa])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f42314832fsm8584435wml.18.2023.05.09.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:54:27 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 15/15] replay: stop assuming replayed branches do not diverge
Date:   Tue,  9 May 2023 19:53:47 +0200
Message-ID: <20230509175347.1714141-16-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.1.491.gbdd8a3b3e1
In-Reply-To: <20230509175347.1714141-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230509175347.1714141-1-christian.couder@gmail.com>
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
index 4d24eb95d8..7699d28f93 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -221,20 +221,33 @@ static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
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
 
+	result->tree = repo_get_commit_tree(the_repository, replayed_base);
 	pickme_tree = repo_get_commit_tree(the_repository, pickme);
 	base_tree = repo_get_commit_tree(the_repository, base);
 
-	merge_opt->branch1 = short_commit_name(last_commit);
+	merge_opt->branch1 = short_commit_name(replayed_base);
 	merge_opt->branch2 = short_commit_name(pickme);
 	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
 
@@ -248,7 +261,7 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 	merge_opt->ancestor = NULL;
 	if (!result->clean)
 		return NULL;
-	return create_commit(result->tree, pickme, last_commit);
+	return create_commit(result->tree, pickme, replayed_base);
 }
 
 int cmd_replay(int argc, const char **argv, const char *prefix)
@@ -264,6 +277,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct merge_options merge_opt;
 	struct merge_result result;
 	struct strset *update_refs = NULL;
+	kh_oid_map_t *replayed_commits;
 	int ret = 0, i;
 
 	const char * const replay_usage[] = {
@@ -347,21 +361,30 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
-
-	result.tree = repo_get_commit_tree(the_repository, onto);
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
 		if (!last_commit)
 			break;
 
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
@@ -391,13 +414,14 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
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
index 3fb4167e69..5aafad448f 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -151,4 +151,56 @@ test_expect_success 'using replay on bare repo to also rebase a contained branch
 	test_cmp expect result-bare
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
+test_expect_success 'using replay on bare repo to rebase multiple divergent branches, including contained ones' '
+	git -C bare replay --contained --onto main ^main topic2 topic3 topic4 >result &&
+
+	test_line_count = 4 result &&
+	cut -f 3 -d " " result >new-branch-tips &&
+
+	>expect &&
+	for i in 2 1 3 4
+	do
+		printf "update refs/heads/topic$i " >>expect &&
+		printf "%s " $(grep topic$i result | cut -f 3 -d " ") >>expect &&
+		git -C bare rev-parse topic$i >>expect || return 1
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
+		git -C bare log --format=%s $(grep topic$i result | cut -f 3 -d " ") >actual &&
+		test_cmp expect$i actual || return 1
+	done
+'
+
 test_done
-- 
2.40.1.491.gdff9a222ea

