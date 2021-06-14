Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E2C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62CA61469
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhFNKk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFNKiP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:38:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF117C061787
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y7so13970892wrh.7
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ypHfSi7SXV5NcfJn+7pVEt9nZfmts64RKFBGRgUZ5R0=;
        b=Y4UR2G2ObYHBs41yMbUk6Y5RZj+BpNlO5D/BpFhnPvtgVCNTSMyr2InUSCzcLxjVSr
         uMu/fhLqOWwGrqaq0KV0M3PSMYehIHkyLoHwCLvfxK6j1OyLc15zz9BIq7EYFCvIWZmf
         f3d/J4McZf7ZIAu7OL7o1RzzX+ZsV31HZTdHDQ/hQHR2/Ciel9OFjzyn6QtsRzSB18vV
         5skJ58INzUjRpkpkvyufO3QJ54QOuBh9oKabJBHUJrzU07bGuYiICtKv7z/ureiT+47j
         qMJQlPHKS5ZnoBBnMLaecllRvyIvfF9oknltYoSPAZ13hO0Y7oDIR7dTTmHX7tF8w35l
         ILnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypHfSi7SXV5NcfJn+7pVEt9nZfmts64RKFBGRgUZ5R0=;
        b=k5iqZcO/+JqFheU2ASP6kS8VGdrQ14qTKyk8h6XQDKWa/kb6Z63ij0vWYtoE7V5Enz
         qjdrYuBRB+ob01cWMnP28Szj9B4/tfaHLDz4S0s9bVbYN1tWdeEU7nW65WTn/k6FJ92a
         tw/R5O48UCHz5YVT+arPrslf0PNokKJfWvLnZ2Cnv/t2XRwy+jVec0cyGjfHKnzrOqKd
         b3/ljIRFI4rNWPJL0hxpy+74RmTEsNNyWwwbTVtjqEgqoLtItXvmuMSdH0uhbnYuZvPe
         EWxgQ/hjeI9GVuezDRaFCH2+aK5x6dcZ372APbDX1tcTEk7sFOsGvilcEhEvRPkkvpzo
         hK6A==
X-Gm-Message-State: AOAM533Z9H5Vf88+7lHwQw36Cvsfi5GZqoTo8iHd/WiGthRw5Lx483VE
        9F40RHb9of4u8ZM28kqEKk+4Pf4gBj/z6g==
X-Google-Smtp-Source: ABdhPJwmeRA6lX5D1WXPeYmK1QOXRMpmvH6RwIHOfV/xDhX9ioaIz3epLtDIFS/FVtMkwLOAbVm6sg==
X-Received: by 2002:a05:6000:1049:: with SMTP id c9mr17650827wrx.416.1623666843308;
        Mon, 14 Jun 2021 03:34:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:34:02 -0700 (PDT)
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
Subject: [PATCH v2 22/30] transport: convert pre-push hook to use config
Date:   Mon, 14 Jun 2021 12:33:11 +0200
Message-Id: <patch-22.30-62eecafb3ff-20210614T101920Z-avarab@gmail.com>
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

By using the hook.h:run_hooks API, pre-push hooks can be specified in
the config as well as in the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport.c | 57 ++++++++++++++---------------------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/transport.c b/transport.c
index 2ed270171f0..9969ed2cdde 100644
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
2.32.0.rc3.434.gd8aed1f08a7

