Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBAC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJLJDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJLJCj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC97BBF1F
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n9so4468917wms.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWiq+1Qk7Pv/yhNrnfikzX8KE+pwJte1q3Q3RPBbztk=;
        b=gewKUH0N41xcuyCOT+sgXzTzJo5+P8xizw2bd6VPO3FzCOO+FHy67p/eQHksIe/WBb
         hngUmlUDyTX2XjhVp3v75jURPpmXhKnNHKYrVWAzM53fZA7pBDAt367do3FMo05/Euvc
         Rjmdvx5+sSzI3ImtZHQ5CZSSG1rZtHhbxNrn0eTTrXtOqt8V3LHycCQtMx9CPT7K6t/5
         QSjeexxF1ejMJcHPak8d4/ziXe3tKPGx/G+ggozVLRMcOta045xbvFWQanKBGJUPCHI5
         zoBDKkYerBWDg7m8ZqRhoAHH7XGJ8Qj+GSaBQqp3ycXftbY2rS/cOeNLeur2Plwqac3S
         tAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWiq+1Qk7Pv/yhNrnfikzX8KE+pwJte1q3Q3RPBbztk=;
        b=cVxuzGRlm1Om2p0fV+1g87Cxb+6S2P+aZ21V2E/Sby063avVRMQ+a5H7Sl2mAdEjfj
         1Vxxy7fEfziOG3V7ta1PK6gcNkk2vQ+kTwOFkytZU8fsDXTEJTYN8EaVhtwc051sOR+c
         zLq2o/JLFeR5NOOmc4AwhgEdwEj0Qx8Pu49tDSpDGXupIlvL3QjA92dYoacuHFs4nwzW
         5E+t5EKio43qDEy3lGncv50Xqt2JvJjEXs3+JW+jepyICIOq98ttCRXzQMH5OZ2Bu7lz
         ctzJITMEDho517o8NwWIp7aW+BSmljpr6scvNQhHWVjbbCaal38T7ln1oC0hdHM4F027
         RnTw==
X-Gm-Message-State: ACrzQf0XQHa+GwHOtYbOiDmC/oyqqUxUR+UGS8ANZrCw8I96IrJ6ZXFc
        m4x7Dba1iRf0aaUhS65OyOiv8D55wNZP+Q==
X-Google-Smtp-Source: AMsMyM6prcboIIEWnp1fkY9rQWwaE7tVDQWdLShDhtBX4nSontjdku53aEgWRWXaSmwMAUNxkY50Zw==
X-Received: by 2002:a1c:f30d:0:b0:3c3:7c80:67f4 with SMTP id q13-20020a1cf30d000000b003c37c8067f4mr1988448wmq.86.1665565326504;
        Wed, 12 Oct 2022 02:02:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:02:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/22] run-command.c: use "opts->processes", not "pp->max_processes"
Date:   Wed, 12 Oct 2022 11:01:28 +0200
Message-Id: <patch-v2-20.22-2dabed9e155-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neither the "processes" nor "max_processes" members ever change after
their initialization, and they're always equivalent, but some existing
code used "pp->max_processes" when we were already passing the "opts"
to the function, let's use the "opts" directly instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index d07ee759b34..b19b62749e0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1597,10 +1597,10 @@ static int pp_start_one(struct parallel_processes *pp,
 	size_t i;
 	int code;
 
-	for (i = 0; i < pp->max_processes; i++)
+	for (i = 0; i < opts->processes; i++)
 		if (pp->children[i].state == GIT_CP_FREE)
 			break;
-	if (i == pp->max_processes)
+	if (i == opts->processes)
 		BUG("bookkeeping is hard");
 
 	code = opts->get_next_task(&pp->children[i].process,
@@ -1685,14 +1685,14 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			       const struct run_process_parallel_opts *opts)
 {
 	int code;
-	size_t i, n = pp->max_processes;
+	size_t i;
 	int result = 0;
 
 	while (pp->nr_processes > 0) {
-		for (i = 0; i < pp->max_processes; i++)
+		for (i = 0; i < opts->processes; i++)
 			if (pp->children[i].state == GIT_CP_WAIT_CLEANUP)
 				break;
-		if (i == pp->max_processes)
+		if (i == opts->processes)
 			break;
 
 		code = finish_command(&pp->children[i].process);
@@ -1721,6 +1721,8 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		} else {
+			const size_t n = opts->processes;
+
 			strbuf_write(&pp->children[i].err, stderr);
 			strbuf_reset(&pp->children[i].err);
 
@@ -1767,7 +1769,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 	while (1) {
 		for (int i = 0;
 		    i < spawn_cap && !pp.shutdown &&
-		    pp.nr_processes < pp.max_processes;
+		    pp.nr_processes < opts->processes;
 		    i++) {
 			code = pp_start_one(&pp, opts);
 			if (!code)
@@ -1781,7 +1783,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		if (!pp.nr_processes)
 			break;
 		if (opts->ungroup) {
-			for (size_t i = 0; i < pp.max_processes; i++)
+			for (size_t i = 0; i < opts->processes; i++)
 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
 		} else {
 			pp_buffer_stderr(&pp, output_timeout);
-- 
2.38.0.971.ge79ff6d20e7

