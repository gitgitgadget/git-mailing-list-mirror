Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B2420248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDCLfZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38934 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfDCLfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so8022545pfo.6
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SILCV0xL0rMhdc8DRhCUAEY33mnaNDt1h5vVG3Tug14=;
        b=mjBUDmRBZJIOdzY+h7iqVz/18Fx77a3pBwDAIX6m14zaEkLhkBfpB8bqGADsqlZuDE
         n/CE398GcMeFzGIJg1R+GKd7PWHzEmXqoc11mgWWZt6mCszhg6uTzAhgMtmfEqDvKOpg
         LKxu7sRZ33SnTpNAon0sMtwg7IXYGJ8+/IUXfdNSMpebsb6FuiluY8UwfHhbuk9YkF8s
         YILn8rAIEXC4hf7jeeMSVEZfFhIJz2Oy2f4wRjHv0yku15p+13Ghf84Wsiw2GqRq+1Xm
         CPQGJXke4ZOoDOxOhSgAQMJfkGbG859JIUJ4jG7ZwQ1FipC85t5wkN9CS57SK1HB3iwt
         cCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SILCV0xL0rMhdc8DRhCUAEY33mnaNDt1h5vVG3Tug14=;
        b=X1sDiTM3a5m9zfthwUZ/vX2LV7Eu6gc1wXrbeTbM4EEkYYjG2AJyaj3K3vgpqUy0GK
         majPH6ng2R6hiIemjLqnWrw2rj7SqXTWdAifhI/TGqWshorxrXkkcQIr5zOm7whC0MqP
         4x3zA1uliDwes9NNlQEQowI5fmLHIHTeQvC7+7fmGAzAO6vmsUT+88qPG55l+oUUoedg
         xdVNM70KddBfzX3mFT8lS2AwBzk7j7xXqsMIkqeDq0eQIKrjIAveIGvIZ741ZVYqgH4N
         ZKv3ejx8bZQLizkjEd0pUErPmG23j6/zFM2fGe5qTgDm2u8mQ4/LKVCcyOp7DTNGMkOY
         ONQQ==
X-Gm-Message-State: APjAAAVfUPyBB84KFfLM9hsZehD1E0VyWpsmeaNEnhA983UQOVyUsgE+
        R5D5gOjvPSmd/HGRtbCPWUY=
X-Google-Smtp-Source: APXvYqx0PpAT9P0CWVRgldaQuGK3ce5Yo97UUdZGE6jyg80DyKgiJkaMJrf9H3IouNSFvyoK2GohEg==
X-Received: by 2002:a63:2c55:: with SMTP id s82mr64970241pgs.356.1554291324625;
        Wed, 03 Apr 2019 04:35:24 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id x24sm21774389pfn.128.2019.04.03.04.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 03/32] refs.c: add refs_ref_exists()
Date:   Wed,  3 Apr 2019 18:34:28 +0700
Message-Id: <20190403113457.20399-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 142888a40a..b869f32d8b 100644
--- a/refs.c
+++ b/refs.c
@@ -241,9 +241,14 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
+static int refs_ref_exists(struct ref_store *refs, const char *refname)
+{
+	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
+}
+
 int ref_exists(const char *refname)
 {
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL, NULL);
+	return refs_ref_exists(get_main_ref_store(the_repository), refname);
 }
 
 static int match_ref_pattern(const char *refname,
-- 
2.21.0.479.g47ac719cd3

