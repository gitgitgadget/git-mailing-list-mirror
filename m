Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005A6C07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F2D613B6
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhGEMfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhGEMfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B8C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:34 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso6383150otq.13
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aT/aKVr0A+qx3cbs8aVxtNJBCLEI2a9eKTwOZx+Nn9Y=;
        b=ijLkFKAnjFYhElFvdPzMkYYKehITgK96fnGdngbS+PQgEpJeAa4+aA3S9RqugtXEC+
         BgwkSLFEVZcYuf2uOn3GYJKsqUzw0eN8JotoBRGq0zjQsDvFM+p4eO6/tDcA10Ehx/o3
         WWo5s2AFq2pKMHM44htLN7a0IePoeH7mURNOi5EaWde7lP3BHhZfoGE4g7cbchVAOf/n
         i5PeKS8/8d3ByxMzV2IhMTQaUyDDTZc+G/kzSN0oWWpLviMcuZrQXvrH4zK4rMYPUrbV
         QxNEOIQhZYm1Qb65t5K/md1od+0pPEglJzhmLbKX5jKwLsd4XyiR+ggdfV+8HxuRPI1F
         sZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aT/aKVr0A+qx3cbs8aVxtNJBCLEI2a9eKTwOZx+Nn9Y=;
        b=TOgW+n5gq0CGbmUp2wLH2gkFt5XeCPKEzMsTXwHQ3NrKLNTpOP40P4b/2qt8Im+Wot
         uMYetEvGS/sa0+1xC4oRoJhkKa/Wc5cCgUKZ7ISWRePPA33t+vSVBRRk5gn9Lo21baLi
         sl5laseBNqyYckrSG4uSS/TANltoWK98CKGO1TxYud9w/unZ3R+1h4NpMtIKricL9OBK
         FdC69d5RjcpKlDwyhvEBVAx1/6kMIgfOe6w4whvEOfc8vmnHWBK6NAEnbzefYk5fCS6X
         fg1Nn/aSyYeqKrgCLNIFTzenFyHw6xxxrJMhScGP/2BYWDvCFoLksiN6XtV+oHROTQfb
         +4Vw==
X-Gm-Message-State: AOAM5321finzZoCjHRoZF5zae2F37TSt0LTc+UtEr/I4rU/1of+QhoIh
        1yfU7VISTsgKwZMhKCCJiZByOH9hyQk0Xw==
X-Google-Smtp-Source: ABdhPJx5EfR/x/fLUnxQnKqQSIaonr1P3j2h30p7FiFSB5QLXlrWM32nPsYOcLe0sScVwnbf6btVVg==
X-Received: by 2002:a05:6830:18da:: with SMTP id v26mr10273299ote.144.1625488353789;
        Mon, 05 Jul 2021 05:32:33 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l10sm2571331oti.9.2021.07.05.05.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 13/35] merge: add --reverse-parents option
Date:   Mon,  5 Jul 2021 07:31:47 -0500
Message-Id: <20210705123209.1808663-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would be useful to make `git update` reverse parents as desired.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/merge-options.txt |  4 ++++
 builtin/commit.c                |  5 +++++
 builtin/merge.c                 | 11 ++++++++++-
 t/t7600-merge.sh                | 26 ++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396..8917ed97b2 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -149,6 +149,10 @@ ifndef::git-pull[]
 	Note that not all merge strategies may support progress
 	reporting.
 
+--reverse-parents::
+--no-reverse-parents::
+	Reverse the order of parents in the merge commit.
+
 endif::git-pull[]
 
 --autostash::
diff --git a/builtin/commit.c b/builtin/commit.c
index f9dd155566..931738eeaf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1724,6 +1724,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		FILE *fp;
 		int allow_fast_forward = 1;
 		struct commit_list **pptr = &parents;
+		int reverse_parents = 0;
 
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
@@ -1744,9 +1745,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 				die_errno(_("could not read MERGE_MODE"));
 			if (strstr(sb.buf, "no-ff"))
 				allow_fast_forward = 0;
+			if (strstr(sb.buf, "reverse"))
+				reverse_parents = 1;
 		}
 		if (allow_fast_forward)
 			reduce_heads_replace(&parents);
+		if (reverse_parents)
+			parents = reverse_commit_list(parents);
 	} else {
 		if (!reflog_msg)
 			reflog_msg = is_from_cherry_pick(whence)
diff --git a/builtin/merge.c b/builtin/merge.c
index 1836f98f82..b9c6c43d8f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -91,6 +91,7 @@ static int signoff;
 static const char *sign_commit;
 static int autostash;
 static int no_verify;
+static int reverse_parents;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -306,6 +307,8 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add a Signed-off-by trailer")),
 	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
+	OPT_BOOL(0, "reverse-parents", &reverse_parents,
+		N_("reverse the order of parents")),
 	OPT_END()
 };
 
@@ -913,6 +916,8 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	pptr = commit_list_append(head, pptr);
 	pptr = commit_list_append(remoteheads->item, pptr);
 	prepare_to_commit(remoteheads);
+	if (reverse_parents)
+		parents = reverse_commit_list(parents);
 	if (commit_tree(merge_msg.buf, merge_msg.len, &result_tree, parents,
 			&result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
@@ -937,6 +942,8 @@ static int finish_automerge(struct commit *head,
 	parents = remoteheads;
 	if (!head_subsumed || fast_forward == FF_NO)
 		commit_list_insert(head, &parents);
+	if (reverse_parents)
+		parents = reverse_commit_list(parents);
 	prepare_to_commit(remoteheads);
 	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
 			&result_commit, NULL, sign_commit))
@@ -1049,7 +1056,9 @@ static void write_merge_heads(struct commit_list *remoteheads)
 
 	strbuf_reset(&buf);
 	if (fast_forward == FF_NO)
-		strbuf_addstr(&buf, "no-ff");
+		strbuf_addstr(&buf, "no-ff ");
+	if (reverse_parents)
+		strbuf_addstr(&buf, "reverse ");
 	write_file_buf(git_path_merge_mode(the_repository), buf.buf, buf.len);
 	strbuf_release(&buf);
 }
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 10f8956665..660d13dd51 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -563,6 +563,16 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'merge c0 with c1 (--reverse-parents)' '
+	git reset --hard c0 &&
+	test_tick &&
+	git merge --no-ff --reverse-parents c1 &&
+	verify_merge file result.1 &&
+	verify_parents $c1 $c0
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
 test_expect_success 'merge c0 with c1 (merge.ff=false)' '
 	git reset --hard c0 &&
 	test_config merge.ff "false" &&
@@ -940,6 +950,22 @@ test_expect_success 'merge annotated/signed tag w/ tracking' '
 	)
 '
 
+test_expect_success 'merge --reverse-parents --no-commit && commit' '
+	git reset --hard c0 &&
+	git merge --no-ff --reverse-parents --no-commit c1 &&
+	EDITOR=: git commit &&
+	verify_parents $c1 $c0
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
+test_expect_success 'amending reverse merge commit' '
+	EDITOR=: git commit --amend &&
+	verify_parents $c1 $c0
+'
+
+test_debug 'git log --graph --decorate --oneline --all'
+
 test_expect_success GPG 'merge --ff-only tag' '
 	git reset --hard c0 &&
 	git commit --allow-empty -m "A newer commit" &&
-- 
2.32.0.36.g70aac2b1aa

