Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4821F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeDLAWF (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:22:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41333 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeDLAVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id a2so2081396pff.8
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hau29DdPie4j5JkGiAnR/05Ad3+KbvA0ZlZw7eLnL8o=;
        b=BLrBC0+bEk4SRiKZmSF7P77QOX/vuTj4qiNQpt+ikUczfI02GIeALPgpwkH8ePy/L3
         UjO/OX0gQMBAH8EY6RyP6aJq5/+DslOixChMrm+xBPrW++dg5/Jc0gyrD+JEh2fOyhpd
         OeL4LstdUZdeElle6MhFAQhJPBJltqo79Cusfep9C46IHzFG9aytvXfDKiuKRc8B4W+s
         pg3TS0ZXVxNbBCdyuJU6q7HA5Y6N7fjPaKttDd/TDtMYazQP7Yarb5pmtosEA8zBT4cH
         GRJBb9DCxFg5sm03C766vPLIQ8UUkLuEAgGsD7EfKaO+nPZXF+Efnq4M+xNB4gg5EkT6
         ATtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hau29DdPie4j5JkGiAnR/05Ad3+KbvA0ZlZw7eLnL8o=;
        b=MbAqebvY7jwts8875WVW2j/sOZpxZPwv+Hk7eS+fdCDFOiJ6m8hpjqVpiZ8n+pvUNd
         Y5vxDOt7UJqmD2PI+Z80QG+yWi+0HME2Rz0uLZmZ7zcamrMOZMXH5diMHJStkanN7LFz
         7xajW9raSOIpLDXqN+CYc3lFhw1ntV6R2u1BPHD/0W8jKnHczPvEzN9jIfAPFgXAIlJP
         IaPi44YtUPpRKzOKM+piPiXP68CLyZ5DeO1l/VDD4Pq2m8uxydjjFi6Jn3jw42/o7Tid
         kcjH6trZ82WNpE4zIdshn+TJ9afZ9bTS8lqi6YmKWj7vg4zgsXhorTjy7qd/SOsXaoht
         1R1A==
X-Gm-Message-State: ALQs6tAom6ktf4WjyVMxa8+oHq53JNa3MmhHMV1yPHuSh74inFaSHqsS
        uLqxC+hvI7kuYy8faSFHddazhA==
X-Google-Smtp-Source: AIpwx48Y2QXd18Wnq3W8P2uK/UZ9/JtR2a73WoOKriW4SsAJNZ8rpeK3wn6jOTVnTVIj/scl3VQy8w==
X-Received: by 10.101.76.207 with SMTP id n15mr5035174pgt.313.1523492496178;
        Wed, 11 Apr 2018 17:21:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 67sm4667164pfz.57.2018.04.11.17.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/15] replace-object: add repository argument to prepare_replace_object
Date:   Wed, 11 Apr 2018 17:21:11 -0700
Message-Id: <20180412002118.102976-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the prepare_replace_object caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace_object.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index 16a95ea416..567d9da708 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -31,7 +31,9 @@ static int register_replace_ref(const char *refname,
 	return 0;
 }
 
-static void prepare_replace_object(void)
+#define prepare_replace_object(r) \
+	prepare_replace_object_##r()
+static void prepare_replace_object_the_repository(void)
 {
 	if (the_repository->objects->replace_map)
 		return;
@@ -58,7 +60,7 @@ const struct object_id *do_lookup_replace_object(const struct object_id *oid)
 	int depth = MAXREPLACEDEPTH;
 	const struct object_id *cur = oid;
 
-	prepare_replace_object();
+	prepare_replace_object(the_repository);
 
 	/* Try to recursively replace the object */
 	while (depth-- > 0) {
-- 
2.17.0.484.g0c8726318c-goog

