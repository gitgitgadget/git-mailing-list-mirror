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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA8C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD84764DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBPMEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhBPMBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:01:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C10C06121C
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 7so12650470wrz.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sP3z9bB4vjOmF6IdiX9c5bFgwE2Pntf9nNCK22ONYjo=;
        b=jszU1qyqK/DQaDbY/nb4p+afh7nJ9H7Twa7OKwNfW7QoanY4oh8iJKYKj/vXUuLMVW
         HQOFZoYqS+/OAMXV87USfv2y5S+ViznvA2fHWvEe3v1bopm3GTYBremOKlEs0OYXGV96
         DaZF8wvF0zYjEJ1D1lHlFVqbdyX0QSz8aXQn0JoapAl2j83YC4vWTcEZ+y919Z5SSu3i
         aIHgHXvw5aDWGQOtaYoi46zlGcyw4V8BswzhXJNHrFgnqzI4uqrhhA/NxgdvoFwKOj3o
         KVKGcYON8M9QjmIWHiDNKuQfi515oYnWsx4Io1vOWc0OCExMTJv46wqgLY2AgSs3x8qU
         pbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sP3z9bB4vjOmF6IdiX9c5bFgwE2Pntf9nNCK22ONYjo=;
        b=kSm68p5X4zXeHqJKKbsHPvWtmnhB5PNq0c6uoF3vcngLVPYMcAVQDvo2IF/1eHBwpM
         Ve1cjenC3iAWqr8WHOSXfOkFMhE1eHsuecopaOEoxAiWOw/0vPWgAx162g/2PEp6htPl
         kUlwrEZvJdhk4AOC7qVfhPp2aGvq3bq7SfvBwzgQU6OFvIG/Vhi4cHay6DTKW33mK7xk
         2uNtgtri7yyGsGCaOBC0T3veHjkWugbafMyvMhRjBVvn7nq32kJ5zXgxAz/pWiiZn3e6
         kNwRbNZjqAHovu919tRRUj43RwgvGyuyKZlXxqt8Togm7YoODiopzCCe97sHI33mD3zb
         KO1w==
X-Gm-Message-State: AOAM532U9NkUZ/cHKbwXoaNKETZNMHcRoYtF4siriD+htK6h++U/S2Ko
        XHl+Qn+PXLkpjOWq4JgE4+SBtFu5fni+zQ==
X-Google-Smtp-Source: ABdhPJz2KVVpHsPfDKcOTTkyAtfXHKcVP1TcAI9IE/WqXRycFz2K5QJc7/hpkyFLowTD5g2pWRIR3w==
X-Received: by 2002:adf:e511:: with SMTP id j17mr24331303wrm.251.1613476707476;
        Tue, 16 Feb 2021 03:58:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 17/22] pickaxe: rename variables in has_changes() for brevity
Date:   Tue, 16 Feb 2021 12:57:56 +0100
Message-Id: <20210216115801.4773-18-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the {one,two}_contains variables to c{1,2}. This will make a
follow-up change easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 0bf50a2f595..66e34d254f1 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -108,9 +108,9 @@ static int has_changes(mmfile_t *one, mmfile_t *two,
 		       struct diff_options *o,
 		       regex_t *regexp, kwset_t kws)
 {
-	unsigned int one_contains = one ? contains(one, regexp, kws) : 0;
-	unsigned int two_contains = two ? contains(two, regexp, kws) : 0;
-	return one_contains != two_contains;
+	unsigned int c1 = one ? contains(one, regexp, kws) : 0;
+	unsigned int c2 = two ? contains(two, regexp, kws) : 0;
+	return c1 != c2;
 }
 
 static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
-- 
2.30.0.284.gd98b1dd5eaa7

