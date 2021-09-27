Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72265C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544846103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhI0Alk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhI0Alh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:41:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35436C061714
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:40:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t18so47230014wrb.0
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RiC6apAft0S25h4pox63WJNIKIQ1ZDc39M3Fy1I5sP0=;
        b=FeBHjzjxDsGQ1jmYKpR5OXZwt9+yMsRpQiP8Ertm6DZXMwrSUcNpKfbfu+q1Dlq54T
         mEPK/qjdmzfRGxkXd+tPILSeSMxvB3IMLr9dJwwyrWzu6h43z1V3iXlGu6QyalRDfBcO
         QMZ+Kyc//YuKar0jT2IT3S7BqVV2P3lTSFR3hkighrfWPGSCIjf1OMROiD8xTsqt1Sg+
         vwZrkoMaE+uODwUKThIgymtVcqEeDbrrup/Nx37QvNG7/ApeqhUA6ZHLBLA+7YBbesa+
         k1dMoekqTks2W6wY6dvaVH/KkuHT5iBd9ovMDBIOLrhk5fVoXreDdry4OA8DS41bqvPD
         RyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiC6apAft0S25h4pox63WJNIKIQ1ZDc39M3Fy1I5sP0=;
        b=DtWujduA4xjXhvs6jf2BOcWL+ALMOgrKKsl6YJg9/DXkzmT4bvIqPTuROEj+jJ+l6D
         WXJgIZTS4CMiPWsF9+ZKbpvvotrwtkJwRGYxQANR9yDCd+hJ7zOgAtgCwrVMkUx1JLk4
         DMxZXxbHgiye6vf5lJTNILncbLSh2ru6AnAcGoL+HlOis98Cfy4e0akp4EkyXEhYkfdc
         OL/YDuByiRc5MPaqYTRBB4Np3YZQLLSgrBLMkvFBnCnBYARs9dMYSJUISEuXMFo3mugZ
         eX/PQMHTc4JB9VKLqZDXmJHV1noTZAeKCvl27vybbAAcWp64W/JtZy/ozM+Qu5zrF7xC
         EDZg==
X-Gm-Message-State: AOAM530TTqlW5C3Cl2ZcLKC9QF1MtmhpWxFh1+OjZCWG2XeIDnwYl9Kw
        0CNr9/LmeJwgxb6Ov2g/UDA0rRIAdpX0lA==
X-Google-Smtp-Source: ABdhPJyC/IvG+QzHCoJdgRZvWEYczicbGqldIvUlioD7/gVnKhW4xx8AXW49zck8r9Yr7ej/bstLSg==
X-Received: by 2002:a5d:5541:: with SMTP id g1mr24957035wrw.402.1632703198571;
        Sun, 26 Sep 2021 17:39:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l26sm19070162wmi.25.2021.09.26.17.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:39:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
Date:   Mon, 27 Sep 2021 02:39:52 +0200
Message-Id: <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the same pattern for cb_init() as the one established in the
recent refactoring of other such patterns in
5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
macro, 2021-07-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cbtree.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cbtree.h b/cbtree.h
index a04a312c3f5..dedbb8e2a45 100644
--- a/cbtree.h
+++ b/cbtree.h
@@ -37,11 +37,12 @@ enum cb_next {
 	CB_BREAK = 1
 };
 
-#define CBTREE_INIT { .root = NULL }
+#define CBTREE_INIT { 0 }
 
 static inline void cb_init(struct cb_tree *t)
 {
-	t->root = NULL;
+	struct cb_tree blank = CBTREE_INIT;
+	memcpy(t, &blank, sizeof(*t));
 }
 
 struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
-- 
2.33.0.1294.g2bdf2798764

