Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4563BC433FE
	for <git@archiver.kernel.org>; Wed, 18 May 2022 20:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbiERUFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 16:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242264AbiERUFf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 16:05:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273FB2375C4
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k30so4152825wrd.5
        for <git@vger.kernel.org>; Wed, 18 May 2022 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/u9MXgIjBzGCtIK8vpp0tte2/yRO94eKu3/TNl5XG8=;
        b=RqbA5xkqtZspcEcoMQUjePa+vA2n0LL72zT7seuMRvJnLai6hmySOMi8MfUnktUZgW
         UH4g7M8sZLm+iB6d/SBuVYPjJNN0X40li67YkmBJQtLeyA2a3RdLaTVmKRjos6VNG8Xf
         pqGj4zYXU/NPKN8KE7d243/JYj7qoDMGHI/kv+tHKpm1MdT7712r/mx1b2ZkZ08nf/o2
         lIbv7S9Jb5cf56y7Yz/Af/vEUBxI46WdUUn8oxgWN2ozLRalR2ofaJ2eH40U0MCaS/7E
         F4LgqYgh/v9JpXtgZ41uGSDYMCFO4WeddeXgQhQ9hXOB2mByJGKmJIKm9tblYQBplx9g
         Dyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/u9MXgIjBzGCtIK8vpp0tte2/yRO94eKu3/TNl5XG8=;
        b=pL6c+Mdd8Ie6wd2AxOYWQAATC7qtJrja5FN6JDvWDIfFRMJ1gFN+/lFVy1uMM7Ap6T
         yPRgoVv6tFLefNL8J75goQm8pedAAG1g+uwmA0/sdWev1qAJhYofyi/meHyvDLIrGfBd
         d3GIR8Pv105nE+XKqqE0xKVFS3muRzFCroFP6R0rcpnCzK/HQvPacSXnqd16reH5ePei
         0o3QRY/Vra3m9dyvt9m7ERcHt2SwcPXOEkQSgL//1M4L87h25VNs/CfUAmw2Yo3aYkbz
         tw6HYBSkbPLVLrbB3r59/W2MDN76PgyyNbX/6MBIdCjAM9T4NZjMxev+yz9W6U8mFc2+
         VR8A==
X-Gm-Message-State: AOAM532cwXLC7WGktXvTGqqfSecHCXpcwaNozT9EvSZKCgXMHP+rEmVH
        33Df2Tnz93+o5KRHSf8IIpdIXbtpGoUpKA==
X-Google-Smtp-Source: ABdhPJz3c9e4KnPQbDG53JwKG/RYi1KC5O6ia6LuJSOaGRNr33mTvZFEaOEHNtvON5HmozcIsOB0Sg==
X-Received: by 2002:adf:f085:0:b0:20d:e4d:1fe with SMTP id n5-20020adff085000000b0020d0e4d01femr1114181wro.42.1652904332466;
        Wed, 18 May 2022 13:05:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b0020d00174eabsm2674441wre.94.2022.05.18.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] run-command.c: add an initializer for "struct parallel_processes"
Date:   Wed, 18 May 2022 22:05:20 +0200
Message-Id: <patch-v2-4.8-663936fb4ad-20220518T195858Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g0ae626f6cd7
In-Reply-To: <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a PARALLEL_PROCESSES_INIT macro for "struct parallel_processes",
this allows us to do away with a call to strbuf_init(), in subsequent
commits we'll be able to rely on other fields being NULL'd.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 8c156fd080e..839c85d12e5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1498,6 +1498,9 @@ struct parallel_processes {
 	int output_owner;
 	struct strbuf buffered_output; /* of finished children */
 };
+#define PARALLEL_PROCESSES_INIT { \
+	.buffered_output = STRBUF_INIT, \
+}
 
 static int default_start_failure(struct strbuf *out,
 				 void *pp_cb,
@@ -1562,7 +1565,6 @@ static void pp_init(struct parallel_processes *pp,
 	pp->shutdown = 0;
 	CALLOC_ARRAY(pp->children, n);
 	CALLOC_ARRAY(pp->pfd, n);
-	strbuf_init(&pp->buffered_output, 0);
 
 	for (i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
@@ -1744,7 +1746,7 @@ int run_processes_parallel(struct run_process_parallel_opts *opts)
 	int i, code;
 	int output_timeout = 100;
 	int spawn_cap = 4;
-	struct parallel_processes pp;
+	struct parallel_processes pp = PARALLEL_PROCESSES_INIT;
 	const char *tr2_category = opts->tr2_category;
 	const char *tr2_label = opts->tr2_label;
 	const int do_trace2 = tr2_category && tr2_label;
-- 
2.36.1.952.g0ae626f6cd7

