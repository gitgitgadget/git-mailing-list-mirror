Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B8FC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjAJFpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjAJFoa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:30 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A47640862
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:05 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vm8so25801106ejc.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuYTKjTk7XWDGwdWhx+LIoy2M27eh7bfsBuGhMmK1RI=;
        b=ASVreSRfPsoIUHN0a6vkTo88b4W9MGakR9rOHKs4QwnvDTSoyNtrkaHpV6ruV3kzEB
         zJCJQX5bCBYDsrdybm3noBV2CrYG7qQtrCHTL+s9BP44sY3UCK0TXRSThCyFMd8lqSRU
         gpF57IiwG5CqIGqp/A4KdRB64fd2ZeZ7suJl1IwndM/OyevIJn/uaOBuwxK44UpKzi4R
         4rcg+iiBdBdyenrT+Nvr9Kx2RoOgSuDV5fTzn1D+QASU7wiZr7PI5tG2lWNcnaemPNcX
         cYsRRmvWQnLvcfyWxN706pd2eVpa33d6LD+dLR6iS0UpGdFeTvMdD4CwZR1hAEW3W+Na
         d10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuYTKjTk7XWDGwdWhx+LIoy2M27eh7bfsBuGhMmK1RI=;
        b=AhBooehXbmnwoDrMjitHLM7oDOf2PZJ1SWAJj2Mhn7WdHAKP9ngyvmYuu6ws8G/tgg
         A+oRwZKue1Uq1yT3Bo65dTLSXXsYtj048kyWRtTQ5HJrqsKblvJi7DvQ4yfErNRT7cjU
         JQTwzzPuzz5geI6V5cb9xfH6lPLFfB0fvjU+NuHXJCuA2Nf/mco1NYxLllnJeKlAEXjg
         WX4aHdhAVMi+XTrFPSASAMp/fQHt2ZJkFGrV52XpJisWCO39yhBj4WlAjB3zfmgBPKyB
         3NUeHIpuxLco6vW9TBCmuy0h1OB4e9EGnzC27hu2FSu/AJXJol1CEvqiLdSO2FKeOP56
         BJrA==
X-Gm-Message-State: AFqh2kpyPB+QHxquH/B6Fgxjv2NaLBjuCqAJZLM8a3JgkucRgQ0vVOat
        c8I+Wgi+TM1hoeFVfRSHbuwdqYznXBzwyA==
X-Google-Smtp-Source: AMrXdXtAqFQ2boici3YLBJud2dSNW6k+XxXribNENHa8MOGtKaCXeH+IRBa0nvo0d232o5tTSmgNpg==
X-Received: by 2002:a17:907:93d5:b0:83c:cca7:64a7 with SMTP id cp21-20020a17090793d500b0083ccca764a7mr52102894ejc.73.1673329443455;
        Mon, 09 Jan 2023 21:44:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:44:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/19] builtin/merge.c: free "&buf" on "Your local changes..." error
Date:   Tue, 10 Jan 2023 06:43:34 +0100
Message-Id: <patch-v3-14.19-a3bf3045597-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a memory leak introduced in [1], since that change didn't follow
the "goto done" pattern introduced in [2] we'd leak the "&buf" memory.

1. e4cdfe84a0d (merge: abort if index does not match HEAD for trivial
   merges, 2022-07-23)
2. d5a35c114ab (Copy resolve_ref() return value for longer use,
   2011-11-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 91dd5435c59..2b13124c497 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1618,7 +1618,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
 				      sb.buf);
 				strbuf_release(&sb);
-				return 2;
+				ret = 2;
+				goto done;
 			}
 
 			/* See if it is really trivial. */
-- 
2.39.0.1195.gabc92c078c4

