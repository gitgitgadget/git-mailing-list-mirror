Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D96C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6960200
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbhIANfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhIANfl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:35:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C791C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 06:34:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z4so4566299wrr.6
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HX/QAqjb1ZZwB6Pp5auNS7pNt5429NWhRx3IgypTnbU=;
        b=HZ0L+1WWKc/kZXzsFKidwsLlWfkH68rf2lwZ87tIKKJOUnX05AqZ11pXCY+UCxIkoC
         kiKF9flLWa2G2Z3x50bmj6erdtFCwa9YBMStcGp5F9ux0G5Uvjuyj0ewwP2ChqE70VCW
         zn6Z++EzUsFi9MbTDHGhaLMGRtGjIBs9wm7S24Z0K4DeCnwkGzgbSjmgfcm3Nr0G6NEE
         n5Lc9+5/8OG1JBuPkVvCeb4+xx5g/KoeXPCVoQcixxEnlhQ9XQLr3A7+gwxVOJ1x3PPa
         1gAdg7v4Ffaq4zhbvI8QvJmgZcriituJ9eAZJ5rohJ3qRAg7iAwdyUZSyK0EzKQUsVP8
         AwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HX/QAqjb1ZZwB6Pp5auNS7pNt5429NWhRx3IgypTnbU=;
        b=EvZBUwWBIbSEhp0lIrA7vapqgr9LvCSepiWbUtRDcBf6WiaTRxuhbICbiL8OEXjJqn
         wGo4BghUIqELYVqR3D1XRUHV8RfSZWBjfl0p6EYn8XmPZYfCjpu6kKuT8AWKdNklJDeP
         OyA9bY73aKTgzdXFCnDhIxlOqqusb/bAhTMoURat9Yi16uBJ3mK8H8bymL4DWWsuVyZC
         O7L7l7rPpntSac+nlDg4riE4COloq/gG6p5nWG9YT0M9tES234FpxLd3q3AVw8bAYKVs
         bDvxF4jeWdK77s3TTIMgwRgpAqgqUj04QpXl3oWStaZSd3w3C1S1/ZoorABWpxl7Kb5X
         /jkw==
X-Gm-Message-State: AOAM5301/sFHmg2JDGNdhuHgO4Yzevjxsse1/VhZBd+u/gBir3/tpetY
        7C66GB/dGo2TU6yQ9x/vmf0=
X-Google-Smtp-Source: ABdhPJzlNcYkzEJwc6OVE7o7jTJK8xzf7+r5mfWCzpkVCX8DXu+rl3tgYlZo6p7SW4XGKnS2FeL00g==
X-Received: by 2002:a5d:55cd:: with SMTP id i13mr37735428wrw.366.1630503283118;
        Wed, 01 Sep 2021 06:34:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c24sm21331234wrb.57.2021.09.01.06.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:34:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
Date:   Wed, 01 Sep 2021 15:33:05 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
Message-ID: <87tuj4v2q5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This option was deprecated in favor of `--rebase-merges` some time ago,
> and now we retire it.

>  static int is_merge(struct rebase_options *opts)
>  {
> -	return opts->type == REBASE_MERGE ||
> -		opts->type == REBASE_PRESERVE_MERGES;
> +	return opts->type == REBASE_MERGE;
>  }

This leaves us with a rather pointless is_merge() function and
nonsensical control flow in parse_opt_merge(). Let's squash this in:

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4e19f64b91b..043933ab771 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -383,11 +383,6 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int is_merge(struct rebase_options *opts)
-{
-	return opts->type == REBASE_MERGE;
-}
-
 static void imply_merge(struct rebase_options *opts, const char *option)
 {
 	switch (opts->type) {
@@ -909,8 +904,7 @@ static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
-	if (!is_merge(opts))
-		opts->type = REBASE_MERGE;
+	opts->type = REBASE_MERGE;
 
 	return 0;
 }
@@ -988,7 +982,7 @@ static void set_reflog_action(struct rebase_options *options)
 	const char *env;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!is_merge(options))
+	if (options->type != REBASE_MERGE)
 		return;
 
 	env = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
@@ -1208,12 +1202,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
 
-	if (action == ACTION_EDIT_TODO && !is_merge(&options))
+	if (action == ACTION_EDIT_TODO && options.type != REBASE_MERGE)
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
 
 	if (trace2_is_enabled()) {
-		if (is_merge(&options))
+		if (options.type == REBASE_MERGE)
 			trace2_cmd_mode("interactive");
 		else if (exec.nr)
 			trace2_cmd_mode("interactive-exec");
@@ -1465,7 +1459,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				break;
 
 		if (i >= 0) {
-			if (is_merge(&options))
+			if (options.type == REBASE_MERGE)
 				die(_("cannot combine apply options with "
 				      "merge options"));
 			else
@@ -1507,7 +1501,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		else
 			options.empty = EMPTY_DROP;
 	}
-	if (reschedule_failed_exec > 0 && !is_merge(&options))
+	if (reschedule_failed_exec > 0 && options.type != REBASE_MERGE)
 		die(_("--reschedule-failed-exec requires "
 		      "--exec or --interactive"));
 	if (reschedule_failed_exec >= 0)
@@ -1746,7 +1740,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		diff_flush(&opts);
 	}
 
-	if (is_merge(&options))
+	if (options.type == REBASE_MERGE)
 		goto run_rebase;
 
 	/* Detach HEAD and reset the tree */
