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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF50C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D1D610A0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbhIBNON (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345226AbhIBNNw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CBC06114B
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso1406892wms.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUewC8kYyqtcKMjvm6xu28EbYkmcIlakTlRv6tNfFyg=;
        b=PDw7tCEl15bYS2jgoVhPjNmYNm2euu4OqvWMW9wRM6BHfk1S4CeivnaNH9BabaanRt
         Urz3jO86FgxScqj2bOCyCqS1KEv49UpAImVxOOJLqBUwEHjFlKJ/eehJih8TcLePwdqZ
         s6isszQw7E7AfpNgudd4CAekGBGoVCIyokCZxLzOnOMQYdR9fqI/guGMTjg5BYSmYtJn
         XJ3xmRR/OA1w90QHRnZIwjAbhE4lOPCSGWDK+iEjduAZCxQ/11DKYU2IL/654H45JktA
         dSNvrHvCxe69ckuBXw4n1BtGDrYjf6NTWES9FHYSESe6neEtqUrX5HGrfRzBAUM9XhHL
         nStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUewC8kYyqtcKMjvm6xu28EbYkmcIlakTlRv6tNfFyg=;
        b=OQsKnIazn87Ig6wgepdggf/olIze9sWFltSLyeSCEFIaLzmdk81U+To2GeDjrehzh2
         F95nxPZMDvhXksz+Ok13XDujHqaAryOGts7WqRpA7aFN5ZHE5H369c7OqAk+ig69sECm
         wbNCcPjBJzhFzxjjcyjNelZ4j3pG+YhaLjBAW1KHKkLs8ULgJcbkHYKo8dLp8bhJqye/
         WNKDn9lmDOFeZgWcR6E5qcKga1mTZSrz2uv44c5SrfwTDqcg07o++xOqtBjYzKKEyAQM
         ZaVM8E6Jno5Az4OFOEcguvMwWCXqCAE35rld/QuS94WHreDDINWMwmREQqPU7HcVBZb0
         8UxQ==
X-Gm-Message-State: AOAM5302j/spKW81xcp2r8dPZtVO8ZuzEyYiL4VAyn6xEEXySAbuHTPa
        6P0E16AIXxd86lsjJEk/h6c+/BYqivQZRQ==
X-Google-Smtp-Source: ABdhPJyF0dMwaERXC8BgGBBZtX8P2iw3FAcvR6II0lOPBY9aMC4glZC93EJqhuYtHfeWG9oB3asQgA==
X-Received: by 2002:a1c:4e11:: with SMTP id g17mr3170126wmh.2.1630588339135;
        Thu, 02 Sep 2021 06:12:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:18 -0700 (PDT)
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
Subject: [PATCH v5 32/36] hooks: allow callers to capture output
Date:   Thu,  2 Sep 2021 15:11:32 +0200
Message-Id: <patch-v5-32.36-7d185cdf9d1-20210902T125111Z-avarab@gmail.com>
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

Some server-side hooks will require capturing output to send over
sideband instead of printing directly to stderr. Expose that capability.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 3 ++-
 hook.h | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 169287ad152..7f93fe40dba 100644
--- a/hook.c
+++ b/hook.c
@@ -174,12 +174,13 @@ int run_hooks(const char *hook_name, const char *hook_path,
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
-				   NULL,
+				   options->consume_sideband,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
 				   hook_name);
 
+
 	if (options->absolute_path)
 		strbuf_release(&abs_path);
 	free(my_hook.feed_pipe_cb_data);
diff --git a/hook.h b/hook.h
index 4e26b8d658d..a85e3e6981b 100644
--- a/hook.h
+++ b/hook.h
@@ -47,6 +47,14 @@ struct run_hooks_opt
 	 */
 	feed_pipe_fn feed_pipe;
 	void *feed_pipe_ctx;
+
+	/*
+	 * Populate this to capture output and prevent it from being printed to
+	 * stderr. This will be passed directly through to
+	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
+	 * for an example.
+	 */
+	consume_sideband_fn consume_sideband;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.33.0.816.g1ba32acadee

