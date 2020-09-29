Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC6CC2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3702100A
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="iKEYZH9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgI2ACM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgI2ACM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:02:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F5C0613D3
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 17:02:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so2770056qke.13
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIO8IC3YVH/BFy53QypZ1qePPfRaZiddzx8shCE/88o=;
        b=iKEYZH9jbj6Di3OPSe9XlGaaZBX242cLofuIFSuOEBnN2Ucw/T/3g2Jwcg4sOLjtxr
         AJIPJX8qzjXXRtxW5YR5UZGEn8xqSrP8r4gAj7lwOW1BWB4SIjGwQxmY1nqeoEPs2+jr
         OozGbHVD2/watT8i1bcppaOhFyYXFJ5JEK0/qrrawRe+VJ0pWi4Qg7Fo2pvl+YMAzu4E
         AwTWuWe8eiBXUTIE/hi85rPuwSLZt3C/dwFr7L/iq0+T8E9AwrBk0znO3DqRRTsiCzcj
         L4Mpy5pRg4O8Du+D+HD/eCO00ClRKQUv8xkNgo8zsuY1gIoZRnw7+mrlsYX4f+dB6HJt
         Nx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIO8IC3YVH/BFy53QypZ1qePPfRaZiddzx8shCE/88o=;
        b=uasnMA0wLQ7OLPWbNbASrx8Nm2SZuWGIeE1cksWMYJl29y9f4R6vF76q8e0ikbRYXq
         MbTyGsHJtSgeW5xKGCWqjHSfWYDCrXInUWylWcdqy2fROEDTrErGYc4fmnqwHZ0eqdtn
         nPNDBGZpUSn7KWv7oVXlXGVIxZqOxsFXd8RFdnOaH0TYcMn85AbpVUt2OtblMW3sGqcJ
         vAPpSk8et4GC2haK7k6R8ViQSgV2mmlpvL1JZywJaKsA6psJ1lzXhrDvPqy22YHocZiX
         BUzqes4Ecc1ixwe9lpIyMaIOjozpnROREBKdwmx9hK2fpVUfnPzgLYyZhfdgrEN/UquP
         fXlQ==
X-Gm-Message-State: AOAM532FC8wokcjbNZBRs7/Q6U600V0GdTsC3IfnIPxYALQgggsDmYdH
        YeJJz9YqpMJHkPjswnBVUJjvDawLyFFZxQ==
X-Google-Smtp-Source: ABdhPJw0CEQEyqsEqHept1mT4+4Qm5iaVqEF9wQNDm1iKq2Spj70PyhWNfCyTMywdYpMZs6+npXi1w==
X-Received: by 2002:a37:ef18:: with SMTP id j24mr2004236qkk.22.1601337729624;
        Mon, 28 Sep 2020 17:02:09 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id f14sm2567545qkh.134.2020.09.28.17.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:02:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     phil.hord@gmail.com, dstolee@microsoft.com,
        jonathantanmy@google.com, stefanbeller@gmail.com, gitster@pobox.com
Subject: [PATCH v2 2/2] packfile: fix memory leak in add_delta_base_cache()
Date:   Mon, 28 Sep 2020 21:01:53 -0300
Message-Id: <f15f0c82fd779656dc03ce196d7c29acd63fb6be.1601337543.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601337543.git.matheus.bernardino@usp.br>
References: <cover.1601337543.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When add_delta_base_cache() is called with a base that is already in the
cache, no operation is performed. But the check is done after allocating
space for a new entry, so we end up leaking memory on the early return.
In addition, the caller never free()'s the base as it expects the
function to take ownership of it. But the base is not released when we
skip insertion, so it also gets leaked. To fix these problems, move the
allocation of a new entry further down in add_delta_base_cache(), and
free() the base on early return.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 packfile.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0319418d88..d31aaaeeaa 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1474,7 +1474,7 @@ void clear_delta_base_cache(void)
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
-	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
+	struct delta_base_cache_entry *ent;
 	struct list_head *lru, *tmp;
 
 	/*
@@ -1482,8 +1482,10 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	 * is unpacking the same object, in unpack_entry() (since its phases I
 	 * and III might run concurrently across multiple threads).
 	 */
-	if (in_delta_base_cache(p, base_offset))
+	if (in_delta_base_cache(p, base_offset)) {
+		free(base);
 		return;
+	}
 
 	delta_base_cached += base_size;
 
@@ -1495,6 +1497,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 		release_delta_base_cache(f);
 	}
 
+	ent = xmalloc(sizeof(*ent));
 	ent->key.p = p;
 	ent->key.base_offset = base_offset;
 	ent->type = type;
-- 
2.28.0

