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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9249C4320A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B00D6108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbhIBNOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345213AbhIBNNu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D798C061140
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v10so2856235wrd.4
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTOmtGfxwClGIa/BmKDqSE/IJnx8G+p2LBhI1YVnoB8=;
        b=mrz65AMTtgyJ1h43xxvwHqwHGHjB9rMwVn1fwEa9t7FMzdKeAMb5gENH2Qk0YyqHqK
         NDS5A/mkPBXI5CkgYXYs9Zu7YTPxx+o/1Cfe/n6Uva8X+QiryyKKm0OBnDkNhqtKNuoI
         uHnQWQnj3X03c8/7C2c9hgk9LRrafez4CBuIWB3UZ7Mb8R7U2AbCPZ3eHv7n1iuEwMZz
         NH/K9WqQyT3ihi1j1IatGQBbbyY8O3866fgUxrQNVQmfsUEYbsn0RRkjzTlMbptqtCly
         WtxT0D74M9jVzPfVVPGpxtJxRYp2/JWbCfgNKR4Sr5PjsDhoA4HolQiGCn9drGco1U44
         9NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTOmtGfxwClGIa/BmKDqSE/IJnx8G+p2LBhI1YVnoB8=;
        b=syzRZGtA4GeclLiKX43YtAeGCFpa8u46PMVNERRBym7pPTurMPMBtH9xtsE2WYEkO2
         QuySTLt0binINVbiPrw29s3wLWCK5n79SJzEiGcbSjYJg8Bn8xnMv/7skEN67RF1SNiq
         CulOcf0FuHt3tRf2kkDT6DeSSF+Jq4CBQ3ZUX/xYQSk30k8arp5rmPc9oggprSD53NqK
         E0LI7zxpinJ9hHVTsawip9AO3oHJZcGLGHo8XbvFL7HJEgwG/IkOHEfqI1mALKeWlV78
         f5gCbXBXxqMclt6n5bz0Nlp7l7DlCGlSk3BkbLtYrXQwBSb4Q3umkljpt2c1xefZGt8+
         iROw==
X-Gm-Message-State: AOAM532Ep4NWj66uTux8Op5JpPTMDimqm0Ppgn2AC5LSXSYJUGlL5jpe
        aB/OMxTVG4S+DiERAzLrc4gbETTTVIDDGA==
X-Google-Smtp-Source: ABdhPJx4qiU/0MGrj5qqxVZXvyuakR2yOoTN/nq6HjApvIu15d8TxUXPEktxZjynba31Q6f7qW+p8g==
X-Received: by 2002:adf:e910:: with SMTP id f16mr3714149wrm.393.1630588336619;
        Thu, 02 Sep 2021 06:12:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:16 -0700 (PDT)
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
Subject: [PATCH v5 30/36] reference-transaction: use hook.h to run hooks
Date:   Thu,  2 Sep 2021 15:11:30 +0200
Message-Id: <patch-v5-30.36-1d905e81779-20210902T125111Z-avarab@gmail.com>
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
2.33.0.816.g1ba32acadee

