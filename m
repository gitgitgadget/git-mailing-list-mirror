Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D3C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 05:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88A6610CD
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 05:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhIBFbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhIBFbk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 01:31:40 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63CEC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 22:30:42 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y144so850157qkb.6
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 22:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V268iyFrYtUB0QwIqalAv/f2HLrPnddP0T80Vlbtx/g=;
        b=gzXJxgOqM3U3T5JzmT0hTjeGA55EAejeDR4qH4AbvgtibiaiMTcIRztLf7QFUThwNJ
         1vvCT7IMwUDllcvcablVNOdbfU1+JlLzM5bmVWQacMfU7gqAYTqPArBW4ywpAWEGtgUC
         6dCrjff1jKGtjY3cgjV7PX/65AH5SZ70WZM1KZrOs2Yl+4JMQwyiVjjkV/B6ibz7Wp5j
         mmMWf356hSIhuZ+seDyrudEYPDXo8DQ9tXVkIsoyWM1pktVtLCcNeNO4xYKVhVPKWV1o
         1RkOd5RxSOSJF23PVpvHEzSs/GQTZbDZQ/pX8eMgrABzUfZ4i/puAdl5FxP/3K/a225l
         zeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V268iyFrYtUB0QwIqalAv/f2HLrPnddP0T80Vlbtx/g=;
        b=p5ehFQETaBIWLqjZRSKnF7fOJ9fvalzl6DQpeNuf96tDZvDiYfaN48/Cky/xzQaz2e
         A+dJYKYPFzAr5mjzQ2HhHEuDTsD6WZgftg18B3QqB2qg92ANKDQPa/b6Pyn3fYFhyNrY
         WbnrRd5xtsttdBSdVBK7PwHK3hlysrZshS25EkNVeTcTt9ZIU9yhnvdZmgMXrVfMHdj8
         dvqfiEJ/xCKDY86RU8gPLqZ61oU5i5bEwHQwL1gPxCwF8tc4UgBAjdJT03CuKZiB8NDc
         Zm8j0aRStedGR2WMNunMbpx/tLjXkcQYthPH/yDRaRvXMO+Lb56K5rhcd0icrAI6W4r2
         UWwg==
X-Gm-Message-State: AOAM53050E4uI2MlfIDxDRsTA1te9WhW2hOe2OZrIggp8k3gvSzgWDfo
        s3I/FZE7UCFhQ/MOfFTcCsJh6vg2iMo=
X-Google-Smtp-Source: ABdhPJyYYvLPc4i0WIeDb0iIMv64ppPO8vnAjHHOqCSf+6S2jjUL4rpTZgwzdlaYmvBdw3ifXzG7TA==
X-Received: by 2002:a05:620a:13cb:: with SMTP id g11mr1559731qkl.332.1630560641793;
        Wed, 01 Sep 2021 22:30:41 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w19sm669346qki.21.2021.09.01.22.30.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 22:30:41 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] fixup! reftable: add a heap-based priority queue for reftable records
Date:   Wed,  1 Sep 2021 22:30:23 -0700
Message-Id: <20210902053023.44006-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210902053023.44006-1-carenas@gmail.com>
References: <20210902053023.44006-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

not a very useful option, but the fact the main logic is done inside
and assert that then gets compiled out when -DNDEBUG might be worth
reconsidering.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/pq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/reftable/pq.c b/reftable/pq.c
index 8918d158e2..a6acca006b 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -43,12 +43,14 @@ int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
 
 void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
 {
+#ifndef NDEBUG
 	int i = 0;
 	for (i = 1; i < pq.len; i++) {
 		int parent = (i - 1) / 2;
 
 		assert(pq_less(pq.heap[parent], pq.heap[i]));
 	}
+#endif
 }
 
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
-- 
2.33.0.481.g26d3bed244

