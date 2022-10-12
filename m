Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE3C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJLVEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJLVDr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FDB13EAF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u10so27977623wrq.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2qPtg4voyOuFwXp2Lzn6VX/8MTszyFp6nPZbwyk5+U=;
        b=IRm2Z0x0PNUmg5zaqY9NEQyrmTelYr+J9/mqAehjuNa2E1khBHVkHueNV4x4v+ChFu
         2nK7Zo4+TdmyRwW5h24rwV+73PUCA/9wCoh+C/26KjBGDIsHW5UEpoAz3U+C6hkDe6dE
         HxD7icv6Tfl9NzUX5X7m+T/ba9BEu1RoYZ7fcIbuqWlRhss1Q3SqFvSL194r7zCEld3H
         RUM2Mp51QXFdQGNUWfghA7D3geZKfr8bhghnC+xuaNrkaLLgIj+WOWS7y3Xd7+tq2rPP
         na/dO9w4Z1G7icQ/Z9njrpD4enVA7KW0ibnmE9yHcOOArxR/lwLZLJC9+mShPiphSmCd
         ZLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2qPtg4voyOuFwXp2Lzn6VX/8MTszyFp6nPZbwyk5+U=;
        b=WUrOaT0U+9XGl5LWJgim1VBuJGUliL0/N00WywA5nRLbBRl+4P1GgUirZJBfFvO+ln
         R1NhCBCIDBs/fMEIebWN0MuWBt/Kmh9dmPPbpDrB/4RuGun7pxuavZz5prH26GWyfdo0
         lFeA7BykDj/8qSaYfbumg3tyLNW0irvDg2wjyD41Wr1EdvWLp95THh7+UjjhamVm6Z8u
         Ot3qVNMSS8Sq4HMOa5rTf9XSpkUVPQyRNoWDogq6DdlnfDdqCw7MFwoMHkfEV8PlKHo7
         dwEwpvJKvCzeJh6F7hSVbzG9LOZqM3HP2ZjUGi1LQ+O8B0If3S2kwt30x97lF9vABxQt
         9lFg==
X-Gm-Message-State: ACrzQf0Qjg9zfn42czkI8Ey1Q+n1xDtAbY9YER+JzI5ozn19b4lQoK5c
        kww4WPKkj3GWGirQsMAApdDM09cMF40qDw==
X-Google-Smtp-Source: AMsMyM5U5EOLNMSf+EZgka/6Y5UhsiEoNy/PRcm1LAy4awRssBvL8d51XB5R6VIr6W62gz9zjeiHhA==
X-Received: by 2002:adf:aad1:0:b0:22e:3667:d307 with SMTP id i17-20020adfaad1000000b0022e3667d307mr20344886wrc.359.1665608617482;
        Wed, 12 Oct 2022 14:03:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/15] run-command.c: pass "opts" further down, and use "opts->processes"
Date:   Wed, 12 Oct 2022 23:02:33 +0200
Message-Id: <patch-v3-14.15-4856d6a4674-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
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
index 719a5b58e29..ce7966394d4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1565,10 +1565,11 @@ static void pp_init(struct parallel_processes *pp,
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
@@ -1647,19 +1648,21 @@ static int pp_start_one(struct parallel_processes *pp,
 	return 0;
 }
 
-static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
+static void pp_buffer_stderr(struct parallel_processes *pp,
+			     const struct run_process_parallel_opts *opts,
+			     int output_timeout)
 {
 	int i;
 
-	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
+	while ((i = poll(pp->pfd, opts->processes, output_timeout) < 0)) {
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
@@ -1790,7 +1793,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 			for (size_t i = 0; i < opts->processes; i++)
 				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
 		} else {
-			pp_buffer_stderr(&pp, output_timeout);
+			pp_buffer_stderr(&pp, opts, output_timeout);
 			pp_output(&pp);
 		}
 		code = pp_collect_finished(&pp, opts);
@@ -1801,7 +1804,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		}
 	}
 
-	pp_cleanup(&pp);
+	pp_cleanup(&pp, opts);
 
 	if (do_trace2)
 		trace2_region_leave(tr2_category, tr2_label, NULL);
-- 
2.38.0.971.ge79ff6d20e7

