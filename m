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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B2CC49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4367D61245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhFQK0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhFQKZq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484FC0611BD
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i13so3242146edb.9
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XGkB4nZ+AQpvz3PnGx+LTGeUuRHYf+xnAxUcuc5hFM=;
        b=IKKPVSSkkG7z6H7o7x7JNIlAcHcvscX/YZ2zKH6jCE7AcAlLibauJj5nHGIqrdbgCf
         lQ59+MSszXJ7tfHCBOFE82dxeLJaOo2p0QX1ocTVlqg5EjQqPCjqCTsaZmunv2zqI12K
         OeBCvsYuayZsR9tTCpgkzbIipcS/3GYBKR5dpFxIcoLz0+R3vV1lm9zyvK4pxg7g2UmD
         Z8LlgSsEcAV7mKzuWgmKdyCmCBJV7z200PTPtU62MBkSffH8bfTymTjRNogL1U66ev93
         gPHcSGeeLtUerS2EyXd5i4t4dvxboT4NzEZ+kpS/P95FM7u+DKuHi1sISN/df3B24fyK
         Nsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XGkB4nZ+AQpvz3PnGx+LTGeUuRHYf+xnAxUcuc5hFM=;
        b=AqIY44PTevNrj4HFud0jEnTueURXxNX2m3evEWK7QPR6Tp7D212tX5/I88ueIeI5Ru
         Cwu6bUHfph8adWmJ6fEfqwekJx6FZgcVq5Zo5X271GotM3zvt3IBicklAwS6ZuSJ+guT
         OMdVOlD8Bb5MInxBgBmlVf/TrckwmR6TveVPF6DRM6v3q8Tw0xgMOEEN4K5CVyHdRHiT
         xaVMyGThTolV2RwXNBixDUyqFYJ7S5uYlLz0DLyaDMwE9O24gZyNpl1DdQ0NCzCHnuTJ
         ylaBSV5WUv4JphvwukyzqHunU/CeHa8dpieNGc6REQiguWfRRlC/2S+BauduM+SkcQhv
         DR8Q==
X-Gm-Message-State: AOAM532flShdQaZmrTIss1alVyVESZ/5v2hlEtzy2jNFMNoA1TIy2C/o
        om+6rUYM4W9EArso3RMtTRN4oM0U1eBt+A==
X-Google-Smtp-Source: ABdhPJyyMBzeM4I5f+EGCCN0wRMaWslOQ6PCDdag5089OAr6VFpVRL6qmNL3k+WAbTPJLLCyNoKmnw==
X-Received: by 2002:aa7:d713:: with SMTP id t19mr5382333edq.144.1623925409592;
        Thu, 17 Jun 2021 03:23:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:29 -0700 (PDT)
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
Subject: [PATCH 24/27] receive-pack: convert 'update' hook to hook.h
Date:   Thu, 17 Jun 2021 12:22:58 +0200
Message-Id: <patch-24.27-e74d49e559-20210617T101217Z-avarab@gmail.com>
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

This makes use of the new sideband API in hook.h added in the
preceding commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 65 ++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5248228ebf..378f8f6b5d 100644
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
2.32.0.576.g59759b6ca7d

