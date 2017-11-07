Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB37A20A36
	for <e@80x24.org>; Tue,  7 Nov 2017 20:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933407AbdKGUj7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 15:39:59 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:53081 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933304AbdKGUjz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 15:39:55 -0500
Received: by mail-wr0-f195.google.com with SMTP id j23so431370wra.9
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrMtJp97rmB+//7UM/ElbhjRmM4VhzLXF1+YlPuIoXc=;
        b=UmvRPQqurEhLJuLhW+W1shnuUf/388ExIg2vbJ0cxm4kcljpZUwB/nmQIH8OkUOzNt
         8eI5ItorObFkm3XHcaI5xTTOR35EKM39QnX4Uuv75Ccf43URTOSU2AMN+duBMxngW46i
         qTQrLSyEn9GVQH0Y0gekC9ql0ym2eymKKAuqHckEy8eJfsiJJk7Reqt0J3sm8ttFJUiZ
         MZ7hyktUjsURuG1/81mHLH2yNLTJbOKf0CfFDBClI4plUqKIbNfQ3I9ZjPQYDmwGkQmw
         eY5VpiAMfRR9VUvldSkEmA1737gCC3SAlQdwRtuUbbdKWzP/KFOSl94d2WHZ/NPlTJre
         haSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrMtJp97rmB+//7UM/ElbhjRmM4VhzLXF1+YlPuIoXc=;
        b=WA2m77B/7jMSjAxBKzRiZEUQyqbmvRuSIk81rcnfsu/oRz3JDyZ5DCCMNGCEg6yq61
         owxwmxzvz9onRbamqVxxKKNydMpFipmBlNvZk65PLxGKx2XwR0KKibqsimawCsnCqJ6A
         9CRGE6R5XGpxOk/T0TYjm2cpBfBhXydUbMQymebeINEdtRvTHj5oP09CwmtuGRSZNwDP
         G8VA7T6DkSZUKK6B4aYOmnbkG74TXZXLbROY39yUSlS9Xzc+ijvkrP5y4AcVR99Hwnay
         SmjYaWF+pPuyby0RXxJklAJfikd9RGVrBH1qLOfFgmVEPasZzxX9mKy+XBn90/VPWwsH
         A5AQ==
X-Gm-Message-State: AJaThX4OTyMzzIwHjCcBI0JU5E2JfQwB3rt/zZCrolXw5XrM0Ef5kqzo
        U3dqPSG1RoXkbx1sqDDKHV6eE3sM
X-Google-Smtp-Source: ABhQp+TnLim4Zn0WksEOgy8uVkHRLm6eoxqKO2QUrU9jIGNg1EAkXY1TcelHUmMx1aImc/vAwWIpEQ==
X-Received: by 10.223.185.33 with SMTP id k30mr21863wrf.40.1510087193723;
        Tue, 07 Nov 2017 12:39:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id r123sm1088584wmf.41.2017.11.07.12.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Nov 2017 12:39:52 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/2] reduce_heads: fix memory leaks
Date:   Tue,  7 Nov 2017 21:39:45 +0100
Message-Id: <05f0d03b2cf54e3f8e742d8cc5dc36bfd35e4d70.1510083860.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <20171106110549.dkv725bjikcms3aj@sigill.intra.peff.net>
References: <20171106110549.dkv725bjikcms3aj@sigill.intra.peff.net>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v3: Like v2 but rebased onto maint.

 commit.h                | 18 +++++++++++++++++-
 builtin/commit.c        |  2 +-
 builtin/fmt-merge-msg.c |  2 +-
 builtin/merge-base.c    |  6 ++++--
 builtin/merge.c         |  1 +
 builtin/pull.c          |  5 ++++-
 commit.c                |  7 +++++++
 7 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/commit.h b/commit.h
index f3805fec6b..cfa2636e33 100644
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
index 1a0da71a43..73c4ec2b08 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1719,7 +1719,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 				allow_fast_forward = 0;
 		}
 		if (allow_fast_forward)
-			parents = reduce_heads(parents);
+			reduce_heads_replace(&parents);
 	} else {
 		if (!reflog_msg)
 			reflog_msg = (whence == FROM_CHERRY_PICK)
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e99b5ddbf9..27a2361e91 100644
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
index e17835fabb..24f6c71935 100644
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
index 23c53a3082..5cccf21c30 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -981,6 +981,7 @@ static struct commit_list *reduce_parents(struct commit *head_commit,
 
 	/* Find what parents to record by checking independent ones. */
 	parents = reduce_heads(remoteheads);
+	free_commit_list(remoteheads);
 
 	remoteheads = NULL;
 	remotes = &remoteheads;
diff --git a/builtin/pull.c b/builtin/pull.c
index 9b86e519b1..a5dd6426d5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -741,12 +741,15 @@ static int get_octopus_merge_base(struct object_id *merge_base,
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
index d3150d6270..7ff102c0df 100644
--- a/commit.c
+++ b/commit.c
@@ -1083,6 +1083,13 @@ struct commit_list *reduce_heads(struct commit_list *heads)
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

