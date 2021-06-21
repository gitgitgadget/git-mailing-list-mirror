Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C132C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6FA60FE9
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhFUW1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhFUW13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:29 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D422C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:14 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id k5so3125512ilv.8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gNhnSuz11aYXJPqYSvE9SZD82rVbAXajnXodd8BEeRQ=;
        b=ugbULfUHKI/69QTFH3cPClCV8MjxVA1FgyfIANbA5OU6Wh6DKWptVYmdao3UMqEgBv
         ZRRB91pO5zq/GB7lV4kUKth0FnMvL5d3A7RGa2iwD8m0Qm3QAHYxJBVXaesXgi/RDdzG
         IcRYpwtI4zS2KqEh6ee4V7BfAWy2raTjqUesc3L47BnTZh9rZ53ta9MzWBEobTwfpbmp
         W2f9UxoPLDA3w5/T+U10oEstc4fmYJ2H5gK8iZJ1M/TSYUDhsO9rqVqol9/7S4xrTswX
         EP3GxTkKkqOjOFt4NBBFohk6/PCAlTbL07wKxJD1Bz3RUFMNFrzV2xTb88foe/WbKRm6
         SkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gNhnSuz11aYXJPqYSvE9SZD82rVbAXajnXodd8BEeRQ=;
        b=tU3WjYGV9bgqFRsoekKcHCb3RknPc21B0icKkTGlQmCDuH/fyDb888Q5f6UTZCQJD2
         o+uJyq2QkTHYcUVMz9iCmo3c1n3SOSLPHeyaMgcxmF6R714+PlNSmLek5TmTGXFmSIIi
         RTfN6XrLynzdHI4SLOiaAMR1dR9MW2WNfjzzTi2v7ly7Ri8y6uhJOu27MOAVv4WdMg2T
         Y4uqXtn3ix2NpdwxqPEsS3pCTuo0yxjKmGCFCSI9aIVouDiG0cv0eojwzWGH91T9DuL1
         MHqv3l9AOvHe29mIiZRegXaXwA9w+s5OCYNYahKNALogMpFjtVnHK3wnhf1njXXoG5ri
         jjsQ==
X-Gm-Message-State: AOAM532H/kCbthGvkQot97gfWKIXVFSMMfWLOeCYOsfMNCBD5B5f/KjW
        DUoyzL/WqwIx3QKd3VpaHB05oeL7C1NfTMMq
X-Google-Smtp-Source: ABdhPJykJooXAeOYXSxC1h6wRPbFRnsd8tqujBOoalpDoXBjqceuTNfVyxE8JpoKLapt05zxwAmoUg==
X-Received: by 2002:a05:6e02:5a3:: with SMTP id k3mr357568ils.302.1624314313824;
        Mon, 21 Jun 2021 15:25:13 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id h18sm3196159ilr.86.2021.06.21.15.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:13 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 06/24] midx: make a number of functions non-static
Message-ID: <b3a12424d78e80553741f5c7a0672490a59b6f7d.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These functions will be called from outside of midx.c in a subsequent
patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 4 ++--
 midx.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 21d6a05e88..fa23d57a24 100644
--- a/midx.c
+++ b/midx.c
@@ -48,12 +48,12 @@ static uint8_t oid_version(void)
 	}
 }
 
-static const unsigned char *get_midx_checksum(struct multi_pack_index *m)
+const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 {
 	return m->data + m->data_len - the_hash_algo->rawsz;
 }
 
-static char *get_midx_filename(const char *object_dir)
+char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
diff --git a/midx.h b/midx.h
index 8684cf0fef..1172df1a71 100644
--- a/midx.h
+++ b/midx.h
@@ -42,6 +42,8 @@ struct multi_pack_index {
 #define MIDX_PROGRESS     (1 << 0)
 #define MIDX_WRITE_REV_INDEX (1 << 1)
 
+const unsigned char *get_midx_checksum(struct multi_pack_index *m);
+char *get_midx_filename(const char *object_dir);
 char *get_midx_rev_filename(struct multi_pack_index *m);
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
-- 
2.31.1.163.ga65ce7f831

