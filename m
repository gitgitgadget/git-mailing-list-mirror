Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13B5F20281
	for <e@80x24.org>; Sun,  5 Nov 2017 20:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbdKEU1A (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 15:27:00 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:49574 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdKEU04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 15:26:56 -0500
Received: by mail-wr0-f195.google.com with SMTP id g90so6770809wrd.6
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 12:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPZHyKjlqiLhhj6IvG/mpp/FqGjUC0zkFK6dJ6RCFHY=;
        b=uRt6h2PhmJr0zwzNXRemMEnuZ6V8p5swLBfOYkbNv1H1MtqYEIK8ssdJ848inBjru4
         PyDOO6T2PP0gR80RVaD4xTxpmDqtt/GiOuwiQssM3phnx253zt+KMp8R8cPUV+KV6BYy
         oxdRptQXk0NoDeOlt1IY1TFKYXosyQqG7Ho92/8iu1S5DsHXhjKaIZHEZriXWxohJqS9
         Q8RD5AwyqwsUA74i/gQNY2HVE+D8Mb7FVc3dB44eNov1KSQ2FssuY7BXqYaXVLnQuZCW
         xGOmP6djQHurywwjrFdoOEM/dLdv484JyUjUO33XGEppYS0W1e6fUSS5Ki5Q8VIgzdOn
         1HmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPZHyKjlqiLhhj6IvG/mpp/FqGjUC0zkFK6dJ6RCFHY=;
        b=e8GtE+FWNq647OfyhVior8V29eWcSuPagEp5l3C7cankK+IF/4w4CLPSJZJmdJUHGQ
         jLzYNb42uXfaBN1v0p+r4BNrS89OZmyfdkeLW7W4Mqp5ieDhKwaAjiDEOnLkK7egaIr0
         B5nD3Cnu8X7fHqkpeyvr1vVHhaPljreFW2h/YRL2+3oKK4a2jaauttvcOonkO8C8e09f
         Euh5+RWVfokTVYq/faMivXBzSBXjoOsI69E5AMi14Pv87CV6w7RxOnTLlm66Y6seZAEn
         7GIjPIw6dnh2IHodHZXUt7CIIVV9ogUOBetUH2dAw299mq129yY4n0SZOmIecpii84A4
         eosg==
X-Gm-Message-State: AMCzsaUMWMaYKuknwJ7WkROuIqylg0aW3t03LRTvtlJIu/i2XE26HJHw
        3Eclbczfyha4fzrp7WC1V/oKzD6J
X-Google-Smtp-Source: ABhQp+TApQ5N/a+iI82T5IDKL4lXRwp7bDsL4hQO4lifhThwK6YdqsDoBYk9GkaSAjvNoec6el9kXg==
X-Received: by 10.223.152.149 with SMTP id w21mr10890195wrb.274.1509913615156;
        Sun, 05 Nov 2017 12:26:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u138sm11573033wmd.17.2017.11.05.12.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 12:26:54 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] reduce_heads: fix memory leaks
Date:   Sun,  5 Nov 2017 21:26:31 +0100
Message-Id: <e67b7c112b4b7b59e75e0b67e78c0f7f7ea06d84.1509908607.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <cover.1509908607.git.martin.agren@gmail.com>
References: <CAN0heSpgUBy4a6iok4MoDqJ__hZtrXvfApcxjHuS0vOBKSuShg@mail.gmail.com> <cover.1509908607.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have seven callers of `reduce_heads(foo)`. Six of them do
not use the original list `foo` again, and actually, all six of those
end up leaking it.

Introduce and use `reduce_heads_replace(&foo)` as a leak-free version of
`foo = reduce_heads(foo)` to fix several of these. Fix the remaining
leaks using `free_commit_list()`.

While we're here, document `reduce_heads()` and mark it as `extern`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 commit.h                | 18 +++++++++++++++++-
 builtin/commit.c        |  2 +-
 builtin/fmt-merge-msg.c |  2 +-
 builtin/merge-base.c    |  6 ++++--
 builtin/merge.c         |  1 +
 builtin/pull.c          |  5 ++++-
 commit.c                |  7 +++++++
 7 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/commit.h b/commit.h
