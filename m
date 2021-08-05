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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD446C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64AA608FC
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbhHEB0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbhHEB0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C98C06179F
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:25:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so5103225wms.2
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoUWmarRZN/gbmQypN5vWQszdQPq1pziAdy0aivBc4o=;
        b=gudkbvr9aa3r3MRC4oH328tm78XNdPvzeJhGXZvtY+pPxnkZGmdtIZX5GVyhsCpszB
         RXmis4NCYnFJPeiMcHhy/JFwc5frVYjmN4lZiMxt9EJTG38+zwf2cN3QdvntIQ6JBgRR
         3aKsclKaAsz/cxzHZ3QY26sqgAi854gE7P0PPchq4az79Ni/c6oE3MIdmDrdhu7ZihQs
         4OE794bsYCgt9gJe6bSUkbk4+3hBSQnyJ9XnGMeNn+OZrHrsebqyofT64f/snHSZGzry
         QhrF5TY/4N/mLW1e9javGrpKwdYH8V35owZz3xYqwwCa2Nu6rlP4MXsjdNa3Dik2eoLA
         SX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoUWmarRZN/gbmQypN5vWQszdQPq1pziAdy0aivBc4o=;
        b=WxBN25Wic/JNtxZu5kwl94pDcw7SzjtdqM6U9rRG6n25MD2y4dPBeUvOMQYVs6g4hw
         xoERkOu0uLwi4s0jStgjPVXpyHxNRXtFjrDfR/rIwklHOPYF4vm7uZkZisygVQyGL3g7
         8KIajAmiKzbuOxNj/SlU2VrrnwQ1G7s3QMojMNOihjUg2oitsGtWBaLCmYp52g7czlmi
         OZp0+0cCpM+f+Gn9TJ4spqbU2iJKPkEAOH+p2+YmRADj8RDBzWUjxL+Uu5yGhY/F+7D4
         B3k0LVIJ4NF6MJFdNK99w8mx0iZmGiTU/ptnpq/lbMWxvhV4ltWz6aK/MMO1XuN4nNiw
         zTpg==
X-Gm-Message-State: AOAM5314U2PpwQqsHPxCjs1Uh28hD19wG+1IX1Z5/pmdnmjGsYKPqVgl
        6uQWBLfPVOppqPrhEUkaFBv9GI683ejikw==
X-Google-Smtp-Source: ABdhPJxgvWcIaZ2/nNRbvvH3f5ABY7j+Q2q0MT34m4z286hoo3zjoF+JINnCFu4EhahyJrbteq0VJA==
X-Received: by 2002:a05:600c:3b8d:: with SMTP id n13mr971510wms.69.1628126751272;
        Wed, 04 Aug 2021 18:25:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm4120176wru.50.2021.08.04.18.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:25:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/10] serve.c: move version line to advertise_capabilities()
Date:   Thu,  5 Aug 2021 03:25:40 +0200
Message-Id: <patch-v4-07.10-9828e08cbad-20210805T011823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The advertise_capabilities() is only called from serve() and we always
emit this version line before it. In a subsequent commit I'll make
builtin/upload-pack.c sometimes call advertise_capabilities()
directly, so it'll make sense to have this line emitted by
advertise_capabilities(), not serve() itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/serve.c b/serve.c
index 26829991333..412c2cd1317 100644
--- a/serve.c
+++ b/serve.c
@@ -112,6 +112,9 @@ static void advertise_capabilities(void)
 	struct strbuf value = STRBUF_INIT;
 	int i;
 
+	/* serve by default supports v2 */
+	packet_write_fmt(1, "version 2\n");
+
 	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
 		struct protocol_capability *c = &capabilities[i];
 
@@ -304,9 +307,6 @@ static int process_request(void)
 void serve(struct serve_options *options)
 {
 	if (options->advertise_capabilities || !options->stateless_rpc) {
-		/* serve by default supports v2 */
-		packet_write_fmt(1, "version 2\n");
-
 		advertise_capabilities();
 		/*
 		 * If only the list of capabilities was requested exit
-- 
2.33.0.rc0.597.gc569a812f0a

