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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D811C4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6B760BD3
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbhHEB0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbhHEB0F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54504C061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:25:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j2so4261812wrx.9
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tI+e3JiuYzz7Vn4N19KpwNWskCXvjWMmkQGKwC1M6zs=;
        b=RYgru9fyG3Bvaq3wGeUvevtA4O4PRvtmBd/2DwgPbJKdafBT7LhBrtvC0l455IepYE
         zYqNLA1i602vssEcP7n/4scAKs3osM3oiAcY8Sn0dJ3Gf6efq76wZEHS0vBbNxTnoCrM
         1UlUV7WnDku4xiQqjNEeQDXjn3xu+SPnVPpDuBDrNUr/Eo7g6MGsoub0naYjdJ9TEM+F
         A3INkaOVFkwIFeWtNykvkv2slXNEwu93CuXaWUH2VWjNZbPHxgs1ESqkyMu19Q21PWEz
         1MF9kLpPBByegGfHWnCntWy/3gM7qWiCFRJQag4XIxnCBYcaND9t707nhdjFxYLu0TuR
         iFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tI+e3JiuYzz7Vn4N19KpwNWskCXvjWMmkQGKwC1M6zs=;
        b=hpC3TH4dSM5/4jlhJ3K6cWYHHzgDh+IpvbhDlU2s1TDJBG1l2OmDJcRc2BuY1oGfUn
         2uRd4sS7J/U+kCz6HypHRbLA7Nm7/sPcfJ0PRUQyaqQZWUge+SXTbfJBBeKo1U+XNTQJ
         xq9QOKDy7F9OQeIOoQSZ0CQn+RPvAP0+3HcrHmSbduQkUxOjtQ67nHTwXzXQ4d92JkUg
         XGT2ApY0RrWbEXNsyABvvuPuxBNN9Y1QNsP6E8HDX78H7QvjBeTLq/MBlncdyRGYT1bG
         uf+o+4JTCqgF+MepbXJQ+aSUWSmp9f//deiZGYlNmnhfQ0jjV8AU9IDCxTlF0Mn+ZlBM
         E/vg==
X-Gm-Message-State: AOAM530sP6mj7FfR3NBKuDnKRtWugw/M30tSv+J1zSwPLw7d5bLUaZqV
        ZR0EqNC6pDJrEoPXXAqKnwK5X1ycrflFIg==
X-Google-Smtp-Source: ABdhPJzpQc5mFR6QnuFMNa9XpyC277G357gZg5qiQTPLRRUsRWzJVJA5NPezpWpEYUnLnT+xBK8Eng==
X-Received: by 2002:adf:f584:: with SMTP id f4mr2029628wro.211.1628126748750;
        Wed, 04 Aug 2021 18:25:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm4120176wru.50.2021.08.04.18.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:25:48 -0700 (PDT)
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
Subject: [PATCH v4 04/10] serve: use designated initializers
Date:   Thu,  5 Aug 2021 03:25:37 +0200
Message-Id: <patch-v4-04.10-8da15c373cc-20210805T011823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the declaration of the protocol_capability struct to use
designated initializers, this makes this more verbose now, but a
follow-up commit will add a new field. At that point these lines would
be too dense to be on one line comfortably.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/serve.c b/serve.c
index 7bf5f23ea6a..33d00c8c634 100644
--- a/serve.c
+++ b/serve.c
@@ -73,13 +73,37 @@ struct protocol_capability {
 };
 
 static struct protocol_capability capabilities[] = {
-	{ "agent", agent_advertise, NULL },
-	{ "ls-refs", ls_refs_advertise, ls_refs },
-	{ "fetch", upload_pack_advertise, upload_pack_v2 },
-	{ "server-option", always_advertise, NULL },
-	{ "object-format", object_format_advertise, NULL },
-	{ "session-id", session_id_advertise, NULL },
-	{ "object-info", always_advertise, cap_object_info },
+	{
+		.name = "agent",
+		.advertise = agent_advertise,
+	},
+	{
+		.name = "ls-refs",
+		.advertise = ls_refs_advertise,
+		.command = ls_refs,
+	},
+	{
+		.name = "fetch",
+		.advertise = upload_pack_advertise,
+		.command = upload_pack_v2,
+	},
+	{
+		.name = "server-option",
+		.advertise = always_advertise,
+	},
+	{
+		.name = "object-format",
+		.advertise = object_format_advertise,
+	},
+	{
+		.name = "session-id",
+		.advertise = session_id_advertise,
+	},
+	{
+		.name = "object-info",
+		.advertise = always_advertise,
+		.command = cap_object_info,
+	},
 };
 
 static void advertise_capabilities(void)
-- 
2.33.0.rc0.597.gc569a812f0a

