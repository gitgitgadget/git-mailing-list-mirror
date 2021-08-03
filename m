Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B54C4320E
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C95560EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbhHCTkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbhHCTj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798DFC06136C
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c16so26472221wrp.13
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvW3V7M+OI+BgkcwtyCLIYcAP2tVMxhrTUAAeJ6vL9I=;
        b=ftavWhffpyUguFy++suVR7o1V2MxBRu0cGBpMPXf5O6VvFMxbzrSVkpcN+WB76BaBh
         NTccn9Sh/NEHCD4Qr/k0JgfldXeoj9eW/cS0GmNISk6gorDoX6+DL53S6PVaqoinru69
         KGGwHuYGHtOL2RaLzilROsRlTt0mztG/5oBhqBHjFiFXEPrhDEbrkSi3tguJI5FlS33Y
         udOlhjOxA/q1SMnLrRppHHuDg+CzV/C04eXJtzOnB4vrRBXjZjNQK5fshTYd1AX/w9lc
         O+krdCTti3c+NPkQ9fGJmhosBU4l6gCEpfDDvi0TpjsqZq4ILVpokgtA3NzLxar1+dPb
         A8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvW3V7M+OI+BgkcwtyCLIYcAP2tVMxhrTUAAeJ6vL9I=;
        b=pQAOemBR91LPnzTJF2lFZM3x2Yi/whammxOELaUU6go1fCdZeZGMZk8/ozaKM6dAqJ
         +i8EPTS1plKEVuoYKczHn5SbNqQjl25sDZ5xdr2d7GvC7Xv5fGS3ol6mXa28rgUrntL6
         kmH5/wqKqTptfaiL62huq82QQ45yzCZsvuq++w2WMxNFXpxQhjC3cU3UJbe0j1vNSdc7
         /QtrJ4A2QWW7wx/O09jsXQ6hY8kLJ+Y8MCnwSknxpLFVvfIkRrNEEQTyj9+H6m1T2MQb
         w+nrbqjz2b1uz5N0bDXCNAFfTeM8dQlT2Aqt6hRnDlkpSIrRv+TW8s6RHilUoKtAK+PS
         LQDg==
X-Gm-Message-State: AOAM532hEy0woHOZa54CGli6CkqlwEbM5U2yG/MUBJm6Iu6SPHfK4IDZ
        2aYhprHITC2BM8dQYIOWIaFn7uiIIn1R1w==
X-Google-Smtp-Source: ABdhPJx/zwJoEjd6ZG2Jlc7Cm/nZj10AF9QFdFCGfhvvbys2RXb1AGpwAeBoXyykC03LD7cYTuhy3w==
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr24035994wrs.367.1628019580809;
        Tue, 03 Aug 2021 12:39:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:40 -0700 (PDT)
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
Subject: [PATCH v4 32/36] hooks: allow callers to capture output
Date:   Tue,  3 Aug 2021 21:38:58 +0200
Message-Id: <patch-v4-32.36-0b6e9c6d07a-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index 9ae3007cdd3..efed5f73b4d 100644
--- a/hook.c
+++ b/hook.c
@@ -203,12 +203,13 @@ int run_hooks(const char *hook_name, const char *hook_path,
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
index b55f283f90b..37a9690c2ca 100644
--- a/hook.h
+++ b/hook.h
@@ -58,6 +58,14 @@ struct run_hooks_opt
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
2.33.0.rc0.595.ge31e012651d

