Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E300C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjELRP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjELRP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:15:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299E6195
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7c58ec19so12204514276.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683911724; x=1686503724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5f498UlYQtT4+AnzO7l4cDYxfPnE32VNkwKxPgKQYUc=;
        b=TbVq5tlWm5FhTiONiaLRGjbzFbM5hHvZIhsL/jqlgmliUItkerDCkHJPRfqUxc0J1y
         pybb1A+OK1qx3J+ODkz9T9TZ4SPHFjjMEjFQ3wBIydRS9S1GliAw7T3nYV/03eOGbTU1
         w+9T/O2LPRXmJ8AKTQBCNdPbbzjJ9G+NRm0yxL2q+CXNUwa2SKUYE1/7TyFHipbBD6UV
         KVuxduu0SSwspnqkNs/ZC9geY3YoTiIjkCTgZ7JSQFmqxXNwRTGdyZdDClG3ikJfCZpF
         EonwC8RZep1DvcVT9Gpt4NeIi6d8SlsMjPi9fWhXTiivd2lRlGYAJG+jxRJyD3eoZEQI
         xALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683911724; x=1686503724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5f498UlYQtT4+AnzO7l4cDYxfPnE32VNkwKxPgKQYUc=;
        b=OegHj9dQWAStgDfkLhi8Iq8wuwz0zwOnR0bzEuHsIooW4Xbb4pUBcFUzgmHf7wOsM8
         +qmgfnPqy+5cJ3bw17EbnEOubZD2vgdMT7ewj0Rp7DKrRKZXxUcJUfA39kj7WMsBSZFr
         CVjdfNsCOKtyuWwi9iJ2UJRZap4xhLkEBjCPD+2grMwSKvXOhOWxs7+6QQOH8BLgelW7
         RsIoNfX51QHtclY9XhRdleUq5ppyKJyWAg7pUMSPnq7vPwBK3u30FES8RuDLtLH/VuPA
         nzThud/XlOfXVcPIKWonewXC4brzdfLdOBp7wkgf/hgif/1GHPjgKEsYjxYYdiKWT/6p
         BKww==
X-Gm-Message-State: AC+VfDyccKMEA6ISpdEEHVe8BdrQH1f2KruWxFhWGkNsZlgQzIW/zTy7
        bT62HzpbF3WMMNGqMM3E8TNIz2/hqVliAuQvZa14e76fHdDtsqjTBJ7Q3ydftjNPjMUuEnAifQK
        XnQoZDmLT0gajS3s0c1RFJZfi9HEelCk0CYKuh9bD68PbL8kDkRT39tzbgplvad9+0w==
X-Google-Smtp-Source: ACHHUZ4NmIdlLkIs5OQDCD455z9dk4I3Bc6NV5po6mnqck0qwjf/LdcU+dz5Na7evCDJXJZHwjiIPYaNek2Wz+o=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:584:0:b0:b8f:54f5:89ff with SMTP id
 126-20020a250584000000b00b8f54f589ffmr16054863ybf.11.1683911724216; Fri, 12
 May 2023 10:15:24 -0700 (PDT)
Date:   Fri, 12 May 2023 17:15:10 +0000
In-Reply-To: <20230512171429.2202982-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230512171429.2202982-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512171516.2203472-1-calvinwan@google.com>
Subject: [PATCH v6 1/7] strbuf: clarify API boundary
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf, as a generic and widely used structure across the codebase,
should be limited as a library to only interact with primitives. Add
documentation so future functions can appropriately be placed. Older
functions that do not follow this boundary should eventually be moved or
refactored.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 strbuf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c..70778c6e10 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,14 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+/*
+ * NOTE FOR STRBUF DEVELOPERS
+ *
+ * strbuf is a low-level primitive; as such it should interact only
+ * with other low-level primitives. Do not introduce new functions
+ * which interact with higher-level APIs.
+ */
+
 struct string_list;
 
 /**
-- 
2.40.1.606.ga4b1b128d6-goog

