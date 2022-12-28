Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA26C3DA7D
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiL1SBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiL1SAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C0178BB
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n3so14786411wrc.5
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24AYxfGOKt0kvEpasKToBFMori2rehTHt7xakRSaeNM=;
        b=H2kZSFta6rFTvn90DR/vGCaBPQZ5Unx5lJR5/Fg04THXcprFz6ZHhpD2kGOn9xqydo
         1AQxQFZ+DsvcoYxFAQNtyIqXXAZY3TTkHWM7Ge3ZRV28QRtiQaLhxrTA80uybkEyrPHr
         nMFvLWshpkXtl+1p7ZEO22QfCoEzwvzJdaEgSdM5+iQsnhdiL552ZkP8u0lUwW1JA9Vg
         DhDS29vqPR44tgNL5Bs+ZbnCIovHfMwV/O6qvzifK0vhQNWTIF7thJL2fevasbJIx2zs
         p7x8ULeyqLdLxa4TibM1OimkwiEYGkHR1AxjCMTFW0zFH8MoeCZe004JnaYBggMM4lUQ
         mu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24AYxfGOKt0kvEpasKToBFMori2rehTHt7xakRSaeNM=;
        b=ORSczpCnENmPFKp9zQM+6Un6Age/G+EqmuIKvVZGVE0eP6e1ps3dQ6xyt/b286fkPk
         6tcyh+27dbg5+GfeHhBKnKTKGdjZqu5V4XUxG37rTgUuFHEisv8qTAyZl9RJQ9ZzOHaf
         44yT8S3oNgaGlESmPTTh6pImPL90XCPchpT7cPpyHyMVXBK4jnCwsox0ubPy4KDdanDr
         NGA2nJBMOJvGlCMi6IAOCzDT8E3J+aQrv6YS00e/tTL2mfN3zNsj5sU1M8lKNuak8ySH
         jL62TD0OQwsfJpgn76bwpFxnP5mJkBoveihgNtrFDgkCc9aPp6FVrim7pRjPA3KFNbrV
         9O2w==
X-Gm-Message-State: AFqh2kpZZoTSUvzK/oYpVE97C2dwJH6CB4AQWDnTyxa99utG5xiC+/qo
        OCh5iBlU3vVrvzxT0TN7maNmxwaPCIHp4A==
X-Google-Smtp-Source: AMrXdXusfVu1Bl+YK3bg2/t+4vhJctBZNBRSZU+tsghhBQaN3p/hO7+mY82xN1fQaFsNkgZJA9fyZQ==
X-Received: by 2002:a5d:430e:0:b0:279:53e1:5178 with SMTP id h14-20020a5d430e000000b0027953e15178mr8642521wrq.45.1672250438610;
        Wed, 28 Dec 2022 10:00:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/20] commit-graph: fix a parse_options_concat() leak
Date:   Wed, 28 Dec 2022 19:00:13 +0100
Message-Id: <patch-13.20-78f12259ac5-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the parse_options_concat() was added to this file in
84e4484f128 (commit-graph: use parse_options_concat(), 2021-08-23) we
wouldn't free() it if we returned early in these cases.

Since "result" is 0 by default we can "goto cleanup" in both cases,
and only need to set "result" if write_commit_graph_reachable() fails.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index b6e5726b082..c76faffde4b 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -269,8 +269,8 @@ static int graph_write(int argc, const char **argv, const char *prefix)
 
 	if (opts.reachable) {
 		if (write_commit_graph_reachable(odb, flags, &write_opts))
-			return 1;
-		return 0;
+			result = 1;
+		goto cleanup;
 	}
 
 	if (opts.stdin_packs) {
-- 
2.39.0.1153.gb0033028ca9

