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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D73AC43333
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4385364F5D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhCPQAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbhCPP7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:59:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02EDC06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j2so10720045wrx.9
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3YtwXPRsxlzFMIP5ADyz13R8HvJZqtr2T92nsoYjgo=;
        b=GYxLH9wE8y7oFP6SuEsj9XdpUEs2gOobxbmoKQQj1nzh4jXoCZrHNs4BEXsnzFfzCZ
         ol/Bo2GCpILtCukQu2YzO6kuVqlv1uBcUD6n0ozZpX1P0ikLaUy5HMQJMOXuu18sXnWX
         ECWPm1jYpn0pt9NDwdKn25hoaqb9+QO7rvuYVIHme+r59Gr0cE2m+P5H0boXwnN3x++G
         3A0Q35U2Eyq7gcNCPj9pTuOrKoVkIFPR3x/sWhCf0neRrE8dYe9w/YhSqonyiOpQEN4N
         YHfphtjLXXuWMI4ASJOGFNM4CNUpvRiKyFQxrFLiWC2TSABJqHlPVoV3LHH2h9yTN2mi
         xr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3YtwXPRsxlzFMIP5ADyz13R8HvJZqtr2T92nsoYjgo=;
        b=lIw93imJYu0Rb1MiNG7Jv2QGDlRoaWCvu3AFNZ8+2kCEgHbiHFkCHdvHKN5B1acJ7C
         gSS0fLKIqIgPu4AbvDnA1gZttU1EMdVdxaxFZ8VY6oNBVHNjbKE/K1oIWK4qcD+k+JGh
         AvYEJOvtwnm+QyWauN1Ft1duS+MnFlrNj76IuLsELfxYbWEYgCAaZhCd6YwRmMINcqM5
         H4hHfzH9Mt1RGld9OgdqkYnV1yqlPEhze4YLx4cGWYdelXn2VfPmH1UdhQ3jZJwDw8ql
         hnzeTDDLwpv9PgCHyWmn4IUlMdzOVxr7tB6Z1gIdmJSAQr5GSmZUuhcvUW6m1wc5w399
         Z0cw==
X-Gm-Message-State: AOAM533m5zyRXMbFawTl0DX2pmaG/twsQrZVAWR/ZI2s/iPSaNXKAyVj
        IZL8v3GbC2S7QIxngcbeQMX2Rb1nh9vs+Q==
X-Google-Smtp-Source: ABdhPJxmVppugtnWU0BcTFmIw/dvh8t2iDN3282GyOYBGWhhDYWa6Bne+Euq5gVCY0n/rSuwVRKthw==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr3274078wra.398.1615910339285;
        Tue, 16 Mar 2021 08:58:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 24/32] match-trees: use "tmp" for mode in shift_tree_by()
Date:   Tue, 16 Mar 2021 16:58:21 +0100
Message-Id: <20210316155829.31242-25-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
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
index 0faacd8f4a..e84f993a46 100644
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
-	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &mode1) &&
-	    S_ISDIR(mode1))
+	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &mode2) &&
-	    S_ISDIR(mode2))
+	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 2;
 
 	if (candidate == 3) {
-- 
2.31.0.256.gf0ddda3145

