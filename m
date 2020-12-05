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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A1FC433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDFC22DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgLEBu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbgLEBu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:50:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B217C061A55
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v12so9336533ybi.6
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=luXBwOtpikkdNrYnfdM9JMdzWElhhuE/WuLI+XXCgms=;
        b=sYCHehlm9fyI2CH+m18OL9+sFmirYaYPtv9tSGACbUeI0zoDyMka3oEfat/OfvlVs8
         i6V7yU15R7QcVtznIrUXprmlek5Co1JsE9JO7gCMutOHpbZSgJFK9/pWaJ6DYp7DyEOj
         zQquVbrWfKe3PavXROUB9WJd4bGAqTS6TR04eVGVT3OGuWs7SXCrQ7uPDZ3oOQz9lSqD
         ROHeGmW0OQIRAoT/OisTSktb9OlNVa3dT8RK70CAGyRk59312rqDygX6oJR3tppbDzrt
         /HNM1Cw7Ycy6Ly52VZ9XD2PbwNAGgs9XnnqxNG13NjwvfvXF+XqeACT8UEKXd5HepgSj
         PcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=luXBwOtpikkdNrYnfdM9JMdzWElhhuE/WuLI+XXCgms=;
        b=lc8BhlAsHdTRq/Hhf1M6FMfVrJja+kLZ9lQXHJ1aJuVzFcpvolfhYVqMKpLlDHycFi
         dDhUvwfonXs3dqLKZH3QIvJJI6zaXnDoUfwBvCFza08QYNmBJ/hF1t14gYRVc2gjhjAM
         l0eSHNeCO73zn2yGXJWX0IZkccdeDMu4FWn9xZdctpso7OKeqx1Slz9Pm5XTRrojwOJp
         iWlAhXgLFhUIGDG2RNRx1yb6fa11qCDgXQJs01fYUlqOnsMOGs7DOXEeskqzvTyKB7sE
         41ATNLjI/qDX3w7tg8JlaaHP8bQPf2ovaE7hFPWWV6XARqpyBXUMjloQ3rUetVVLYiQm
         sLbQ==
X-Gm-Message-State: AOAM533BvzBMpaJwy4pmFnjNxSZX/DpXqmnHKiNqu9s2SvEWF2xn2ZxZ
        Ahi5ouHbBkxpj9LVEyEc/JGzGq1zBj6VEbIkG2TDECl6v084vlvdHIZdYyTINyLGhbW4KM1U0h/
        oNW9/RhZJtuJfPhS/d3tvY74gQ5cgcHFktV5xAk0xSxAz1+fcemL9s7MQF/gNWt2hgoc1Skm3lA
        ==
X-Google-Smtp-Source: ABdhPJzQz2wcrQKp3gqGpaB+4o96IKeV6RlkilM8un+GzSkVs1Wvh2C72Kn1/Hb6+iOS4xci9eh8oHPCFs1HsxOwCdQ=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:254a:: with SMTP id
 l71mr10191891ybl.439.1607132999805; Fri, 04 Dec 2020 17:49:59 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:33 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 05/17] rebase: teach pre-rebase to use hook.h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using hook.h instead of run-command.h to run hooks, pre-rebase hooks
can now be specified in the config as well as in the hookdir. pre-rebase
is not called anywhere besides builtin/rebase.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt | 2 ++
 builtin/rebase.c           | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d74308dc20..5dc0690607 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -200,6 +200,8 @@ two parameters.  The first parameter is the upstream from which
 the series was forked.  The second parameter is the branch being
 rebased, and is not set when rebasing the current branch.
 
+Hooks executed during 'pre-rebase' will run in parallel by default.
+
 post-checkout
 ~~~~~~~~~~~~~
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 19c7b377aa..f61ca3e5af 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -28,6 +28,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "hook.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -1312,6 +1313,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_ASYNC;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -2024,9 +2026,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* If a hook exists, give it a chance to interrupt*/
+	strvec_pushl(&hook_opt.args, options.upstream_arg, argc ? argv[0] : NULL, NULL);
 	if (!ok_to_skip_pre_rebase &&
-	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
+	    run_hooks("pre-rebase", &hook_opt))
 		die(_("The pre-rebase hook refused to rebase."));
 
 	if (options.flags & REBASE_DIFFSTAT) {
@@ -2106,6 +2108,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	ret = !!run_specific_rebase(&options, action);
 
 cleanup:
+	run_hooks_opt_clear(&hook_opt);
 	strbuf_release(&buf);
 	strbuf_release(&revisions);
 	free(options.head_name);
-- 
2.28.0.rc0.142.g3c755180ce-goog

