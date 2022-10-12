Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60724C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJLJDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJLJCk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE9CB97A4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b4so25266013wrs.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROCVsX5/tkZdcHQMUTjeGgC1L1zCsLPmUFZsLtReitY=;
        b=k1iNzqYInVl7RcJFLanH6IDIFh/YHj6fv0VHioMeds72+drs6RqZBfsQ/KMPOiRDT9
         L6WD8MG1RocFBAJPSFjNOZyb0ftUwU/nuvg8WPjvjpJCR0CY/1TCnNyiryCTnUq2P06N
         i45JRyVv3Ug2QA1BtEfthVWRsRcYyOUX4iOY/bl956DL2TqhN6kya5fIymOCtNyJlIl2
         W6av8VsjdMJoz80rKdPkcMa9VqK8fpIlYZmDcOcFgXwhsTSoJbNnu5g1TBdm9Rf8oT3q
         ld+nh5SelXZvWJJlSEG3ZKAkLpBlh2sa85lhcr1ce57OS1ddX732zQ1Ekj0yCiNZicHw
         7LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROCVsX5/tkZdcHQMUTjeGgC1L1zCsLPmUFZsLtReitY=;
        b=cD26k7CKAu8PM/P/N5NcWomQXTRzDGh/KBCgF11IFlPRiRXFBTjHWSBpjwJEq8Q18+
         i6IznEPTen0WcQA8PdiGoHQK76uthgYYxkR6ap892ku2chko/LrlDUxOYZkhRjHansrK
         W1FwGjL7hO0dIsJVr13KzJcP35Oxu9bofwLGbP9+n7V0R6stCpuMnTT//CmKlaeZ/a8G
         ioF1+ngyYHqDn3kmTbw5VizZOL5SnCZw9YI5ZQPOpc16u1yv496LPNqYtZPZW3tYOczf
         OxWu2gUvr2tIHDAupmJqkmsbmzsmYqnL6oWUhLGWxrrnSawcH7qlIXqvQdKGVcDhYOSK
         cj4w==
X-Gm-Message-State: ACrzQf3+jF3Nh07Hs3pR9tgjXj3j6gSvZ+wTYHxQmrC/2KaQl002Urxk
        v5pvWx1JMmHlr9aW568EVKwa/NIHaxEevQ==
X-Google-Smtp-Source: AMsMyM7Bo+gXSqvDVMERz+KfPRcAdGgfVxcWs+FOt4334WNQ+PtieuqkDCOD64CpyWKIpmXlfD0vQw==
X-Received: by 2002:a5d:500a:0:b0:22e:34bd:c907 with SMTP id e10-20020a5d500a000000b0022e34bdc907mr16921913wrt.548.1665565329247;
        Wed, 12 Oct 2022 02:02:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:02:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 22/22] run-command.c: remove "pp->max_processes", add "const" to signal() handler
Date:   Wed, 12 Oct 2022 11:01:30 +0200
Message-Id: <patch-v2-22.22-541f41566e7-20221012T084850Z-avarab@gmail.com>
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
 run-command.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/run-command.c b/run-command.c
index 6b91235ff2d..a6c123ade1a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1495,7 +1495,6 @@ enum child_state {
 };
 
 struct parallel_processes {
-	const size_t max_processes;
 	size_t nr_processes;
 
 	struct {
@@ -1516,24 +1515,38 @@ struct parallel_processes {
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
 
@@ -1559,7 +1572,8 @@ static void pp_init(struct parallel_processes *pp,
 		}
 	}
 
-	pp_for_signal = pp;
+	pp_sig->pp = pp;
+	pp_sig->opts = opts;
 	sigchain_push_common(handle_children_on_signal);
 }
 
@@ -1755,8 +1769,8 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 	int code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
+	struct parallel_processes_for_signal pp_sig;
 	struct parallel_processes pp = {
-		.max_processes = opts->processes,
 		.buffered_output = STRBUF_INIT,
 	};
 	/* options */
@@ -1768,7 +1782,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
 					   "max:%d", opts->processes);
 
-	pp_init(&pp, opts);
+	pp_init(&pp, opts, &pp_sig);
 	while (1) {
 		for (int i = 0;
 		    i < spawn_cap && !pp.shutdown &&
@@ -1779,7 +1793,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 				continue;
 			if (code < 0) {
 				pp.shutdown = 1;
-				kill_children(&pp, -code);
+				kill_children(&pp, opts, -code);
 			}
 			break;
 		}
@@ -1796,7 +1810,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		if (code) {
 			pp.shutdown = 1;
 			if (code < 0)
-				kill_children(&pp, -code);
+				kill_children(&pp, opts,-code);
 		}
 	}
 
-- 
2.38.0.971.ge79ff6d20e7

