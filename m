Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA77C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197FE206B8
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="W036QJgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgIIAu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbgIIAuG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:50:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC00C0613ED
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 17:50:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e1so882916ybk.14
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Whgj4+S6hi3Yf6sSoKGg5cKYVxwTioXGs+Po6FqpmeY=;
        b=W036QJgUPvA2YSfvUMefRaju7hPVEbZmYG0CSFe728Af//Hx/zASiWpviPraUqdZRR
         fpYPh2wUGoE+akoiAepWrq57A9NHsvB8kZ91NYj6DxPZ0UBsh3FkdXuvViZHY94afvkG
         e0o+cy/gmAuSJplfmQBzcbtLjXTlTnUu9Lp6x1gKUuc+QQ2uWaJ9fpRrUXxgCa5iWk5M
         2UFGLB0gNgT51K/Suge/hebrV5GuQ7HCqdck0O+a70Pydx0U1ZXtGXxgjgRioOtNMSxR
         hjc1NZOFR8LNyqmooCffMGXvf/LxgQ/m5Ps3RrAQ627gWe4WDdbrDi8RuCIoWjz3Ig/k
         MeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Whgj4+S6hi3Yf6sSoKGg5cKYVxwTioXGs+Po6FqpmeY=;
        b=jThKYk9VykfzVDS5rRt4D4Lcw19eS+X6sGVAyr+cyv4NLYmF35EQ2QKTdcEHSYya9a
         djhn8ADzJUagcooBbw0+Ft7hqxHtdRkFhvbE7VuYv50Wt3vPc1PXahO/AfV9nfBqOS6D
         B2YjlY3UQNYBPZ46970J1MlqH0aPosbbZxfJk6Lc+QIJuXGwy/wDg94j4KfXehrAAFF9
         BGVV1uX8DrOBASKi+ZRat7+yII7PDxMGss1xNIgIsvj05ED4iCpCrBa1YslG5Cs1dtao
         bzDAsspfv1oErnYtr9RNb7+L9uhucOvm8mwc5yhAPeK0eozPRdKkE6ZKRlsaqPLgjZDz
         HYTA==
X-Gm-Message-State: AOAM532AZi7YcIBPoxpCUvzcypXzfjJOnF60RJugi7W7wgqu78Ew8pLu
        csL08VggKP9lnBniGriq9wGv9/wS1lTvtOMHQ2q3AGK3/6RVsVJSzZxknoddXS1R0hKTJXpKqT6
        yJy1LeO/01JrXcPLfrvm+OYMqSmke2CpZvbZPJkEXIBj3uI9UvonxNuUaT57fo+FjfUxUbTqE5w
        ==
X-Google-Smtp-Source: ABdhPJyHSp7aDO3LlQzqDbIiRmSRVlPdc41J/JKVj0zfpwgmzials5KO+kwdnvQCAwVSPV6roh1stYclPYb+aRIuzjc=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:d98e:: with SMTP id
 q136mr2414551ybg.354.1599612604038; Tue, 08 Sep 2020 17:50:04 -0700 (PDT)
Date:   Tue,  8 Sep 2020 17:49:38 -0700
In-Reply-To: <20200909004939.1942347-1-emilyshaffer@google.com>
Message-Id: <20200909004939.1942347-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v4 8/9] commit: use config-based hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the adoption of config-based hooks, teach run_commit_hook()
to call hook.h instead of run-command.h. This covers 'pre-commit',
'commit-msg', and 'prepare-commit-msg'. Additionally, ask the hook
library - not run-command - whether any hooks will be run, as it's
possible hooks may exist in the config but not the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/commit.c                                 |  3 ++-
 builtin/merge.c                                  |  3 ++-
 commit.c                                         | 13 ++++++++++++-
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 13 +++++++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 69ac78d5e5..a19c6478eb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -36,6 +36,7 @@
 #include "help.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "hook.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -985,7 +986,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit")) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
diff --git a/builtin/merge.c b/builtin/merge.c
index 74829a838e..c1a9d0083d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -41,6 +41,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "hook.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -829,7 +830,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (find_hook("pre-merge-commit"))
+	if (hook_exists("pre-merge-commit"))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
diff --git a/commit.c b/commit.c
index 4ce8cb38d5..c7a243e848 100644
--- a/commit.c
+++ b/commit.c
@@ -21,6 +21,7 @@
 #include "commit-reach.h"
 #include "run-command.h"
 #include "shallow.h"
+#include "hook.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -1632,8 +1633,13 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 {
 	struct strvec hook_env = STRVEC_INIT;
 	va_list args;
+	const char *arg;
+	struct strvec hook_args = STRVEC_INIT;
+	struct strbuf hook_name = STRBUF_INIT;
 	int ret;
 
+	strbuf_addstr(&hook_name, name);
+
 	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
@@ -1643,9 +1649,14 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env.v, name, args);
+	while ((arg = va_arg(args, const char *)))
+		strvec_push(&hook_args, arg);
 	va_end(args);
+
+	ret = run_hooks(hook_env.v, &hook_name, &hook_args);
 	strvec_clear(&hook_env);
+	strvec_clear(&hook_args);
+	strbuf_release(&hook_name);
 
 	return ret;
 }
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index b3485450a2..cef8085dcc 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -103,6 +103,19 @@ test_expect_success 'with succeeding hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+# NEEDSWORK: when 'git hook add' and 'git hook remove' have been added, use that
+# instead
+test_expect_success 'with succeeding hook (config-based)' '
+	test_when_finished "git config --unset hook.pre-commit.command success.sample" &&
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	git config hook.pre-commit.command "$HOOKDIR/success.sample" &&
+	echo "$HOOKDIR/success.sample" >expected_hooks &&
+	echo "more" >>file &&
+	git add file &&
+	git commit -m "more" &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success 'with succeeding hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
-- 
2.28.0.rc0.142.g3c755180ce-goog

