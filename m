Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE3CC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJLJDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJLJCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF1BC45E
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f11so25268448wrm.6
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/NTPbtC8voArdAzTWPZmQoXgyxV9caBO5BFaYIMXZw=;
        b=blIPmK2FBzbl6t7EcM6aarvNRVsLn/j971Lcc6m/cJdHcWctCa2z7WOa4BSTJQq46u
         3+symio5U550Nmrnhtn6uNm6RA+L6ALhfnOQBGRzUCH5F9lT2uiogw+rqhRmNMpTjzg4
         dwfz3nEzU3oo6bYkp8qDSwj/MJe4SCKHFSlhxCraLv5AV+ifBKQlS3c+U++mYjAgN4xW
         npADykZBldHOoRHGn6Q1Muxp4+jpANbrAaZkNZ8VHft2l+9Tw8rvxFWOs9z87dF/jUmd
         NPVlBz/ph0NIOPW/BLcMRsq++UQyh4Z+Z38jeQwkqw1i+XXmL5GXM03VJ5QAstiiW55h
         C47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/NTPbtC8voArdAzTWPZmQoXgyxV9caBO5BFaYIMXZw=;
        b=7DJAlqBBlBfh3qdlnfJS3C+ETQeJOqV7KUClNcFteXVsPmSLKnXaZsJ+KUIoU3aM3L
         vXcrGY7MtL9ANrATL7UvtD/URjkmvx9AjiRr9QSneKNIeiAi7SpsemondRMOvaic5uue
         sDdmq7xZdHdMjXJrjWSX7MddiyJ6BgT54GUT9AcKDJIYHCcwP1SF6uBvYZ00G6GVn/56
         OOaJ79K+b9qyP0a/lVLCOVvT+Oypo20ff2gh2PMDQcplgslT8RBH845amzwccCSTN917
         T43t85TbfBVN0oBDJUCkgE3FzeNGvrGsIsXNdqXu/LRAFCDyhMLTh/GBzedDDaNwHMWq
         L4Pw==
X-Gm-Message-State: ACrzQf3BvVDM8c6wiAE/CGDJUqUH4I8763Ir+Dcq0WbNEuzsvnRso9wF
        vqeHe6VtuYtWHWFdHwgaNCfd1FRr6RtDOw==
X-Google-Smtp-Source: AMsMyM4DvS1uvdkPDFDOTgIirYQsJ8dZlyQss7Gak70ojE2BSUtZMO1MQAELUa2Ot03bU9ng8OAbYQ==
X-Received: by 2002:a5d:64e9:0:b0:22e:7631:bcab with SMTP id g9-20020a5d64e9000000b0022e7631bcabmr18386109wri.36.1665565324891;
        Wed, 12 Oct 2022 02:02:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:02:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 19/22] run-command.c: don't copy "data" to "struct parallel_processes"
Date:   Wed, 12 Oct 2022 11:01:27 +0200
Message-Id: <patch-v2-19.22-9cbee2dfe76-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the *_fn members removed in a preceding commit, let's not copy
the "data" member of the "struct run_process_parallel_opts" over to
the "struct parallel_processes". Now that we're passing the "opts"
down there's no reason to do so.

This makes the code easier to follow, as we have a "const" attribute
on the "struct run_process_parallel_opts", but not "struct
parallel_processes". We do not alter the "ungroup" argument, so
storing it in the non-const structure would make this control flow
less obvious.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2b1cfbc996f..d07ee759b34 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1495,8 +1495,6 @@ enum child_state {
 };
 
 struct parallel_processes {
-	void *const data;
-
 	const size_t max_processes;
 	size_t nr_processes;
 
@@ -1607,7 +1605,7 @@ static int pp_start_one(struct parallel_processes *pp,
 
 	code = opts->get_next_task(&pp->children[i].process,
 				   opts->ungroup ? NULL : &pp->children[i].err,
-				   pp->data,
+				   opts->data,
 				   &pp->children[i].data);
 	if (!code) {
 		if (!opts->ungroup) {
@@ -1626,7 +1624,7 @@ static int pp_start_one(struct parallel_processes *pp,
 		if (opts->start_failure)
 			code = opts->start_failure(opts->ungroup ? NULL :
 						   &pp->children[i].err,
-						   pp->data,
+						   opts->data,
 						   pp->children[i].data);
 		else
 			code = 0;
@@ -1701,7 +1699,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 
 		if (opts->task_finished)
 			code = opts->task_finished(code, opts->ungroup ? NULL :
-						   &pp->children[i].err, pp->data,
+						   &pp->children[i].err, opts->data,
 						   pp->children[i].data);
 		else
 			code = 0;
@@ -1754,7 +1752,6 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 	int spawn_cap = 4;
 	struct parallel_processes pp = {
 		.max_processes = opts->processes,
-		.data = opts->data,
 		.buffered_output = STRBUF_INIT,
 	};
 	/* options */
-- 
2.38.0.971.ge79ff6d20e7

