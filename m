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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9463C433E9
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73F622AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgLVAGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVAGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:06:37 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D16C0611CD
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:03 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t16so9293595qvk.13
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CVbnpWOwK+ivPuNaZHaYPy5vxV5u/BNDRDW9Ol7Q52s=;
        b=qNlfx5p6Nh2uHYdR+c9wiMQAj7kTH1h2mlE52opYmthPfeW6wRqMkWO9DQ4LchX05Q
         0RoDNTa7+daLuoEQbcmLbsZTuRbgME1UbedbmGZY6glrsVL1gSetbwBGEX2ebp9yd2O/
         Z19UlN14E7vZJy7WdLZ9+bZlciLSXjAVI+ocYa+KsgNnGkdoUIiMIacyI/N5uqvYrKRx
         IoHxnK6s2Mti/SNGHwPo5EtI4473O9wEjE76U4aaejMoixCO+PEL/IcduD7gcMbPSbZ2
         OwcO6EO7r+IPUBDnYPhpU/6QxwDuFraDjMq8J/TK+t3DMTGxdKL4aZxzIs6bjV3CLG4N
         yXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CVbnpWOwK+ivPuNaZHaYPy5vxV5u/BNDRDW9Ol7Q52s=;
        b=CqnGu+LR70BJiGv3U8oxNLSGmM6bl8CQi+5jTp/HkWc0b8b2zx7lDda7H1iENXB+4A
         vi68HZWVtH2fgP6Qzea72fou5jo6DNc4aqFuXypGTMD3IIsmz7cTR/012rmppGo613wO
         C9/o+QBdKswZxs744io9svhQLYz30HqBKcF93vfICYCsJUF/Bn7NjfF6ktth+be0YOzn
         Osu3lW9Z/0Yc5nXQvKlsbXDygkkjmxTLBh/rRq4pYAtehJezkvk8xHrxKY+X4jySlkwN
         Zdy1oanJ1yWW8nWnT68eARpxJzDQP/pSrfUlJbYfJdjIV76l/pnOCowYxMtgqawWYvUS
         xdLw==
X-Gm-Message-State: AOAM530be079buVbTAQVeo0BeMiKvwz/WgyzY7vEa2jc17K+DySEYA92
        jvc9/18r0twv6xbCw4Mp0T3R5ia1kRiu0T8qIBwva2JuLcn6qghJc0XY3NWfngu7/MAozjJ3ZHe
        ZRqNXlFUEVnFXIg4Nv4bj3s5PXq/lyOFe2DOAdxbbVxAIIyfy5DY6n+0nxFBwktZ4HAP4bI9Yig
        ==
X-Google-Smtp-Source: ABdhPJyo2G0eFKolNZQCahm25P53lJ83aVw74CabZtMPsn16xlVHNURsPieAaXf334DoXDKsF0rZ0QjHDHBllW5ZJ3c=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:d4a:: with SMTP id
 10mr19507745qvr.62.1608595502933; Mon, 21 Dec 2020 16:05:02 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:29 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 11/17] transport: convert pre-push hook to use config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using the hook.h:run_hooks API, pre-push hooks can be specified in
the config as well as in the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  2 ++
 transport.c                | 55 +++++++++-----------------------------
 2 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index db290984f6..8f5524055b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -271,6 +271,8 @@ If this hook exits with a non-zero status, `git push` will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
 
+Hooks executed during 'pre-push' will run in parallel by default.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
diff --git a/transport.c b/transport.c
index 679a35e7c1..58fee65815 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "hook.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -1172,31 +1173,13 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
-	int ret = 0, x;
+	int ret = 0;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
+	struct strbuf tmp = STRBUF_INIT;
 	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf;
-	const char *argv[4];
-
-	if (!(argv[0] = find_hook("pre-push")))
-		return 0;
-
-	argv[1] = transport->remote->name;
-	argv[2] = transport->url;
-	argv[3] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.trace2_hook_name = "pre-push";
-
-	if (start_command(&proc)) {
-		finish_command(&proc);
-		return -1;
-	}
 
-	sigchain_push(SIGPIPE, SIG_IGN);
-
-	strbuf_init(&buf, 256);
+	strvec_push(&opt.args, transport->remote->name);
+	strvec_push(&opt.args, transport->url);
 
 	for (r = remote_refs; r; r = r->next) {
 		if (!r->peer_ref) continue;
@@ -1205,30 +1188,16 @@ static int run_pre_push_hook(struct transport *transport,
 		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
+		strbuf_reset(&tmp);
+		strbuf_addf(&tmp, "%s %s %s %s",
 			 r->peer_ref->name, oid_to_hex(&r->new_oid),
 			 r->name, oid_to_hex(&r->old_oid));
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			/* We do not mind if a hook does not read all refs. */
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		string_list_append(&opt.str_stdin, tmp.buf);
 	}
 
-	strbuf_release(&buf);
-
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
-
-	sigchain_pop(SIGPIPE);
-
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	ret = run_hooks("pre-push", &opt);
+	run_hooks_opt_clear(&opt);
+	strbuf_release(&tmp);
 
 	return ret;
 }
-- 
2.28.0.rc0.142.g3c755180ce-goog

