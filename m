Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7007CC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A7964F5D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhBCPk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhBCPh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:37:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAAAC0617AA
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:35:03 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a1so24873170wrq.6
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tUd9omKSffFRsXV7K6/6DEhbnGyQp25YksuiGbwNKKg=;
        b=Wk+4k6gqM67HFDWRj4rWCuMLoipzuAs9oPJEh9BHmr/RobAgg+YDtvjd5Xk3NPdoJM
         XCdqJUiwNA0tveW/QaFWrQIyCWqc3AIgIT9IIZ1Y5qUYBv8IVctwYasIiECUBKudQQAd
         6Z+cVLKU0REQFD7+L0ka7LLHHC1Ljoctf6RpeneS1AbKrffdKnYRpidjMi9chkBohIY6
         kXpEADddWbWpGpep2Bg9xyRVzSri0y0FJXX/Uipv0j0lJgQOiCryT2FR1wJrYrJEhG7t
         TxcsOnYOGPniLw/pCajMXwtOa4TSl8vvuGJF5wjnfzju7yTXTmKzb06zSxcOV8V6O8av
         0c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tUd9omKSffFRsXV7K6/6DEhbnGyQp25YksuiGbwNKKg=;
        b=Avt8bHdPAC3jLKGH043qQDPG4mZ16p2hCg+wzg7vW2epl3D9vEqZ0Bd58IgCb4AyTX
         MEiDJSw+SlWtO5wK/BKvnvBnP/SesnLCYbiEUkjWp5FqpC6f8YhqUySt0cCNcHvOhog7
         1bUcWXW7Jzhp8QLqrQg7gmlC/R6uLnjohCpZei8yVkk3pub1DlGWsxjRpJZNBa7k72uK
         zymRwwQY/UVtgr5UTD1Bxf0EFm8y81f3scLykXXB3v/eHbJz1p0u0suxhPSUmEx9v8Mn
         zK/xYL5dV3ZytSB3c+MwPJ9QLIq5h4btPxglsmXX9kE7ej74HwU1hq9za5omPYMiYL1n
         3gjA==
X-Gm-Message-State: AOAM531vW9oaaGTRvyQKSXthVfqwTZIlAl+KyGFVL0dwCthyz5e8bYyG
        NU6LRXW09IIderk69+2Gbhfpm3/SGrc=
X-Google-Smtp-Source: ABdhPJyFM/hkWPDVPMhIgrGsXyhPSSXjPrDu/0AUHwAzFM6lcAZr4nPC8SJMm2mi3v3o9qzyw+XDuA==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr4145523wrv.211.1612366501939;
        Wed, 03 Feb 2021 07:35:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16sm2746765wmq.36.2021.02.03.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:35:01 -0800 (PST)
Message-Id: <6ec4a4468f6a068291c2ad6b1ddb75f68c13c3a8.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:48 +0000
Subject: [PATCH v2 09/11] fsmonitor: log FSMN token when reading and writing
 the index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 7a2be24cd43..3105dc370ab 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -87,7 +87,11 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
 		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 
-	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
+	trace2_data_string("index", NULL, "extension/fsmn/read/token",
+			   istate->fsmonitor_last_update);
+	trace_printf_key(&trace_fsmonitor,
+			 "read fsmonitor extension successful '%s'",
+			 istate->fsmonitor_last_update);
 	return 0;
 }
 
@@ -133,7 +137,11 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	put_be32(&ewah_size, sb->len - ewah_start);
 	memcpy(sb->buf + fixup, &ewah_size, sizeof(uint32_t));
 
-	trace_printf_key(&trace_fsmonitor, "write fsmonitor extension successful");
+	trace2_data_string("index", NULL, "extension/fsmn/write/token",
+			   istate->fsmonitor_last_update);
+	trace_printf_key(&trace_fsmonitor,
+			 "write fsmonitor extension successful '%s'",
+			 istate->fsmonitor_last_update);
 }
 
 /*
-- 
gitgitgadget

