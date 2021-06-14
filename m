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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28BDC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4EA6141B
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhFNKkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:40:22 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:46754 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbhFNKhK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:10 -0400
Received: by mail-wm1-f46.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so12473092wmq.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LESMR97jcTsx8/DDjybCC6129jMzHgP48FHyDQmD1QE=;
        b=QvsE6ds/LQlewS6EOQKD1SdIiTdqafzwrAD0ja05ly1a4LTrFiNQUMZN8Xxn9Ga/VE
         2oDODJVGh8lnC/hdUR2UarlsbMyg6MS/zSoejCdvjyBs6D+K+TFcCYVubLxV7mB4KxSI
         GmoYpaT0AmyXwlVCvnXtA0mJJjLlJ4/TUtlL2ITcRnpUHrmFhjMMHGZKxp06DFsYcy3O
         F0sRm+wGnbThpfzwvPFu4mBRZmv8oZoqpbeilujMr1bzGR2UdSeM45IvCObMayrq86b3
         fMdT4C1vM4oKyIOBLF4sLzvJDZJLfwhwy1CyrqPeVfRvwXD46IQ33LDCcw1aOYl21po1
         g7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LESMR97jcTsx8/DDjybCC6129jMzHgP48FHyDQmD1QE=;
        b=BM4AH/n8j2yc3rY0d90z4Y7anAwF61+k2Wi/+6ZAqTi1Qs7BloNjsMr5MVN1KKnHAY
         HDQFmjcpzDmc5uzkSmgejRJq+pnS7lkP83UySAIT0Dm8HkfKA4fMwQHdxOXiYOAW8eIl
         yPgPC8toOtoiBMEECySvEhmKs69GHH7O6S69TwTvuTHum6Xol/QE0Jav9EMTLpxG5dpR
         A3HF1/qRF3HGBaVASimKaTRobhtmMxcFjeOQLlwSSOuZTstnnZZ7ZntDxN/TAIqgJNIG
         xqPn1uTZLp89zHUVUiSj8Yi9Ix8XxU5cPK6Yg8TZO8v3ZJz0edlaISxzxAjdar5Vfbui
         YmBA==
X-Gm-Message-State: AOAM530XlA3AaahfmEMSwAWXOYmpl85UDx1a/f9GJwy/FlB1ee0qlAEe
        KBpjIQ/KTWyYC59bNdWCMWIlzLHPKwFUSA==
X-Google-Smtp-Source: ABdhPJyTxllVJdS3d8w8/n2DzwXaEt0hL1xSsoyvo5Ar8KCCYr8P3jSURw3HxREgf85aXO9RrsXGug==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr31702919wmj.25.1623666847123;
        Mon, 14 Jun 2021 03:34:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:34:06 -0700 (PDT)
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
Subject: [PATCH v2 26/30] receive-pack: convert 'update' hook to hook.h
Date:   Mon, 14 Jun 2021 12:33:15 +0200
Message-Id: <patch-26.30-e11a8f60071-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

This makes use of the new sideband API in hook.h added in the
preceding commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 65 ++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5248228ebfe..378f8f6b5d1 100644
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
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
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
-- 
2.32.0.rc3.434.gd8aed1f08a7

