Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C45C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbjDGHZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbjDGHZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:25:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18C93ED
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:24:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e18so41597143wra.9
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680852284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZGEHAN43hCo20KnFAhasAWJxHrvQIQ713ezcf+4WHE=;
        b=IAeveeg10M1yYpe8glFdEJ30RTkcBAgMAOZIfzc6UDJKodckHZQWlHQ25SEKIUE2Rg
         YC/2pL1WncELKJQlkF279MF737LLyR/hfup9TQtGxvZyoFlLCaiIOkxTeaANrav5sBR+
         ucASQhPzgKAErkK0wZM3dnBLflG2+pQfpvYlqYBC7+PcDJkBKlkaca+vQR9sXiHQVKoY
         thZ/0/688P6WnQc2eyrWnwPIo7XTEQnRypIlC/BAywAR7/hgbzlSFTqELNjO5JQCazNt
         gTER2E6VW143K46WW0Seh7fnzxzhJIZL4x/suxNWNM/FO1b1XRYYCftoEL4/z3J+sPAU
         9MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZGEHAN43hCo20KnFAhasAWJxHrvQIQ713ezcf+4WHE=;
        b=Tpkhgz9QghfGE8cSUYjUPX3FuBrqhT5xKxBiWLf8hMWktn6Fao92znk5Lj2lzwFXbR
         X5wgYhtiSPAHdUlVIKgm8gw6kpgeeE/kQah0nOdfQayonL9VK0EqFpcXvDcWuv3bF0w5
         jQfQNAnmkA2FDj6GIhkGFiT+m2gjScFG+0ihwoWQkp/KZAtt9GwUX4CDAIlMiOwWN6eA
         wmL61aZxrSFnOCI/Sw3MtlkcR19iZiZKCLzgIYpFCjkm1BzClJbXOUdZDTC89hKGI+PX
         kbbaNTCeTySEkfksNPAoXaCoYdWj2YCKGz/qIYErT1TO9aLMg7kHUEO0sEP7P7delm4M
         2vWw==
X-Gm-Message-State: AAQBX9fXcCRAVEsfjvr5m+xN8aNiieDJIz82KvywL/V7vxbHTLD/Bb6I
        +xFP4UIPJCI9nbyFGR3toGkCeksNhuzzNg==
X-Google-Smtp-Source: AKy350ZU9AYoAHxV8zMVO+gv6d8kJUvYwQaCycLR3Irzxr8b+ojlY5EOIibSuqE+DEvR7EmcRglyYw==
X-Received: by 2002:a05:6000:1b0a:b0:2ef:b3e6:8293 with SMTP id f10-20020a0560001b0a00b002efb3e68293mr169072wrz.9.1680852284134;
        Fri, 07 Apr 2023 00:24:44 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:90e:3fb7:fec2:981])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002da1261aa44sm3782761wrw.48.2023.04.07.00.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:24:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/14] replay: die() instead of failing assert()
Date:   Fri,  7 Apr 2023 09:24:04 +0200
Message-Id: <20230407072415.1360068-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.40.0.228.gb2eb5bb98e
In-Reply-To: <20230407072415.1360068-1-christian.couder@gmail.com>
References: <20230407072415.1360068-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

It's not a good idea for regular Git commands to use an assert() to
check for things that could happen but are not supported.

Let's die() with an explanation of the issue instead.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index ca931dee41..16efac11ab 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -170,7 +170,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
-		assert(commit->parents && !commit->parents->next);
+
+		if (!commit->parents)
+			die(_("replaying down to root commit is not supported yet!"));
+		if (commit->parents->next)
+			die(_("replaying merge commits is not supported yet!"));
+
 		base = commit->parents->item;
 
 		next_tree = get_commit_tree(commit);
-- 
2.40.0.228.gb2eb5bb98e

