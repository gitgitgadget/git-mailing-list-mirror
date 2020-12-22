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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE68C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2C522512
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLVAF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLVAF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:05:57 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC08C061285
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:51 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i13so9113870qtp.10
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=szzTHJd6sqRvu0qG5IShlxbRdUP7g1k3ZqXUc4Z/QWk=;
        b=AxIyqaytIPJHKxvI76D3hsCXrK9ohOnipMqnBbBawwgJ5E4uCAMlWMsp2Ge3fDeVFP
         bp5hQEAFZQLTH/dzEeXE1wW9rawP0Qrhi5Qylk2UpSXzIRrZ+YiiRIdxx/nFZmlcDp3L
         zZEhN2IKnJwb8wwvjM6H2nnH4p1yMroufFkbJ0FfZLyIVU25iQWwAswy89zPQQRR0NDX
         76RJwK/QajojFTn8eOddElzoEUqHGo05MlWhxF9dQp8TSToPqUo4qhT9FEim+ESW/37T
         Aewhn7q+KXA1GKtrmWcfYghEs7izvcvHOYkavVlPx4WZCLnOL32zfcn8PF3w7m61LFC/
         4klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=szzTHJd6sqRvu0qG5IShlxbRdUP7g1k3ZqXUc4Z/QWk=;
        b=ZqDdbrBgkCwbROjT9zVvXE/gOF57ViHQkiEULBllExvo4tgVfaC9vRVB4Eb8x+ER7H
         84+qd6ZEKBmdbPJ8nE7vUa8BICanTGaY+3shCnQL4kAwKf0MNwVzscdNn3vR6rq+gpbd
         gRqpOqMuh0KixX7jsDLL75KLAzwPaJDIPBtFosVfNpNchrIlF88+xNFV3qG6nj8O4UWO
         06s+DOfMowYXiDNSMFktdWj4/g61Udi+4Kys8O/+h0ohBG7Z8eAfu7stnQRzQHQea67M
         kQkVF4qJm+cglIBYySicIeF1Ku87FjpTLPbi/2Rl2HeklLQkF4Wt3hrxtYpEqH0Kwu5K
         wJRw==
X-Gm-Message-State: AOAM532vs8L/QDOznQh+aGCIyz2tIXZF0e7ohcZUVHKCt90zL21eqxzc
        SNouUKm6+HhKBmi2s6+XODT9cdu2+B5inr62iH1o3+2iq3IARcj2NNyONSC1/bxzRDIJI4HzP/K
        DjkqIk6/QW0qqYGk6d3hggu9/5s+6v5u6I9bUuex45B3wrbBIvIiNVz0ZOIIe/c0aHcyHxFxslQ
        ==
X-Google-Smtp-Source: ABdhPJwJkx0NLueH7AVdVA53FhCFPyo6gp6arsOvuY9HpoN/hivesYIcKI8PvwKbIPpv5jiDDvM6jTDyb5OPVB1OOag=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:b59e:: with SMTP id
 g30mr19864459qve.30.1608595490098; Mon, 21 Dec 2020 16:04:50 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:22 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 04/17] gc: use hook library for pre-auto-gc hook
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the hook.h library instead of the run-command.h library to run
pre-auto-gc means that those hooks can be set up in config files, as
well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt | 2 ++
 builtin/gc.c               | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index f6ddf1aa22..d74308dc20 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -553,6 +553,8 @@ This hook is invoked by `git gc --auto` (see linkgit:git-gc[1]). It
 takes no parameter, and exiting with non-zero status from this script
 causes the `git gc --auto` to abort.
 
+Hooks run during 'pre-auto-gc' will be run in parallel by default.
+
 post-rewrite
 ~~~~~~~~~~~~
 
diff --git a/builtin/gc.c b/builtin/gc.c
index b57fda4924..edcc873c70 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -340,6 +341,7 @@ static void add_repack_incremental_option(void)
 
 static int need_to_gc(void)
 {
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_ASYNC;
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
@@ -386,7 +388,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks("pre-auto-gc", &hook_opt))
 		return 0;
 	return 1;
 }
-- 
2.28.0.rc0.142.g3c755180ce-goog

