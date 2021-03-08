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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0207BC433E9
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72DB65260
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhCHUFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhCHUEq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:04:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055BFC06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:04:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j2so12770737wrx.9
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dTRsw0ycUi1DnIfV7GZshliFLmmeGvSxEupuLS+5Lc=;
        b=R3RoZJ8DcZgrtCj8+zJu4ZX+l2JCM3nn+2S3VScF81zNvGToce1ShrvqiBFc8mu9xb
         7K6zU9Rr0n5pv+qgv084D/Ey94eZgPdBWgKlcPxrO58uJHpUC9ihlMstc4+tmQ/amR4r
         aoQo51zwmBpaNnRQpLQTN+GtYojguJYM51JLXmNCSRei+3fquKs89mW7kyvUILSdWys7
         h2HipjWagXZaiJRwNo6AihueZxwEomB8eb46CPJt8QeBcJTsFjg46mbCVf1ySM8286W6
         FP/UQWOLJfxV7AFE8LJ/DtuitavNuEgm8EFsuV5tWcgc5OrdlH0czY+GnLaTvV9GIbdc
         YYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dTRsw0ycUi1DnIfV7GZshliFLmmeGvSxEupuLS+5Lc=;
        b=YgQ2ci81Vq2BwaJR7nOELUAQ6f2nAIzxrR7hI3oh6ZFEMuOrxipU7P7sPVTSGOTf8C
         BhYP1ZnOSv0N0nQBC53H+aQvV32h3a01dthrJmxOC6a0Mlv+6N7/fYHLHIj+9+E5y4ZK
         XEijYC4lVQzbw2Jxi6V4BWiJM+vSg0h0PVRbsvhusyzsLdeGzjmUEesnCyG8zpagLPUK
         1yYr0Bq4suW0ozSkawcjwcFBUH3CqiLfuHjnGTqfjXI0dz/6Gv7qDK3wUDrNBbhDYO4g
         gDJMprvxk+owWvq2ab3/Ec85lF+liU0vPUSFR/lmyrCkm85MY01RdK+9jw0rwDe8Zcj2
         pW9Q==
X-Gm-Message-State: AOAM531Cm74kPWTRYxAEEZO7h8kWOSnl2vjV4pqLiTJQ5p/KQ8rmg2yv
        7gc/RPfZXVQrn3t8E62k8dZa5dmt8g1uVA==
X-Google-Smtp-Source: ABdhPJwk+7AZD9XVgPApqipvUPvYvfGzfuLWui4EVEwjLVS89lqLL3hCncaAU92na4kWO4Vq1kSYJg==
X-Received: by 2002:a5d:4e0e:: with SMTP id p14mr24474525wrt.64.1615233884575;
        Mon, 08 Mar 2021 12:04:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q15sm20790786wrr.58.2021.03.08.12.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:04:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/7] tree.c: fix misindentation in parse_tree_gently()
Date:   Mon,  8 Mar 2021 21:04:23 +0100
Message-Id: <20210308200426.21824-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables declared in parse_tree_gently() had a single space after
the TAB. This dates back to their introduction in bd2c39f58f9 ([PATCH]
don't load and decompress objects twice with parse_object(),
2005-05-06). Let's fix them to follow the style of the rest of the
file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index a52479812ce..4820d66a10c 100644
--- a/tree.c
+++ b/tree.c
@@ -216,9 +216,9 @@ int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 
 int parse_tree_gently(struct tree *item, int quiet_on_missing)
 {
-	 enum object_type type;
-	 void *buffer;
-	 unsigned long size;
+	enum object_type type;
+	void *buffer;
+	unsigned long size;
 
 	if (item->object.parsed)
 		return 0;
-- 
2.31.0.rc1.210.g0f8085a843c

