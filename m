Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C7FC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJLVEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJLVDl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963E4A118
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so1914973wmr.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crgGSHXTomG+o2Ee5LO6r8XHkdaAmnrSdV1KNjX9cOI=;
        b=mz7BOeB4rmPwM7lX3dxvAksRIyAUVdBDjyV02UspLiYuQAchjUI++JCWlA3cQtZ60b
         oK5gjCT7DMb5sbjUa4J4KQrmYGystgRYIOjFCZOHvsRp7+K7vOsK+VSikAKtQbKEosJD
         RX6KH/+iWEJAdCGISDsPST/r44vpGbKb0e+znOASCQ3PpZJc5IO+AyIHlaCF1x5/b2Xw
         5ZHkKwEu1Imo6R1r4gB2LFKjrVVPz9fvaqn3p1eYCTk7iy5VRiaA2FBFXAJ9O03WIxQ3
         iyUI+GeUfJUrWU7NUmGTMhGDxV67sok0dJcuxEl7q1AvI0IJKEAkGGLJLLTYtPXoacNy
         frkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crgGSHXTomG+o2Ee5LO6r8XHkdaAmnrSdV1KNjX9cOI=;
        b=KyqMnK9/znCLy2KcU7t50NV1wgpKEg9Vjyu723uRlmWlX6aPPN7fbU5eCIxTQkrLPR
         Yi8Xf2SKq52+EAVigs34jtXZs9NuYfhX3le8bBHyq2eu1toV+AbJaPeMS/jc4H08sMnv
         niQFkpFmM9rSX6NwBO88RvwddKLsWB7GQk1gb5MtHtckR60W9SoSwNNQiELSEhn1Yba0
         zpPCkyM3JEPeBSmXSoxM8gaKSy0EPRAqSg/EhZCL5kZB8jJMqI64iJ0MVYYFx3I9YvN9
         HRnZgvAQTnTAgtQ7PvexFJf+sfv7EAh2XXQYPa9e3VPlHFVjBp34sLmBonnRk0y1Lg0z
         z9xA==
X-Gm-Message-State: ACrzQf3YFAB02F+8BoFoT+WHh6USKWowtehMzq7tbwt+hHaeajp42aNj
        8RAeC9w4pRJQw1TVAfwIU/0G8X5+uB+vZA==
X-Google-Smtp-Source: AMsMyM6onsy0tPrLUe/pXr+Xo71ICDB1j2QG9VvUXPIliXYRtL9Dnb6gkUGoGaQgMWNHZ+RN510EsQ==
X-Received: by 2002:a1c:6a08:0:b0:3c4:a83b:bc4 with SMTP id f8-20020a1c6a08000000b003c4a83b0bc4mr4014964wmc.115.1665608616414;
        Wed, 12 Oct 2022 14:03:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/15] run-command.c: use "opts->processes", not "pp->max_processes"
Date:   Wed, 12 Oct 2022 23:02:32 +0200
Message-Id: <patch-v3-13.15-b7c10f6a23f-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
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
index d382c42f82d..719a5b58e29 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1599,10 +1599,10 @@ static int pp_start_one(struct parallel_processes *pp,
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
@@ -1689,14 +1689,14 @@ static int pp_collect_finished(struct parallel_processes *pp,
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
@@ -1725,6 +1725,8 @@ static int pp_collect_finished(struct parallel_processes *pp,
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
 			strbuf_reset(&pp->children[i].err);
 		} else {
+			const size_t n = opts->processes;
+
 			strbuf_write(&pp->children[i].err, stderr);
 			strbuf_reset(&pp->children[i].err);
 
@@ -1771,7 +1773,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&
-		    pp.nr_processes < pp.max_processes;
+		    pp.nr_processes < opts->processes;
 		    i++) {
 			code = pp_start_one(&pp, opts);
 			if (!code)
@@ -1785,7 +1787,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
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

