Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC43BC433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 08:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351437AbiDOIhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 04:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351441AbiDOIhI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 04:37:08 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E6E99
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 01:34:39 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z15so5548879qtj.13
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e6OPpdAXNI9DWWuwDNc8SHRBBpb2A+cN9zMz7Haz0hY=;
        b=edsirVM+WsjorS8ZKj9WeZH8dKnZlcfqpXGtpVUxCvADdkEzHDUtAbuAtk2lhTiQCV
         vsmXhtpESQjN4mvxkgWzXGtQWSNN0KG0bkowOHwfI6xzNKNNFS5ZjWwbqQaYqVqcq4Zt
         z3cN60LYCvN1H9MZ/paIP7zv4483z6g/tfzCXZdPGwcSbRXnUXMphdksaT24dAfJ0TEH
         CqPka+lI0FvQZI7Z4ETg8LfI4DDqXQ2DAieivfHhNCqjCTKY/cVoe5dIpzfG6y8/B5ju
         ZNjmASVyz2p4DChOheWo1xarxnVFN4UoJ4lv0OPNc5M6ZK/+g+R7W0BA7+xlkEBUTg22
         HTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6OPpdAXNI9DWWuwDNc8SHRBBpb2A+cN9zMz7Haz0hY=;
        b=ak/g5epOTs5GLvzqxLeY08Bhr3mbCbZI4dYwlmTPWWE0PbtyrpWId4gdUaWZ0XlrEM
         7dtCGz5GeMl2CwvVd46bt+tejEGVdbRe5TBxXlkSoP3gYeR9/vzFReCYEJRfzudZOUh6
         l0bLr2goVB7ZqHJ3x/eecSMKzbsDKk8zMcPovdFV8ysERllwLTTAMBdUE5ZNIleNaFTS
         uc8YRw7EL6KBaxT8jmj4HZVQdq7s4wrxihYgfDo+q2xLDJvtY39XMPgA/pjmN7E0mpPh
         ZF24Lqi1QEdlJkir8+pL5NujbpVdJxPNTreWpbRs6l6vqjLx0cGSAevk7pfhwX9H36Xm
         /cFQ==
X-Gm-Message-State: AOAM533WNx8EG1FiFuvCcY2Hm1A/KwqK72CSSvmZp9c6aeiL0TQYKnPx
        uqWzrTjZye6o8olXYevgw5yHjL9327Q=
X-Google-Smtp-Source: ABdhPJxBpLZ9w9QUnVWMdd4x5mEuvDjUudmLD9ID6aUcfeFGzQYc8g3lc6g3498Q0mw2cD0dlF1FhQ==
X-Received: by 2002:a05:622a:1aaa:b0:2e1:a40d:8253 with SMTP id s42-20020a05622a1aaa00b002e1a40d8253mr4584326qtc.135.1650011678472;
        Fri, 15 Apr 2022 01:34:38 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id b126-20020a37b284000000b0069a11927e57sm2120295qkf.101.2022.04.15.01.34.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2022 01:34:38 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] reftable: avoid undefined behaviour breaking t0032
Date:   Fri, 15 Apr 2022 01:30:59 -0700
Message-Id: <20220415083058.29495-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.283.gbef64175c85
In-Reply-To: <20220415070236.25280-1-carenas@gmail.com>
References: <20220415070236.25280-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1214aa841bc (reftable: add blocksource, an abstraction for random
access reads, 2021-10-07), makes the assumption that it is ok to
free a reftable_block pointing to NULL if the size is also set to
0, but implements that using a memset call that at least in glibc
based system will trigger a runtime exception if called with a
NULL pointer as its first parameter.

Avoid doing so by adding a conditional to check for the size in all
three identically looking functions that were affected, and therefore,
still allow memset to help catch callers that might incorrectly pass
a NULL pointer with a non zero size, but avoiding the exception for
the valid cases.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes since v1:
- Improved logic as suggested by Junio
- Hopefully also improved commit message

 reftable/blocksource.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 0044eecd9aa..db1b7dc966f 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -15,7 +15,8 @@ license that can be found in the LICENSE file or at
 
 static void strbuf_return_block(void *b, struct reftable_block *dest)
 {
-	memset(dest->data, 0xff, dest->len);
+	if (dest->len)
+		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
@@ -56,7 +57,8 @@ void block_source_from_strbuf(struct reftable_block_source *bs,
 
 static void malloc_return_block(void *b, struct reftable_block *dest)
 {
-	memset(dest->data, 0xff, dest->len);
+	if (dest->len)
+		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
@@ -85,7 +87,8 @@ static uint64_t file_size(void *b)
 
 static void file_return_block(void *b, struct reftable_block *dest)
 {
-	memset(dest->data, 0xff, dest->len);
+	if (dest->len)
+		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
-- 
2.36.0.rc2.283.gbef64175c85

