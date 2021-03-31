Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A3EC43619
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691F861056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhCaTKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbhCaTKB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:10:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5628C06174A
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g25so10707955wmh.0
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGMmMW6vIPg9pkmAMbC0tSoFRasl44GE4c2sqKs9xts=;
        b=dD8Ac0yBJjGQK8qdFmOaOiXO8D5tvSTNTYzf/W19IkYOpHkiWbB2Brg2a2244d18tP
         GSJTVbGm9f+0bCcdQ2n1YvglJQzpXXbkUSthiZGdXA7Neo5s42sbhghZZpXEiGoSWCah
         TT2om/Gw6f2qjnXZCXdAe2otgYH9zDPD1ejChx8X5jtC5y3PtkbgED/JOcP9LK4O/1mL
         Q77uBLCZ784/asMXRa8JCNY7JnnhlC9AIh1B3bAxFriC3U3vTG7Zw6IoLv0NahLFm2BY
         Jhxrrs5XS4UHgbDKofQouiY4f/sUemZP+MRgb7Ccd916Qk7tbSE8GsiAug5RaLBBunT/
         1K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGMmMW6vIPg9pkmAMbC0tSoFRasl44GE4c2sqKs9xts=;
        b=HjDaeRDJgMnoFT9g/UjLpXC+rkt1JE/avtZd+mIb/GMjfSkbmHSaxX+WplZmNW+2tB
         LlpqedcFCQ764JZ1PGTm9FjvVIF0iwWCfPNdPsrD05+pb6ebO7882JAGYGJB/dVM2M6f
         BHr6RTnY1T/IEOipvwtOfgR+fXvjiFm9Bw2P2eYxTFP50Ks0WDJchtLh/ue/vkPtiagt
         B4GT6PIRi14lTwI2q2yoIcqYmWwz+IBmlUdxTUq5bZLegq9+/SUqC/Nkl2z+5veV6Kxd
         bJpacuprX1p8w5v2lrTyeUsQj/cbrRjpXeQRs9TmEbgXxZQxM4MsIKc/hyqum3YGstdQ
         d99Q==
X-Gm-Message-State: AOAM533oaK4z9Ai84zjZZ6gOZqg0/pd5nbfGE22n/1JaEHAEqVgaqe9W
        BHMdBkkSXAQLcG3qQPcEuoSOdgmDA0hxnA==
X-Google-Smtp-Source: ABdhPJyMFCNTJN3UcydAX/YUDvo1H3bgm2Xl4jZHDnPpTvWQYszXd5hzUO+MV1eOYZOMZ2XGwesFag==
X-Received: by 2002:a1c:e208:: with SMTP id z8mr4341468wmg.111.1617217799093;
        Wed, 31 Mar 2021 12:09:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 11/18] match-trees: use "tmp" for mode in shift_tree_by()
Date:   Wed, 31 Mar 2021 21:09:39 +0200
Message-Id: <patch-11.19-e190ed39754-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added in 85e51b783c3 (Make "subtree" part more
orthogonal to the rest of merge-recursive., 2008-06-30) to make it
obvious that we don't care about the "mode" here outside of the if
statement it appears in.

That's opposed to the sub1 & sub2 variables, where we use the two
object ids later in this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index a6796de442d..bdd16adb70a 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -317,17 +317,17 @@ void shift_tree_by(struct repository *r,
 		   const char *shift_prefix)
 {
 	struct object_id sub1, sub2;
-	unsigned short mode1, mode2;
+	unsigned short tmp;
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &mode1) &&
-	    S_ISDIR(mode1))
+	if (!get_tree_entry(r, hash1, shift_prefix, &sub1, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &mode2) &&
-	    S_ISDIR(mode2))
+	if (!get_tree_entry(r, hash2, shift_prefix, &sub2, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 2;
 
 	if (candidate == 3) {
-- 
2.31.1.474.g72d45d12706

