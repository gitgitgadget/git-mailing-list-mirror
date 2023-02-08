Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E394C636D7
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 19:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjBHTVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjBHTVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 14:21:42 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1673351C73
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 11:21:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u22so9073900ejj.10
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 11:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVSJaj0QMhRtZU5yv6Ks2zyXX5fJPkcIZf+m8Mauzv0=;
        b=j4+1++UpxUZozetS9pnjJkai/H1QADohs8o+JscCFx+PBnBD2OCZGF1dHfrjQZhAn4
         SEkpoYVCA3QJE+z/aBQgq4my1ca7PDvHwxHpHA8OCjK3AK7QQcrIrKFPoyX19T732WGA
         /X0cIVgVg6vcSyzGESta6N4WIOxdpsFW/+cMqScqgrnaseIfbH/If7Yoig+GUBvH49Me
         bTWsEYJJzE63WOGJ6i2JjA3KGTcTK41khzCYrWC6CGFicGABfiuZ7gF5/8HBew95tyre
         o4XYnRHaoyeC/b5qmN/dWRlEIEIfG7X6vLUy2gtTIvRAK2Q60NgmktRFFRGd9q3t/qX+
         EH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVSJaj0QMhRtZU5yv6Ks2zyXX5fJPkcIZf+m8Mauzv0=;
        b=2sk2Xp90DMpO1Bh2Ha+IwpGRPPmliq6bjvWWzr2EX0PxwcJ8tGAdQKPQoANfq2gr0c
         3NyeU9buZEHyl7UUf+2QrXgz+TdTsaAFQ8mpvhNkrLoyQNpJrmlv0YIMl1N8pw+9rS4R
         72FsMm/tsjThx6b279Oqm9PSNjGU7KyR+Wy4us9FaSi+3hJbn+JYDyj8wA93fPp2lQqn
         JMDf1aLb7OUiR2E230v2xHOjDtmwduPyhTYu4+mLA6DDdlF7cX6fffFWnvJC3Hx2k8uV
         /A/g425XngN9atMdpYF1IIPgc3iBTBoxYyNfyhl7udN2tD15EXqSkdH0417/Jr8PFwwv
         8Fzg==
X-Gm-Message-State: AO0yUKXYjZn5Wi6hdWGHI4DVUWhEcEffFisAzBpTj9MHia4v5eyJI8Dq
        6l/Monty65R6Nl/aetOBwQ/nem0raZpbmhjl
X-Google-Smtp-Source: AK7set+pYXY+/lWcgOvIbl/VAe74IsMQsg1BK1eF7/8ABEb5NM/ZYD7kFc2uAKdBJdzj54cahXaKhg==
X-Received: by 2002:a17:906:fd8e:b0:8aa:f74:3252 with SMTP id xa14-20020a170906fd8e00b008aa0f743252mr10083604ejb.2.1675884096269;
        Wed, 08 Feb 2023 11:21:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15-20020a1709062c0f00b008964fdd5bbfsm6244227ejh.155.2023.02.08.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:21:35 -0800 (PST)
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
Date:   Wed,  8 Feb 2023 20:21:13 +0100
Message-Id: <patch-v2-3.5-3d3dd6b900a-20230208T191924Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
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
2.39.1.1475.gc2542cdc5ef

