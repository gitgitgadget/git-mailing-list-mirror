Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F171F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbdLSW07 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:26:59 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40501 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbdLSW0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:26:54 -0500
Received: by mail-it0-f68.google.com with SMTP id f190so4594269ita.5
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m5guzOqG3TqpfZvuSQjnagfKjdAx7NpeS/ivYzxLVos=;
        b=Ax4bS+f9Gv5YzdcIZaurEr5B3CuyVjsCixygpiwemSb+rY03PN9ISWJOkBZBVya+sQ
         7t/1ZfUNCj0xiGknycV2WUVnob5qKOpD1Y9zrCu74p6xUJItxbrwrjJrDn0UEcyo2VzW
         XHeGbS1xejfI07txZZl2eCLxNg4k3LwlBeO293E4KPIuylWK/w96Nko0NhpNtS6S4kAa
         wpscjgwiYp9GHxvefcdtdyhxXEWSabyWDW4yS+J2+gRY7JoRy79ufQkunHda3bU0KsAO
         sRnOjgMEkkhKL+aiHrtVqiCE/3XkZ6A7d6+j8tbs1gCNazw8+OIa3f3RsbHx3PwnShCx
         0tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m5guzOqG3TqpfZvuSQjnagfKjdAx7NpeS/ivYzxLVos=;
        b=EBMBIcYYKtU0SCQNCVa+QW/qoHF1mJpN4Osw0Hw+VqFLtv/OaquFKzTssxvQQ4mxJE
         ZRQ8utC4+LdGf/oo094kWBNHMh1k3Mv/d3AtCzdrXCcgw4JdJmjT1JWJ36Kd4IpbMkQn
         UFHcl6vGOSbs8J/0YyNB+KoyBRwPcYD0Fqix0p5xWbbFrTg6JmGIl0+YMoCiq1MN9V21
         5FiLaojvB7+o0trR5CKMagXJUL9icibXYwy+ZvZ4FQcJxI9KVBVEkFON5kqxysIksGjx
         WJRl4MHU9VUrh0zTgMzeHqcitTaTxPPJQ6FHdAk4lsSp5c1yPctoTGBFZcmEIR3MutPE
         rEaQ==
X-Gm-Message-State: AKGB3mLlJz7fSKOKlNIauP9SXNB30JKe3PQh+9TCN8QcdWjIA823AODT
        0pwdLd6ds7Lm8AdjEN+DiV2/WcyiaUg=
X-Google-Smtp-Source: ACJfBovyG/s21GrWr9BmS8iEBMQi1LJPAL9D2s2JsEGWcBcSjxFJMQHIxFY7E/WfGnnwo3QOEkusCA==
X-Received: by 10.36.19.132 with SMTP id 126mr4839688itz.21.1513722413227;
        Tue, 19 Dec 2017 14:26:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s2sm8315626ioa.45.2017.12.19.14.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 14:26:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/5] unpack-trees: Fix same() for submodules
Date:   Tue, 19 Dec 2017 14:26:35 -0800
Message-Id: <20171219222636.216001-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171219222636.216001-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
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

