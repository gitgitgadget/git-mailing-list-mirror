Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8F9C433FE
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 07:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350861AbiDOHF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 03:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDOHFY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 03:05:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE0B6D1E
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 00:02:57 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 12so7681922oix.12
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rckO1aR4pEJTQVM/0kGI4mhGVUmfxl1p/T2Ae43iBdk=;
        b=nuNq58/yb6K8gbDu3YVdKnrbWivr8j/qfiCsFECqkqsMslPJcJd2fvlyk1uGG9cZLg
         Yny1w5cI7oQSIgS4DuxHOx0ontZRP2nM8B8Gc9y+4rhM0ZtKCuWxac/KliT9Im2+W1fR
         DkqRjFHPn0c6rVPzqAnlmQ4WXxFqoVEyZwRgoiY5LQ/qZDL7btY0eAg7yAneQ+rT6lhF
         YGXmG2xt53aZKByqgeCO/eaGPfXJvbi28IEwXCURAtwfMWKYPQVr3x6quFO+kJwynQCv
         RiN77r9ygln0LM9z0dbsm7gdc6rR7qEM9ZFO9GESnluh3e4VQHlnAp7RDkbypk44t0+O
         W0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rckO1aR4pEJTQVM/0kGI4mhGVUmfxl1p/T2Ae43iBdk=;
        b=nbpyIi1nAjunRVxWS6N6HwzbR/DSOpVOSw3Bb7sg+/m39uYoIxlSeCZ561+8jXwYdF
         ztrKsLLjg71QD1J6I7Zl2Amc1Mme7X/wYx4sRWtjlj+STraupC/VgYTuqR2x/Po5SQEG
         RdIUh8XIP0UIL8WR8teaXnlnmL9yenBmIL+Wq39ZtSJgNLQkv3h2VWo3/cUyiUz8ky15
         3AGnH6kGQw6ZnZ+n5w4o78bSOEitD2IhWhM0lViOwA/rJY6usJvEykalawsWRhbabWQj
         fRpXGL365/AbIQl+PA/+XtaTw5OTdSoAIW77SzwmFcx3aQOZ4LRQ0y7c7oW2ITtqXS4J
         /+gA==
X-Gm-Message-State: AOAM5311i17rrDZwYX/QwKyFWbLyfkwMXE5Og/tvOOJuzPq0qVzkY5QE
        3ukmZ2FYAdBvnZ1Ru0ZWuA1yI5/YFUY=
X-Google-Smtp-Source: ABdhPJxM0XzmcvGvFZMJxWFrOhAwLbZYNIZ6wjFtfcnnLs8+g0ZmD4Ch3UwB3acf8DlJ9UgBQNLwFQ==
X-Received: by 2002:a05:6808:d51:b0:2f7:38c8:9b04 with SMTP id w17-20020a0568080d5100b002f738c89b04mr1055477oik.6.1650006176545;
        Fri, 15 Apr 2022 00:02:56 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id u7-20020a05687036c700b000da4bcdae42sm1441765oak.13.2022.04.15.00.02.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 00:02:56 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] reftable: avoid undefined behaviour breaking t0032
Date:   Fri, 15 Apr 2022 00:02:36 -0700
Message-Id: <20220415070236.25280-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.283.gbef64175c85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At least in glibc based systems, memset with a NULL first parameter
will cause a runtime exception.

Avoid doing so by adding a conditional to check for NULL in all three
identically looking functions that were affected.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Bug was introduced with the original code in 1214aa841bc (reftable: add
blocksource, an abstraction for random access reads, 2021-10-07), so not
to be considered a regression for this release.

 reftable/blocksource.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 0044eecd9aa..984bf07fc17 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -15,7 +15,8 @@ license that can be found in the LICENSE file or at
 
 static void strbuf_return_block(void *b, struct reftable_block *dest)
 {
-	memset(dest->data, 0xff, dest->len);
+	if (dest->data)
+		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
@@ -56,7 +57,8 @@ void block_source_from_strbuf(struct reftable_block_source *bs,
 
 static void malloc_return_block(void *b, struct reftable_block *dest)
 {
-	memset(dest->data, 0xff, dest->len);
+	if (dest->data)
+		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
@@ -85,7 +87,8 @@ static uint64_t file_size(void *b)
 
 static void file_return_block(void *b, struct reftable_block *dest)
 {
-	memset(dest->data, 0xff, dest->len);
+	if (dest->data)
+		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
-- 
2.36.0.rc2.283.gbef64175c85

