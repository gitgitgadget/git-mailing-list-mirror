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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A704EC49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9374E61057
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhFQK0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhFQKZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48775C0611F9
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb32so794785ejc.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8NsYz3rSr29PAhRjRC2o3IiZMJtHxbwQP29AB1FPMQ=;
        b=oyHcvrxdGFDPKPz21VOOSICvOcFyntVeiDKH4kOBXB6uNhsGHJ3V+LEmdkKH/HNzv4
         JIlKHZLqFNl/rhgTdIr4O4ISvpN+x1qh+FybcaCHl2YWMRgRySZ14/CMxOZS3qF7VkOF
         fcg8Wcvh8LQisyYhDZ0L2NxTvFKCMmnMXJJ0PLyR0/yYrLW7l5dc7uIzeyUY4CXXyW1B
         e55gPNvEbvWOH8OKHmjhxAZG0tJturs0GChjfESSIE0Ly446rm/UL9Bwaa/N4cnVO1Y3
         LnMNWrle5cwxTjh4H69LUDdcTEqZs1aJDlsNVf+ea99qnJ2tfjdaR8GACtgg78ww6iRP
         k9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8NsYz3rSr29PAhRjRC2o3IiZMJtHxbwQP29AB1FPMQ=;
        b=ouSL5/diojqD3hKxygIalmCJ9NBENECcAFzIp1yzlWHsbYPOxYUWGnUzieXYN8Sk2k
         VMhL+jdGgl/DSn6KO+VfKeCu3L/z7RBSWjnqsQ1e6PCJYRBtl6iFqpSz4uG7a7fBo2/n
         EJKdOzciPNr76pchH6OQfGhbPl3G01DTPlPfS6GpoCpG/pNsI4fjzhmG+D7/BkPhngpU
         9SyBa0HFxZ3QXCbki2H811I76fvCRY3MNBbBVuNiwv/hdhuUH22VLG5c3143eKmGklXF
         JjD3xllelEmJnt4iSTwx102Ac41R4M6uajiwU7/yD2t2BkGLfAT3yMbQcLoY+F5h1VtD
         uypA==
X-Gm-Message-State: AOAM531y4sdLW9Rr14iOCreKPejHm78TxMWbPVKmwAOYoD+UVFO7a06X
        /RMCJOir8ptAIASKtDEVEMXTz0ukoZpwHQ==
X-Google-Smtp-Source: ABdhPJwm/WL3t9rbJqVkzT2Ei1OxrVmMRfg8jnR6asd6jbhn7mAPTPMwOyB9ACiIJM9PZzSfovYb/A==
X-Received: by 2002:a17:907:6f2:: with SMTP id yh18mr4439241ejb.5.1623925406607;
        Thu, 17 Jun 2021 03:23:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:26 -0700 (PDT)
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
Subject: [PATCH 21/27] reference-transaction: use hook.h to run hooks
Date:   Thu, 17 Jun 2021 12:22:55 +0200
Message-Id: <patch-21.27-331014bad1-20210617T101217Z-avarab@gmail.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 59be29cf08..1149e7e7dc 100644
--- a/refs.c
+++ b/refs.c
@@ -2062,47 +2062,35 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *hook;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 	int ret = 0, i;
+	char o[GIT_MAX_HEXSZ + 1], n[GIT_MAX_HEXSZ + 1];
 
-	hook = find_hook("reference-transaction");
-	if (!hook)
+	if (!hook_exists("reference-transaction"))
 		return ret;
 
-	strvec_pushl(&proc.args, hook, state, NULL);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "reference-transaction";
-
-	ret = start_command(&proc);
-	if (ret)
-		return ret;
-
-	sigchain_push(SIGPIPE, SIG_IGN);
+	strvec_push(&opt.args, state);
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		oid_to_hex_r(o, &update->old_oid);
+		oid_to_hex_r(n, &update->new_oid);
 
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		strbuf_addf(&buf, "%s %s %s", o, n, update->refname);
+		string_list_append(&to_stdin, buf.buf);
 	}
 
-	close(proc.in);
-	sigchain_pop(SIGPIPE);
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
+
+	ret = run_hooks("reference-transaction", &opt);
+	run_hooks_opt_clear(&opt);
 	strbuf_release(&buf);
+	string_list_clear(&to_stdin, 0);
 
-	ret |= finish_command(&proc);
 	return ret;
 }
 
-- 
2.32.0.576.g59759b6ca7d

