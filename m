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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205DDC11F65
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA2C6198E
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbhF1TWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbhF1TWE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:22:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F984C061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u11so22550934wrw.11
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUR4J0PiYcaNYPdNPOwmbDwIYv010ilIwXFhLx01/0U=;
        b=rMiq4QgEXmh3+ofAWB95FkmPjvSipldiN/2nRC6nPj8HkkTHkp31RR6QScoTCjKE5w
         TtZvaNhrkmeeK4AQ6YUrVU5KZYOVmimAEIvygZoJ2n2hmZ+14fbAox6ZK+9D1f7f7W5F
         +/ba43hi/lVwnUnU53axgH7cGWccdUhaxtBhD+1Qes8BJo1BQrgAs6Gsp2KVzUdH5UsI
         pl1Ko9BvnOn09J6mGA4zZBfSbSXr3hdQ0mtJ0ZuaIlkJTYpo0hep6BaY/f6gkvdbSe5Z
         qyQ8bQZsY3jrAGX9GAkqivaDL1zVrwLAhFD9KDYBe0gPpEe6C0MhvCtsFKGGGI43B/Kt
         Pp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUR4J0PiYcaNYPdNPOwmbDwIYv010ilIwXFhLx01/0U=;
        b=BZlvEfSu3AgmetsTTTC5X5STqBCTgGrRVDr9ezP996YJr08ZzaOtnFzB97Rgs3qVpa
         f3FFvI8+wK14p+QMybl4y/n1RLPjemyzX8b8qdoVlciAvoE7aFhfflbOaTCVjatQuQdZ
         78YP832SiEh8w2kn8eus7UM1feTV+DHdgXYBCzAaPGO6RYNne0cG8rFxfOJsjKPa8PCG
         GZltkrmqavFweHqSSW4igS2E19KFXvu8KJsCzcoajnBmKGIfVil59gObbkGU+pSAooN2
         3R2I5xpREth3nxRco9iKcwuw8tjtPzBmjikPzAiu7XG63eUP9DmKZuW4ov+4u6NNyoON
         k4JA==
X-Gm-Message-State: AOAM531O5oqP86YYyShVDBjklgndxH/8CzCr4zwgVqZzKvXUFd9zWI4t
        0g5lKLUKv/Q1lGlmREg2HBFc5KPYr5YTjw==
X-Google-Smtp-Source: ABdhPJw1KYNirpR+R+x/bZQxWxavHvuvgKQGR41GWRcPQCqLPeKcCM0M+BHpRkwDtLvdDdDg/VQhUQ==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr29252286wrr.356.1624907975234;
        Mon, 28 Jun 2021 12:19:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s5sm350531wmh.46.2021.06.28.12.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:19:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/8] serve: use designated initializers
Date:   Mon, 28 Jun 2021 21:19:21 +0200
Message-Id: <patch-4.8-bd920de1629-20210628T191634Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.611.gd4a17395dfa
In-Reply-To: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com> <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
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
2.32.0.611.gd4a17395dfa

