Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FEDCD80C0
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjJJMjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjJJMj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3BB0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40666aa674fso52899755e9.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941564; x=1697546364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG9uFhIZYBAT1cYlYWjhUFiG33889dMAk/xw90vmX04=;
        b=PAC43qNUkNIxG5azNSGjuyztw7N/VQSmHkrZzt9WlAN7nuop9dBrLPVl0MzMUOqKwi
         eAATmtAOYPsL3r4OSxzZo6O6saXaPFkq5tTkvB4Y9HyXfajbzNmfTJJDY7Y8UTKLnh1g
         67vtF0M1oXab7CZHMKfBCZjO++Y+lAcdnZyrMVTRNDZ3HtUELWd8J7VE6X1YXRFvN+EL
         bU+vGdtLabLrFxVs5M5MlA36TKoO+rdLihVcUKDCrKsZ9herITNbpp2QtF/wmGFxQ3To
         Xr+/FMpslgh/YRK1M6CpzdL5wwiIWvUhUH5HZTcGpFjIXYOQEXFfvL9hHrv08X2koZR7
         NZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941564; x=1697546364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG9uFhIZYBAT1cYlYWjhUFiG33889dMAk/xw90vmX04=;
        b=mHXEZqYwNZ9mgKMrkRM7nXunhkqSw/avlgzVDTwhJBXipnVPt/Qt3/KQ2vtfe6KXrk
         ozP19QaaJFZTATx/ZhLuA9x5UTjLhtM3xKYcazENJDQdDOlidxoPtsH/pdSqreKGXa0l
         V9uNbosgg+zMWJ2oaiSqoIgkd7EoMOWfd6VapNRZOiTpdrA0Lu75B7hrWQWttqi3dtQQ
         PX0Uy74Ovvl2cuYeOyX6VOPCWgVhZOkL+O2RD9E8friW4vE0oq0bTRbZ/YKqN+Sb+biZ
         FGtfJci593PS594H8DAjZzx1HmKSxQLA+lFwUh/YBZRGSir3di75+f2H5I+olvEi5ris
         b6MA==
X-Gm-Message-State: AOJu0Yxse88+2O3Beoh+c7kxFDqeXOzL1oXMf+qzD8qCbDt6VTv8dL9f
        Zerdbn65R8k6ks0jEhEtTBlD+Ka1i1426Q==
X-Google-Smtp-Source: AGHT+IGQQIFHXmePHRPv65VykYu2TvmMfY3yDxNCocx6kCSXjZJEpwzPhMT4ImmUBQZKPysLLvfTRQ==
X-Received: by 2002:a7b:c8c8:0:b0:404:7462:1f6f with SMTP id f8-20020a7bc8c8000000b0040474621f6fmr15581631wml.8.1696941564223;
        Tue, 10 Oct 2023 05:39:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 14/14] replay: stop assuming replayed branches do not diverge
Date:   Tue, 10 Oct 2023 14:38:47 +0200
Message-ID: <20231010123847.2777056-15-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com>
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
index 12689f1c89..f74261b75e 100644
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
 	int ret = 0;
 
 	const char * const replay_usage[] = {
@@ -324,21 +338,30 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -367,13 +390,14 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	}
 
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
index d6286f9580..389670262e 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -143,4 +143,56 @@ test_expect_success 'using replay on bare repo to also rebase a contained branch
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
2.42.0.339.g663cbc8ab1

