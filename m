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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B071EC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BCBA61037
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhHCTkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbhHCTj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20DC06179E
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b13so15628482wrs.3
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9lxZ1nFhaiOgv1gjNp59SSY+ODJl8LIdh58BMvHMS4=;
        b=cEpzuNtX8FedseCbnw+xeExNIkSeiwDoE+F6SMsr69Uf9awgdNNFSWGEqbADc80O1H
         Ypx0xEdpZHFbB/z/SwcTLCjeWcnbp6w5bQGfQjqUL/xjFlj0qXvqD0V9EYj5pX6sq1xo
         Cd02pbRRSm6faq4m38VflMwWG7fdjmoS+21KMhyzUmb6p2IWOXYCBKdgPAGeZxvbEGPl
         gYZu3i7AgIo2PRaILThJoYs1h9nP0fkGhTuY3CkjP3Emgd31quX7gNIagErirvwFhLtu
         KCmBzkECcro5Ial3fWl/nkfpyana7gkLhILYOtFG7Flo0HsTNc4YVDJs3RPlYiz12c38
         bamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9lxZ1nFhaiOgv1gjNp59SSY+ODJl8LIdh58BMvHMS4=;
        b=s6UFVOe0nFTfK6c00ZIKg8TH37dMm2SMNkLDi/pJyncuz9tjqYCFXaBXVIDFEgnr4e
         8rcT9VtGcGP12jJaewDcQ6WRJ05uExVV/q8cwWXpaMO7q6VM+URfqcQjXVzbhkTnPbho
         fnmGDV2EIpWpwlDTL5UY8Ncod1aDxiAF/1TbfyZCw6JHCtTUE+pvHCBIp2BDZ+3BB5jk
         0RDPpjlJlqhkmBHeBFScMd0n5jbjyqnu4KmCE3+3Kfx91AFsH5J/5LsRQY+9Ysdd3gjE
         dFKdLrIWiwr2UJuKgAnQZtw99cWEcAHGpWq6s6knU5NHvxYJuDGMMAu0z2yS/4fvWkSs
         pDqw==
X-Gm-Message-State: AOAM532nfhUxlx/ulwxAgLUakw3jhciPsGPML3wvAUQii1GXpucCtx8S
        GHYXrVvStUQ+AfxTXOHuYeG6YLFVQMrHbA==
X-Google-Smtp-Source: ABdhPJyAEUPRH7tGMmdDj0SIaGOPmezoBgGb9UIypG0ldlAcau4EpJhrLMaFZkM7QwplejeZdWH/bA==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr25516876wrn.248.1628019579177;
        Tue, 03 Aug 2021 12:39:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:38 -0700 (PDT)
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
Subject: [PATCH v4 30/36] reference-transaction: use hook.h to run hooks
Date:   Tue,  3 Aug 2021 21:38:56 +0200
Message-Id: <patch-v4-30.36-1ce456f9d9d-20210803T191505Z-avarab@gmail.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/refs.c b/refs.c
index 6211692eaae..73d4a939267 100644
--- a/refs.c
+++ b/refs.c
@@ -2062,47 +2062,33 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	const char *hook;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct string_list to_stdin = STRING_LIST_INIT_NODUP;
 	int ret = 0, i;
 
-	hook = find_hook("reference-transaction");
-	if (!hook)
-		return ret;
-
-	strvec_pushl(&proc.args, hook, state, NULL);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "reference-transaction";
-
-	ret = start_command(&proc);
-	if (ret)
+	if (!hook_exists("reference-transaction"))
 		return ret;
 
-	sigchain_push(SIGPIPE, SIG_IGN);
+	strvec_push(&opt.args, state);
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		struct strbuf buf = STRBUF_INIT;
 
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
+		strbuf_addf(&buf, "%s %s %s",
 			    oid_to_hex(&update->old_oid),
 			    oid_to_hex(&update->new_oid),
 			    update->refname);
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		string_list_append(&to_stdin, strbuf_detach(&buf, NULL));
 	}
 
-	close(proc.in);
-	sigchain_pop(SIGPIPE);
-	strbuf_release(&buf);
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
+
+	ret = run_hooks_oneshot("reference-transaction", &opt);
+	to_stdin.strdup_strings = 1;
+	string_list_clear(&to_stdin, 0);
 
-	ret |= finish_command(&proc);
 	return ret;
 }
 
-- 
2.33.0.rc0.595.ge31e012651d

