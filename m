Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A125FC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhL1PTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbhL1PT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:19:29 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D9C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:28 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso10204711wmk.4
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4bEVcNZltpi07qKJ6L23hTUWLuWqThFD4odHwaTOYg=;
        b=b/2mNCO1/SlKwD1PV4wSDBif9YogFO5yTvTF+hymu535l7Pf6lhyAuI7ARf/Kizpxr
         Kco1Dys5xFzwVePIn2jwIzFhBSPhiY5G2uUd/ks7/X9nMGdYXvC4CCB6Oo3+SkVvXBV5
         72/OU+Y9i+OsUZYdjntUh4v1NbDu+c590952/401NHHIlk0Pa2sC5Qk0QZrJP+d3tZ6+
         QyCP4Fat8YezvVkSqRdp5XW1PEHW52EDZD/sEGujwGm0ry0/P5RTFdxrSzUCxc1HdGdP
         MjoZfu1Lr85kJWeaBj+51PkghB3k2G9yzcPEUxpLq1zzWomCMbI06JNqY0SDhmTf/6pg
         0qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4bEVcNZltpi07qKJ6L23hTUWLuWqThFD4odHwaTOYg=;
        b=MXILeDhbg75bTXv7kMhg5gI/cpFvFC1XFUIn35sQViE5rtMqnfXg0S3SVa13efcCrL
         MCgD1P9D2kRSiG/rJLr/aj0vLij/0CuJSbeklNZ77+KkCdxV8HjQais+IcaakTa4SgUc
         HvezAWmvDlLo9UdhwNw+q6R2ppCmfyWOM8D/nHbjTtsfUUfkreql6fzG4UrovnTzzWg6
         TAjMLmmPFVmI1L26lpKMwuI9GBCttHUNp1LbBh2rJ3NbUFZLjfH19/5Gj8b6tU8VgSEo
         Lg2r3njXGdOl/N0KoXpnJNwoH5vM00iYGZUsU0yXqhAh0OhviQV2hcqQpV/TE5XB0ATY
         ncGA==
X-Gm-Message-State: AOAM5312cgH2QaBRZyBG6NLdGyed9y05TrL/evFv1P6XgHqAem00NXqT
        Uh3BRXLZxKPZBeOUz6f2wz1aB14iyChFbn1L
X-Google-Smtp-Source: ABdhPJyNH0nZTw45rwwR0IwW69Ow9tr274fGrsep14rzBBSaJz6cG0ompgdq6yzMfnkhFU33BO0D7A==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr17822762wmi.52.1640704767026;
        Tue, 28 Dec 2021 07:19:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p11sm20491022wru.99.2021.12.28.07.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:19:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 5/7] progress.c: add temporary variable from progress struct
Date:   Tue, 28 Dec 2021 16:19:01 +0100
Message-Id: <patch-v8-5.7-72a31bd7191-20211228T150728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 98a13647408 (trace2: log progress time and throughput,
2020-05-12) stop_progress() dereferences a "struct progress **"
parameter in several places. Extract a dereferenced variable (like in
stop_progress_msg()) to reduce clutter and make it clearer who needs
to write to this parameter.

Now instead of using "*p_progress" several times in stop_progress() we
check it once for NULL and then use a dereferenced "progress" variable
thereafter. This continues the same pattern used in the above
stop_progress() function, see ac900fddb7f (progress: don't dereference
before checking for NULL, 2020-08-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 680c6a8bf93..688749648be 100644
--- a/progress.c
+++ b/progress.c
@@ -319,21 +319,23 @@ static void finish_if_sparse(struct progress *progress)
 
 void stop_progress(struct progress **p_progress)
 {
+	struct progress *progress;
 	if (!p_progress)
 		BUG("don't provide NULL to stop_progress");
+	progress = *p_progress;
 
-	finish_if_sparse(*p_progress);
+	finish_if_sparse(progress);
 
-	if (*p_progress) {
+	if (progress) {
 		trace2_data_intmax("progress", the_repository, "total_objects",
-				   (*p_progress)->total);
+				   progress->total);
 
-		if ((*p_progress)->throughput)
+		if (progress->throughput)
 			trace2_data_intmax("progress", the_repository,
 					   "total_bytes",
-					   (*p_progress)->throughput->curr_total);
+					   progress->throughput->curr_total);
 
-		trace2_region_leave("progress", (*p_progress)->title, the_repository);
+		trace2_region_leave("progress", progress->title, the_repository);
 	}
 
 	stop_progress_msg(p_progress, _("done"));
-- 
2.34.1.1257.g2af47340c7b

