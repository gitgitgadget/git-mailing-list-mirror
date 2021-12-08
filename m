Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF177C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbhLHPB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbhLHPBs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCB6C0698CD
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso1952155wmr.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ieTmdmFrQ3TWBhksR7eaDCc6S5DicVx4i30sMnKFuC4=;
        b=COVPc2c7d39yuu0NSZMl/XtSYmSlmcY8hMnlCpv1GlWmmR0WGJcPltNZlH/VwS7UOg
         NDpPxG3Q1V5h7eM3FLCBcC4sB7e+h6FLVxUfrpQrL3pQ0+qSvle4xGO4athFlns4AltO
         ymgYhsmB7LF7iM3yZOqb89GjAhYt4gvXnVFBiBeQ+KDSU+GRj5d3Oq1Rr0223+hsxGwU
         O8xU3vVtY7kuTkuq7Pz8ChbOxs7qumGweZ6Q2oJPYc4YjN/eG6CLygyaQZlBt9EHcpMV
         hUu3zaJJkwpmAAkL6r4SEEnV+w0SfH44Auc/3fSOTBwJwAIsBnamXneV9HFNUAUMRduy
         yt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ieTmdmFrQ3TWBhksR7eaDCc6S5DicVx4i30sMnKFuC4=;
        b=mvc3p2pWVDFBkyv53S9nit58Bt3o3e2tg35ut/yKv3fOiJAQRyraTQc8R0kdGuoURu
         6X2+swvE6rYX4v/YrLPmmTo6BLKVeEajaNIS9zFvlClH7MBeq/axdv8uK1xv626ShqkM
         ihfXLYxG5xch0uNpwXDEY+lVsKFsKkifCBNlkqhCj4x9XtocY7nnwfsyBMUotLqRyNSQ
         ScBPa+KXpRCoNc6KYQF7mN/YF8jsfjdz+KBtsfChrah4ZxTrNf5gsloZjlaei7UwMm3O
         7BI7JTou06wawh2EyNY42rmhX35VG9OVhmX6+Lk2pgHLtwju3Na0TEsMbdCZBxgCU3xw
         BpAw==
X-Gm-Message-State: AOAM532jdnrGFDHhhWHoeZYT8EYOhN8BM1LRLoKWUuhNmcGpfYoDSceM
        b6J/04hQbelnMUjaoXvZRwEAJ7AtuZM=
X-Google-Smtp-Source: ABdhPJzFcctQZR6QuSWpsduYYcbs+x4xdY6lPUOAMmMNAxk3pCwmNte4aNK5R4ilXze8KlONC+8Hrg==
X-Received: by 2002:a05:600c:3647:: with SMTP id y7mr16628632wmq.39.1638975494242;
        Wed, 08 Dec 2021 06:58:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm2876017wrx.25.2021.12.08.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:13 -0800 (PST)
Message-Id: <3f64b9274b5580d14ea9cac916be5077b5eebdd2.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:58:01 +0000
Subject: [PATCH v2 14/14] rebase -m: don't fork git checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that reset_head() can handle the initial checkout of onto
correctly use it in the "merge" backend instead of forking "git
checkout".  This opens the way for us to stop calling the
post-checkout hook in the future. Not running "git checkout" means
that "rebase -i/m" no longer recurse submodules when checking out
"onto" (thanks to Philippe Blain for pointing this out). As the rest
of rebase does not know what to do with submodules this is probably a
good thing. When using merge-ort rebase ought be able to handle
submodules correctly if it parsed the submodule config, such a change
is left for a future patch series.

The "apply" based rebase has avoided forking git checkout
since ac7f467fef ("builtin/rebase: support running "git rebase
<upstream>"", 2018-08-07). The code that handles the checkout was
moved into libgit by b309a97108 ("reset: extract reset_head() from
rebase", 2020-04-07).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a62ea9d0e05..19082aa6c9b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4217,42 +4217,26 @@ int apply_autostash_oid(const char *stash_oid)
 	return apply_save_autostash_oid(stash_oid, 1);
 }
 
-static int run_git_checkout(struct repository *r, struct replay_opts *opts,
-			    const char *commit, const char *action)
-{
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	int ret;
-
-	cmd.git_cmd = 1;
-
-	strvec_push(&cmd.args, "checkout");
-	strvec_push(&cmd.args, commit);
-	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
-
-	if (opts->verbose)
-		ret = run_command(&cmd);
-	else
-		ret = run_command_silent_on_success(&cmd);
-
-	if (!ret)
-		discard_index(r->index);
-
-	return ret;
-}
-
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 const char *onto_name, const struct object_id *onto,
 			 const struct object_id *orig_head)
 {
-	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
-
-	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
+	struct reset_head_opts ropts = {
+		.oid = onto,
+		.orig_head = orig_head,
+		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
+				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
+		.head_msg = reflog_message(opts, "start", "checkout %s",
+					   onto_name),
+		.default_reflog_action = "rebase"
+	};
+	if (reset_head(r, &ropts)) {
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
 	}
 
-	return update_ref(NULL, "ORIG_HEAD", orig_head, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+	return 0;
 }
 
 static int stopped_at_head(struct repository *r)
-- 
gitgitgadget
