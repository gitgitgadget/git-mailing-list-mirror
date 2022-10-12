Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A26C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJLJDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJLJCk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CECB8C27
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bu30so25235481wrb.8
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHh9sxSAxHJ86Rf94FzCNVK6qVMsfZrPHIHVMtkKSpQ=;
        b=EEYQEwIgSj56l73jfLO9ltyiMTjGXlgjdL1j1Lpy6IxoJoR40upFVjrAJpiE5H7ylB
         le7olY3gIJ2dR7IDApBodhmyCGDmaQupFAGqDDf5j+tI/qhtB0uJJRQfJjNDs0zhDMic
         /v9eDAojIE3CoyT8CM9seuOG3v0GSdwDq8eSZrFXf6i/DMqh6fa7M9ehBQsy4LRnZVZ6
         k+ktgwosdoW5Uh38ypPe+/QrcK7wbh38+0d+aol+QbB2dI7tu8ZDLEm/j+WHnf1rzjl3
         xnrJ2sEtH1J+obDKokRyFuxMUr1NMLBK8KngcoFz0kysLO/uRKP9p9ckUT1CjbDKKQQX
         ukGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHh9sxSAxHJ86Rf94FzCNVK6qVMsfZrPHIHVMtkKSpQ=;
        b=pxP552IL8MxsrLtXSRH/wwGLwjpFd6ANuriaP/UolPKom0hZFSde4Dih5rz3tPoHKD
         8emhDtTVvwbcNs9VGFDsVNTiQuE8Lec/SUqJVQsbCu0Kr2QaEgq8kzu9tdljbaLQZ3p6
         gxI43PfZtmzB5mj9H6sxPPnW7+C9AuqAP5hLQ0SGzsG6ea8E0fVB4i/UPO+lwqnDqcYB
         /hUAeCD4JI9/pegjqTZFU0sO2PfMT1AIoKR7rCqFl1ZptcqproVj4IL+cIXwCjw/uHSp
         x7LphVqjIZLxmwNHmbqzk6viH/Z7CfyigWkjiFCHo51utrbVipsTMuiksoNyypgs/+tY
         z1EQ==
X-Gm-Message-State: ACrzQf3nFOi6sOFUue4j0QdXE43xSoFK+wA4/HuSmx5XpSin2hI3EqWp
        Bit9nx8UZOHdwqmCq3Zs0cDsan29lqqQdA==
X-Google-Smtp-Source: AMsMyM5YmV7nUX4jiKFbLChno4zi47khfv1rJj0S050KW1024VY8WdpYXEDsp7DlxHzlF62M5kIzTA==
X-Received: by 2002:a5d:4e4f:0:b0:22e:3e3a:a65d with SMTP id r15-20020a5d4e4f000000b0022e3e3aa65dmr17962055wrt.115.1665565327579;
        Wed, 12 Oct 2022 02:02:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:02:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 21/22] run-command.c: pass "opts" further down, and use "opts->processes"
Date:   Wed, 12 Oct 2022 11:01:29 +0200
Message-Id: <patch-v2-21.22-c1a286a8ebb-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the migration away from the "max_processes" member of "struct
parallel_processes" to the "processes" member of the "struct
run_process_parallel_opts", in this case we needed to pass the "opts"
further down into pp_cleanup() and pp_buffer_stderr().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index b19b62749e0..6b91235ff2d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1563,10 +1563,11 @@ static void pp_init(struct parallel_processes *pp,
 	sigchain_push_common(handle_children_on_signal);
 }
 
-static void pp_cleanup(struct parallel_processes *pp)
+static void pp_cleanup(struct parallel_processes *pp,
+		       const struct run_process_parallel_opts *opts)
 {
 	trace_printf("run_processes_parallel: done");
-	for (size_t i = 0; i < pp->max_processes; i++) {
+	for (size_t i = 0; i < opts->processes; i++) {
 		strbuf_release(&pp->children[i].err);
 		child_process_clear(&pp->children[i].process);
 	}
@@ -1645,17 +1646,19 @@ static int pp_start_one(struct parallel_processes *pp,
 	return 0;
 }
 
-static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
+static void pp_buffer_stderr(struct parallel_processes *pp,
+			     const struct run_process_parallel_opts *opts,
+			     int output_timeout)
 {
-	while (poll(pp->pfd, pp->max_processes, output_timeout) < 0) {
+	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
 		if (errno == EINTR)
 			continue;
-		pp_cleanup(pp);
+		pp_cleanup(pp, opts);
 		die_errno("poll");
 	}
 
 	/* Buffer output from all pipes. */
-	for (size_t i = 0; i < pp->max_processes; i++) {
+	for (size_t i = 0; i < opts->processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
 			int n = strbuf_read_once(&pp->children[i].err,
@@ -1786,7 +1789,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 			for (size_t i = 0; i < opts->processes; i++)
 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
 		} else {
-			pp_buffer_stderr(&pp, output_timeout);
+			pp_buffer_stderr(&pp, opts, output_timeout);
 			pp_output(&pp);
 		}
 		code = pp_collect_finished(&pp, opts);
@@ -1797,7 +1800,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		}
 	}
 
-	pp_cleanup(&pp);
+	pp_cleanup(&pp, opts);
 
 	if (do_trace2)
 		trace2_region_leave(tr2_category, tr2_label, NULL);
-- 
2.38.0.971.ge79ff6d20e7

