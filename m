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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436E7C43333
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295B822B43
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgLVAGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgLVAGM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:06:12 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0815C0611CF
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:07 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id b11so9162697qtj.11
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iDqJWsAPBG3G1J20vMEo0a/NxzvZWVs472i9yb8IPXA=;
        b=IbCUee66QH6JP09LlerCOebl26j9eTk+FPxlsSqgJ5FwobCx3xWXQWl9zc32DuF3Ah
         6HdWY/UmQL1w86wp/s+CnP6E8mzXcdbydGAQcrwm+2xeMS/ZdTa2c4xyZYBDevoLldMI
         KnJlsmzaGKUwv+me7heEBrBBH1fkUc5Lk6d39R24f+Q3eEEEilOojpf7xTS0iZ16ZSoj
         Dy4FlmukD8k9VT7Sx+EUX19gihv5YAGaDZzilj0ySM3LmSCEU5ND86JsVCXRJSMYovFb
         JwfS2R6fbkQRnaaNO2ImuqmRElR3NktLYQkkDSZEDIcK8/wdyyswiKYUaPbqyusF+KQi
         fwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iDqJWsAPBG3G1J20vMEo0a/NxzvZWVs472i9yb8IPXA=;
        b=UliQwwCIjwToQ6NajVmyJXUOIMcujce8W1eIDUhC//boCpqqFvCJDB53arwhBQx/Tn
         +FTMx71zzKL7QEKbsbHt6J7I9E6/BVfy/e08o0uf3S4HV3Ggj4RQjWz2b9t1JaBaCUKr
         M6GmhL7Z8tMLFDfoJl5d8JuU1cyryNfW8JmODwMYmX0W9t4SmfoEKl7GS+lX+crn/sPP
         ILPaCgcUh1leR9eXEL1fKgo9dBujID93qfWF7FwImh1kKE5EDEx5AU6dZiTOHTlDTNiX
         Owu2YWikpPO7XB2ItPvZNUkT7j0GhwnkYZfhMWN9kIWUqpa7mymN6reak+nj+u67lxFN
         1SEw==
X-Gm-Message-State: AOAM5312TNw3Duh0rw93rW/Pj6MoAzNuIekIi1S05Jo4iWWVoKXJ3Bsh
        wn4lefam28Q7vbbaEWLgY1QzMVDhymgjyW9bf/9JtqbAr5tpmVe0SD9X7JeLFprpxq8ooKB+P+8
        WOo+mauC0Wq6ZjopK/lZFtSsXUZ1P5CToBByiBM3gNMOxL4WkEZriBzjXglbfkj9/7RlIZwIJWg
        ==
X-Google-Smtp-Source: ABdhPJzaHIaD4Ut5WPEUPRHThmYsK5zdhZxLtuTY2mX3WqlLtgnzsIJn6eYK3wNiE00S4gf8gnH6FuKzkDhphob60O8=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:124d:: with SMTP id
 q13mr19673177qvv.52.1608595506839; Mon, 21 Dec 2020 16:05:06 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:31 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 13/17] receive-pack: convert 'update' hook to hook.h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using hook.h to invoke the 'update' hook, now hooks can be specified
in the config in addition to the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt       |  2 +
 builtin/receive-pack.c           | 65 +++++++++++++++++++++-----------
 t/t1416-ref-transaction-hooks.sh |  4 +-
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3a35500132..2b3a74f249 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -359,6 +359,8 @@ The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
 
+Hooks executed during 'update' are run in parallel by default.
+
 [[proc-receive]]
 proc-receive
 ~~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1c0bad0448..57f3bb979c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -938,33 +938,56 @@ static int run_receive_hook(struct command *commands,
 	return status;
 }
 
-static int run_update_hook(struct command *cmd)
+static void hook_output_to_sideband(struct strbuf *output, void *cb_data)
 {
-	const char *argv[5];
-	struct child_process proc = CHILD_PROCESS_INIT;
-	int code;
+	int keepalive_active = 0;
 
-	argv[0] = find_hook("update");
-	if (!argv[0])
-		return 0;
+	if (keepalive_in_sec <= 0)
+		use_keepalive = KEEPALIVE_NEVER;
+	if (use_keepalive == KEEPALIVE_ALWAYS)
+		keepalive_active = 1;
 
-	argv[1] = cmd->ref_name;
-	argv[2] = oid_to_hex(&cmd->old_oid);
-	argv[3] = oid_to_hex(&cmd->new_oid);
-	argv[4] = NULL;
+	/* send a keepalive if there is no data to write */
+	if (keepalive_active && !output->len) {
+		static const char buf[] = "0005\1";
+		write_or_die(1, buf, sizeof(buf) - 1);
+		return;
+	}
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.argv = argv;
-	proc.trace2_hook_name = "update";
+	if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
+		const char *first_null = memchr(output->buf, '\0', output->len);
+		if (first_null) {
+			/* The null bit is excluded. */
+			size_t before_null = first_null - output->buf;
+			size_t after_null = output->len - (before_null + 1);
+			keepalive_active = 1;
+			send_sideband(1, 2, output->buf, before_null, use_sideband);
+			send_sideband(1, 2, first_null + 1, after_null, use_sideband);
+
+			return;
+		}
+	}
+
+	send_sideband(1, 2, output->buf, output->len, use_sideband);
+}
+
+static int run_update_hook(struct command *cmd)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
+	int code;
+
+	strvec_pushl(&opt.args,
+		     cmd->ref_name,
+		     oid_to_hex(&cmd->old_oid),
+		     oid_to_hex(&cmd->new_oid),
+		     NULL);
 
-	code = start_command(&proc);
-	if (code)
-		return code;
 	if (use_sideband)
-		copy_to_sideband(proc.err, -1, NULL);
-	return finish_command(&proc);
+		opt.consume_sideband = hook_output_to_sideband;
+
+	code = run_hooks("update", &opt);
+	run_hooks_opt_clear(&opt);
+	return code;
 }
 
 static struct command *find_command_by_refname(struct command *list,
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 17f11f5cb0..28359f6099 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -121,10 +121,10 @@ test_expect_success 'interleaving hook calls succeed' '
 	EOF
 
 	cat >expect <<-EOF &&
-		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
+		$(pwd)/target-repo.git/hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
 		$(pwd)/target-repo.git/hooks/reference-transaction prepared
 		$(pwd)/target-repo.git/hooks/reference-transaction committed
-		hooks/update refs/tags/POST $ZERO_OID $POST_OID
+		$(pwd)/target-repo.git/hooks/update refs/tags/POST $ZERO_OID $POST_OID
 		$(pwd)/target-repo.git/hooks/reference-transaction prepared
 		$(pwd)/target-repo.git/hooks/reference-transaction committed
 	EOF
-- 
2.28.0.rc0.142.g3c755180ce-goog

