Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816D9C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiGUQPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiGUQPA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:15:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC189A88
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:14:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v5so1339571wmj.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3CBsBgItHwq3I8+M1jkjtGUyICpqh8trbIVanepaBUo=;
        b=fdgZFh2sD30NcPJG38ofSXSf+P2pAq6dsZ8nlEf4OtiujZZFVHn75XWDnkoKXCguSF
         4nUiZBu3a/avpBPfZ5uVRtzW/h5zITNOZaZ1IHCTxMu93NTiSdBXY9YQI9Bws4gSsl6C
         xd8LC3JWmJInDR7Re2IUO/S7baOSqQWpwFs153u/wNIiK/7aIymRnAw3b2cJ6vky457V
         lGJuSzMKam+MWkneBzyZYFntFqSnu3OLIGtXVLolGDzZJneW+ouSF7s7h4OiYi0HEQSu
         1tmPh+qE8Mxk3l8+GEbMOQpzTlTZu9wPqoX2VDGKC84BYI5BrsczyETKbc1FhP7PTlHg
         BK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CBsBgItHwq3I8+M1jkjtGUyICpqh8trbIVanepaBUo=;
        b=yTnxYjJZVpRlm12sAFivR8mKajthSiU9gH7yZlpFqfg425KWv2RF2c9Ff0ySauPhrw
         jhZi9jBVPpJQBGRxTugvlHHFOeooNnXtOMoEaPxvduS8ZeVs0fTwCDK3E5fjG07+CuST
         1cPeNZQvNIyGv6EKE3cmjSefkOfi/fFOhIhue/pdmeO+omceBGQohVr0A++0uChxIubh
         2M8DowFT2RHs9hq4fVZivDjr6nPuV4VqZKKIS3epgkcaNJ8c8hSgFs3uZ9soPL191Hdg
         inIiJ0Jp4r/H/8E+xiNSeOMX1HxTmqj8Z6cLpECeSeqS4N3ahJWAbDbkBuxfW/WKyw1O
         vbwA==
X-Gm-Message-State: AJIora8Y+nKLExv3smI7AXgNgMIeL7iEk/kc5wzN3Sg3N0WNNUjBZ9Rk
        JbrQQflxihSVUGkvTF2IVPVW2G5C51pLlg==
X-Google-Smtp-Source: AGRyM1t/Yavimj0FsIExu2CFoWIHCqwHHjZgx3A2eU+24ixc+1gJ9C2uz/815V4q+1n7So4T2M8vMQ==
X-Received: by 2002:a7b:ce13:0:b0:3a3:102c:23d3 with SMTP id m19-20020a7bce13000000b003a3102c23d3mr8795282wmc.67.1658420054694;
        Thu, 21 Jul 2022 09:14:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003a2f2bb72d5sm8498608wmq.45.2022.07.21.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:14:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/9] help.c: BUG() out if "help --guides" can't remove "git" prefixes
Date:   Thu, 21 Jul 2022 18:13:50 +0200
Message-Id: <patch-v5-1.9-b0bb29bb131-20220721T160721Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 929d9192828 (git docs: split "User-facing file
formats" off from "Guides", 2021-06-04) to be more strict about the
prefix trimming of the "guides" category.

There are no guides in the command-list.txt that don't start with
"git", and we're unlikely to ever add any, if we do we can remove this
BUG() invocation, but in the meantime this makes the intent more
clear.

While we're at it remove a stray newline that had been added after the
"return name;" statement.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 41c41c2aa11..80d516abb0b 100644
--- a/help.c
+++ b/help.c
@@ -44,13 +44,19 @@ static struct category_description main_categories[] = {
 static const char *drop_prefix(const char *name, uint32_t category)
 {
 	const char *new_name;
+	const char *prefix;
 
 	if (skip_prefix(name, "git-", &new_name))
 		return new_name;
-	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
+	switch (category) {
+	case CAT_guide:
+		prefix = "git";
+		if (!skip_prefix(name, prefix, &new_name))
+			BUG("'%s' in category #%d should have '%s' prefix",
+			    name, category, prefix);
 		return new_name;
+	}
 	return name;
-
 }
 
 static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
-- 
2.37.1.1095.g64a1e8362fd

