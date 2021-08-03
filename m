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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C9FC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FD460EE8
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbhHCTji (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbhHCTjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECF7C061764
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so2450337wms.2
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9lSSGf1sv0qQkCQL0QsZf8Dse1H0w03hbA91D+KFGw=;
        b=dU2p1UCDraw0V/AjLaYPoax4Cw+nQcDG2ILo3mSlbv0QLvUT58R8c78ePrqc/GsYGV
         uctkeAX/o8a/R/aGu4HJkwITySgocNbWxt3B55Xrkx9cEWSCCkYG/1zvZZVfUESCPO06
         +J86d+WR5U8s13x+u528Uzcdv6nL+gvNw2Nz4Tfzc+5W9bPt0c44Hl7M7k5M92cfPhpp
         9GPDJK9QOMG3m3huMDFzVqqJRVRVPDmbR+pfGx3yVrMlzzpspzFGxDNucVOlLVAWKjWG
         TYZuXOGSAqKp+bnn33NERFADmSOm+NXgAAGnEqob0bObJ58Q7jTOY1FfpKT+OZDWtO0w
         tV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9lSSGf1sv0qQkCQL0QsZf8Dse1H0w03hbA91D+KFGw=;
        b=BJYLwMz/CkQ1pYUV7AC5Oc/xIkdTbteRO/jsgty5e6JEN7zVTXv+HcwPhZzQdgPnlf
         leev8tqM9x2dsy42S15qJu4clw2xa2Oo2hoDTzTyKQaOV94iYlrTII90qiZs8UaXrfCS
         Wpheyz2e1fH9PoyzXW+MlHJrbB3SUtu/0au0H5MjkcmRjvcSbLBoyMg0bvSYTHpgxT0e
         vqyFlcw2ilmH/o5tcS7mp493BESRJwt+qVSvhGvpg7x6Cb39u53/hPqqmG2JdaLNw2gi
         uy5MvNA7WsD/vFHzp1EkiEYaRHRNkPneMpaBk1jRTcyoxtHXhDyTAS9tQI9kpzFI2bKW
         /dyw==
X-Gm-Message-State: AOAM5319Y4hIMJH1zCykV5FyQubI3kPJ2xob8sNXS0L3mMacequg1gaN
        MM2KIqNirazbpgi0cgCvvBtmnrxNhHjdIA==
X-Google-Smtp-Source: ABdhPJzD8u8MbFPpbQhc2TGdolG2dS2VfESvPCkC+MU80Rg4Yj5mMlNyoaAQGV/LOygp4Oor3e8aDw==
X-Received: by 2002:a05:600c:4103:: with SMTP id j3mr24430582wmi.12.1628019555873;
        Tue, 03 Aug 2021 12:39:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:15 -0700 (PDT)
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
Subject: [PATCH v4 06/36] hook.c users: use "hook_exists()" insted of "find_hook()"
Date:   Tue,  3 Aug 2021 21:38:32 +0200
Message-Id: <patch-v4-06.36-d5ef40f77dc-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new hook_exists() function instead of find_hook() where the
latter was called in boolean contexts. This make subsequent changes in
a series where we further refactor the hook API clearer, as we won't
conflate wanting to get the path of the hook with checking for its
existence.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c       | 2 +-
 builtin/merge.c        | 2 +-
 builtin/receive-pack.c | 2 +-
 sequencer.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 51b07ee02ea..aa3c741efa9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1052,7 +1052,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit")) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
diff --git a/builtin/merge.c b/builtin/merge.c
index be98d66b0a8..03f244dd5a0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -849,7 +849,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (find_hook("pre-merge-commit"))
+	if (hook_exists("pre-merge-commit"))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 97aebdc15bd..91fa799b66e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1464,7 +1464,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
diff --git a/sequencer.c b/sequencer.c
index ea4199d65a4..9aac08c1545 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1446,7 +1446,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	if (hook_exists("prepare-commit-msg")) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
-- 
2.33.0.rc0.595.ge31e012651d

