Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2BDC433E6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAEA22525
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgLVADN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLVADM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:12 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F20C061285
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:32 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id w4so7493745pgc.7
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=c/vmugnHQwHPjeFKAYrWXfuwZcwZYECjyB5o35wtJbI=;
        b=sfWF1oPnFkGE2rClcPfaSVBzY8RCItf2op4kRQcU83GWzSkkaKcEjJL0mLpV66N/zd
         Oq0RouJ8HTsbaHIezPiyHSPn75LhnBDphnr7zwTJghovvxu18NPOScKJJX7bZITSWzik
         vkg+TZnD510r8YsP2Vlc6lGMFe6LcQ69Ybh9pd5Hx79eeaW6Dy+xgxi+pgCDqjmZobmv
         qM9QBYiQn3JYRgWwIAn60kZwa4+4gpqN1JbbFg9beTCA739Xw4XlCllB891HkU6Qpsjv
         JYUsi3EF3N+CEvUWm99VCnQpjVUjE7xlAP4+KDJP0uSKsyQnGvT6tXtUjo2W0dGkDLpf
         ZbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c/vmugnHQwHPjeFKAYrWXfuwZcwZYECjyB5o35wtJbI=;
        b=lvQb+NrpHKeWFGBm1sdZAU+9lfJ0pQaCocSCWKtcJ8wmTdta9goIlzkCCNU8UFzFGR
         FErHPB12QAgAwIdnBHF19UBpEpVWinSMqM+CTzI0MHWSe5VPW2xqwbDclK4KPNmKBwsw
         7M3bzbwEGqi/aOQDuaBreLP31jXthjJ8nKYk1jRWX9z15xVVA5D5zDItoiZkA0bWvUTD
         iiHBVo4bqj0zblLAVha2qF7QP5JwIxUVXRhTIMKOr9JxorPSZT83h0Yn00BTLGJxN10h
         PJ06UjTU78NoWWkmQP4wonuKqXUn0bhIJGuzqnVLQTQJO1/7U6WJ0EAUxaCi9X4fk+wH
         TPoQ==
X-Gm-Message-State: AOAM533ooaH5RGJTyf/JrnH7GJ642zYR/VdDXsjqcd8o8C/usTFJcjLL
        UIgO0FUxW0iUoz6EDc3U8tEUT4ZKbp1AoL8V1ZjYF9FFq2UThp95k6holvMkR7alFkpUWKW5FlQ
        uQqprdkyzU4b/tQj4d5lCxKSSOaI9n8wFcdi0PL4GPbc0vCAhbXCEXoiPH+NPuXQsumZQs7SfXg
        ==
X-Google-Smtp-Source: ABdhPJxJwWOojbDCzZc/oXe4MXqVkXABiSVN6F3dXkqg/rwnZHGlNl61NAzAg7QOYAzLq7nG8TSPiA+jnGc50NefudE=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a62:ae0c:0:b029:1a5:819d:9ac5 with
 SMTP id q12-20020a62ae0c0000b02901a5819d9ac5mr17318189pff.26.1608595351862;
 Mon, 21 Dec 2020 16:02:31 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:07 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 04/17] hook: include hookdir hook in list
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Historically, hooks are declared by placing an executable into
$GIT_DIR/hooks/$HOOKNAME (or $HOOKDIR/$HOOKNAME). Although hooks taken
from the config are more featureful than hooks placed in the $HOOKDIR,
those hooks should not stop working for users who already have them.

Legacy hooks should be run directly, not in shell. We know that they are
a path to an executable, not a oneliner script - and running them
directly takes care of path quoting concerns for us for free.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Newly split into its own commit since v4, and taking place much sooner.
    
    An unfortunate side effect of adding this support *before* the
    hook.runHookDir support is that the labels on the list are not clear -
    because we aren't yet flagging which hooks are from the hookdir versus
    the config. I suppose we could move the addition of that field to the
    struct hook up to this patch, but it didn't make a lot of sense to me to
    do it just for cosmetic purposes.

 builtin/hook.c                | 18 ++++++++++++++----
 hook.c                        | 15 +++++++++++++++
 hook.h                        |  1 +
 t/t1360-config-based-hooks.sh | 19 +++++++++++++++++++
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 4d36de52f8..a0013ae4d7 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -16,6 +16,7 @@ static int list(int argc, const char **argv, const char *prefix)
 	struct list_head *head, *pos;
 	struct hook *item;
 	struct strbuf hookname = STRBUF_INIT;
