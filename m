Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE1C38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 17:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjAWRPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjAWRP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC902BF1F
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kt14so32402207ejc.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0EAP/+ht+MCm0hS+nzUQZhtsmL3FyKKtMK1D6L7A8w=;
        b=nTtacCaabKPItmmgObPGGZZpYUvGXlPfINZEG0xWCScJWZx+mK8ozFo+zgY3nW1OkL
         2yZjSy7a6YoXgkGBRbRIdFJQ2GeyOU6Aa7vNuGywu/4Lq8kjy8cCQovasug6A5RZEoWA
         ld3FMk0JfhR5RLuu1USZ4rbwk24OYGXcHAu1BmokQORg2U4k+ql1jNHAlYtYWtnF6PxD
         6HyiE+8wDOI6VjWQBdMoaVnbmOyq7UcgwYL5NEUrHEKoK4AoplNRyOsB+IckXgXRYT6U
         tVqbQ8Hv1sgxhls4K3w7m3+9zLiE5i0LMLi4JHGoyHBIegKfTvB2aTf+A117YOKZU4JM
         7OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0EAP/+ht+MCm0hS+nzUQZhtsmL3FyKKtMK1D6L7A8w=;
        b=l87dxs+VjVnUaCUW9TelpBHhx356x0qN3jWLg44w23nmyts8MUIRMt5BCHSCDdwPRg
         Hsrj2OVrd1JHWW39vmmlgg5fmceU5sqcX1zWpOwdWe1rcmWbgqBQPADsUf5+5oRNaaor
         0YJn59QFuk5Zwjf4ob4/iJtfF+2t3eockg3s/B9AEbgABY6sRkrqFyZJpE/J0JCbaACx
         BckNWcIQNDoNbmK1xz5Qy4OYWEC8qzlpyhVhCH50iOvdfctfQQSBSztJYLjxOcJ/ZgY1
         hFQ9HokKbVKoWvZPgLKyBD5pvxBsJZabP4YQDhh5KwjB07EaBWPYCKsl1U28q73tfBos
         y0BQ==
X-Gm-Message-State: AFqh2koxLNiShd/pATqGaq+QsfIIq5UTBHVfYbxxjh2vllC1BBg4QGn8
        8si32/F9IiwjQ2Zmx7HKNPdBVO/qy6geBg==
X-Google-Smtp-Source: AMrXdXsoMhWNN4hJ5w5WlC+Us6SoSC7MKI9DVWkoLMvUy4egjB9peKUabcLexnY0D1i1hVZHUjPYGw==
X-Received: by 2002:a17:907:c609:b0:862:c1d5:ea1b with SMTP id ud9-20020a170907c60900b00862c1d5ea1bmr29038928ejc.8.1674494115263;
        Mon, 23 Jan 2023 09:15:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906164400b007c11e5ac250sm22771754ejd.91.2023.01.23.09.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] hook API: support passing stdin to hooks, convert am's 'post-rewrite'
Date:   Mon, 23 Jan 2023 18:15:07 +0100
Message-Id: <patch-3.5-c6b9b69c516-20230123T170551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1301.gffb37c08dee
In-Reply-To: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Convert the invocation of the 'post-rewrite' hook run by 'git am' to
use the hook.h library. To do this we need to add a "path_to_stdin"
member to "struct run_hooks_opt".

In our API this is supported by asking for a file path, rather
than by reading stdin. Reading directly from stdin would involve caching
the entire stdin (to memory or to disk) once the hook API is made to
support "jobs" larger than 1, along with support for executing N hooks
at a time (i.e. the upcoming config-based hooks).

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 20 ++++----------------
 hook.c       |  8 +++++++-
 hook.h       |  5 +++++
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 82a41cbfc4e..8be91617fef 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -495,24 +495,12 @@ static int run_applypatch_msg_hook(struct am_state *state)
  */
 static int run_post_rewrite_hook(const struct am_state *state)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *hook = find_hook("post-rewrite");
-	int ret;
-
-	if (!hook)
-		return 0;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
-	strvec_push(&cp.args, hook);
-	strvec_push(&cp.args, "rebase");
+	strvec_push(&opt.args, "rebase");
+	opt.path_to_stdin = am_path(state, "rewritten");
 
-	cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
-	cp.stdout_to_stderr = 1;
-	cp.trace2_hook_name = "post-rewrite";
-
-	ret = run_command(&cp);
-
-	close(cp.in);
-	return ret;
+	return run_hooks_opt("post-rewrite", &opt);
 }
 
 /**
diff --git a/hook.c b/hook.c
index a4fa1031f28..86c6dc1fe70 100644
--- a/hook.c
+++ b/hook.c
@@ -53,8 +53,14 @@ static int pick_next_hook(struct child_process *cp,
 	if (!hook_path)
 		return 0;
 
-	cp->no_stdin = 1;
 	strvec_pushv(&cp->env, hook_cb->options->env.v);
+	/* reopen the file for stdin; run_command closes it. */
+	if (hook_cb->options->path_to_stdin) {
+		cp->no_stdin = 0;
+		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
+	} else {
+		cp->no_stdin = 1;
+	}
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
diff --git a/hook.h b/hook.h
index 4258b13da0d..19ab9a5806e 100644
--- a/hook.h
+++ b/hook.h
@@ -30,6 +30,11 @@ struct run_hooks_opt
 	 * was invoked.
 	 */
 	int *invoked_hook;
+
+	/**
+	 * Path to file which should be piped to stdin for each hook.
+	 */
+	const char *path_to_stdin;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.39.1.1301.gffb37c08dee

