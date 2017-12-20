Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667011F404
	for <e@80x24.org>; Wed, 20 Dec 2017 22:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756202AbdLTWRi (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 17:17:38 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:45430 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbdLTWRe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 17:17:34 -0500
Received: by mail-it0-f68.google.com with SMTP id z6so8469101iti.4
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 14:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m5guzOqG3TqpfZvuSQjnagfKjdAx7NpeS/ivYzxLVos=;
        b=IiMb7K6KkfO0J5M9tAGPJ49cUS0s0wtQWTCswmVEx6ngKd1BLcT2fSq3lUOyn9qqHp
         N3s768d8WW6eN7YRjuLDv3wfUOPZSRWvSjG4XNtLMU3n+QrvZpLuv6yDyvXRGSDBlj4N
         uMYQqSRSo6xDN7T2bblj8GrcEtTvoOEYVdbr7QdCTxR8D+Zgq3zbPEPgdWIO7xHX1kd0
         F8tmDbzqr6BxGA7rwm2Aq1A6hvjZQT/zSc5zOfq6LkbOaMQZun/xF4xgdHjbnKy88BET
         OjcS3iS/vUOqeAE4s7JEkogVldJvG4sMC9LfcOk3rn6v8qBiMZPbho/ZxFa6vXTiqXHU
         /19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m5guzOqG3TqpfZvuSQjnagfKjdAx7NpeS/ivYzxLVos=;
        b=dc6ilBRqZ0t/VMBPzhwiiKke7hqoYeIG1Jg6rmAUxbv6RRWr+nd90YKAb5XogJNI+L
         ttuN6XSiZwTIYYZxVlMIDM/uoHVgjO5p6pJM0xkosBvRKGF1LwAc3a7jDtgCSCCkF84z
         omo/Lzy1BPkSzVnh3NMbJuWaM1UxXVGvmYTioDNBU4fpckVA+rwMcPADmQv5DS7i3m6g
         MYLwsbrINy9lfKTQeLi6kCn646nzX09tc17+Kp7xD6mi/M9vJF7L/124DFUu2W9OV9ph
         GBuI8irSdwhnb1f1MVIcQr2+pZpzaE5AWRZnVcOJSMaIrT8+00a7APneQYIpXalX9Fq6
         n1fg==
X-Gm-Message-State: AKGB3mKgh/LWfakXAj+Xy5ENIYERetoxWKqKCIGoAyM6t7RpWuqlmLx6
        w+PbN9U82TCCzcgDwO4H7Mqq3A==
X-Google-Smtp-Source: ACJfBosOJz/C+ByIAijfkURocXrAeYQkWYEGuMtLu9OREFATHCejqcMyR4bHvcH8ponhkEvgQzM2gg==
X-Received: by 10.36.172.73 with SMTP id m9mr9847719iti.120.1513808253607;
        Wed, 20 Dec 2017 14:17:33 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id g187sm3143183itb.29.2017.12.20.14.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Dec 2017 14:17:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] unpack-trees: Fix same() for submodules
Date:   Wed, 20 Dec 2017 14:17:24 -0800
Message-Id: <20171220221725.129162-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171220221725.129162-1-sbeller@google.com>
References: <20171220221725.129162-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function same(a, b) is used to check if two entries a and b are the
same.  As the index contains the staged files the same() function can be
used to check if files between a given revision and the index are the same.

In case of submodules, the gitlink entry is showing up as not modified
despite potential changes inside the submodule.

Fix the function to examine submodules by looking inside the submodule.
This patch alone doesn't affect any correctness garantuees, but in
combination with the next patch this fixes the new test introduced
earlier in this series.

This may be a slight performance regression as now we have to
inspect any submodule thouroughly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index bf8b602901..4d839e8edb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1427,6 +1427,8 @@ static int same(const struct cache_entry *a, const struct cache_entry *b)
 		return 1;
 	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
 		return 0;
+	if (S_ISGITLINK(b->ce_mode) && should_update_submodules())
+		return !oidcmp(&a->oid, &b->oid) && !is_submodule_modified(b->name, 0);
 	return a->ce_mode == b->ce_mode &&
 	       !oidcmp(&a->oid, &b->oid);
 }
-- 
2.15.1.620.gb9897f4670-goog

