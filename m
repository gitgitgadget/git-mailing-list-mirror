Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F9B1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfAXI3n (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:29:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38068 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXI3m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:29:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so2560343plb.5
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5hxhoqR4odfiPLDJFW4BrF1tQyW0EVA7eppcIVvAkw=;
        b=K00COPqVLtM/IHUMaNbicP2L4GO904z+rEzcHj8Fo9tT1iUG18BX4iG1E0GrrFlw6+
         LZJx6yHse/lOaBhQbRdr0ytPa2Jk8dx+fyseTYQSZNY/nES2SEP8w6nRHBBrwJc0ni35
         Vnm8VQMkuYU5ejP/65THMnKA7EsmkKJ6a+euCeAtU+cgXyqEk4A7Yee9C2rNhL8ds/wn
         EeTq/vCuXITDjnTtPjSQZH4BFBr88lGOgrvrfir5BQ6HNaYUlKm2lRyWhCpH/1POEJrb
         nWU9beIHTpw09rf1tqO5KJ68pZ+hh+xErBOcRgTrcelRK1tba+t6pQBuwBeAurEZKbP0
         71tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5hxhoqR4odfiPLDJFW4BrF1tQyW0EVA7eppcIVvAkw=;
        b=FJFTEZLslAvnccB1J4MUOp6wfli8aCaINTeluxG3mnT7hQj+gunqChDRD0fnPEhoRq
         y192Wp+87BcPFahKFrx2xQMtQk4slUUcbmC4yNkTumahRNxKJjll37pcM3pzjBsPAU27
         k3BC1f2rNJwl4daYjAyn33WLuAVGtCHaN0fZ9irlqLZcYl+W70QkJb6XyFSs55chD2PM
         UTgsiZFIadLnpk8Q5GDkEV5U6zgW1nzAXQGF/IAo4KQnhwkJU/B42yrxwt4dRN7WnLHT
         EFuarYTetLVpz/Ycor71lcg2LoCcY/7oZqk9Ruf54GU+GiklXbCEImHEogdjnR3AFEmV
         CEog==
X-Gm-Message-State: AJcUukdU0R7KZdmAO0iJQF1q5XgWJDEEP2mOllJjZ0npTY29HTZeAc6x
        UPKAiPz1a7eYKtilqexSo8vKqw2062g=
X-Google-Smtp-Source: ALg8bN7xyFiyZ4d1MCj+zgFAx1E9hjcNuAn8jwsg5BQWCp6zj1n0SEBIwuiCu4/H7/dLbAqmmDpIFg==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr5687384plf.233.1548318581440;
        Thu, 24 Jan 2019 00:29:41 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 24sm83701634pfl.32.2019.01.24.00.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:29:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:29:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/11] checkout: avoid the_index when possible
Date:   Thu, 24 Jan 2019 15:29:05 +0700
Message-Id: <20190124082912.24401-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190124082912.24401-1-pclouds@gmail.com>
References: <20190124082912.24401-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 08b0ac48f3..1b672a9fd9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -284,7 +284,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return run_add_interactive(revision, "--patch=checkout",
 					   &opts->pathspec);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(&opts->pathspec) < 0)
 		return error(_("index file corrupt"));
 
-- 
2.20.1.560.g70ca8b83ee

