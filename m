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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716D2C6377C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA561241
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhGUW7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhGUW7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5E3C0613CF
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t5so3880909wrw.12
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fN6TqGOnIRPyZFHYAnlasxZNQC8ih5QnEoNRDDA9m+E=;
        b=BuoLYAp4czZSaUGN0ZkDuxUJ/Rw3xc4y38ndcb5de0sXZWxb2ueLijfAIdPkRcYlNn
         33jcat75EiwkBui8pns6Y5q85blehdi1V757dlbI1eXfpCu6noKSL9LFPjjF9Xjirvi9
         dwDVDkItXh+WxtNwkkgpzb2hw6Q9BPB1tKmzBdMhyXeX4I+lrtqRKJEiBW3V8MBr+s6L
         3Qv0suXAg/EWti0RzwgYrVVbHXzNTR0c9z6ERN7x8gtnt67lx91sFbZtxKjc7Sp2tkLY
         nT9IWerjvZkblHlaqQJCyi99LzLt5u/zPb/8eTUEF7wsTBpuuPKbCGdEtNzWP93RHn73
         wPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fN6TqGOnIRPyZFHYAnlasxZNQC8ih5QnEoNRDDA9m+E=;
        b=a4DDAKTED7w/2xplHxod//gFQWTaklorj32hOAfcGDDys0jcrv/dGMND+wEUz+05O1
         w20h8pypbzZKPt+G/Jgd3J0t3tMu54lTWuudqePPrrfFvNdrcqbjGxaNjrHnKGb/LW8g
         8IlccGsgjGQB70su6w/UWtS02i9Xq3XbwJ5r0XdnyKnXtZoAqycnoNJikh+cqtssEsH7
         nSx8NNWdIwHL4QXtxBzQJy4wIq+BQ1AhwzfAJuUkOxOQwE+UhZBxIl9iTh11TjbEUI/C
         n1docfS18RthVMLY0apWhLsWceoDsDCOi4VGcH70JLQTDfuTXEZBu21KqpUEFYGGMrUi
         1Jhg==
X-Gm-Message-State: AOAM532hrHHsKQPmloTKjrRoPAaBnPX/TC5fRtYughM1fZz+2WCM6SGB
        R0i2XgC7tCj1qmGYixho2JmfPWsPCrjTXw==
X-Google-Smtp-Source: ABdhPJwK15havmJfLwDrdm8QGZgntb4oqpL8RcPpLgzdqUx/kwn0C75iH+ai9PvZwAGm9P7Y24e7FA==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr26031672wrw.29.1626910820608;
        Wed, 21 Jul 2021 16:40:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/12] serve: use designated initializers
Date:   Thu, 22 Jul 2021 01:40:05 +0200
Message-Id: <patch-04.12-13f1a8d8325-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
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
index 6748c590b74..49ea9fc8fd5 100644
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
2.32.0.955.ge7c5360f7e7

