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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC1C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E324D610D2
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbhIBNOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbhIBNNy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F9CC06114E
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g18so2841876wrc.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gV1lGLcuTnZQvsJ5UVp7qgZPpx4EebNPaokt06b/uo=;
        b=AyVBJvM6JmhtvIqqNfGWPgCB8xDPdVNRHI8MbI+CIlduBh1gooUFOjUCXg/yNQvLSd
         wAfPR/gKd22Wi56aOaIlg/7MD+5B+zu5zWnWJ9VWEgW0TtnbHq74IyX8b1McJDlYCXLY
         ywld8PtMAFlPUAXnSrT7AovVVJJtJcEB14aS1CLZARIRIuOtInJoVkBW5/NYCoHW5Gau
         t/WkRqrsrc66UZJosud9xbV95iZ9d+lUwMP2tB32b4KjLKfJi8b88X8NP9JfZ22Qyd14
         kO2GnO4yOqVML9RU2f1s+C8vpdIe7mDMkHOYxFDnobN1FGa8S3/dMJsuAob8QaJP2WXZ
         Dv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gV1lGLcuTnZQvsJ5UVp7qgZPpx4EebNPaokt06b/uo=;
        b=he4LDY38UdNGooGw83vjrg4l7bwOiuDB/4FqpUdiVGwrQ6ZEmW9qUz6+ifx134J09B
         vG5lz2AWkZ5E9kAWClE9281i6v2T7tTg4cq+YpA/PaFDAIqFNL/Wzv/fo8kLyZnYqRO6
         qiYAq7lHrFnQ8xKZu/oBwx25Vt4ySDqgoq5VQgLwdTqfMK9aXOeW/GEvDGTk5B9uSKhx
         +s0rfSydJkuRpqw+ZY4bmG3X+mboQV+1+S77Z5rfFCqxQnr3SrT+X+we32YuL3aKcW+D
         kKwAyG/1ZC28Kp75IMhrG3J81uJ28UmsCnakaY5vY4pUbRuggEU0QH2VsNwViFdPi6Gi
         4NLw==
X-Gm-Message-State: AOAM531cge5XUWaOfgs1CDVPbz8PPFd22BQuw99Z4/VEhrubGnUQgWmw
        FvFCqpAUfPp1HgxxVMogNvzhymnZdyYe9A==
X-Google-Smtp-Source: ABdhPJz3VSeNsmfQVixXp2oPhNRz9glIlf3vLxJeQn+74OpB/a9pIYtLKqaktKCp2dOBlNjVsLMQPg==
X-Received: by 2002:a5d:4fc7:: with SMTP id h7mr3659272wrw.333.1630588340363;
        Thu, 02 Sep 2021 06:12:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:19 -0700 (PDT)
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
Subject: [PATCH v5 33/36] receive-pack: convert 'update' hook to hook.h
Date:   Thu,  2 Sep 2021 15:11:33 +0200
Message-Id: <patch-v5-33.36-c8150e1239f-20210902T125111Z-avarab@gmail.com>
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

This makes use of the new sideband API in hook.h added in the
preceding commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 62 ++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a7d03bbc7d3..31ce4ece4e7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -937,33 +937,53 @@ static int run_receive_hook(struct command *commands,
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
+	return run_hooks_oneshot("update", &opt);
 }
 
 static struct command *find_command_by_refname(struct command *list,
-- 
2.33.0.816.g1ba32acadee

