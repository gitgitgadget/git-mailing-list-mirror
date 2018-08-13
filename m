Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9401F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbeHMS6e (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38260 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbeHMS6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so13011668ljc.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7XsQ4B230chpYocNsaTUKnJn2rE2dINXn8T9//cHJA=;
        b=NYM8RSZZ3LiGp0Ej0o/K+oC/RyVTvgQ26VCosq8sr8902YYzrOI6CIu6WRaUYg4U6d
         +1HlLzaCvk8/JyELrBrAq8NSsqCjlCT7Exf6XVyZGRpZx3FI5ZMPl1JlHCiNTbCOgLRl
         7Qfnxqe91URbf6A7YdSnUWBCsY4KOuGuXeNxNJ1mnfpB+kX17sL6UVdZxjPfnGfY5nPF
         9hSWUgqEIzmo3Plqfc8wPXcjF9jj5jXVdtLrqFLAA8Ys1gGqvjBDeC/ASlGAjuoD1S7x
         s+bSKtgjtippqSGxr4hSRyQjlbPuE0v/vdBh0Be3fD6mjSHbIBRmQCzkqHv++JFOxYbt
         +bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7XsQ4B230chpYocNsaTUKnJn2rE2dINXn8T9//cHJA=;
        b=DtxayJXlT08VERcWBLbpDNVv2aWweQS0HhVETAhTvF36eqdvyHvztujDnss8Pyn/mu
         Atnf0LMsjcyWrtrKqSYaeEANr5t+BVPYRm2I61HuvblmG+x70nnnOwm7BmCMvcdwhtsK
         5URTKdkdSiroVUBaBL+FrYBseiikX+AFa56ivE9svzghfxuxfgOjPbOmkUFyIiXNHEsa
         IVg7/eaq5vVTVaSRthoZCZe8Gg+vX2SPMECuvV4WeCJkdv6/jUo8HpNuRftKHIphfGpx
         T3jfV9m1vEMU7iUSkHRuuXl8Rxr1DEJckn24L5AJk4wFDihtdw0IE4YnF6C4of+CWJSX
         r/6Q==
X-Gm-Message-State: AOUpUlF++GBh7wPk8HZrSwRugaUHphsvGYRMO0ZPL9j3KTBFwjTxosft
        34GEyVzA5/jj/lc5jx1f6sDE0YPO
X-Google-Smtp-Source: AA+uWPwaggiIaplPBtB5KJoJUGY9yaCJ3vZ43DrYJ+unOAYkS0eLOOiBoXZteapz0WsaSHFH0VL6IA==
X-Received: by 2002:a2e:6304:: with SMTP id x4-v6mr13382543ljb.9.1534176938624;
        Mon, 13 Aug 2018 09:15:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/24] grep: use the right index instead of the_index
Date:   Mon, 13 Aug 2018 18:14:34 +0200
Message-Id: <20180813161441.16824-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9d7ba87f9b..b7033954ac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -497,7 +497,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 		strbuf_addstr(&name, ce->name);
 
 		if (S_ISREG(ce->ce_mode) &&
-		    match_pathspec(&the_index, pathspec, name.buf, name.len, 0, NULL,
+		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
 				   S_ISDIR(ce->ce_mode) ||
 				   S_ISGITLINK(ce->ce_mode))) {
 			/*
@@ -515,7 +515,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 				hit |= grep_file(opt, name.buf);
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
-			   submodule_path_match(&the_index, pathspec, name.buf, NULL)) {
+			   submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
 			hit |= grep_submodule(opt, repo, pathspec, NULL, ce->name, ce->name);
 		} else {
 			continue;
-- 
2.18.0.1004.g6639190530

