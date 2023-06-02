Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA5C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjFBKbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjFBK3a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:29:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D7F194
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:27:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6ef9a928fso17849865e9.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 03:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701574; x=1688293574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajPa/7hZEf7DJsyM+tg3YsLxH55ulGSSY2NvYdm6oV4=;
        b=KdqNKCKwf2k/wlClR4LDe70r5hW966jm+9qmjEgug4m9sj2p8YOZumgfGLE3a5YolW
         dyZz8Fso3LwXsAf0msfDMVDacCLy6RNHnqBb2oQDA3JVO5GnzMxUuo3W7o3VnWtex1CV
         qnuRtzt5CdHmPIEWbaGeHh5ZyT3NmRd32rlpimMHFv1FXgyoT8tTIvkfekEzedSfz7gT
         jm+PZ5+aIyrneEAQ5tjou2dLOJ/fnkwxirX8kW6BLSWOX4WaHUOPxygZaf4ME9U9Vss5
         8vS38EzDL04zcML6Prus3dtSd6ss3A3YFAB5PUgAdNFbKwGj97NaHurCIl9aprm+sKHN
         g43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701574; x=1688293574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajPa/7hZEf7DJsyM+tg3YsLxH55ulGSSY2NvYdm6oV4=;
        b=lQadLWsbsdZArUE61irkSdJdgZsNiYdfNdSLUvQjzXoOgpVq53I3nv+G/bUld4dLpu
         cBqo6z+nWFvKnUslJEZOc1e3pLNzZiae8fS9qWei1Hl/qAQGueMV6axQILpi3u5I8A0A
         XBA/OzxUJ4rdCL7lUU3IqbHyJwIYcJ5wOVVCT6JFrzqBAv8rFkM6LLAvPQ5ok3WeffHd
         ylTAzMvb2ReCssfMDpz4BxQfhgammWd9WhYaqf3nrRLy/NVZo/tiXoA57xEDPtHFO7y9
         GqSGEa394o1juIXpTjt+RSZGBe/9RGCwBC/8EJuIPuP3DoLS7QgxzijLOzg4fq6hpfAZ
         eJMQ==
X-Gm-Message-State: AC+VfDxKbaJ0e5fyttJXD9pYe4jMdBPtH4+ORTRX5GhZhmN1vyqKQbow
        dI1kCcsTHjIcrMI/Q3NlFP7HK7exlZXs2w==
X-Google-Smtp-Source: ACHHUZ6KXw3Nlfvu9G5hmz/h7AiJWeirF4TUgDrtYxISRc6E9fQrI2QZ8GbN2A0UQxWXEpctDRf4pg==
X-Received: by 2002:a7b:c412:0:b0:3f1:74bd:bc22 with SMTP id k18-20020a7bc412000000b003f174bdbc22mr1532186wmi.6.1685701573976;
        Fri, 02 Jun 2023 03:26:13 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1169:70dc:520b:5de9:c23d:7cde])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c029200b003f601a31ca2sm1468035wmk.33.2023.06.02.03.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:26:13 -0700 (PDT)
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
Subject: [PATCH v3 15/15] replay: stop assuming replayed branches do not diverge
Date:   Fri,  2 Jun 2023 12:25:33 +0200
Message-ID: <20230602102533.876905-16-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.15.ga6d88fc8f0
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com>
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
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
commit in a key value store, so that we can easily find and reuse a
replayed commit instead of the original one.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c         | 44 ++++++++++++++++++++++++++--------
 t/t3650-replay-basics.sh | 52 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 9b182eaa90..a06649fa6e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -223,20 +223,33 @@ static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
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
 
@@ -250,7 +263,7 @@ static struct commit *pick_regular_commit(struct commit *pickme,
 	merge_opt->ancestor = NULL;
 	if (!result->clean)
 		return NULL;
-	return create_commit(result->tree, pickme, last_commit);
+	return create_commit(result->tree, pickme, replayed_base);
 }
 
 int cmd_replay(int argc, const char **argv, const char *prefix)
@@ -266,6 +279,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct merge_options merge_opt;
 	struct merge_result result;
 	struct strset *update_refs = NULL;
+	kh_oid_map_t *replayed_commits;
 	int ret = 0, i;
 
 	const char * const replay_usage[] = {
@@ -348,21 +362,30 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -392,13 +415,14 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
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
2.41.0.15.ga6d88fc8f0

