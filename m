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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95AFC49361
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5238611BE
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 14:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhFPOSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbhFPOSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 10:18:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF1EC061768
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r9so2868669wrz.10
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmsM/wngjW0S4UuM42G08DE3X0flSPTEx30Igs5jkek=;
        b=PiO26E9WmZo1DBWGJrPbqBAH8iAgwSllvv1oS42RQLKzOPQVdPs6HMdiZH1FfISlu1
         m8PqeshZFY9y1vlfo9X74RmkgzUTEXe1/crh22dfeI22Jq++BkO/1/DdvNijgN9Yoa4Q
         DEN89WEjuu1yFbvMoeAzmw/L+EHYwHOMxF++/QmqBPLBnC6YLGa85GtqNyUeRyvQrD7A
         t0Hf+8b3vYhidXzTKc+JcJh5RwH9gy5yZktN8ZV90LYJQD6ETbrmxUWD+J3ExuhzxRmK
         gLINPWAzkMGoLkLHFHzHVkuaK4HhTsv9GjLcVqYpHSfn0fP5nOp/0lOfxFoSaJXRmpUk
         WZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmsM/wngjW0S4UuM42G08DE3X0flSPTEx30Igs5jkek=;
        b=gzUfGsOZ7AeF+5ObJk4FwC5zd6QxDtuUyeLLh5KwE3H4FLt79dLskZZMUrbgsyZi20
         j9XbPtot+EH4ikGRs0RDCv/PmnaSjdDHSW6boD+5h76BhYCxQ5rCN4PT0o8g537OgAZS
         sFkg4UQA1SRho6+dM7F+HgytsMtTpZUSnwS6LJAVpv0URjgPtTTPT93KP1QLSfNUy25Z
         2Pc13yZAMTsDZTsK4FZKj6YS91fmRwl4cfxEfRcLnv4Vj3Ir9cFwxr2Fho0pODFtetSP
         mpX8BRqlmNKNTcv0MIxIIpK0JRYiMJ3qkr1KyXXsfGsXtrFPgV7obExkmI0xjeHbAfi7
         4K7A==
X-Gm-Message-State: AOAM532XrQxr9D7UOOJeHqdR0inPBl4AKKE3DH55P67oCMQW1RKYlMJ+
        vKwyp2dMkTZFHLE0pXaeLSMOvk9c7C2wow==
X-Google-Smtp-Source: ABdhPJxvUL4LgOkcMi4FdFr7ylny8EaLQdAaUpCG/ZZGQrkjadDMr+3hlbsBn7dcniUhT9nLVDx3DQ==
X-Received: by 2002:a5d:47a2:: with SMTP id 2mr5741276wrb.353.1623852993013;
        Wed, 16 Jun 2021 07:16:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm2258555wrv.37.2021.06.16.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:16:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] serve: use designated initializers
Date:   Wed, 16 Jun 2021 16:16:20 +0200
Message-Id: <patch-4.5-8e97412d584-20210616T141332Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
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
2.32.0.576.g59759b6ca7d

