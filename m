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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAA8C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462E722DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbgLEBu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgLEBu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:50:57 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77C3C061A54
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:49:58 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s9so7071054qks.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MhrNwqVyKYFixrNJm9hDFpWMUz/77TSmZOCW/lmC/y4=;
        b=RpwUq2rNwInWQCBt+OtwoeVRO8oSKgsKkJCQSysnUVw1rUcVj2vwSnz2ENMS6SA0wz
         bDrXGyVyXc3lsALNhSdPKzX/4lQjxEG5QEwFz/kNpJ+HwebMMTSH0kjcg8DC9usgjN0X
         AooKCLLcPjLXlprsB2wYM0nSgkXuSm5pFyG1XQITRjJz1/FPI3bG3WXxE/WeXQrhcK0S
         zmcU9pD7JKp+KdO1oQ/gsMVe0zdPIuAiyuw9NPmUhQfT9uaMzDNiQkkfFxTHnhczOQJi
         Dl2wHoIopHIkDTJjUm2+vnkNFFEUDpE+QQ/MdMQ2LvUAdFJfZBhA6LvvOIbx/Nu3FSHN
         6wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MhrNwqVyKYFixrNJm9hDFpWMUz/77TSmZOCW/lmC/y4=;
        b=WAex9L4ws79qsTUY4iP+ltGZ1uiJGrT1tkvLFsmaLp236KknOpVVT+HALAdhgOLs8b
         0g8UaL9X+57UmY/AZJz8mybQSmzXQlyEhW9qr05UrcZY07bsR1cFhtn6boGWT8fPYfhC
         SkeeC7t/CSvElLOTgTlZaBSWkcBIrkp4OTb6DWhQ4axxVTeAdAF+2IXSDHIfmI90M4o9
         6yE9lo1CPcy5isj/g13fIDsuQC4Z89u7K2/wxGRAqgIdTvRs9g5f1LIqoknu14TLRw76
         mx9vz/9VKJ9NP0sRaFLPozLY9ijx+REPjZqGQJY5DKBRGDa0lDLTiMocYV460tODgZJX
         znXA==
X-Gm-Message-State: AOAM53229//gPODutj49xdH0uAznWeoSzpAVONZ8UHdlzUxv9j92Hjkt
        wrs6eWbC+yuXHwRowZkIG1srH+ONKoY3lEzZSzNDOTpZbyfZjeX2o3OvYXlcVcHuDGf8u7LK5//
        wd68bEKaMKNYRZdVuTrr6zOsONJ3uAKC2zCTxOWYBACs3j8CvgBsoPAe6Y1vdmElMr1lwakWJfg
        ==
X-Google-Smtp-Source: ABdhPJys/fZzqWqR/qDNBNfezv0F3v+4ZV/OCpExo2Ny4ELldnKCY/6m518EAU30nE5jow/1h+6+cpgXBCLHMKc+h7s=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:a69:: with SMTP id
 ef9mr9265847qvb.50.1607132997934; Fri, 04 Dec 2020 17:49:57 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:32 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 04/17] gc: use hook library for pre-auto-gc hook
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
index 3e8d76fd5a..b01b6eb5fd 100644
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

