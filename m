Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51568C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 12:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjBCMQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 07:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjBCMQe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 07:16:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB36D06C
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 04:16:24 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p26so14701599ejx.13
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 04:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukuROd+WVlg4bjI0njxyh1k/SrOshfl6sA9dO8JzAzk=;
        b=iwn5xy+QPlPP4Rqx7Qz5deUpPu9Qud5ESMn2vdQ/oBGfrHZNWCRsFc9XrKQtmj5BKP
         IoW3sKbw48QR191UxFZeQukMi3f5iZDUl/Flr4RYijQKZsWQMqmLeLEbW71MgjqvEMv1
         CpaWFIKEqH0Li/2Z97GvJ28s+7S5BTYDhhTokpqwybTHBpyFV5OePJTl3DlL9GuIt0fX
         RjMKD2050HiuYW8gMNo/1MqTZKp+EI2CYzjsdxAjgubGlUGoSiKIlLOKtnCw7kYwCgKQ
         j0vsCtW4dpiLvyzSuvBBAUNxkKkygownn/49HgPP2b+uDQUfW20wfxb0+hb3UPGo/lro
         9O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukuROd+WVlg4bjI0njxyh1k/SrOshfl6sA9dO8JzAzk=;
        b=LMCKKKwWs2syH5EO2m587i03JYLPQfAVy+EiajypT9joowUqY2anmM3f/q6OtdnJ7a
         wmOSIfNwlqUUwVxtUgIM089XWPtexAb1wulhq1MH14VD+HDrx7gqn7QANvinEd0/c5fj
         zNcOtTOhgNJRX2TAM1KKLQtOBdLMSUg6qEly0Y4o8TxPI4VueYCGj7G7Q6dUGY74dYod
         geTgXM2/fv/h/8Gg+jgIew03dRKCH7JBGeDjRUzPoGMdWTZiQyxrgiVthQM7TjR90Ffj
         lesbfNDap64rAe1TZXWOq7Twar0a6/mmHwwOvECHn8dR3EEQpiI55QLsk7KjqHr6Rnpy
         coRw==
X-Gm-Message-State: AO0yUKUY6Zz2nFYByAcB2ojjWTVodx/cg11CDqsAVHVIxLILyRTB5gc4
        CAKk+76cBzkvvunUbCwBhB5Y/imr9vEvB0Kq
X-Google-Smtp-Source: AK7set8KRNj24M4B00K03fKTpx2eeG5WzhoJwddyHJi4yuHxKa8V58Fxrj4Kwkt8RNEHqITHZBjocg==
X-Received: by 2002:a17:907:a07c:b0:884:d15e:10f8 with SMTP id ia28-20020a170907a07c00b00884d15e10f8mr10869610ejc.51.1675426582308;
        Fri, 03 Feb 2023 04:16:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906849800b0088b24b3aff8sm1286313ejx.183.2023.02.03.04.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:16:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] hook API: support passing stdin to hooks, convert am's 'post-rewrite'
Date:   Fri,  3 Feb 2023 13:15:33 +0100
Message-Id: <patch-v2-3.5-3d3dd6b900a-20230203T104319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.gbe42486b8a4
In-Reply-To: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
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
 hook.c       |  5 +++++
 hook.h       |  5 +++++
 3 files changed, 14 insertions(+), 16 deletions(-)

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
index a4fa1031f28..1a848318634 100644
--- a/hook.c
+++ b/hook.c
@@ -55,6 +55,11 @@ static int pick_next_hook(struct child_process *cp,
 
 	cp->no_stdin = 1;
 	strvec_pushv(&cp->env, hook_cb->options->env.v);
+	/* reopen the file for stdin; run_command closes it. */
+	if (hook_cb->options->path_to_stdin) {
+		cp->no_stdin = 0;
+		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
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
2.39.1.1397.g8c8c074958d

