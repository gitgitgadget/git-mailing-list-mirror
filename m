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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B94C41535
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE55E61245
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348073AbhIUCWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbhIUBvy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B30C0386C5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d6so33823832wrc.11
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naZsfccnHocyUpE9k5UBiFNcCExxwcQZUqhxEIadO0o=;
        b=mqQPeshkCYnxrbgRSJ9bgLlq01pQqyy+PNd5RTBC5iC8zl8QrXyCVdKtWZ4z/C8x45
         FSfUMaNXkYrbINofCfRIDWxQsl1OCEUgDlY7hsICh+vMtm9kpaX55ywhw4RA17veGNjS
         UK/Nmqhtv12UovcZFORGj0tF4ab4p70X7jkPFUujoJ3oF0AMbYEcJSJAxru7LVmqyhhZ
         OV67aUKAOTvnEIbQq5gD3Cfq4VWpAYGFBgyTsueQUSCTC/BTUU0lY8TmjifoBP/eULcU
         uXsebY4POFe/CFfuqJojKHx1fWEjxBNit5mB+h35Bt48B0FNT2HGJkj6MTfQMG48ZeIO
         gNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naZsfccnHocyUpE9k5UBiFNcCExxwcQZUqhxEIadO0o=;
        b=GlwOe3zXFBrW8Bdf3eUvbaOViZ8lVG6Dol+9O5zIuQG4ck0uU+xjN3r+1eaHBkpBUQ
         6eFy7DyGl9SrbpQK0dEfXt9VeuVKH0OTnDk7TOHg3ThhYn4j4PSblSeAmSJ9YzThRmzO
         +mQ8zticRDpSdONR1jDfnjAOox52x2Q5H07cT6AhAwqu9Q4t1sO/d3+Ms5CPOX8f9I6g
         RgXpU+9SH8e10GDvB/nYiAcE4VLdqxT96rU+UGHiTffNlOY+WLKIJ1UDT5xnbXTuo+HH
         hGx8eV27mlzM1QTa5dh5FxBH7BmWo1kxs44Wg+nUX/aIrVjdCT7xuHOwUTHXJU0ZoMaD
         K+3g==
X-Gm-Message-State: AOAM533TzvsrpIbyeY3WwD8oCloctCGT2fGIQhaxIBByGJek/piT4wol
        VMiGdYSApdFVGVYhzG1WlzC23XfhLAZhpg==
X-Google-Smtp-Source: ABdhPJycTVrFnd0paHrbbmjB4SN18fS2eHNwCJeUMQC6Qvg1ERJMtCWR5NwIVCKgXK3scI1kiQaTUg==
X-Received: by 2002:adf:ce84:: with SMTP id r4mr31675183wrn.107.1632179380750;
        Mon, 20 Sep 2021 16:09:40 -0700 (PDT)
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
Subject: [PATCH v2 4/8] progress.c: call progress_interval() from progress_test_force_update()
Date:   Tue, 21 Sep 2021 01:09:25 +0200
Message-Id: <patch-v2-4.8-74057b0046a-20210920T225701Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define the progress_test_force_update() function in terms of
progress_interval(). For documentation purposes these two functions
have the same body, but different names. Let's just define the test
function by calling progress_interval() with SIGALRM ourselves.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/progress.c b/progress.c
index 893cb0fe56f..7fcc513717a 100644
--- a/progress.c
+++ b/progress.c
@@ -216,7 +216,7 @@ static void progress_interval(int signum)
  */
 void progress_test_force_update(void)
 {
-	progress_update = 1;
+	progress_interval(SIGALRM);
 }
 
 static void set_progress_signal(void)
-- 
2.33.0.1098.gf02a64c1a2d

