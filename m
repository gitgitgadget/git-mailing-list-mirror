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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CBCC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E2561037
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbhHCTjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbhHCTjg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAEEC0617A4
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so2494724wmd.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vYekOHyvzpEpbHiytPrbkA/C6k4PdJ2YoVyCuon4lQ=;
        b=IKq1TviR1Ndw9CEheOTk2l2wO1WHKbcqnK8clzhnY3M8iVpqBw1NrS+J8v6g7BpxLa
         iRlsqUPPv8ItR7334dvE66xnqoU98YcW4uw2JLdhbLnnp8hGu41+wY8SRxlB+4cyyUVc
         JfCFMukwbhu4IhWYli2QAuOPKUOjWHkwLWVjl3/IU4wkB7ImFH3yy8wvx1vwpKgJfU1r
         masitl5qTrfpBoOofDwKPy61UsWlgSavlqUDVh2wLATQ1LJ6NzNg+17KV34qsoFLJ5qd
         6NNQdDrjz0ra77eh6zydlylcrXMfKtEOy5rxRHFmWYcmVgIvhtQaB+Bm5pkJW4K+RNFZ
         Xz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vYekOHyvzpEpbHiytPrbkA/C6k4PdJ2YoVyCuon4lQ=;
        b=ZqIKCheImrbazKfwW+wrMuGIN9l4lD5SA6nve4PNpY+u/svetDnxiMQEA1x8olpVL1
         i9XWROmuHrbFdrOkhV6bBQZkMBXP4pkC/yY71q9FiE4LRAubMT0RjyIdVhA58jQFfSND
         s9pz+rG9+gu8QdPUvG5yJOFUhjpc1FpGbTruAcYj2puG+OKDB/LT9++OPisHOCFaMoju
         P3JNLmaEFoGGLG4mWracs+bBny4chJI+39QyUWx9nu1QVnMwqTXPH+mzBfWbL7Da4xRj
         x/YzHNk/IlcbYXRdjb0DXsJ17d3LsNZUYd0XpDGI7/spkXDuW5IwdyzoN8aNJAS5GG8G
         ASjw==
X-Gm-Message-State: AOAM530xvA9dzQJc2F6y8pdly/OxzjgNd4Mj3eMBoH+nRac9TEYX+vKe
        jqu5n4WVTRLxkohOrJZKbfTQt4494K2pHQ==
X-Google-Smtp-Source: ABdhPJyduDXDDlctDZm5VZugou6ylIDa2Tqhi51idiVSUvH0xB6j2b13O3WY7eHCdRSbbYi4J7xtcw==
X-Received: by 2002:a1c:188:: with SMTP id 130mr23996369wmb.184.1628019561536;
        Tue, 03 Aug 2021 12:39:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:21 -0700 (PDT)
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
Subject: [PATCH v4 11/36] am: convert applypatch to use hook.h
Date:   Tue,  3 Aug 2021 21:38:37 +0200
Message-Id: <patch-v4-11.36-050f20d14f0-20210803T191505Z-avarab@gmail.com>
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

Teach pre-applypatch, post-applypatch, and applypatch-msg to use the
hook.h library instead of the run-command.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index c603f3cebdf..e444b18b64a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -446,9 +446,11 @@ static void am_destroy(const struct am_state *state)
 static int run_applypatch_msg_hook(struct am_state *state)
 {
 	int ret;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
 	assert(state->msg);
-	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
+	strvec_push(&opt.args, am_path(state, "final-commit"));
+	ret = run_hooks_oneshot("applypatch-msg", &opt);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -1609,7 +1611,7 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (run_hook_le(NULL, "pre-applypatch", NULL))
+	if (run_hooks_oneshot("pre-applypatch", NULL))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
@@ -1661,7 +1663,7 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hook_le(NULL, "post-applypatch", NULL);
+	run_hooks_oneshot("post-applypatch", NULL);
 
 	strbuf_release(&sb);
 }
-- 
2.33.0.rc0.595.ge31e012651d

