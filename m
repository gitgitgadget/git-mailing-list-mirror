Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8BA33CC7
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpCvSZzv"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359418E
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:07 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40a5a444c3eso17610415e9.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058846; x=1700663646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdYvPF40PLW9J9JPPdsPaTxSDxkzVO+P/vd76mIXd+o=;
        b=mpCvSZzvsO/fjqs5Vke8nXeu7TNdUIdQ47g3VMeu8c9W4X3crw1G2leRzyFj4dC9qM
         qtZ8MAmaRv3GLOCyW1vfPapaOPdiXkSjfLWd4Itl0q4XBYywXMCUTsAF5maCbdSpVrKA
         LrVhHLTKGkVmGTfT+6+PDBfsCL5j6ShPOAQyJZpqWjENJXnodJ0KXj1ZNg+FcJl78TWw
         vfAi0vbAJd3KEBN3fc9Q39bHsFzF2vYFwRnrdeeoWUqUaJSqH53F6oBeUxV5ZsD/ijun
         PNvrgBcvS8VUvcaicmfMm8VraD0isMt9r1mVrFBsqugXEywjrj8AcNky/0iB1gAOZ2UO
         C2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058846; x=1700663646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdYvPF40PLW9J9JPPdsPaTxSDxkzVO+P/vd76mIXd+o=;
        b=CWAeR+JjekkxlVMaKgoWZY3mGCKx+8Owvhj3iSD+ap6JsUt6KNLDzEVR7xwIwjWWwi
         3T9XAJaQPi1E4oR31+R5KLRGaNg1BqXiEMG1PBtOTwtU33arrDyI0EY+fkDA7zv7XIhI
         zZ69fACV/xOQmlBmwFQmsKWOEttgeAaVH0G0+vamAiNqLBZP18gaNp/fhFoBPypN4dOJ
         OT4O0yNRLmOCWuHWp0gU5V9+mwIIAcVq1giahrsMN415yrUy+TSgj2JORTJaI5UDkC3i
         IKMYEZMgejgYYtZZal2sd6TKfu3s4dx6hl4ScrUYu2DdfvULt/iB7//lJ6/rKfifOnDi
         jNYQ==
X-Gm-Message-State: AOJu0YzXafAItaw1w5r+kdh9D3d+sIfLXmzROrpeLzqQ55b8Yf8d1i/a
	TGTvYttaaixXPmtBh6miSZ385RbHVLM=
X-Google-Smtp-Source: AGHT+IHkDpTGDyIlHzqcraJgBy33nL/DY39TnTkUKonucceE+4o2vElpbRoIdwuXpSnYuqjIER8qew==
X-Received: by 2002:a05:600c:511d:b0:403:272:4414 with SMTP id o29-20020a05600c511d00b0040302724414mr11930992wms.0.1700058845804;
        Wed, 15 Nov 2023 06:34:05 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:34:05 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 14/14] replay: stop assuming replayed branches do not diverge
Date: Wed, 15 Nov 2023 15:33:27 +0100
Message-ID: <20231115143327.2441397-15-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index e14e33bcc5..f37e511d8e 100644
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
@@ -362,21 +376,30 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
@@ -405,13 +428,14 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
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
2.43.0.rc1.15.g29556bcc86