+	struct strbuf hookdir_annotation = STRBUF_INIT;
 
 	struct option list_options[] = {
 		OPT_END(),
@@ -42,10 +43,17 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	list_for_each(pos, head) {
 		item = list_entry(pos, struct hook, list);
-		if (item)
-			printf("%s: %s\n",
-			       config_scope_name(item->origin),
-			       item->command.buf);
+		if (item) {
+			/* Don't translate 'hookdir' - it matches the config */
+			printf("%s: %s%s\n",
+			       (item->from_hookdir
+				? "hookdir"
+				: config_scope_name(item->origin)),
+			       item->command.buf,
+			       (item->from_hookdir
+				? hookdir_annotation.buf
+				: ""));
+		}
 	}
 
 	clear_hook_list(head);
@@ -62,6 +70,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 	if (argc < 2)
 		usage_with_options(builtin_hook_usage, builtin_hook_options);
 
+	git_config(git_default_config, NULL);
+
 	if (!strcmp(argv[1], "list"))
 		return list(argc - 1, argv + 1, prefix);
 
diff --git a/hook.c b/hook.c
index 937dc768c8..ffbdcfd987 100644
--- a/hook.c
+++ b/hook.c
@@ -2,6 +2,7 @@
 
 #include "hook.h"
 #include "config.h"
+#include "run-command.h"
 
 void free_hook(struct hook *ptr)
 {
@@ -34,6 +35,7 @@ static void append_or_move_hook(struct list_head *head, const char *command)
 		to_add = xmalloc(sizeof(struct hook));
 		strbuf_init(&to_add->command, 0);
 		strbuf_addstr(&to_add->command, command);
+		to_add->from_hookdir = 0;
 	}
 
 	/* re-set the scope so we show where an override was specified */
@@ -100,6 +102,7 @@ struct list_head* hook_list(const struct strbuf* hookname)
 	struct strbuf hook_key = STRBUF_INIT;
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
 	struct hook_config_cb cb_data = { &hook_key, hook_head };
+	const char *legacy_hook_path = NULL;
 
 	INIT_LIST_HEAD(hook_head);
 
@@ -110,6 +113,18 @@ struct list_head* hook_list(const struct strbuf* hookname)
 
 	git_config(hook_config_lookup, (void*)&cb_data);
 
+	if (have_git_dir())
+		legacy_hook_path = find_hook(hookname->buf);
+
+	/* Unconditionally add legacy hook, but annotate it. */
+	if (legacy_hook_path) {
+		struct hook *legacy_hook;
+
+		append_or_move_hook(hook_head, absolute_path(legacy_hook_path));
+		legacy_hook = list_entry(hook_head->prev, struct hook, list);
+		legacy_hook->from_hookdir = 1;
+	}
+
 	strbuf_release(&hook_key);
 	return hook_head;
 }
diff --git a/hook.h b/hook.h
index 8ffc4f14b6..5750634c83 100644
--- a/hook.h
+++ b/hook.h
@@ -12,6 +12,7 @@ struct hook
 	enum config_scope origin;
 	/* The literal command to run. */
 	struct strbuf command;
+	int from_hookdir;
 };
 
 /*
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 6e4a3e763f..0f12af4659 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -23,6 +23,14 @@ setup_hookcmd () {
 	test_config_global hookcmd.abc.command "/path/abc" --add
 }
 
+setup_hookdir () {
+	mkdir .git/hooks
+	write_script .git/hooks/pre-commit <<-EOF
+	echo \"Legacy Hook\"
+	EOF
+	test_when_finished rm -rf .git/hooks
+}
+
 test_expect_success 'git hook rejects commands without a mode' '
 	test_must_fail git hook pre-commit
 '
@@ -85,4 +93,15 @@ test_expect_success 'git hook list reorders on duplicate commands' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list shows hooks from the hookdir' '
+	setup_hookdir &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

