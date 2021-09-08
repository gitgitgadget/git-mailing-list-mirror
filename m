Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EFDC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC6E60E97
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348801AbhIHNm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbhIHNmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:42:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F20C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:41:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i3so1765223wmq.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oFa9M4k19kNRart/HjXJxyS+9vVejrqwfcHUQrTobqk=;
        b=YahGNggaNXzTnXB99KiaWBc8UReQXDn6TPpP6sfRulg0hNPTLgRxqjbdfzIW7+4Sri
         md6D0Sahv2VhdrlhjV2jlGduPTt2OGBfHgk3ERfgBFo5W4d9ymdsXQrDnm3h7yme64u1
         WA/2XJmcEPCZsjT+lPOz/Uv21uVHVrFeOeWH97uRrcas1HbWLWkybga2U5Q7Ff84259D
         FQxIwCfwjtsHFtIzyvVibcf8Llj/vv8IInvEV5D3jsTI1A/dGaM8doyEZqTpDKGJffzj
         dknSMF+LEPdjq7tQA3Xm1Ia5BuCBv4kMZgR80J9fmu/ioLaqayCf9pNoFaWeDK4qHQ5T
         +HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oFa9M4k19kNRart/HjXJxyS+9vVejrqwfcHUQrTobqk=;
        b=sr7xMIfAiml5hKItTGtIMzqXajLHgjFKXYhxTvu1gtxy5Zz2YiQddFEzCFKlacGJKg
         t0mJnxo1svaWYHktA8Z2ZZt+DDoW8Y1rTgR4EqFsvyf7WvOuG49bf2tfKVdvG3hwzcxI
         KkY57DhO2L/+46+OWDLvHPqnTCgn5Rwer+Er4UCWvmBtP9+403DppPoKEGbOG8G6H4Ph
         nEvulIrV+l2/Rr7blvYd/BqyuBQeNQxtSrySy7oBoTwl1Mndue4T0tJHUiPWRewY9CvF
         mutAKiOPHKXTGpw0G9PtpqwsrhdeOXZ06qfE+J4R+XDUO99eeBk6BFgkDTwl3zTzUWKf
         Quqg==
X-Gm-Message-State: AOAM5335euMH1cj3a7FBuS31os5evnNBqLapqe5JY+JuF3PgHf3Qh2ls
        J9inwU0KebVLuSm0S3Vbi1qNk6FlQ6E=
X-Google-Smtp-Source: ABdhPJzISZyUdtClaqJfO79lAjfsx3HuMhu9WBulgJs3ozrE0QwzElUlOVHS/omnLDZiNlKDaFw84Q==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr3685200wmi.163.1631108476131;
        Wed, 08 Sep 2021 06:41:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm2140325wmo.39.2021.09.08.06.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:41:15 -0700 (PDT)
Message-Id: <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 13:41:11 +0000
Subject: [PATCH 4/5] rebase -i: don't fork git checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The "apply" based rebase has avoided forking git checkout since
ac7f467fef ("builtin/rebase: support running "git rebase <upstream>"",
2018-08-07). The code that handles the checkout was moved into libgit
by b309a97108 ("reset: extract reset_head() from rebase", 2020-04-07)
so lets start using it for the "merge" based rebase as well. This
opens the way for us to stop calling the post-checkout hook in the
future.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d51440ddcd9..1a9dbc70d3c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4192,42 +4192,21 @@ int apply_autostash_oid(const char *stash_oid)
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
 	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
 
-	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
+	if (reset_head(r, onto, "checkout", NULL, RESET_HEAD_DETACH |
+		       RESET_ORIG_HEAD | RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
+		       NULL, action, "rebase")) {
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

