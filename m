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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67FAC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98055611C9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhE1MO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhE1MNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED234C06134E
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so3103852wrw.3
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGy8NXKxgkRrLnBEksuxOFf3L7dDb8rvfm8xBzrPtYw=;
        b=e0s68Wp/S4uB7FkhVp0dAtB7i2exxm5+euBDEu+//cbdGVYEv+/YMeES8KTu4w7Zba
         RfQ2P0cBKKr0bhcVsOjXXQkfeIgNJDbBUIfbvdn4tROz++VGvjur08VOHNwv8wAuNrE2
         XWMBVf0NrQWSKgDCkNPN2XlWzYP3g1WlOd6Ppfxo4p3l+af5bebXuRsXaeowCVk1H+wN
         x3Qr/r+uEn2IiyAtTXUHhRq76/YwQL/bzjpeGgow65R2zMzsl7XON160T/C1bhLHEP4v
         fHkv1xcQkGwuayAriWeJufT2MK7eySIzxQM9PG0W72VtI+Q4WcCIytODa12e7JrSP3b3
         dz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGy8NXKxgkRrLnBEksuxOFf3L7dDb8rvfm8xBzrPtYw=;
        b=Nyi5VXw5WNomQzYCvkcsDfnzNRBqi67sTH+3QGcmqTexorzPBx0lL+juS2kGCnXg2x
         gjtdcp4MAa1yt2a+BfMD0IrT6X2de/S3LR5yLF8vl28mM461PlLefjX/inCVR4VqdjS1
         iRiLi8aBXNMyROW/b804WfVTWpvAyN4DJEVbwzH+1UNAg+lOMV9yyYMg+e4RahFEto21
         bLbKWF+g6hXkU9y/1P07kYWUhkjyxh2IcpTG6Rb4Bc91GVzKH6cha38rn/v2BYdeQjjf
         9a22iwqshoWbHDQ41Xdm9RgIJ2YkZvswrtrCOn9Ae8yg14xvJxhPPZyb+pMMvaucmos4
         Mapg==
X-Gm-Message-State: AOAM532zTcJ7TLNBJXCrdpVMhCjuka6MaqY5MU2SBcA7e3f/aaCDTwlm
        Ank9AF39/rjTx0gzqYYYhO4ovKjTAiSu+g==
X-Google-Smtp-Source: ABdhPJx8jXq67Dly2KVrC5INcjujp9jkNvYFA3ooPOddQFCa31WoEeAkqVtZvmniqRP2diOyLUN76w==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr8223786wrv.354.1622203922291;
        Fri, 28 May 2021 05:12:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:12:01 -0700 (PDT)
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
Subject: [PATCH 24/31] reference-transaction: use hook.h to run hooks
Date:   Fri, 28 May 2021 14:11:26 +0200
Message-Id: <patch-24.31-f7c8c97cb81-20210528T110515Z-avarab@gmail.com>
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

By using the hook.h library, we get closer to removing the hook code
in run-command.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 59be29cf081..1149e7e7dcb 100644
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
2.32.0.rc1.458.gd885d4f985c

