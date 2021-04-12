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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9468EC43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A9961222
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244565AbhDLRRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244318AbhDLRQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E1EC061350
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c15so4783366wro.13
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnoplLLoCKJrRd3z3LoruaAWiUu+p+Fc/bbjHnU9KuI=;
        b=OLIUozXyG9JFbCq16HzryjBO8galMkw1tUD4azFkdmouVoBXqDbnezrf/zhpbmjPjw
         QgvL64sXYUg40RGczmsT+SeQPD1tWMJAUIUALWKrwQbpJQzq+brSrdqz6rO0yt+kP0jp
         ChWR6+3/Rocgue5W3Aavc59RlmgQ9d9/fmIk2B2GXLAz5/XWiXZ1iZYz8UiQXVIZN+Fs
         jpHmlbaq7JJkAGdI0iloT6aR1VlV7sIZfUP7n8YH1fRuWw+dw1f/e6F+gZR6OFV/jg4x
         aXX3Wxg7wJ8Hedb4FBb8I3sYsPARJdjZ+moAiamBn2/FblYqVyYex2HzBfzlmAmxWQFR
         Wn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnoplLLoCKJrRd3z3LoruaAWiUu+p+Fc/bbjHnU9KuI=;
        b=PxiEW2TWVtwVODIAKCUAdaVdXiVko2oKhmSR+uo/psLgIZO+p9WWN7S9io10D7N12u
         nxz78uTNL16eOz4FV7k2nSWCQwdgTdqDUEFyffECAz/vjX96xD83S3+Y9+e5/v0wMquG
         Hq942IO0eBO7GSHz5FEHyxk7LGD/VNUFcnXVJVicVLo1Do9/HtzruQqh3+JZ6NbLjODC
         /UbpUiUB6x1gTFyUp8CJ0epDw4l55kF+bRWwRpFmu8lGxt6Fa96rxpSYSiphU5k7p0cV
         Vgp1BT0B+KpDdKdPxf2KJo9oHZgU0ubnd4qsUWhisAigq0W7VVQdldvSvZhtq4ygebIf
         9nAw==
X-Gm-Message-State: AOAM531Jq7/3k27A32JWh+74Pu1ZmIpWfGux3tj+GnYhBK0giZLACrz4
        ziKVk2Ct3XUUimZoOeb7hrWz4Ry60ZqJ/A==
X-Google-Smtp-Source: ABdhPJwFBS1mrRIFtQHbLjw/Y0InjG4A+iTrEj90Rwk28a2zYOMaO/WDAUYPmcHlh6CozgacqxNhxA==
X-Received: by 2002:a05:6000:1816:: with SMTP id m22mr4726493wrh.260.1618247754851;
        Mon, 12 Apr 2021 10:15:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 21/22] xdiff users: use designated initializers for out_line
Date:   Mon, 12 Apr 2021 19:15:28 +0200
Message-Id: <patch-21.22-9bb7ac910f3-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the code added in 611e42a5980 (xdiff: provide a separate emit
callback for hunks, 2018-11-02) to be more readable by using
designated initializers.

This changes "priv" in rerere.c to be initialized to NULL as we did in
merge-tree.c. That's not needed as we'll only use it if the callback
is defined, but being consistent here is better and less verbose.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-tree.c | 5 +----
 builtin/rerere.c     | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index de8520778d2..5dc94d6f880 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -107,15 +107,12 @@ static void show_diff(struct merge_list *entry)
 	mmfile_t src, dst;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
+	xdemitcb_t ecb = { .out_line = show_outf };
 
 	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-	ecb.out_hunk = NULL;
-	ecb.out_line = show_outf;
-	ecb.priv = NULL;
 
 	src.ptr = origin(entry, &size);
 	if (!src.ptr)
diff --git a/builtin/rerere.c b/builtin/rerere.c
index fd3be17b976..83d7a778e37 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -28,7 +28,7 @@ static int diff_two(const char *file1, const char *label1,
 {
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
+	xdemitcb_t ecb = { .out_line = outf };
 	mmfile_t minus, plus;
 	int ret;
 
@@ -41,8 +41,6 @@ static int diff_two(const char *file1, const char *label1,
 	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-	ecb.out_hunk = NULL;
-	ecb.out_line = outf;
 	ret = xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
 
 	free(minus.ptr);
-- 
2.31.1.639.g3d04783866f

