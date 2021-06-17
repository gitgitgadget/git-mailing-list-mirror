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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE4DC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F4661245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhFQK0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhFQKZl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D496C0611F8
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id my49so8940792ejc.7
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9Ik6qLoHV2+sMYlUg3Jydq/czJGR92aSCTNKp3pY3Y=;
        b=klIh9huhqvp3zi11VUXoprN5thm0Tg+yIqxU/2Z/QJ+qzKEaW+LmOjCWPNhryRM3Tn
         2/bSNYOlginLOVvGTl7FwCP0/2ZgngOc1V0gEfPN11KcwluxejT2gRjemm1vfW6tbRyQ
         JqhCF2SsdGUZ3xYK6uG0OFsXmkHMOhCFrFbSqrvEMdzfpHsdGXNu03EP6zgVXRjjwKIR
         wJ46sKUQpeWGGuw7WIdJ62tVDsnMvUcLG65im7rbF8BF3O8CYOED3/0UHZ8gH9/mSBKt
         jCMuXc4uC3iX9Yb5lJaNo5cABgzGPnKh2C9uLsHOvLJNpNqT09GUsHxN5U8Ow56ydB+Q
         t5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9Ik6qLoHV2+sMYlUg3Jydq/czJGR92aSCTNKp3pY3Y=;
        b=Z8JliuIozU8AOC44/SY6qM7IgCcksg96E5ArJGpCSIH9+ic16df0vVVqNMKHwXnzvF
         Z7HCmzVXJdEhO4cUPmXj5n9vZCV7akUj92xukXhd8BqCOKvYRpS/9HY3GeiIrMl7JU1R
         eyX9CcTzHzf1jrPfVj7zoS52aTR3Adcn03+a7HfnyIYqiTsQlIcs1NVxfFJ/Jbow3YTd
         NlsbtaWoYgPvhFHsHNO/QJmudgOqwuAK0mtHuHWZfUnsMjvhzW4+nGDxhBmjIjx5sIwu
         s7OTLyTjuaWTvEJZfCUtFKrdlcJ/0lc8MRetqdO5bg7HePKfn9q/cXJTvy3cdEmkuy9x
         ThXA==
X-Gm-Message-State: AOAM533jQvgxC5+I8JhjaDXZNV//sDFwPMqJwPnJNJGOydn9s6Qnofta
        s+37tbI8yBd+tRHO2RoDfa3C26GNOmPhbg==
X-Google-Smtp-Source: ABdhPJyNwAaZGVIUv99m7HMemokmrzWoCpcg3leh+SLQ9WIVorztk4Qnxf/+tFaNhyUjdasu5yhX9w==
X-Received: by 2002:a17:906:6847:: with SMTP id a7mr898176ejs.268.1623925405802;
        Thu, 17 Jun 2021 03:23:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:25 -0700 (PDT)
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
Subject: [PATCH 20/27] transport: convert pre-push hook to use config
Date:   Thu, 17 Jun 2021 12:22:54 +0200
Message-Id: <patch-20.27-85bf13a083-20210617T101217Z-avarab@gmail.com>
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

By using the hook.h:run_hooks API, pre-push hooks can be specified in
the config as well as in the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport.c | 57 ++++++++++++++---------------------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/transport.c b/transport.c
index 2ed270171f..9969ed2cdd 100644
--- a/transport.c
+++ b/transport.c
@@ -1199,31 +1199,14 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
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
@@ -1232,30 +1215,20 @@ static int run_pre_push_hook(struct transport *transport,
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
2.32.0.576.g59759b6ca7d

