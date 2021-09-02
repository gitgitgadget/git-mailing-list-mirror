Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022DEC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1374610A0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbhIBNN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhIBNNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FE5C0611FB
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1419599wmb.2
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQ0UavLqYGrpqz8s1YOftq10mN8wCzrE0MmrJsADMCo=;
        b=nXnBPZmZu+f6BFWiOV0q7TNY0zl1bNUHDfXcn3byIcB+enVeftqV9yBtbU1zfunNs+
         /Rw9ORgA8+rZruj9V3n3n4cvEjyQMlXcneLhd+yHPBQviEq/PSAMme8q8tItsfrVSsx+
         NubFQp7YUj5qpRk3E+ZuYe8Qu4Wwzd1KNScsJGvMDIU25dhmYYq/Ld5tn2wLxqmJ5MSf
         mJcntIM4X1nA6owDY8WRzc9JWpyUyL9tTz4iwaRAWWD/18rs28klreimSe5K0piyqtK5
         bIl+EQsMBDPzoold3eqPypP2DnG2FQQy2NBagXNeNm7rfvfRz4AelKzcaXvetUU1P5Ja
         V2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQ0UavLqYGrpqz8s1YOftq10mN8wCzrE0MmrJsADMCo=;
        b=Gt7Wb6bwHNuIyj8rfolBIz5kW34nE2Qf2TWATvGgsDGTnwp3BqsaIr6IOS2cH1SgUq
         Y2bMtxhRoCuyW4BKxlu+VLDH2GJxJ0OdYeA/lWwaGHvCqTSVjOtFzE2kPJMHmC2wyFFA
         q8whzP8JufUJV/C/KI+U3BqRtzcmbeO97mAjWJwwmy9AsPShQ/xRzgii1b4r5vO2K26S
         9iyzyCxSmY4haM57wIMPBRAnVxpnY4lrkuGiX1qkZ/durKWtAvLy4nehDOG+aYNcHx+H
         GPY5Zsw9MTlY2CcvDndfe5FNxmPttTbCHx10XaDzLBiAwtuQZAZNPoatPYu+7BsDrLv1
         MxGQ==
X-Gm-Message-State: AOAM5315vk2+gZzCoOqtgYHOM4HBBN+ETnYKffQCjvbdkXul57Q8YMs2
        s/S30hCBLuXZdLFqObEiw1TmkEG3Tf4wdw==
X-Google-Smtp-Source: ABdhPJw62rGJt65K5J3aowyDo7H9pK9wn4GKro4I9p8cEcyHLI5v6Kt2e+euS2v2GMsd57BMWOtxBw==
X-Received: by 2002:a05:600c:5102:: with SMTP id o2mr3033827wms.104.1630588331664;
        Thu, 02 Sep 2021 06:12:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:11 -0700 (PDT)
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
Subject: [PATCH v5 26/36] hook: convert 'post-rewrite' hook in sequencer.c to hook.h
Date:   Thu,  2 Sep 2021 15:11:26 +0200
Message-Id: <patch-v5-26.36-48a380b3a91-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
 sequencer.c | 79 ++++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 47 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8999edf8d7b..549b583b277 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "string-list.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -1147,33 +1148,27 @@ int update_head_with_reflog(const struct commit *old_head,
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
+	code = run_hooks_oneshot("post-rewrite", &opt);
+
+	strbuf_release(&tmp);
+	string_list_clear(&to_stdin, 0);
+	return code;
 }
 
 void commit_post_rewrite(struct repository *r,
@@ -4526,30 +4521,20 @@ static int pick_commits(struct repository *r,
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
+			run_hooks_oneshot("post-rewrite", &hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
 
-- 
2.33.0.816.g1ba32acadee

