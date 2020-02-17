Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F26C7619F
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F7A2064C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0VU2xCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBQIlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34734 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgBQIlX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so16604807wrm.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/E7cK3VSiOwE85cFoKaYycycoziCZiL2QoxWjjLcEQ=;
        b=m0VU2xCbF1qPIXpDVUx1c9sAQ6y9orA9FAcP6obFFPVE0/kZ2FWmQ+Jw8XhOBhbSl1
         n1zH0iAAPlhMsETllp+gWNRj5cR03TtQ72pOxHg/8DF8ymMIIeatlBq75KOVDMYYKI3C
         41VOFD60buXf9NBk5CVqWmdo+QSeuDsOn3TrGd5aHaRB9cbbuuOuro5run0X9i4Q5WyJ
         yBwhXxThfJAw5OJQQYzVwLl9nGNqlQDJPUVNg2L/pSCbnNJRHVdgElugd5InsbNywMvX
         Z7VJ0laF86FwkLpewDIxSZ865bsN39a/xoDyiGWb2UWRifp1bC9+tmMRyuv3M6x/rQge
         3ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/E7cK3VSiOwE85cFoKaYycycoziCZiL2QoxWjjLcEQ=;
        b=VGP6Ss06zm24ogA/07asT5LDBH2XBkaelCzLhycSUPTZTB/QC56ivuPSmxgBL4Dp3u
         DUB5aOfGMPvE8e+8DDH2a48AnI/b5fT8+Zmw+XPwothknBW5AyEc1wvcrs4MhWuXpS9D
         8mssCJaERh62bh26wtdUx8zhqpqXLsWNtfldzG+uHEjdMi22PXSbRhJ7cNtABFNwOVEr
         FFhQfxL+lhITD6L6VbpDkEkzhFa6zXNxT4wytEkw/2ypKa0bRbajlc6eq+sqvlu5eriB
         C90VT9ApjqhXIVkC1KSCX0rMFDx9DJVH5FgfWMTg7idJukuhj/cfj2rjhnonlPCVWpxY
         +yqw==
X-Gm-Message-State: APjAAAWZpvWDuNFJyv0M6PAnVtNwpb5wYes8CJS0GbFR6iVzD/K5Nh3U
        vJbqRGtqQ00PLftJ/QnFi2o7hvru
X-Google-Smtp-Source: APXvYqyh1bw+ovjM7ymtpfK018hP+LtveKwCeW3B2evUB1cbEbJ8YuNNSg4JPQxWdRLIoxiV5dvkTg==
X-Received: by 2002:adf:b605:: with SMTP id f5mr19778027wre.383.1581928881911;
        Mon, 17 Feb 2020 00:41:21 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:21 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 03/12] bisect: use the standard 'if (!var)' way to check for 0
Date:   Mon, 17 Feb 2020 09:40:30 +0100
Message-Id: <20200217084039.78215-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using 'var == 0' in an if condition, let's use '!var' and
make 'bisect.c' more consistent with the rest of the code.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index e81c91d02c..83cb5b3a98 100644
--- a/bisect.c
+++ b/bisect.c
@@ -572,7 +572,7 @@ static int sqrti(int val)
 {
 	float d, x = val;
 
-	if (val == 0)
+	if (!val)
 		return 0;
 
 	do {
@@ -869,7 +869,7 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 		goto done;
 
 	/* Bisecting with no good rev is ok. */
-	if (good_revs.nr == 0)
+	if (!good_revs.nr)
 		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
-- 
2.25.0

