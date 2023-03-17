Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA327C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 05:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCQFB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 01:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCQFBW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 01:01:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2190B06D5
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c8-20020a05600c0ac800b003ed2f97a63eso4387390wmr.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679029279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJa2gU4qnwkxG7CMb6TZDE2ZBj0ctRC6a/a9Vj+Ar0A=;
        b=FE8TUCy13WakKPRLackd9pR+/6FVL5wfQyPlXAVitTDrxClWjwKSKZpJQbR50W7Dyp
         w2YHWsLb1l/Rr+bl5z5KL3NgquN4xqNgkFKz+VzQU0cnNwXNyyx9+JNnz/r00EwoWHbs
         63YY/dfhiXFR1uba9vIir6b4tJXCwU3FJy031CDOj5ZPt3S2OQ4UBYjkRmuzjaScRY+V
         0d+mcI0nAnXa6FfFffZekIx1oOkRqAmc7CM0Lg9hedceFmEXGnooPScWpEKWhn1X9u6S
         rrb6Q55ooM48Jr+G5hP78cvBzC+t/5pNOWMUliN4chIsUwIMNscjZVe3YrXUZ9X7qQB1
         i+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679029279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJa2gU4qnwkxG7CMb6TZDE2ZBj0ctRC6a/a9Vj+Ar0A=;
        b=ZXtM/gVD0n1Nl/+5KHXSZxkcstEUbTfH/eB/Z/CcCl0eWz1s03yQLQBgMP6F7P6m0p
         irqMm7elsMAiipkQzhSa1PzPCzhfCnjKMl+L8rlPvLze+ac3PEcvfMHZZ6DYocRowEfl
         AemjGaEjMa6RHwewbsQaP7qnm5a1WtCNBRr3XA3wQBQl05GMLbWGCjDgge0yUVKf2iwu
         rI/uC6zl10Hx3gjzySPQ8I7fSiiDibejMyCtMqZiAkAqvOXp31jzmbaZ3nVVHLEgR6CH
         UqNk3GHgN4JXn1Ou4ZGcz5nVrx9U1a/Krwq6IrksjU1i6oBLP9aQ7PnN/9ugXRW11Z9+
         1NTA==
X-Gm-Message-State: AO0yUKWhhHQef1SdfEqenXLOYGLROoYtjWutC0H06QWE58K9IJaC0gPJ
        IRb93cNPh9JZfKjeE62ot0gS+FcD9JsTFw==
X-Google-Smtp-Source: AK7set8L7/ThHF6ampJ7RdK2iOLoRDOv0bf/qGU7kj2En2bdsRhUNqizbX9bCn+tCnRz1Oh6jkgwUw==
X-Received: by 2002:a05:600c:458b:b0:3ed:23e5:e6ae with SMTP id r11-20020a05600c458b00b003ed23e5e6aemr15888065wmo.34.1679029278895;
        Thu, 16 Mar 2023 22:01:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b002c559843748sm1027844wrq.10.2023.03.16.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:01:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 4/5] config.c: refactor configset_iter()
Date:   Fri, 17 Mar 2023 06:01:09 +0100
Message-Id: <RFC-patch-4.5-cf224010970-20230317T042408Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com> <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use variables rather than long lines in configset_iter(), and use our
own "kvi" rather than relying on the global "current_config_kvi"
within this function.

There's no functional change here, but doing this will make a
subsequent functional change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index a65e7bb36d3..230a98b0631 100644
--- a/config.c
+++ b/config.c
@@ -2227,17 +2227,22 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 	struct configset_list *list = &cs->list;
 
 	for (i = 0; i < list->nr; i++) {
+		const char *key;
+		const char *val;
+		struct key_value_info *kvi;
+
 		entry = list->items[i].e;
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
 
-		current_config_kvi = values->items[value_index].util;
-
-		if (fn(entry->key, values->items[value_index].string, data) < 0)
-			git_die_config_linenr(entry->key,
-					      current_config_kvi->filename,
-					      current_config_kvi->linenr);
+		key = entry->key;
+		val = values->items[value_index].string;
+		kvi = values->items[value_index].util;
 
+		current_config_kvi = kvi;
+		if (fn(key, val, data) < 0)
+			git_die_config_linenr(entry->key, kvi->filename,
+					      kvi->linenr);
 		current_config_kvi = NULL;
 	}
 }
-- 
2.40.0.rc1.1034.g5867a1b10c5

