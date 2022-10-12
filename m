Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D203C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJLVEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiJLVDq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692A8BB83
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so79687wmq.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSMtaeEQbhLwIh/rYpvNzoxFLefkFRBeO5/fQGJSJm8=;
        b=S2DmaRBabFqd+f4yOeY0NpS/bcdqJcIyq8YyV+b3Xb9ZY1yF+wwY1REY4wN/rtUwlO
         gpZbaeA/PnZvy87ULaw2tToASLPp82oo7wAcJaKM1YpqDMQM/hXUceVyzv6jDnkTWYf3
         79RE/L7ZrEuqzQaGqk5yCp38a3ZQ/aFDB6JGpPauhUyeXlbvZdMDwmmttfQVxb8OE0Vu
         Ftrqf1iy0Cfk8WRvZzKLAI7pdaMthTeTz3h6to3ZEd1/vkCXJt0g35UuXLphRgHNiA5N
         HtjriATJJO92RWcsMPZA6HvnWyjEL9IwT9Twvcsntsqo6aJKCiVmIwUDyYCqAFl+8C/h
         XhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSMtaeEQbhLwIh/rYpvNzoxFLefkFRBeO5/fQGJSJm8=;
        b=1Y32Lvf29SJIqsN/yhpXftBx8h7cdk2AQN4fkz76XL5Pfgl6zE3JLPJaHZxSJ16mOQ
         NupCOeYgAZ3AY8o2GuE3+I6T43awbJiAdU5lTRNoIgoD+aPdVboF+U/nTPUsKHmaSiO6
         rU+polGbcTdybDU4xTAk+/dDWte6T/xIOM6x2A7iz6wEgfxyjmMBeCgAQ+MkOkHZv+N+
         uN3q866u0Rf3KQfDEnDCVuz2hA2ecEuKvWW4So6zMcgW9jqXdbkeQal+y0cVkWB2X9AF
         2exfbYzXwjt25GLMjtRYv+PfIQmqI2hJNftmMTFWmhTzQOfz/yKNHoY9MsXfG00lxnEi
         Omcg==
X-Gm-Message-State: ACrzQf1T7cZzanYm6NYMSGcsRWnorYyBsX6n60WkCq8M6TstPzitUlN6
        YlaDKW+2Of2dXVMvF00MX41gccquR6ee2Q==
X-Google-Smtp-Source: AMsMyM6RTU3gyM1H0VlILEGt/1/jyT34htQwK7S+yofz/JoEZaeCcQeaIYPRT8Wg8FcDSaCHjbCo5A==
X-Received: by 2002:a7b:cbc6:0:b0:3c4:20c5:3fc5 with SMTP id n6-20020a7bcbc6000000b003c420c53fc5mr4077786wmi.9.1665608614154;
        Wed, 12 Oct 2022 14:03:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/15] run-command.c: don't copy "ungroup" to "struct parallel_processes"
Date:   Wed, 12 Oct 2022 23:02:30 +0200
Message-Id: <patch-v3-11.15-06de42adc2e-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
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
index e10b1b97390..19d5cff8c65 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1515,7 +1515,6 @@ struct parallel_processes {
 	struct pollfd *pfd;
 
 	unsigned shutdown : 1;
-	const unsigned ungroup : 1;
 
 	size_t output_owner;
 	struct strbuf buffered_output; /* of finished children */
@@ -1552,7 +1551,7 @@ static void pp_init(struct parallel_processes *pp,
 		BUG("you need to specify a get_next_task function");
 
 	CALLOC_ARRAY(pp->children, n);
-	if (!pp->ungroup)
+	if (!opts->ungroup)
 		CALLOC_ARRAY(pp->pfd, n);
 
 	for (size_t i = 0; i < n; i++) {
@@ -1609,17 +1608,17 @@ static int pp_start_one(struct parallel_processes *pp,
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
@@ -1627,14 +1626,14 @@ static int pp_start_one(struct parallel_processes *pp,
 
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
@@ -1705,7 +1704,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 		code = finish_command(&pp->children[i].process);
 
 		if (opts->task_finished)
-			code = opts->task_finished(code, pp->ungroup ? NULL :
+			code = opts->task_finished(code, opts->ungroup ? NULL :
 						   &pp->children[i].err, pp->data,
 						   pp->children[i].data);
 		else
@@ -1722,7 +1721,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			pp->pfd[i].fd = -1;
 		child_process_init(&pp->children[i].process);
 
-		if (pp->ungroup) {
+		if (opts->ungroup) {
 			; /* no strbuf_*() work to do here */
 		} else if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
@@ -1761,7 +1760,6 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		.max_processes = opts->processes,
 		.data = opts->data,
 		.buffered_output = STRBUF_INIT,
-		.ungroup = opts->ungroup,
 	};
 	/* options */
 	const char *tr2_category = opts->tr2_category;
-- 
2.38.0.971.ge79ff6d20e7

