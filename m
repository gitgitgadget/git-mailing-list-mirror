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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E082DC4332D
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC18822B51
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLVAGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLVAF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:05:59 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4AC061248
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:52 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l7so9293783qvp.15
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=luXBwOtpikkdNrYnfdM9JMdzWElhhuE/WuLI+XXCgms=;
        b=AwMi2bMbHHzN9V7mEjc9snf05SLJ6Bkv/NNWNB5kzr/VZKC1uarnuR4K7cqUuF/ODh
         0pYM/by/0q00okypTsMrNuLMJI9k/wWoZ7mZmBtswpxJeVElgu90ZOHS+RnwercIzcGj
         GflhARQxJ7HAG7B9We/LhZS35rQ5k7h3Dy7p4QuUbwxRM++dQYAVu7olmMTBrvhjyE06
         dMvGoiiubgX2BCHhK0C6EZjF88Ig6PEdpL6OiTEymU2yjsixcHlEZfAROJM2oacMGDUS
         iDYUTMON+VoiYbGyjRrafTJcA5IyA8yHFczQd90zgUUe9EEJj7DaIz+NpyJP5aYEOIUb
         4QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=luXBwOtpikkdNrYnfdM9JMdzWElhhuE/WuLI+XXCgms=;
        b=qRb5M4qK17Bhg6YC3bpeOtWvu6jfY/rHdJaK/TcG6bSLqzYU5/kQudsjBNVZrQTe8p
         ymZwtWIWGYkf6pvcBAl3u97lze0X8+C1d3+pMVemIlnEeCjr3R+DHiJ9jpkZnffGfeB4
         Eq38/kiL3cxuusfg+0E7egTqh8M3+cmithwserxhahVzUlt71IICCk8t7X2lTSRd1/wK
         14ZpkZ6XlNMJDfYO1cThzouAx97EFvyF4aQhJEWlrZsa9dnf5ZWP+r5+KE1XdXvCXoeb
         t4Saq7YpMGNBMjJHoA09jKDhi7Nm7UjcrSm8KuQvpcVISQqAc2sEVlCuboAao6QFz4su
         J8Uw==
X-Gm-Message-State: AOAM533EN7E42QwfQD3H+34G4QogGjS83usjgjCgkKUJBLnWnf5knmja
        iIQaJnZAVQl96e6tXLPMW+ouXeR/ShrGwmAF6VgejXzPo/192j13zSufVv6dTpr5tItkYASsEXN
        1HzjVIlU0RT8dmbZKD6yKt+In/0oQ6146ocKk0yx1AI+EMyjTClta3yBL9luOpAsUrSaijQfRCA
        ==
X-Google-Smtp-Source: ABdhPJxNBsR3ydFKq8TJQSZgbXmB38eWUc5IQUVwn+/WNwpDYh+xcy0gbmwl+38Jyfoo6Br/3DUeGUJyfmHOIVyy0gk=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:c583:: with SMTP id
 a3mr19334590qvj.15.1608595491884; Mon, 21 Dec 2020 16:04:51 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:23 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 05/17] rebase: teach pre-rebase to use hook.h
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

