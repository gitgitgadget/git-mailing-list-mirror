Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ABFC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFC661263
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhFQK0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhFQKZl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6596EC0611C6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r7so3217781edv.12
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KbqqglF5L+7KCmYzQq1fd+B0jm+IIL9LVoFGfz/8fc=;
        b=LI1ZfT6452wS4raDBRJaZ61QhUqgsSdldHOIisKVUz1HyAf6iH25g/F1OTu65BoJrR
         +fF4VTrITz+vHjfJnfI4sgDbujX4UE/bBiSZ42yGjTeEWo0ICOJparVS2sg0zHYpuHtL
         tVEQPK42zjsUI/j9edadUeynMupu62IyjmtWpmMW/+BuTZQ5E93Rie0/Hxg6XgiTKI11
         4mihRhwNf5/4s1UDMyE3IxpJvcx7vESC9qmZXgTxUsn5gZDen87PXxw97sgPb9gbEufD
         rH3DFjhmWDPfrh8SrNnyBiEF4sg2XmBZ38SbzS5EaBRTYOQiaHtJOXdvxSqh4pGrFk/9
         aA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KbqqglF5L+7KCmYzQq1fd+B0jm+IIL9LVoFGfz/8fc=;
        b=PpMrOkBSOxP+b5xN10724eaEU9BDIJlMvSBBiKfPNITq4Pq/fEUU7u10Cu06dn3Rt1
         8pnSyq5LY2f4be4Tt633NuU3X+LbWMaSeVoeyNwRjLLrdiN6WYyEiutIJcAShq1VFoK4
         dj860Z/yAflHiQnh73hhYPKf1+d700BNmN6w6rJixYqZxy9l0qQ2ff5ssK4IntRmP+5Y
         hYtRqZmi0Ym61UaC2FIiQkbSLEmeY2kstz2CCnJEj/wqcE5kmhR9UrKFpH8cH5Ya+9wU
         T6m1n2Hgfag4zEA4Sc+CkmAsNtZ/aCNgJjerL7Y0J4LG7+boqXXZzjRFUmAZxO4MvD5P
         STHw==
X-Gm-Message-State: AOAM533e4nTYZM8yhrBopOvzqHTVoDI16viPnMbkE2KVmEr0lQtQpDqf
        qUdOhDgjwlmicOEbPsqULzZ7rnJlTnfWmQ==
X-Google-Smtp-Source: ABdhPJy5sUT+5U/Z/32ns4myuTNiw6DcC0edYU6yEc5vIQ6cFaMfzQbbh2dhzplUqEQnktFoVu+ehw==
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr3874997edu.51.1623925404819;
        Thu, 17 Jun 2021 03:23:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/27] hook: convert 'post-rewrite' hook in sequencer.c to hook.h
Date:   Thu, 17 Jun 2021 12:22:53 +0200
Message-Id: <patch-19.27-7343be28ef-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

By using 'hook.h' for 'post-rewrite', we simplify hook invocations by
not needing to put together our own 'struct child_process'.

The signal handling that's being removed by this commit now takes
place in run-command.h:run_processes_parallel(), so it is OK to remove
them here.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 81 ++++++++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8f46984ffb..ec2761e47d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "string-list.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -1147,33 +1148,28 @@ int update_head_with_reflog(const struct commit *old_head,
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *argv[3];
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct strbuf tmp = STRBUF_INIT;
+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 	int code;
-	struct strbuf sb = STRBUF_INIT;
 
-	argv[0] = find_hook("post-rewrite");
-	if (!argv[0])
-		return 0;
+	strvec_push(&opt.args, "amend");
 
-	argv[1] = "amend";
-	argv[2] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "post-rewrite";
-
-	code = start_command(&proc);
-	if (code)
-		return code;
-	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
-	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, sb.buf, sb.len);
-	close(proc.in);
-	strbuf_release(&sb);
-	sigchain_pop(SIGPIPE);
-	return finish_command(&proc);
+	strbuf_addf(&tmp,
+		    "%s %s",
+		    oid_to_hex(oldoid),
+		    oid_to_hex(newoid));
+	string_list_append(&to_stdin, tmp.buf);
+
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
+
+	code = run_hooks("post-rewrite", &opt);
+
+	run_hooks_opt_clear(&opt);
+	strbuf_release(&tmp);
+	string_list_clear(&to_stdin, 0);
+	return code;
 }
 
 void commit_post_rewrite(struct repository *r,
@@ -4527,30 +4523,21 @@ static int pick_commits(struct repository *r,
 		flush_rewritten_pending();
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
-			struct child_process child = CHILD_PROCESS_INIT;
-			const char *post_rewrite_hook =
-				find_hook("post-rewrite");
-
-			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
-			child.git_cmd = 1;
-			strvec_push(&child.args, "notes");
-			strvec_push(&child.args, "copy");
-			strvec_push(&child.args, "--for-rewrite=rebase");
+			struct child_process notes_cp = CHILD_PROCESS_INIT;
+			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+
+			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
+			notes_cp.git_cmd = 1;
+			strvec_push(&notes_cp.args, "notes");
+			strvec_push(&notes_cp.args, "copy");
+			strvec_push(&notes_cp.args, "--for-rewrite=rebase");
 			/* we don't care if this copying failed */
-			run_command(&child);
-
-			if (post_rewrite_hook) {
-				struct child_process hook = CHILD_PROCESS_INIT;
-
-				hook.in = open(rebase_path_rewritten_list(),
-					O_RDONLY);
-				hook.stdout_to_stderr = 1;
-				hook.trace2_hook_name = "post-rewrite";
-				strvec_push(&hook.args, post_rewrite_hook);
-				strvec_push(&hook.args, "rebase");
-				/* we don't care if this hook failed */
-				run_command(&hook);
-			}
+			run_command(&notes_cp);
+
+			hook_opt.path_to_stdin = rebase_path_rewritten_list();
+			strvec_push(&hook_opt.args, "rebase");
+			run_hooks("post-rewrite", &hook_opt);
+			run_hooks_opt_clear(&hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
 
-- 
2.32.0.576.g59759b6ca7d

