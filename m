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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAE9C43333
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6999164F4F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhCQSVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhCQSVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F214C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so3954405wml.2
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNxKQn4LWflJp3zVbUeKRR8PJHBq91o4KntAb3/Y7Rc=;
        b=HciKWEf5eZ96DVuBQsuIbvhOZwxlgJDaj3BdujAzDWod0dmypsHnlabNXIGAV75N6e
         faoiWr305dIEGtWN975Z6uP1Wx7W7RZ+b/KwToKq8coXJEN5Fn3jw890lZO+HKSFD8tn
         M12xji4tpUpofDI+KbMbvax5ITcA7LaR86nfNHEW8r8h+jFZNCOvZwCbAR1WEvkcnaAE
         JJaI5JnGRew9lR3XGhWUbPTjQW9UP+2KcER5oC2uyUBa5rxZvXesqnUgzWfqJncXgSBN
         u7B2aUWiKYzv2J+1EcM6qS52ToN5+aUVyif9OhWAmuJtRLYNRSW2kN8A65EsFillgO6h
         EwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNxKQn4LWflJp3zVbUeKRR8PJHBq91o4KntAb3/Y7Rc=;
        b=lG789RdheVrqO3zrfBZo+araikzrD6WZzNKsPlKrJorf6iGwGfL3qy6ISWHTOMLC6N
         0dQGyGtn0+64oD/ZwvDCw52YXkd5fuy5w54qJltWhWcwbPEH7WoN5k1kMrzbTowca3xc
         E9S16sgruCfvpl7Z4Gt9LlSM9FKtDsDpo1+iTbUVQEu6JN0aMNgTgNjLJoFBRWanX0KZ
         wGm6BpSsgaNSbgUIrDPp+YEuOzQzgqRgnIPpWcPO0JZ18an1+/8hFWpWTR0i6UGLInvD
         HBlKcyePrrs+TX5T0utdxwP7eUrr+h2miqvdamCLmH/xWl8QXrZt7miAqw98BiNLtrQn
         lpmg==
X-Gm-Message-State: AOAM533ui0Z8K1yYDzWQrXH3aMwNhYlRuDUnzGTvsM3d67Xex9jAGI/c
        ine/9zp/l+KOQOVPOIWSI3/hw/cwmpG+ZQ==
X-Google-Smtp-Source: ABdhPJyEJ5yYHiGVQcEtwr0POsU+69Zg6U4zVwXhzeJbKGmNgjCiW2fYqPaifu1w0nJzdlkQkqVnIQ==
X-Received: by 2002:a1c:8005:: with SMTP id b5mr128836wmd.130.1616005278572;
        Wed, 17 Mar 2021 11:21:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/19] fsck.c: call parse_msg_type() early in fsck_set_msg_type()
Date:   Wed, 17 Mar 2021 19:20:45 +0100
Message-Id: <20210317182054.5986-11-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no reason to defer the calling of parse_msg_type() until after
we've checked if the "id < 0". This is not a hot codepath, and
parse_msg_type() itself may die on invalid input.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index e1e942821d..341c482fed 100644
--- a/fsck.c
+++ b/fsck.c
@@ -201,11 +201,10 @@ void fsck_set_msg_type(struct fsck_options *options,
 		       const char *msg_id_str, const char *msg_type_str)
 {
 	int msg_id = parse_msg_id(msg_id_str);
-	enum fsck_msg_type msg_type;
+	enum fsck_msg_type msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_id < 0)
 		die("Unhandled message id: %s", msg_id_str);
-	msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
 		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
-- 
2.31.0.260.g719c683c1d