index 6d769590f..99a3fea68 100644
--- a/commit.h
+++ b/commit.h
@@ -313,7 +313,23 @@ extern int interactive_add(int argc, const char **argv, const char *prefix, int
 extern int run_add_interactive(const char *revision, const char *patch_mode,
 			       const struct pathspec *pathspec);
 
-struct commit_list *reduce_heads(struct commit_list *heads);
+/*
+ * Takes a list of commits and returns a new list where those
+ * have been removed that can be reached from other commits in
+ * the list. It is useful for, e.g., reducing the commits
+ * randomly thrown at the git-merge command and removing
+ * redundant commits that the user shouldn't have given to it.
+ *
+ * This function destroys the STALE bit of the commit objects'
+ * flags.
+ */
+extern struct commit_list *reduce_heads(struct commit_list *heads);
+
+/*
+ * Like `reduce_heads()`, except it replaces the list. Use this
+ * instead of `foo = reduce_heads(foo);` to avoid memory leaks.
+ */
+extern void reduce_heads_replace(struct commit_list **heads);
 
 struct commit_extra_header {
 	struct commit_extra_header *next;
diff --git a/builtin/commit.c b/builtin/commit.c
index d75b3805e..11c474018 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1728,7 +1728,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 				allow_fast_forward = 0;
 		}
 		if (allow_fast_forward)
-			parents = reduce_heads(parents);
+			reduce_heads_replace(&parents);
 	} else {
 		if (!reflog_msg)
 			reflog_msg = (whence == FROM_CHERRY_PICK)
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e99b5ddbf..27a2361e9 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -571,7 +571,7 @@ static void find_merge_parents(struct merge_parents *result,
 	head_commit = lookup_commit(head);
 	if (head_commit)
 		commit_list_insert(head_commit, &parents);
-	parents = reduce_heads(parents);
+	reduce_heads_replace(&parents);
 
 	while (parents) {
 		struct commit *cmit = pop_commit(&parents);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index fd0eba14b..0178ca772 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -57,7 +57,7 @@ static int handle_independent(int count, const char **args)
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	revs = reduce_heads(revs);
+	reduce_heads_replace(&revs);
 
 	if (!revs)
 		return 1;
@@ -78,7 +78,9 @@ static int handle_octopus(int count, const char **args, int show_all)
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	result = reduce_heads(get_octopus_merge_bases(revs));
+	result = get_octopus_merge_bases(revs);
+	free_commit_list(revs);
+	reduce_heads_replace(&result);
 
 	if (!result)
 		return 1;
diff --git a/builtin/merge.c b/builtin/merge.c
index ab5ffe85e..fbbf2a9e5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -999,6 +999,7 @@ static struct commit_list *reduce_parents(struct commit *head_commit,
 
 	/* Find what parents to record by checking independent ones. */
 	parents = reduce_heads(remoteheads);
+	free_commit_list(remoteheads);
 
 	remoteheads = NULL;
 	remotes = &remoteheads;
diff --git a/builtin/pull.c b/builtin/pull.c
index 6f772e8a2..4edab228e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -745,12 +745,15 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 	if (!is_null_oid(fork_point))
 		commit_list_insert(lookup_commit_reference(fork_point), &revs);
 
-	result = reduce_heads(get_octopus_merge_bases(revs));
+	result = get_octopus_merge_bases(revs);
 	free_commit_list(revs);
+	reduce_heads_replace(&result);
+
 	if (!result)
 		return 1;
 
 	oidcpy(merge_base, &result->item->object.oid);
+	free_commit_list(result);
 	return 0;
 }
 
diff --git a/commit.c b/commit.c
index 1e0e63379..cab8d4455 100644
--- a/commit.c
+++ b/commit.c
@@ -1090,6 +1090,13 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+void reduce_heads_replace(struct commit_list **heads)
+{
+	struct commit_list *result = reduce_heads(*heads);
+	free_commit_list(*heads);
+	*heads = result;
+}
+
 static const char gpg_sig_header[] = "gpgsig";
 static const int gpg_sig_header_len = sizeof(gpg_sig_header) - 1;
 
-- 
2.15.0.415.gac1375d7e

