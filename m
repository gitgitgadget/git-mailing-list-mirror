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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF04C28B2E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B756124C
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348094AbhIUCWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbhIUBvz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1290AC0386C6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q26so33952967wrc.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWArdbesqrtoFzdFuzsNBHMZqO+dxCaMAkuhy7POVic=;
        b=hz7qvYPH2a6brtPTkRBtKFbppw9nE8WFizAyTMzWmaJ6vKqfFGv8uhICOzWh/UmHmB
         GmfOLVe7+601Jy0r019xLM/igF6l1IKOES30BH36A7XNkwDT8ZNvmUum0JNMQuWoQY1p
         GNp5rsM8hCWxKBkyXhrjjFO9ODJPD3FMFJvlCfbSzJfsZCCtjGvkarpNZKqo6psa2Dms
         GEKljogjtvKIDF1JWV1mxMxB5VIxlgxz1gSZ7ZegAFiXJtEJb4KnRa8lBDzktUepV5Er
         6G0EoSj4kqe0Gfp+Z3g3/TlAnvDb9DhcMyBoleJbGZy6Ndv/hwMY15yEmJm/S1gbUclR
         jX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWArdbesqrtoFzdFuzsNBHMZqO+dxCaMAkuhy7POVic=;
        b=WlpJ/OUtwsYNy7P14GHGLJ2/jvdMpDIAsr+CC5Xya9ILZjmS7m60c2jSMaMdcYFV8N
         8VudixjXUEZ89JbOwuG02uT262p528UHdruFxiwThvLunAAw82oXtyZ9jJS6cRDAsKzL
         c6HtbwIWe2c93oudTNOUlTWPrFnOwEXsCNkWdQwCoc417GC8B+5QVlBmyT8ZggjS9cKm
         Evl74d+0LJF8i5pKoYqgV3EhE1FOzg3+qw7UHATGQgvJxtrgVwuia9Ie5EndsnjoEhpV
         f7Su7hAK0pwuoZMaciJfimaUa42oUYCvGsY7JIOfyShM2bplFceZAs8zIczrqKLijlen
         Rquw==
X-Gm-Message-State: AOAM532HV2dhdEhAwGW9fuLacgQHD5MhIwWQBZQYSbY6DkE9YpMJJLC8
        JQck6jQoxKepTVuYLpkh9DdFcsisSUMhQA==
X-Google-Smtp-Source: ABdhPJyCoI4WXxuGMqtuF+dM6Jy5hS6qpbKCg6i5/eTGZkOIOrb+OpOwfWesyHeoV0CHPDS2wxebKQ==
X-Received: by 2002:a05:600c:3b89:: with SMTP id n9mr1392118wms.186.1632179381458;
        Mon, 20 Sep 2021 16:09:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm10409154wru.30.2021.09.20.16.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:09:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] progress.c: stop eagerly fflush(stderr) when not a terminal
Date:   Tue, 21 Sep 2021 01:09:26 +0200
Message-Id: <patch-v2-5.8-250e50667c2-20210920T225701Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's the clear intention of the combination of 137a0d0ef56 (Flush
progress message buffer in display()., 2007-11-19) and
85cb8906f0e (progress: no progress in background, 2015-04-13) to call
fflush(stderr) when we have a stderr in the foreground, but we ended
up always calling fflush(stderr) seemingly by omission. Let's not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 7fcc513717a..1fade5808de 100644
--- a/progress.c
+++ b/progress.c
@@ -91,7 +91,8 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	}
 
 	if (show_update) {
-		if (is_foreground_fd(fileno(stderr)) || done) {
+		int stderr_is_foreground_fd = is_foreground_fd(fileno(stderr));
+		if (stderr_is_foreground_fd || done) {
 			const char *eol = done ? done : "\r";
 			size_t clear_len = counters_sb->len < last_count_len ?
 					last_count_len - counters_sb->len + 1 :
@@ -115,7 +116,8 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 				fprintf(stderr, "%s: %s%*s", progress->title,
 					counters_sb->buf, (int) clear_len, eol);
 			}
-			fflush(stderr);
+			if (stderr_is_foreground_fd)
+				fflush(stderr);
 		}
 		progress_update = 0;
 	}
-- 
2.33.0.1098.gf02a64c1a2d

