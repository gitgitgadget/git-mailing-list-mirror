Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A17C433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiI3LhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiI3LgF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:36:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9584114329F
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m4so6382620wrr.5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DmRladxd4ryfu4ppQPJ2pJwE5KcWX1XHp9oco2mICLY=;
        b=EfMrTLZnph9WLCqBQVCCMBycl8Z3B1UTNw3Ow+lE5fgNBQyIRYCKkCbUrE/kCiahl2
         EPgCVTsRlesItyziIfsl4JSMb2P+jHxZpEzD9FWKidCEc194/N28Nj0JBshrZhjpkXwh
         DvRR/ZHZzT9If34t0tUUzdNzf+7JslYmTMoheFho7mRY4EOevYT+N+nwC2evTIxS3Ixw
         EztPEdIrVT4ER9aZ5dVspW8Ra9UgZczCw8U9JFm9D1263ujvYrGa4Ghk31IRXeaZOuow
         LulF/fObNQihX8ZMivrt5WT1Th1Jy2IcqISh9m8Js6nQwaWWs2lJBchgWrNJqggUDJos
         vRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DmRladxd4ryfu4ppQPJ2pJwE5KcWX1XHp9oco2mICLY=;
        b=1pOQUhOAgcSq30wwQVPKtkkYGH87arHq0KXQbGTdrg4NJXpC3Lx9A8q65DuigRbQvv
         qxxp+g/aQ2sMI25OqFTqzBolGsz25mHIW0q+yNB1/5i43gpxwDNL/u0VNDjJKuTMexPi
         vh4LPnXbj360KAvsQP3DYBdtFwS8DAXiDkAjEP4eFMsRAan9NbScSaRCFVxyCat993NE
         A/WMwbvpwNfwDz1Iudu9sy7t2z1QWe4dSBkZMxJDbtmeyiwqVBZEm22Swspda9PGwqxP
         uAT/6lMD8CQeKQdXbMgXtJXIjgV/cFPvUTKJ/KPMiX4ZV20zfpUVCCkyva/Adu7fugUo
         MIWw==
X-Gm-Message-State: ACrzQf1ODugAB9XCfVhnBV7Z4LUR3un7jfSfNaJ9HBAQuT1pGedqpWFA
        LiW1IF+keiLLnutw/ykEp4VYjervflt0TA==
X-Google-Smtp-Source: AMsMyM4oLPix0FsEh3FACNzPOw8ZF0c3O/DKEsNa1N0QIIV6HD3DTMkZYDWOy+HHdJCifZRWJFbsRA==
X-Received: by 2002:a5d:69ca:0:b0:228:dd17:9534 with SMTP id s10-20020a5d69ca000000b00228dd179534mr5763630wrw.652.1664537312463;
        Fri, 30 Sep 2022 04:28:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/15] run-command.c: don't copy "ungroup" to "struct parallel_processes"
Date:   Fri, 30 Sep 2022 13:28:12 +0200
Message-Id: <patch-15.15-60d66fbd90a-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the *_fn members removed in the preceding commit, let's not
copy the "ungroup" member of the "struct run_process_parallel_opts"
over to the "struct parallel_processes". Now that we're passing the
"opts" down there's no reason to do so.

This makes the code easier to follow, as we have a "const" attribute
on the "struct run_process_parallel_opts", but not "struct
parallel_processes". We do not alter the "ungroup" argument, so
storing it in the non-const structure would make this control flow
less obvious.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index b25e74fcc06..da026319335 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1515,7 +1515,6 @@ struct parallel_processes {
 	struct pollfd *pfd;
 
 	unsigned shutdown : 1;
-	unsigned ungroup : 1;
 
 	int output_owner;
 	struct strbuf buffered_output; /* of finished children */
@@ -1563,9 +1562,8 @@ static void pp_init(struct parallel_processes *pp,
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
 	pp->shutdown = 0;
-	pp->ungroup = opts->ungroup;
 	CALLOC_ARRAY(pp->children, opts->jobs);
-	if (!pp->ungroup)
+	if (!opts->ungroup)
 		CALLOC_ARRAY(pp->pfd, opts->jobs);
 
 	for (i = 0; i < opts->jobs; i++) {
@@ -1623,17 +1621,17 @@ static int pp_start_one(struct parallel_processes *pp,
 		BUG("bookkeeping is hard");
 
 	code = opts->get_next_task(&pp->children[i].process,
-				   pp->ungroup ? NULL : &pp->children[i].err,
+				   opts->ungroup ? NULL : &pp->children[i].err,
 				   pp->data,
 				   &pp->children[i].data);
 	if (!code) {
-		if (!pp->ungroup) {
+		if (!opts->ungroup) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		}
 		return 1;
 	}
-	if (!pp->ungroup) {
+	if (!opts->ungroup) {
 		pp->children[i].process.err = -1;
 		pp->children[i].process.stdout_to_stderr = 1;
 	}
@@ -1641,14 +1639,14 @@ static int pp_start_one(struct parallel_processes *pp,
 
 	if (start_command(&pp->children[i].process)) {
 		if (opts->start_failure)
-			code = opts->start_failure(pp->ungroup ? NULL :
+			code = opts->start_failure(opts->ungroup ? NULL :
 						   &pp->children[i].err,
 						   pp->data,
 						   pp->children[i].data);
 		else
 			code = 0;
 
-		if (!pp->ungroup) {
+		if (!opts->ungroup) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		}
@@ -1719,7 +1717,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 		code = finish_command(&pp->children[i].process);
 
 		if (opts->task_finished)
-			code = opts->task_finished(code, pp->ungroup ? NULL :
+			code = opts->task_finished(code, opts->ungroup ? NULL :
 						   &pp->children[i].err, pp->data,
 						   pp->children[i].data);
 		else
@@ -1736,7 +1734,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			pp->pfd[i].fd = -1;
 		child_process_init(&pp->children[i].process);
 
-		if (pp->ungroup) {
+		if (opts->ungroup) {
 			; /* no strbuf_*() work to do here */
 		} else if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
-- 
2.38.0.rc2.935.g6b421ae1592

