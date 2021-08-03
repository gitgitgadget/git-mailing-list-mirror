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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3E4C432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C8B60BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbhHCTkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbhHCTkB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:40:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B77C061372
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k4so15680785wrc.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ta169ZOJ+RmhDlceEmLLsVIdLxFZcY00Al6FLOVtWD0=;
        b=rRremnwAVKpgfy0OYnGMNQ46sjY/KRjRcGOsjMkJMBspc+Ii4cXssHepTPQkwGMRJ+
         MgVjRY7Y0SBlq2mbnBr5OWDeX+0gZU9BH+SGrjIPpfU/cMBUXI59Sl8Y4u81ssjskoWb
         MNSFF47B6oFSy1tnSv6qaMLf+ypOBbHWmSpC6vJHXzsIoAG7y6qfsxK1Ylze6GoLp79j
         u+yoj3aOSCZJjcHgdm0pNpgt7j9Hti98dskb0v14Ocn98qqcdOXCFHRuqeiwMnFqWz0o
         A3J+RT4VZ4AdAAuG5jGs25Xm1ncWX9fxTd7s5sur7fHi5X8c2fMu+dUvxPjRLE1A2zWO
         kJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ta169ZOJ+RmhDlceEmLLsVIdLxFZcY00Al6FLOVtWD0=;
        b=MtlB8abKWp2sn+iG3PvO0MKlpJdhvRKaIpWWs8czvz8v+7MVgYIy9bhiEnFOf527FN
         L3DqEtBlEnyZmpVd7VKiz49FmVIr1Xv6QZyVPJ6lx+cpyyXLXbVUf+3vHgMMTx3bnafA
         R/n32OscfXoWXqdbRjO/M6fkat8gENsQ1GBK6CcRIQcnIWupZVeH7VSRz5SXEORhLpNt
         Y/1Eyd9MAj8WsSITEboM45o2QaYLpNpCoxGlpbBfOXYWXVEpCRFAMk+aLHRwZiN2TKEz
         RQmjL8B08O3Ah+AkDB2NB0oGolMoIQJ19S+kyUuQFL76LSYRVTu/EJQ6Auj4AoKm//zz
         zmqw==
X-Gm-Message-State: AOAM533u9l+0P5XUJmYTeBWxHo0VW7bUstPQLCp5ceklKCR2AVRINg4F
        nvT6Vslk7Stz2BV6Bqx0PivwVLsjkES1zw==
X-Google-Smtp-Source: ABdhPJy6lp/u2JLCWjF9pYKIfiHlAT86vK6u1DchRqikFTLcoKnUgdo2v53ukRCCU1Yqx+F2vJO4Zg==
X-Received: by 2002:adf:f845:: with SMTP id d5mr15447531wrq.267.1628019581848;
        Tue, 03 Aug 2021 12:39:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:41 -0700 (PDT)
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
Subject: [PATCH v4 33/36] receive-pack: convert 'update' hook to hook.h
Date:   Tue,  3 Aug 2021 21:38:59 +0200
Message-Id: <patch-v4-33.36-dcf63634338-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
2.33.0.rc0.595.ge31e012651d

