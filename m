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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0318EC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FBF61037
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhHCTkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbhHCTjn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CDBC0617B0
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l18so26471762wrv.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHCqX0VaO37vKmhX8jZUiyguk1+2q+4YuX+EjBgC2hY=;
        b=eYMclEGT7UZ6zhKUup7ZK72PeFMbqwus1iTu0kbRL3fMqXsU+dN1/ylk3wqI+0hrc6
         YbFjPSzuIctFSXG3TWJhGVzYv/Dal42J3r33O67rvVUQTLWN+j+npmahvNpA2FjaaNyS
         CoVjAi2ZMjGqgITOe8aGTfNeo031xKg3Md/dKDYy73iDMA0f3WxS/3knZuPWLRYCBeLW
         tH86rb/sSNzcdVHKZXXyi3sRd9vnZoK6LPQhjzmaa53x3J62H4HgK3imfdgG5ptP6TH4
         1n1fvEVXpKpILr/WviSwImsEVDK7mxNQRMlRH2q90R39jUmcKfIfge1wXAcY3TmhPb42
         AQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHCqX0VaO37vKmhX8jZUiyguk1+2q+4YuX+EjBgC2hY=;
        b=JP8WzhhW12y8rDTT6c3zhsbLzC3cQoLQAi2tprFvos11kXrg1mz4AV15lXCpH5I6aJ
         UHrZPVxvHyq6j6GocLVoibsc+BaApVPTVI+cvkib6vOYpC9xJYFDG8nfA/k+HoxErr4n
         SmIG1d5+i+q8d9LWwwgyNa4Uw9FqwHgjhg9s0pcRn29U6hvTmROOA2kRLgdaFiNuWpAK
         wfe+Tb7pu+BtDDhbpKJEWTedWdFvV4Fnpj9ct/Zlv0sXVwsfD7CbjoxqJiy4GuwY3TP/
         nsk5Bi2+LC5XS22/7Pquv6j+Rfzx/4kyMP/04F5ichSJgQat757ZTeXPmwP9mdAgiLft
         gVfw==
X-Gm-Message-State: AOAM532wM94/Y9C7e/NRWc7vJYxVyjDy9d839aScElvvrkpoVObAu47O
        gJceb2G7jUuPXs6Hr1PkwFo9ec8oQMZxlA==
X-Google-Smtp-Source: ABdhPJy92i5zIqGmT9BkTLDzY3yVUQaCkH3/6SA/mg8lF+JdnoyJHdf3DyJdpKKZaecXn+LPt0fX4w==
X-Received: by 2002:a5d:526a:: with SMTP id l10mr25385758wrc.40.1628019569452;
        Tue, 03 Aug 2021 12:39:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:28 -0700 (PDT)
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
Subject: [PATCH v4 19/36] receive-pack: convert push-to-checkout hook to hook.h
Date:   Tue,  3 Aug 2021 21:38:45 +0200
Message-Id: <patch-v4-19.36-893f8666301-20210803T191505Z-avarab@gmail.com>
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

Move the push-to-checkout hook away from run-command.h to and over to
the new hook.h library.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 91fa799b66e..a7d03bbc7d3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1435,9 +1435,12 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks_oneshot(push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
-- 
2.33.0.rc0.595.ge31e012651d

