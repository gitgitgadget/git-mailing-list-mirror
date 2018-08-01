Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A521F597
	for <e@80x24.org>; Wed,  1 Aug 2018 15:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbeHARFB (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 13:05:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52062 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389905AbeHARFA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 13:05:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so7442978wma.1
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJzNlh7SRHHloGvkTp+ATCOPRV+YoK2LFSlyS2C4aBI=;
        b=OXbY8J/w1vaEGcDY3tyj9/xMapDCISvCbyElA3bnhg2yseKf2U6PeC61iCfmttNUVI
         UhxfliCEfNztKfHRhyILM5zimSjA9YNDZ9TPVbsUeQ6B5VVpIjau1TxZk9lghEhOe88H
         /0FCzr3+lKQ8mWLcpGOJWA5p5WPZ9+U8DRH3OMYPllKCsuVXUhd3RzGH3Aj+cBn+YowZ
         gD7XOXkWehcsxfZufMNjEc5t5bKZeftj7IH4DVWprCfDdri7Ck/YcPCfkSq5HAgYM01s
         pQnCXkTvi4WG0MTKjmD/iPPuPzezN2YfVRAj2ZrZIeIuoiVk6rs0kDPvJ0Q3NP9m97dy
         cLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJzNlh7SRHHloGvkTp+ATCOPRV+YoK2LFSlyS2C4aBI=;
        b=ZXLDoNNqLUh55EhjSqz9Y/I9yZKChvuPnN/uM610HYavgKVGTUd659VwYrltNaVQyT
         fZAC7GtHJ7se/fM2Qxte8B+wOgkYLHX36Zy9dLx3Ms935TMoOdtvN1dAv/nhOo087C7V
         Y9/UkUiwKwOIWaPQOVf/rPpQatqwpFhCg0poq3OpC5dgosqbgMl8WQEdeJNIjO0XHszJ
         XMb0kI3i25KHzeMli+a6dq2NX+qucePhihMXkuoR1hS7eGatYlvES8koukoaXVc/FSvZ
         conkXChPtg7+1YOy9qSPYW0wZJegg12C6cRC9BlSDcnOPGaMT8c4bB7+dorXO4Q5ytPi
         RBcA==
X-Gm-Message-State: AOUpUlEuYo5k7dONfgs40G+AAGdjh2flZmVEwqY6GXHEOOtTwv/FP36y
        ljLjRQY4XdQC1zemmNmGGjtEcQCewOU=
X-Google-Smtp-Source: AAOMgpfuelOHdwHw1bvj+uDN4BvpLJySVFHbkkNf2981A23FVbWywZkwfnTPqIYJZV6goScriU6eLA==
X-Received: by 2002:a1c:b49:: with SMTP id 70-v6mr3208188wml.149.1533136727835;
        Wed, 01 Aug 2018 08:18:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 2-v6sm6324008wmi.17.2018.08.01.08.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 08:18:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, jonathantanmy@google.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] negotiator: unknown fetch.negotiationAlgorithm should error out
Date:   Wed,  1 Aug 2018 15:18:34 +0000
Message-Id: <20180801151835.9182-2-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180731180248.42787-1-jonathantanmy@google.com>
References: <20180731180248.42787-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the handling of fetch.negotiationAlgorithm=<str> to error out
on unknown strings, i.e. everything except "default" or "skipping".

This changes the behavior added in 42cc7485a2 ("negotiator/skipping:
skip commits during fetch", 2018-07-16) which would ignore all unknown
values and silently fall back to the "default" value.

For a feature like this it's much better to produce an error than
proceed. We don't want users to debug some amazingly slow fetch that
should benefit from "skipping", only to find that they'd forgotten to
deploy the new git version on that particular machine.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt             |  3 ++-
 fetch-negotiator.c                   | 12 +++++++++---
 t/t5552-skipping-fetch-negotiator.sh | 23 +++++++++++++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 63365dcf3d..84f73d7458 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1536,9 +1536,10 @@ fetch.negotiationAlgorithm::
 	sent when negotiating the contents of the packfile to be sent by the
 	server. Set to "skipping" to use an algorithm that skips commits in an
 	effort to converge faster, but may result in a larger-than-necessary
-	packfile; any other value instructs Git to use the default algorithm
+	packfile; The default is "default" which instructs Git to use the default algorithm
 	that never skips commits (unless the server has acknowledged it or one
 	of its descendants).
+	Unknown values will cause 'git fetch' to error out.
 
 format.attach::
 	Enable multipart/mixed attachments as the default for
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 5d283049f4..d6d685cba0 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -6,9 +6,15 @@
 void fetch_negotiator_init(struct fetch_negotiator *negotiator,
 			   const char *algorithm)
 {
-	if (algorithm && !strcmp(algorithm, "skipping")) {
-		skipping_negotiator_init(negotiator);
-		return;
+	if (algorithm) {
+		if (!strcmp(algorithm, "skipping")) {
+			skipping_negotiator_init(negotiator);
+			return;
+		} else if (!strcmp(algorithm, "default")) {
+			/* Fall through to default initialization */
+		} else {
+			die("unknown fetch negotiation algorithm '%s'", algorithm);
+		}
 	}
 	default_negotiator_init(negotiator);
 }
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 0a8e0e42ed..3b60bd44e0 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -47,6 +47,29 @@ test_expect_success 'commits with no parents are sent regardless of skip distanc
 	have_not_sent c6 c4 c3
 '
 
+test_expect_success 'unknown fetch.negotiationAlgorithm values error out' '
+	rm -rf server client trace &&
+	git init server &&
+	test_commit -C server to_fetch &&
+
+	git init client &&
+	test_commit -C client on_client &&
+	git -C client checkout on_client &&
+
+	test_config -C client fetch.negotiationAlgorithm invalid &&
+	test_must_fail git -C client fetch "$(pwd)/server" 2>err &&
+	test_i18ngrep "unknown fetch negotiation algorithm" err &&
+
+	# Explicit "default" value
+	test_config -C client fetch.negotiationAlgorithm default &&
+	git -C client -c fetch.negotiationAlgorithm=default fetch "$(pwd)/server" &&
+
+	# Implementation detail: If there is nothing to fetch, we will not error out
+	test_config -C client fetch.negotiationAlgorithm invalid &&
+	git -C client fetch "$(pwd)/server" 2>err &&
+	test_i18ngrep ! "unknown fetch negotiation algorithm" err
+'
+
 test_expect_success 'when two skips collide, favor the larger one' '
 	rm -rf server client trace &&
 	git init server &&
-- 
2.18.0.345.g5c9ce644c3

