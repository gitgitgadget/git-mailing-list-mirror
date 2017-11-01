Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE1E020281
	for <e@80x24.org>; Wed,  1 Nov 2017 09:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbdKAJDu (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 05:03:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:50095 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdKAJDr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 05:03:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id g90so1343355wrd.6
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJwWaI2OHXMFcnET2e8VPFBwGFHxAa2ISU5ZkkKoAtE=;
        b=nWgQxumt9DJOvDP6pFUHxU3ExC+kcrX6HrFb0aZxMFwugTB79TfmPZq5f7tEwzM8D5
         PH5Rg3mA5OAv/umvyI99Tj9XBiq+lNqXo2hihF0lXoa5nuRhichLwcIwK19Ev0d7antF
         n91ihTsBdkbmuyRKwvPUNTLgniZzYQxCwFyLM8WQXAskOFavsUPNU9oReqFsChipOvDK
         6eo1GOGhUTIAeZWQ2MHs0t53g6wcAJSVHKrVMEajm4sSn4UCoUocIe8cx1wgp6eVxVED
         I3AmRDLFvi8UiuMGediKOFUJPJ3HQtjBPOvXRV7m74RkgirCYju3mUix2jouXGLQy8IN
         FCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJwWaI2OHXMFcnET2e8VPFBwGFHxAa2ISU5ZkkKoAtE=;
        b=CMj8h/ZAnbb87kY+H1VzCV8ej2UitExnsk4fRUOFHdVf6zo0RktdhJufRcHAYPBnkA
         U98ayQce/VY0mxb228Et4A+oFACpDK2IDr8ySN/Qm+8hzD8VqUSNcV1M9bGJA/ziITBM
         4MZ9ehUcwIY3uPe1f29fc6v8lgVMwMmNP71HD+gZNhwH5dlCrglW2efo3mPblizr+JKI
         XvwY1/GC34dJCG4vP9kUxQm6T0hPVUInIrcU3CB9FXsxMuJvufHljPOXmzn1FFtilvrY
         +ClzNZz0XPXORXwBu2CIPM1zBUQHbJFTE8uHDYHJ2Nhrm+8CPO+++KzKeZ73MdQXP1DQ
         TQSA==
X-Gm-Message-State: AMCzsaX/QyG6WEuuyRi8dkF22D/ZvdSFe9eBTscC65euhFUEnq/qTSAH
        gaIX3ypR0s1IPy30w4WYkKr9JbC2
X-Google-Smtp-Source: ABhQp+RHF1GUd+zMLLb6pNqnx9HVfoBFI3N5U9E/XpNjtNBwt11fzUBG0JtOiIHtDwRhaEEcJf24Aw==
X-Received: by 10.223.176.176 with SMTP id i45mr4554308wra.240.1509527025659;
        Wed, 01 Nov 2017 02:03:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id e6sm329478wrg.53.2017.11.01.02.03.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 02:03:44 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] reduce_heads: fix memory leaks
Date:   Wed,  1 Nov 2017 10:03:26 +0100
Message-Id: <20171101090326.8091-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
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
 builtin/commit.c        |  2 +-
 builtin/fmt-merge-msg.c |  2 +-
 builtin/merge-base.c    |  6 +++++-
 builtin/merge.c         |  1 +
 builtin/pull.c          |  4 +++-
 commit.c                |  7 +++++++
 commit.h                | 18 +++++++++++++++++-
 7 files changed, 35 insertions(+), 5 deletions(-)

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
index 6dbd167d3..b1b7590c4 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -59,6 +59,8 @@ static int handle_independent(int count, const char **args)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
 	result = reduce_heads(revs);
+	free_commit_list(revs);
+
 	if (!result)
 		return 1;
 
@@ -78,7 +80,9 @@ static int handle_octopus(int count, const char **args, int show_all)
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
index 6f772e8a2..5eeaa8c68 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -745,8 +745,10 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 	if (!is_null_oid(fork_point))
 		commit_list_insert(lookup_commit_reference(fork_point), &revs);
 
-	result = reduce_heads(get_octopus_merge_bases(revs));
+	result = get_octopus_merge_bases(revs);
 	free_commit_list(revs);
+	reduce_heads_replace(&result);
+
 	if (!result)
 		return 1;
 
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
-- 
2.15.0.415.gac1375d7e

