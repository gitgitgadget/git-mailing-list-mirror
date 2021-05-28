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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD052C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19B9601FD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhE1MOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbhE1MNr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B3C061760
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f17so568134wmf.2
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGImfH037wcNCUcNE1zzMJcQegHcwPgdiVclWcwVQ7M=;
        b=GG60UOdUL9bFafABlHHFjZxr2DVlS7myFS7Ce7igheAeDol/M3NqGe0WInPo/tm53o
         xsOOLw2DfSCaQnBjc0qHgqnwwGMMEh2Xn6v2t5M4Inu8P4MqRRwPRF0xyI9PbaQxheRf
         p5PelT9bzkk0SHwNHj58oJAPBPd/QeL1c4uQuR3lk7Tyr6zu47A4uGQJYR3QdXXrxZkx
         RD5WCiet/17iOGxtIbA67FL9hTplpWC2ifpp0Xk1Cdl/2A/vW9TDrfOh+ukRW56y1zjn
         JIShuRYXSQHJCvCzvRLOtQ3jhpBloF/H77QXjElBysRMwbSoL7Rbu/NuEAUJF5krRv+8
         8uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGImfH037wcNCUcNE1zzMJcQegHcwPgdiVclWcwVQ7M=;
        b=pRZAdbpNTcnXsrq2z8Z+pb5oJR/YQvzBinYVcuNui6+5lNniWiVWyHxrrK6AXH8fZ5
         dbh0lPwOzla2/ptCZ2HsdaPw5bosXMDVCBZa6KPCq5VAv3zST8VJ1Bz/qGZNZkkbG420
         tZbGDiVVLMUBa/t8tv0QEmU4Vqs/t2CGxMUoDcUySBb3Iqpy8wgoQo1tICeAD6zgwzfB
         +WtEomZ0+frz5Vf1hGZhtmPH399ASlGx/tTiwbPQBHzD4okM7v6eW0jMitMXpRAudzzM
         J9KWMqru/FSHTDWFd7zYIagcjIv4HazN3eEaTfvbtMl6YHWEjf9g0zsRx6MX5s4NGPAd
         40ag==
X-Gm-Message-State: AOAM530XSfvgtQ32nDjQQat/hzH7aguLH2rsiVX50clDPz/6PKtxQ5zV
        6ViYNcl87sBbHTUJDtofOH4pvVhzA3NVgw==
X-Google-Smtp-Source: ABdhPJx5GmxWtqjdv/0XKEOSKkOcmkDuKBGgevTcXLCQvxOdI1MgusAdh7Ma+CoxpT8uijj61l9Nww==
X-Received: by 2002:a1c:c382:: with SMTP id t124mr4971320wmf.39.1622203921442;
        Fri, 28 May 2021 05:12:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:12:00 -0700 (PDT)
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
Subject: [PATCH 23/31] transport: convert pre-push hook to use config
Date:   Fri, 28 May 2021 14:11:25 +0200
Message-Id: <patch-23.31-c59443a3b05-20210528T110515Z-avarab@gmail.com>
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

By using the hook.h:run_hooks API, pre-push hooks can be specified in
the config as well as in the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport.c | 57 ++++++++++++++---------------------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/transport.c b/transport.c
index e6c46adf60c..1146ed3143c 100644
--- a/transport.c
+++ b/transport.c
@@ -1197,31 +1197,14 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
-	int ret = 0, x;
+	int ret = 0;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
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
-
-	sigchain_push(SIGPIPE, SIG_IGN);
+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
 
-	strbuf_init(&buf, 256);
+	strvec_push(&opt.args, transport->remote->name);
+	strvec_push(&opt.args, transport->url);
 
 	for (r = remote_refs; r; r = r->next) {
 		if (!r->peer_ref) continue;
@@ -1230,30 +1213,20 @@ static int run_pre_push_hook(struct transport *transport,
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
+		string_list_append(&to_stdin, tmp.buf);
 	}
 
-	strbuf_release(&buf);
-
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
-
-	sigchain_pop(SIGPIPE);
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
 
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	ret = run_hooks("pre-push", &opt);
+	run_hooks_opt_clear(&opt);
+	strbuf_release(&tmp);
+	string_list_clear(&to_stdin, 0);
 
 	return ret;
 }
-- 
2.32.0.rc1.458.gd885d4f985c

