Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C188CC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 01:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhL1BIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 20:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhL1BHz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 20:07:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9248FC06175A
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso9089332wmk.1
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiPoAW06GP+ZsZYzh0Fbnp5CrFcnP0QYQplt1b/fZeo=;
        b=atjjI8/G4oMnpYBblKeIJuxE27M7qqcHl6kF3IUeUHVdLot2lbps/mdbD+dZ4TlJZu
         n+FLVjN3Q7gCqs8PRDhCa8mu0mK+8fr+0xbnwiAdXbsKlkvtw//2N9M1FIddUYLM2E8Q
         WMswaWZwlMfS+SQXCM66ISc0UMgGK7s5TvL9BPA4+TrUuLdDKDMmI24SMdUFrKIEzPSk
         pqAJe2f7ruey2HGTke2A0Es1hnG4eDUkgNyGymlVYgvvvYbzBNaK77P33OsG8c0FmrO5
         4/GkMlZ55dn96CShv2PQoyzniqnkiqYRhIaak8s4VL9txv/nUTYsNA5PAFzpSjgQh/pS
         YYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FiPoAW06GP+ZsZYzh0Fbnp5CrFcnP0QYQplt1b/fZeo=;
        b=PS4WO3YQtft0xgpaNCj9E+rTY8YeAuNifeuAIGu1YCW7zctLuZfwsinN+J6P79WgzC
         PkaWfcWDJENOB9e1SEQDvs6wPgLqpglryiY8Ix8x3GB6Ldy9mch3niojsxaFWJ0DB3Q4
         FjZNjBAA8LsQHF1vwx58UeAWHsb3n5h17zytSgvorqyCyuhkswbpsAZSBABC1Y6xe64A
         iAEcse02Nx2ZaMqYXRhvQU6P3ilpwp5HWexzmg+ebIzfCDBEBz/1W4PSE9h6sw7SDSlW
         l80SEEDpglOoBsUMYfAwIg+ZYsdR7e453ZTcvar8AozAnyy02VvyTSWjtizZg3fHA08k
         A+nA==
X-Gm-Message-State: AOAM530S7HPpvovJmokI1hmSQhD2ZiyJ3iHHLE3MdjcB2n4TEyAVyBAE
        LHOXuHN4k6+frUX7S3q0Z4YtG8pQC8qj/Ry7
X-Google-Smtp-Source: ABdhPJyt2iCU+99vKM8Lx29lI+OnPIggrTJS7FIXv8DBjVGNd7wmZwA7xJjNsINNEEtIqNhD+Ys4jA==
X-Received: by 2002:a05:600c:2943:: with SMTP id n3mr15204182wmd.167.1640653672955;
        Mon, 27 Dec 2021 17:07:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b197sm16910973wmb.24.2021.12.27.17.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 17:07:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 07/10] grep.h: make "grep_opt.pattern_type_option" use its enum
Date:   Tue, 28 Dec 2021 02:07:42 +0100
Message-Id: <patch-v7-07.10-57ecc5c0d65-20211228T004707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1250.g6a242c1e9ad
In-Reply-To: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
References: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "pattern_type_option" member of "struct grep_opt" to use
the enum type we use for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.h b/grep.h
index b651eb291f7..bae2899e364 100644
--- a/grep.h
+++ b/grep.h
@@ -162,7 +162,7 @@ struct grep_opt {
 	int funcname;
 	int funcbody;
 	int extended_regexp_option;
-	int pattern_type_option;
+	enum grep_pattern_type pattern_type_option;
 	int ignore_locale;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
-- 
2.34.1.1250.g6a242c1e9ad

