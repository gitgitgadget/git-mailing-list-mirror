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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CB8C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589F864DE0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhBOPw0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBOPsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:48:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73D5C061A27
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v14so9443436wro.7
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noWoucmypePf3l9dGKk1l/ahOkbkDQn8iyxI6SqhwZo=;
        b=tgGwnhlHw5DIkC1V6c3DAT5aeJgKEimwDHuG8m2QJ7ZzbaMkWg/mKaBSB3zqMbYSoX
         ofTEbrLop9DLaADb1G0zPvXRPWYfgtaQkx4LlJ4UQhZpPOsCCyO0Dygnfd4aNI1iTCbM
         9OmshWsfjCjSRPMf0Y1/OdlbPjY2WLUuyJHJoVXO7yUg7UDt7TUVoPgOHllmhaLWA8/8
         xGgysx3q50M5Aewyl+OD3VGJfp3AzFkN6SELZlVbUjfHBxS/76yzeRt1INaXjwi+1loB
         W3othRartFhW24U1ZQdKCoxw117CMtQH8HFQdzHKWhQXkXyJFaQpN64U+BjnBDkiWK0N
         OfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noWoucmypePf3l9dGKk1l/ahOkbkDQn8iyxI6SqhwZo=;
        b=P7xCBy+q3teHUB01+Shwmu9gwoTh6aSLWZx/7ttFg+G5HVpwLxlj9KLXhDn+kUFMs0
         sdGqbpy5sbqyGhh/hCo/EQ4GqM3iQDjV87/Z1151972BrlPBcCwR5e/t9tWcF4+FUMRj
         ESxtPQcEAqHSebBJGtvAmT/iLOhzCYAr6Gi73eyDm3m9lNhl/Nmob/feSpdM0LN4ZYUI
         vMFkMCjr64K2itmzNru8xY4tislDDkTSPfP1s6ATC38/5drafqGNfhWIw9K8xj1MZMBa
         8IPLm4xw0peq6fHrQxM3Lg9lB6QXvREIX36R1fbcaJNVWgM7mBf9Aj1N7OZIW8mANZYy
         gX2g==
X-Gm-Message-State: AOAM530muVMrQNqX5BFcvwhE/BdTbTMBmMuOePgBjZvw/d+IzgwZr5v0
        DKN0obh3NXXmEbDrW75dJTuPxcX3+ReRzA==
X-Google-Smtp-Source: ABdhPJwMKxTYt2XcQtRf6Esos5wcFe7TApQibloItaNio6YERPeSpsEKalQfCCPNCm/maX4vXZCkGg==
X-Received: by 2002:adf:9504:: with SMTP id 4mr19157427wrs.306.1613403906317;
        Mon, 15 Feb 2021 07:45:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 24/27] userdiff tests: assert empty hunk header context on -U<large>
Date:   Mon, 15 Feb 2021 16:44:24 +0100
Message-Id: <20210215154427.32693-25-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assert the existing behavior that under -U<large> we'll show no hunk
header context, where <large> takes us past the potential hunk header
we'd have extracted. I'm just picking a number over nine thousand as a
really large number we're unlikely to exceed in these tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index d41aed9ba2..80f35c5e16 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -98,6 +98,14 @@ test_diff_funcname () {
 		test_cmp expected actual
 	' &&
 
+	test_expect_success "$desc -U9001 (accumulated)" '
+		git diff -U9001 "$what".acc >diff &&
+		last_diff_context_line diff >actual.lines &&
+		tail -n 1 actual.lines >actual &&
+		echo >blank &&
+		test_cmp blank actual
+	' &&
+
 	test_expect_success "teardown: $desc" '
 		# In case any custom config was set immediately before
 		# the test itself in the test file
-- 
2.30.0.284.gd98b1dd5eaa7

