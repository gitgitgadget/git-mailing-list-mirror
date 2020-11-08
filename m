Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBE7C56201
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FAF206E3
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbPYv33e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgKHVln (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgKHVll (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:41 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B9C0613D4
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:41 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d17so6183783lfq.10
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZH5TpUqiYqsK3RaK+u1B2AkyRuJBCgr1RNjJ2h3qVFM=;
        b=NbPYv33eL/LPCTxiTSciYoacdEJ1ybIeIzRiyFyt2TC9VLyzdYUmtSXG0/NjdoTj6t
         yO8Y9r1NBCcE7RjNQn5VQRztMvBKnufAZdu65BkkChn+jtbBBfwL4/V+0vtSKemxaKgL
         E1qWnnt6p/9s2CtuZd4ELFHqXEZWiJcJ8dQKMAo94NzKaSgS0EKN2CHM5IvAEMOLNNUD
         YoOBvzBc+eiXb9m5gsj1+Usxg0RR3mXHM8fP0Z3vSR3Ju9oETjuaEUlsEh00oiy8KxLb
         aUm455u3Uvzo15Ugai00RLbLqMX2l9CA/Cgx4NSjT9JjTmaoCxE239lqXXMwv/yfLee2
         bGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZH5TpUqiYqsK3RaK+u1B2AkyRuJBCgr1RNjJ2h3qVFM=;
        b=uHwaZU+yyzAhKiZLBKolopK0GqTj7ml5u3kZ8jgumedz09eA1h9DO10Y6GvWWMEJeT
         H6SS6MeYKBbTKou66MyZxxI0IiOB1Faz6ooxFIIBYOoJw/hKD6hCdcxWk6qkdorlErUr
         rScAI/SY2GPTOnH4CU6HpW117c99iQZ3f2yNO1td/HpCgQxSzMzWfz9scyymZP4SHhvi
         Bt4HMskfKlabQIsybumz3nEPW8FnJ+ZnGAJzGJmmUYoeqFhLJW93YC8PMKlJ865NG8Yg
         +FxScit+PWSBp3ewkCFpsLhxZ9xoiX/6eZG4mrInBGA0ZGfxbN2sM94qyF5onwMx3SbP
         bAPw==
X-Gm-Message-State: AOAM532k00yAt8kiUC2VeAE1rOhm3WGbXYGLySC2EsFN3uDzDC6d0aXk
        ZZOWkiTiabEIBN367XFlVFI=
X-Google-Smtp-Source: ABdhPJwDg+PT4Vp88fQ+w4wQzPEqnM/JMqvNMhIBGgDCi4Vun1HvdehcqHFP9RqX4e013nYNsbfE7w==
X-Received: by 2002:a19:8c0b:: with SMTP id o11mr4617640lfd.479.1604871699742;
        Sun, 08 Nov 2020 13:41:39 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:39 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 21/27] diff-merges: make -m/-c/--cc explicitly mutually exclusive
Date:   Mon,  9 Nov 2020 00:38:32 +0300
Message-Id: <20201108213838.4880-22-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
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

