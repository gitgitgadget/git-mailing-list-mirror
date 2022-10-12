Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54617C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJLVE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJLVDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883D56583E
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r13so27926794wrj.11
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh0Fg2Xhh1hoQEPYBziWMa+ayY/kNqB+EUXcNRVSGN8=;
        b=YDs9/9HyXEOJtO4JdKXMKKSzl/oyxaHqgmavdgenSVylA9/8ksx2YjcRe0q1LAOy4w
         Sb06vzCzJ3I3Xbait5TS+iXePNwGMC1ZwlhKhT1s1UV8eg/fRxNiAMRmg/XwaXyUYqvM
         V90JUqIHZgR/f0QncrczpT85Q0BOtPy2E7g1iUdVhoIxe6mRvHWpciy6flgFcqivzBm5
         VF3jDd7byY35QAKR/fjYqtNBUfILpNVhhgKHsnQJF6xz0Kv81pFOXcEoV/zx8zg4tKdY
         qGxdDIjXuBvzuneiVa9vrv58sN24yOLjRSCt3G9X7agTxZz3AVOSmtZAYUhdZZl/HmzM
         3k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh0Fg2Xhh1hoQEPYBziWMa+ayY/kNqB+EUXcNRVSGN8=;
        b=4IzO2uWdhbcqPEsN9EAG5wp5MbQVjtFKyYNBFiwSr08L4EepyAe3t1+BT/Zhd9ZEGu
         Kk3k2o5ZEtRma3EXQAYSrFDuoD9IvfipovoQ3JIZHIb5zUUUcEmyPRn3bFFG2jMmD5e1
         wVuxhwE16NQAMwO/Du6hzpjTwTnunpW74h58iGjSo3h67A1YvvMBJMXfRiS3ZtTxG/y2
         bSS/bEuhhv3KEpSqnlpz7mZMEGIPNNC0FWFvjjr7Rb4sBgD2iq9IFnMUcDKqo1rd4GPb
         NNBPrgJCw8UQ5tXFOgR6OnrUne4KpbH+7odL3jMhENGiLa7kVRVY0w2+zVt3oPw1wzFi
         xHMg==
X-Gm-Message-State: ACrzQf26q9N/hde8Nr8XP/f9kmsOoyQHMdAD29fp4L/uuyfRjKXK9Dr3
        EpP5YTeX6O9sEZNQgqkbndmn60n+4Tcd/w==
X-Google-Smtp-Source: AMsMyM4Q0HRL3x+fpLG2ELHVwblFAlbnOWjN0hMYylGtAdtCgCkpfZL/pavDK+ThSAnw9Ci8WQdiMw==
X-Received: by 2002:adf:ecc1:0:b0:231:b755:e4b2 with SMTP id s1-20020adfecc1000000b00231b755e4b2mr5346560wro.196.1665608618433;
        Wed, 12 Oct 2022 14:03:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/15] run-command.c: remove "max_processes", add "const" to signal() handler
Date:   Wed, 12 Oct 2022 23:02:34 +0200
Message-Id: <patch-v3-15.15-39a20be0cbb-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the *_fn members removed in a preceding commit, let's not copy
the "processes" member of the "struct run_process_parallel_opts" over
to the "struct parallel_processes".

In this case we need the number of processes for the kill_children()
function, which will be called from a signal handler. To do that
adjust this code added in c553c72eed6 (run-command: add an
asynchronous parallel child processor, 2015-12-15) so that we use a
dedicated "struct parallel_processes_for_signal" for passing data to
the signal handler, in addition to the "struct parallel_process" it'll
now have access to our "opts" variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/run-command.c b/run-command.c
index ce7966394d4..c772acd7431 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1497,7 +1497,6 @@ enum child_state {
 };
 
 struct parallel_processes {
-	const size_t max_processes;
 	size_t nr_processes;
 
 	struct {
@@ -1518,24 +1517,38 @@ struct parallel_processes {
 	struct strbuf buffered_output; /* of finished children */
 };
 
-static void kill_children(const struct parallel_processes *pp, int signo)
+struct parallel_processes_for_signal {
+	const struct run_process_parallel_opts *opts;
+	const struct parallel_processes *pp;
+};
+
+static void kill_children(const struct parallel_processes *pp,
+			  const struct run_process_parallel_opts *opts,
+			  int signo)
 {
-	for (size_t i = 0; i < pp->max_processes; i++)
+	for (size_t i = 0; i < opts->processes; i++)
 		if (pp->children[i].state == GIT_CP_WORKING)
 			kill(pp->children[i].process.pid, signo);
 }
 
-static struct parallel_processes *pp_for_signal;
+static void kill_children_signal(const struct parallel_processes_for_signal *pp_sig,
+				 int signo)
+{
+	kill_children(pp_sig->pp, pp_sig->opts, signo);
+}
+
+static struct parallel_processes_for_signal *pp_for_signal;
 
 static void handle_children_on_signal(int signo)
 {
-	kill_children(pp_for_signal, signo);
+	kill_children_signal(pp_for_signal, signo);
 	sigchain_pop(signo);
 	raise(signo);
 }
 
 static void pp_init(struct parallel_processes *pp,
-		    const struct run_process_parallel_opts *opts)
+		    const struct run_process_parallel_opts *opts,
+		    struct parallel_processes_for_signal *pp_sig)
 {
 	const size_t n = opts->processes;
 
@@ -1561,7 +1574,9 @@ static void pp_init(struct parallel_processes *pp,
 		}
 	}
 
-	pp_for_signal = pp;
+	pp_sig->pp = pp;
+	pp_sig->opts = opts;
+	pp_for_signal = pp_sig;
 	sigchain_push_common(handle_children_on_signal);
 }
 
@@ -1759,8 +1774,8 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 	int i, code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
+	struct parallel_processes_for_signal pp_sig;
 	struct parallel_processes pp = {
-		.max_processes = opts->processes,
 		.buffered_output = STRBUF_INIT,
 	};
 	/* options */
@@ -1772,7 +1787,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
 					   "max:%d", opts->processes);
 
-	pp_init(&pp, opts);
+	pp_init(&pp, opts, &pp_sig);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1783,7 +1798,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 				continue;
 			if (code < 0) {
 				pp.shutdown = 1;
-				kill_children(&pp, -code);
+				kill_children(&pp, opts, -code);
 			}
 			break;
 		}
@@ -1800,7 +1815,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		if (code) {
 			pp.shutdown = 1;
 			if (code < 0)
-				kill_children(&pp, -code);
+				kill_children(&pp, opts,-code);
 		}
 	}
 
-- 
2.38.0.971.ge79ff6d20e7

