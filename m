Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C26C4742C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0020320B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDfRldJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgKATe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgKATe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:26 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D32C0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:24 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id t13so12602832ljk.12
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZH5TpUqiYqsK3RaK+u1B2AkyRuJBCgr1RNjJ2h3qVFM=;
        b=EDfRldJ1u/Wnxwz4AISdU6VrG+Z8+wpL3qcHgTJCnpxRCfk7PFpONUk/Obib5WhNn6
         fb5DuxoF1J+bLayDzLTfOB9XXRJt77/2J8hzjou748UTOeqP0c1a13d6xEr9bcJ/2Rib
         NR0jLFDLNwjnyS48iRWElle7rH/ZZkqT5IKaTlZEEcMQ6LjiaD1KfhzYl81s6caqVGws
         MmwDriEE+2PrbS8BIyK1nUwsv30+OO+npBoTlxg5QI79yuEGIBl9C9hjACEkjMkjTZGw
         /9XVg6rPLmyqaKnljZHL6r7IBW0e6jRQbRxcJkipIqOYJzi/sNrmFSdk9IrMSJtqLYZ0
         ldqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZH5TpUqiYqsK3RaK+u1B2AkyRuJBCgr1RNjJ2h3qVFM=;
        b=WWJECVS0+rboOKXLE+0fpfqhSIsDAPFOVgitxEOcJ+tMw8cv45F4/HjBQyLPu2dBiY
         oTCVYmq5wJeZU3js7rW7Gcxob3xSh8dtuuUuGukflRq5kTM+hmnamyn1cJ778U8nZ4Zk
         mY2B3xMU0v4GQklVtTVH2NBxFkhQpfsTf42bToyoKxOJ9ZseSTdsy9dGIswY0a2arVOo
         IuOYJr6hB/7jpo3z1QO70bGK1WzpkD4fSWFju2rqX7p7sR5Vnv4e9gau1HLjrtBibbSc
         SpL0AFeQ7+r2uz0hNy4s6hL7w/6pUJ21K7P3i+XdCKc5zb8p3DvSAUa6dJedLnXoeeAF
         k1Tw==
X-Gm-Message-State: AOAM532u0jRVWtyt+L/5rDydv18qMEwxbVAA6c4VxRO7QIiG3f+Q2sqg
        RJlfFNvEKo2QWMHlzrtSjw0=
X-Google-Smtp-Source: ABdhPJyujW8fFZAujFP7zkJKW2K/DcuW0c+3nR/bdGyK58csbTjei/nRrKjTbZVtlIcbm38r82IjQQ==
X-Received: by 2002:a2e:a492:: with SMTP id h18mr5345821lji.103.1604259263047;
        Sun, 01 Nov 2020 11:34:23 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:22 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 21/26] diff-merges: make -m/-c/--cc explicitly mutually exclusive
Date:   Sun,  1 Nov 2020 22:33:25 +0300
Message-Id: <20201101193330.24775-22-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-c/--cc got precedence over -m only because of external logic where
corresponding flags are checked before that for -m. This is too
error-prone, so add code that explicitly makes these 3 options
mutually exclusive, so that the last option specified on the
command-line gets precedence.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff-merges.c b/diff-merges.c
index 8c22b447f106..db2217171442 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -7,6 +7,7 @@ static void suppress(struct rev_info *revs) {
 	revs->first_parent_merges = 0;
 	revs->combine_merges = 0;
 	revs->dense_combined_merges = 0;
+	revs->combined_all_paths = 0;
 }
 
 static void set_separate(struct rev_info *revs) {
@@ -25,11 +26,13 @@ static void set_m(struct rev_info *revs) {
 }
 
 static void set_combined(struct rev_info *revs) {
+	suppress(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 0;
 }
 
 static void set_dense_combined(struct rev_info *revs) {
+	suppress(revs);
 	revs->combine_merges = 1;
 	revs->dense_combined_merges = 1;
 }
-- 
2.25.1

