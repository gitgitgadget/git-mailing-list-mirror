Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71CC41F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeBFAHC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:07:02 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44712 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeBFAHB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:07:01 -0500
Received: by mail-pg0-f65.google.com with SMTP id r1so123984pgn.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V0VhWQXX4lpkfi6UHjCfYzeIv4ubbNWUGbHpKzH4mLA=;
        b=gecMcLKJJwPakirCpJsnpn+mzqYf2e2SB4xPatQ8q9aK5xGIggEMamk44YP8dB0M4o
         xoF/hkqR/FV0rzUnRFP1s5qr4SBqdQNTEHvLd5u7Rr+y91WKMkR94XtLkMWknnyjR4R3
         wni4n77ESUTp3oY80qCaxdDD9M4qy3vn5KOJJsSX6/YRGyBmDaHQ3X49odO230L66U4X
         vHvMUV4b53/SftjGfti1iShWA76SihstoHCYZYKZboT9QFc3fPnSUarUZfYee40m5WU7
         MOlsI6sOzaEezD9snYKAfEIT8IMm6hzZNoKHcLve0/TdVwmpktet8yqaj20l5vwG4MXE
         oscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V0VhWQXX4lpkfi6UHjCfYzeIv4ubbNWUGbHpKzH4mLA=;
        b=H2CPvPJiQ+NYzR3Sw69CC78EeRDueu41LhZoeDfFgx9wuCr6XrMqbaAG6DWkz6zdOr
         ByuO6HX39ZtX4VlQcnzZ89ZqBnCEBb4RNQPYIKsyqYOgj5btahKbRVaHyF0NZpBu1Ytp
         Q07eySvKCVkcobv6GRc1Kw4Mxju6ly3aMF07R4Tyifj3zybFqbK3Mg+4CxPPdlv7aFZC
         m8EkZ7QhkCmSOilDkWKw4bcMqZVu0DKpHV9eQ7J2Wclgpx6V75YcNO9ztu4dff0eYOU4
         +EvWQkdzkwHtuhJ74479o6jHTwx6HfeUnrJWVIDZ27wSeCy5KF10ZgO1KoFPEUQmvfaH
         bSjQ==
X-Gm-Message-State: APf1xPD3MnxMkOCkL7XOXSaWYC2tAoOONd2oz66yJMfGcgSFdf4BQWF9
        bFcFKNb8je6xDi6qPpCgW2U0r4SCWgY=
X-Google-Smtp-Source: AH8x224wVpQ8Xijg9yL5ATsk7/HJZoYqlnZrja8LKuEKUbNonLZ+3Ttykuu0zbm7B4AmomxLC/LUUA==
X-Received: by 10.99.141.202 with SMTP id z193mr403489pgd.418.1517875620155;
        Mon, 05 Feb 2018 16:07:00 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m21sm15336596pgn.37.2018.02.05.16.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:06:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 061/194] replace-object: allow prepare_replace_object to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:55:22 -0800
Message-Id: <20180205235735.216710-41-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index cba88f50e3..d9250a7cf8 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -75,15 +75,13 @@ static int register_replace_ref(const char *refname,
 	return 0;
 }
 
-#define prepare_replace_object(r) \
-	prepare_replace_object_##r()
-static void prepare_replace_object_the_repository(void)
+static void prepare_replace_object(struct repository *r)
 {
-	if (the_repository->objects.replacements.prepared)
+	if (r->objects.replacements.prepared)
 		return;
 
-	for_each_replace_ref(the_repository, register_replace_ref, the_repository);
-	the_repository->objects.replacements.prepared = 1;
+	for_each_replace_ref(r, register_replace_ref, r);
+	r->objects.replacements.prepared = 1;
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.15.1.433.g936d1b9894.dirty

