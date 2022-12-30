Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD352C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiL3CTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiL3CS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA9C17882
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c17so28840089edj.13
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pq4xbFTh2jF0itR3ZIPXejvF+NP8xceGshYiJYNvNA=;
        b=iGxJiXifWfg0p1otGqPS2zLPmTXcfwaPKD6f8NfMSeQngRA/gpyKACup1r1qr8yx6o
         4rD6fW05Pv/JGm8AVrjuplWBF5cTRrIfdCbPJxsir/cgeU50BAsY8cQtWhOB9G6Q2iaB
         XT+tibYjhWmsaR2n+dmULcDL3RbLBxfHNboNkVKIrbawypgPhVZ5I0JAoPQwcDzIm0ug
         D014goBd5pUQDP0W4E6a0y4HlEPIJxn8VcHKJetp/5sFkAd41UB++77JaqS0Yxebdq6K
         6rYIMFJnZXC4OROyaDZm0sP03cufPbZRO6aWiKDWYyAUnCQnEo3P/e0R47R9DD0Gzurd
         TXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pq4xbFTh2jF0itR3ZIPXejvF+NP8xceGshYiJYNvNA=;
        b=y4Nrj6ZFuU3yYupbUVFXGNDSvQQdelcPKIGtNuV0MekDFIygvrRSIJg+1hvxlyxaXv
         tgLdIo/KUorpX1fghufEOep1N0j4p4Y2V55qUVu+ZM1tMgG3dqST5nY1CGzgUmCGl6PR
         XYVoQ8izNma0cFIQ3Q8Ai9wMVA0wDgXUW6FnhFwTzqzSaTG/QLJy2Hj/nBos69i/X5w+
         KBsWQikqh2X79YYe8O9LJ/fWO2xAzJjCdVavfoSV+yjc2TEHTJaZ4zOUdBVUlsDwQjeq
         9GH9NmrZOXr2rylMfJ29g0Kk6WSZ2jjbzmXoNNseBc2FrGC7bWn8ie61Oa1Wu8NhPj0W
         NDVw==
X-Gm-Message-State: AFqh2kp6w6i05XAV2Nv8GCjaFuIBGHs6BBUDnLJsVIbfTY6IPOQoLXWg
        +QGD6Q5ymtyq+H7AttPHFOjWJF91j0khig==
X-Google-Smtp-Source: AMrXdXsIRiINjAZaUBQw5pGigBvVsfBb5nbpcqZChXVXD8GvKTK15taLeadqcoBcl3JlN4Vt+F0KEQ==
X-Received: by 2002:a05:6402:1770:b0:461:8be6:1ac5 with SMTP id da16-20020a056402177000b004618be61ac5mr23613215edb.3.1672366729340;
        Thu, 29 Dec 2022 18:18:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/20] commit-graph: fix a parse_options_concat() leak
Date:   Fri, 30 Dec 2022 03:18:26 +0100
Message-Id: <patch-v2-11.20-f7005f32cc0-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
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
index 0102ac8540e..93704f95a9d 100644
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
2.39.0.1153.g589e4efe9dc

