Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494981F4C1
	for <e@80x24.org>; Sat, 19 Oct 2019 10:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfJSKgB (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 06:36:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41579 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfJSKf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 06:35:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so8729227wrm.8
        for <git@vger.kernel.org>; Sat, 19 Oct 2019 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bR5KB9UHFGldisBxxZKAgVdv++NTWWdMv0wZ83KQU3E=;
        b=ZYMmdsxdf03NkFR0DsHPIjwfAoesjHGB1t5n0DQmpd4CPHb1wmV/3NDaIXuzXzj/mL
         jfL/Usp7BFqry7MPq8tMSrmHTWeXFQj3BlkV74eanGF3MxD3BH341kOZmvLMcHL7iAWt
         aZNyxXe1qtWsxXA7ZZjExdYU1RAtiP7lwY+fRUEKgbC1FHYLl9j49lq+HBW/gnWrsZN2
         nSp1XlNB2JfmYQKIbXFiUwSZp9ffRw+t1oDslEWD4t6k1qT5VVUuYSPE2MTt4PHUvJg1
         iYpmq+5VrNoj2j1JDl9PhoaEx7crZ8tLlwWD/hv60AExbsnp48j0/ngSaHZ0bfrEZbrL
         F4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bR5KB9UHFGldisBxxZKAgVdv++NTWWdMv0wZ83KQU3E=;
        b=lJfAlMwdOrBqkJVCaNu2Dfq/hVLtXb8cxYO8KMtY8q101Vzmzt1P3UUJ+ULbvT7zgJ
         TepMW6CaQif1nBmXwq/rd8c6qPnFk9i2JJOQMP6lZkKK5d4NwqPfT7qNTmF8UPgDipzT
         TaTxSHQeuGmZZjU2oe2VvN7HUMh0V9cfWJGzrfCoeR95ZmesfYW5vQW7IEpUiBUX5w+y
         s0hSerJENZbVyLAr/V7wl9cD+ZwJLpbZE4/arJICsSqk3p4WtxaqpIHlnUqk6LYqFUUG
         WKK2XhDl/NuXQVVcYELS/hAkQmv4yNZnSoXGGb00E++ufIWAQRmvrir/Y9ILgXjF8h2j
         78Gg==
X-Gm-Message-State: APjAAAWAxHCeOkWg6Uel9ABeCMOg6bvVFTWh3qKAms25Z0AOW0NxUiZl
        quPxPMonDA7juxw6ikggU9J+IpO/JeO3MA==
X-Google-Smtp-Source: APXvYqzpmHU+ObA5cafZo0WUNx9fz+dDUPWj317Je9aQejLqPsA5fvJXIwBI1v3LQqPq+BY3QmVjxg==
X-Received: by 2002:adf:f482:: with SMTP id l2mr937654wro.256.1571481357463;
        Sat, 19 Oct 2019 03:35:57 -0700 (PDT)
Received: from localhost.localdomain ([80.214.68.206])
        by smtp.gmail.com with ESMTPSA id p68sm6383086wme.0.2019.10.19.03.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 03:35:57 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 6/9] csum-file: introduce hashfile_total()
Date:   Sat, 19 Oct 2019 12:35:28 +0200
Message-Id: <20191019103531.23274-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0.rc0.9.gef620577e2
In-Reply-To: <20191019103531.23274-1-chriscool@tuxfamily.org>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We will need this helper function in a following commit
to give us total number of bytes fed to the hashfile so far.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 csum-file.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/csum-file.h b/csum-file.h
index a98b1eee53..f9cbd317fb 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -42,6 +42,15 @@ void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
 
+/*
+ * Returns the total number of bytes fed to the hashfile so far (including ones
+ * that have not been written out to the descriptor yet).
+ */
+static inline off_t hashfile_total(struct hashfile *f)
+{
+	return f->total + f->offset;
+}
+
 static inline void hashwrite_u8(struct hashfile *f, uint8_t data)
 {
 	hashwrite(f, &data, sizeof(data));
-- 
2.24.0.rc0.9.gef620577e2

