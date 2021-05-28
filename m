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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D3C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610E9611C9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhE1MPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbhE1MOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:14:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6BAC061355
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x7so3048606wrt.12
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGU5/c5lmdTaH+JpCf05jhjFfxBSuPGEgD/+rQmcssc=;
        b=Q9CaDNnUfg8a+F1SdddtaT2D1n5wGcFUIgv/FpXxQ7Ln9sKGKqoCKPWc8/soa8KuML
         UlTW2V8zZtIjbJenuZ9LjKnC3uYpwZ/Dmaxk8cryrBETlCBB37G5PL3KwRCh2QEfn+JS
         8NvbXq9ZgP5K1SWzU9tZSxdEOCquE6o+3xahkMCQZrD0jrc4DNJBLi0P4dwdoJLIJmH0
         5UgdQE4EXZ4s6rU9Ekgw8gD3EepwdI+kX3owbE+kfC9LaBBcrE/CiGW+H/YeiODBZuML
         /2YrplKeqcmHJDEi7Oz/KkuvjGktcBe14b5x4G8bVE1f2nvNXntzRoE+kiR7Mvp8CeOa
         uvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGU5/c5lmdTaH+JpCf05jhjFfxBSuPGEgD/+rQmcssc=;
        b=q8vAPa+Ihbi7GADHt3vxFZOSe/+5S70Ilj7q4TP1iz+CBU+Ck6cF1H/kaPuwtorcml
         NWZuj37MN+LDXPRPbApVGPMKtmyj+8Ou+4aSA9eUMH4jub6vEg6To3MIH92kvVkOBSs2
         D9zSikbP7xZFPcZwKXzf3I1YpJlVeeZduSn7wmBiEZ70/mcBFRAFKde7AEifiQSz0347
         MXYD+d0//4EDJeZFhL69tp31YjdTwD3X8kNNNUUlY9AYNDn13B1M6PKAcumLPDvAwjM7
         B2PGfyCdS8gZ7VHKMHzbhAPLFI3otI6cRhXoT43ftLZLEYbdxnvlPMuzIHElC81W5/K3
         MSUg==
X-Gm-Message-State: AOAM533dlzkdP5sBBTQWzbN1k1Wbx2d+2czSJFKUhtOPiOFzeg7KGMVx
        JXOs5JhPkne/8/3ceYxhlUjOdaQ1lj94YA==
X-Google-Smtp-Source: ABdhPJyruA+8ofRDgpnvxQE13QZEew9oovm4Y//Qfkg2RRADZfH+igIB3JDhSF0odDBQB8TOR00N5g==
X-Received: by 2002:a5d:6488:: with SMTP id o8mr6018638wri.113.1622203925560;
        Fri, 28 May 2021 05:12:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:12:05 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 27/31] receive-pack: convert 'update' hook to hook.h
Date:   Fri, 28 May 2021 14:11:29 +0200
Message-Id: <patch-27.31-c39c608e5cc-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

By using hook.h to invoke the 'update' hook we closer to removing the
hooks code in run-command.c.

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
2.32.0.rc1.458.gd885d4f985c

