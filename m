Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1D2C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 11:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AA261056
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 11:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbhKILHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbhKILHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 06:07:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE1CC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 03:04:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o29so11655661wms.2
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 03:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GR/wEkyHVA3j8WXF6CjACCoWjBsKaZNu24HVilJ3Lg0=;
        b=bRBd/c7gtUgy3k4Whg6a/gz3I/TeANwYJG2q5VbSyAV39y4Qnp4YrVVnrFZNnv/o6D
         UHAOAqYTMWWNSz4vBCS1MqHfuOLhmav0JB2lFdWlUbtxPCubSgnr3tntghFil7sHO/6N
         xx5M0c/6Yx5B5wt1LqaXxHDWIpe0r7w2+xmGbm0DSdO2WM3MsnqCm9MO56sAn7Vmok/Z
         JnRtHdP8K8jC93+q7xnPNH0sMyXNoLDpJvFlVAOIWM4xIz5K66Qt9oZv8c9fzIisJ5vq
         uK1UkxFY3/BJt501hdQ31RgF/fWi0eeB7qFnz54nldI4fjvRGeh12UsS3ObPHjbQiTjO
         iXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GR/wEkyHVA3j8WXF6CjACCoWjBsKaZNu24HVilJ3Lg0=;
        b=xYtwFuAmX0NFVpCuZHCYpaTQSe3zV26sz7Jw6iEI3VZjk6qVPh9MJgIM4TxGg02b9F
         AacytLjGKgspW1/gwo6XBbsvQ17Tok/hfdjc6g8AO/rdSMwS5Ef2mu3Xis/tfVqr9Vri
         SHuvw1L34sddP+sOBeZSpMSTUwR/jG0R46h91nwxPaFVFuOrLl4Vgb0anFGGwpWTcwW0
         /uU520UxndYzFSMpRTfBFVaHZej2OOsFP3ZSrmmSjCi6/I6v2tgvMA1rII7ilUBrykUa
         wdBZWVHdWfPHscx4nB4ZTSQphCmPUci8RuBORGWozmSz3RXeRBE8w5JGQDU39vglWtM2
         FfLw==
X-Gm-Message-State: AOAM531W338CklAnAjfIgpOxcViBJpTaCUjWO4ci+I8ZT5yKevy7/FOZ
        AuvfMuVsn+T8cLwdO2CQzW7Loi3tQl6+SA==
X-Google-Smtp-Source: ABdhPJxRkev2mKdF3cgGkffgcOA0iNK4RVAZ+y1P/Gp1ILraR6H84ITpqEUHBz5IGunEQFNPaN6dKQ==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr6352984wml.20.1636455889152;
        Tue, 09 Nov 2021 03:04:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm2480755wmq.12.2021.11.09.03.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 03:04:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] parse-options.c: use "enum parse_opt_result" for parse_nodash_opt()
Date:   Tue,  9 Nov 2021 12:04:44 +0100
Message-Id: <patch-2.2-aa6224b10f8-20211109T110113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-0.2-00000000000-20211109T110113Z-avarab@gmail.com>
References: <211106.86lf21ezqx.gmgdl@evledraar.gmail.com> <cover-0.2-00000000000-20211109T110113Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the parse_nodash_opt() function to use "enum
parse_opt_result". In 352e761388b (parse-options.[ch]: consistently
use "enum parse_opt_result", 2021-10-08) its only caller
parse_options_step() started using that return type, and the
get_value() which will be called and return from it uses the same
enum.

Let's do the same here so that this function always returns an "enum
parse_opt_result" value.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index fc5b43ff0b2..629e7963497 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -404,8 +404,9 @@ static enum parse_opt_result parse_long_opt(
 	return PARSE_OPT_UNKNOWN;
 }
 
-static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
-			    const struct option *options)
+static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
+					      const char *arg,
+					      const struct option *options)
 {
 	const struct option *all_opts = options;
 
@@ -415,7 +416,7 @@ static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
 		if (options->short_name == arg[0] && arg[1] == '\0')
 			return get_value(p, options, all_opts, OPT_SHORT);
 	}
-	return -2;
+	return PARSE_OPT_ERROR;
 }
 
 static void check_typos(const char *arg, const struct option *options)
-- 
2.34.0.rc1.741.gab7bfd97031

