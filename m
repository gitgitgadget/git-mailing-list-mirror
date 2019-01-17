Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4921F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfAQNGt (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:06:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34013 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfAQNGs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:06:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so4829235pfg.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFDC5YmHcrjljhr4RudYYoenEe5kVbZ/lydYL1HasYc=;
        b=JVoKTRqN7NfFjAcJaGr5pXcf9zZEgCNwkZvzDh8rrCvWBJTsVYdpY4GyVdCIFQTyCN
         a7zaf62bvNxDKK+oM6WRSK4MoGPdtJM7u11itlZhBH74gTX2Mhqntmlbj07rGrKv5qNx
         POaxMkac5ACKa3MxCQGCK1I2DxTKQw/Cxrgh+GnnD6I7dXoF1e+wP3Qs7uFhKVBlQ5Ch
         lvX4s05oYnqii9gfUqayOY7pQl6bnCMRLyKLc0oYp4aA3zhPpxHuQMvU56KN3h8777tH
         vzjtRKM/rTgveAUhmWh7UjrMoChaGLk0mB8kDCBBVEBWP9IEo1MwppcEaCRMX4slf3KK
         Yr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFDC5YmHcrjljhr4RudYYoenEe5kVbZ/lydYL1HasYc=;
        b=RsZyoz7UasPy/6c6U1ElkIM1TliLLpBgbuJ86jR1n/ijByqcD/9Cwqiq0VDpbCTs9T
         DOSpWA9qVK31tqdv4BLAZpJAZnDGkdiRtrbkDGlQ+1JcRhqQqIoN9Cu6qiohvWNJFXwm
         cA1VfDbA6e5woZ2NhD985NnkiPsler99Dr9yZxWRzepg57cnSbaIU19D0+biwitJuSY7
         Rhx2RQDyeEclPClf4TuSS49K9/koYsa1YYREoi2S0zd2r+seGLhcrFbpBHtRSnMWVDo9
         kd61LWFpjmAEL3/nkVtoQjNwn748Ucl0JJIpLolVVurzzJiuo1Xnw+XzR8VHw0lhcE7p
         0NfA==
X-Gm-Message-State: AJcUukfzJbXH0qB1yD5l/khPGLC3inZwdvidpOPFXpWu8d51pTUyORhO
        LLpfw8PqpBaKNP3NpGi7FkDijJum
X-Google-Smtp-Source: ALg8bN76mf/o+zy0WGx8HGm5nlcYr91OOn3ADuo9dyExiDA1wLHmggb2EiTdg1RYlB5fX9h62UHyBw==
X-Received: by 2002:a62:34c6:: with SMTP id b189mr15137517pfa.229.1547730408018;
        Thu, 17 Jan 2019 05:06:48 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m198sm5548754pga.10.2019.01.17.05.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:06:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:06:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/76] parse-options: allow keep-unknown + stop-at-non-opt combination
Date:   Thu, 17 Jan 2019 20:05:02 +0700
Message-Id: <20190117130615.18732-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two are orthogonal. One is about unknown _option_ while the
other non-option.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index eb5de0da29..678b263897 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -427,9 +427,6 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->prefix = prefix;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
-	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
-	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
-		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 	if ((flags & PARSE_OPT_ONE_SHOT) &&
 	    (flags & PARSE_OPT_KEEP_ARGV0))
 		BUG("Can't keep argv0 if you don't have it");
-- 
2.20.0.482.g66447595a7

