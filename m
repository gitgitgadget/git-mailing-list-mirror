Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F8C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4766B23A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgLHAFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgLHAFR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:05:17 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B393C061793
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:04:31 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id h19so14338575otr.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KUBJcsWeoRI5VoCgkX2lkcFq3ATa4y+wUU2KV7/4Hsk=;
        b=L7ztPi/gyhZsSxItNSCo/YyQR4VUz29DP9jG02LtTDcIDkydx6yhiSbZZgEnLgw2Ya
         zHbCcj1VyoPtymSrs+KI/oPWkshsSGrAEckg6w2UeJkphOPY3QhkSZdXLLVL88Y4YRFk
         TlFthoeTZ9k+5b4cemg5S+AoRQQ32A3hNsLw3e9sSRmnYKjFGsDm2LmThPZWEfe66Oh8
         K++s/k49+2fXKGPbt7kCSlx7kqQDP4C8fD/0FBgPj9RM7iMD9+KV4sMQn0AzmyPa1uyC
         l9wfDvDEEbCCZlwOXnwQw6wOOaRryR7w1qE8ptlIzlIHsNu+rQ3Rf12Cig6iAZM/ttuI
         ymMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KUBJcsWeoRI5VoCgkX2lkcFq3ATa4y+wUU2KV7/4Hsk=;
        b=CXddz+Wy6/HwwxUePT/m46XF1CXIIhESx/hdbLc3FWTRWv1WlFCarKrj4BOYnHF4rf
         L3gFYV+QT1b4JHvKUZJMMvr4gG0bAlJQ2c8cNLwY0T8UwUeBG1B3Wr0rpCFsoltRk7Cp
         YzRGArWSYKrDhxA2JARli7r65Nv32Jrf3UmsLjlVXgWe3WMx3POWi8YMBF76xOZdamp/
         TfH+lGH/lG7DbvRFDrgc3tL/hYhGCIl80W0kRGKnygv6P8VsicsYgpPKhYyYMHYdOJp0
         3Pz6l1TSZDagzXK9vj0y6zFEhxUNuP977Gy+EOMaH1EVvq9poBas8nU3AR7WfChNLfrJ
         bfxA==
X-Gm-Message-State: AOAM53161dJQxWQcY2j7jwLwDmkqi5BbNW6rA2cNBmlDRDJpPTeUQSW/
        LeZGwHhSpk7VVW/m4Awl3G9y3QRTPlkUP1/h
X-Google-Smtp-Source: ABdhPJxz6hHn3mrFvycDQFs4pr5q/scXYQIzC6aLzJjAjmGKrqlyV7P+DHiZ+tI73Xd/vOgHStMIrw==
X-Received: by 2002:a9d:508:: with SMTP id 8mr8596704otw.338.1607385870262;
        Mon, 07 Dec 2020 16:04:30 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u15sm592094oiv.28.2020.12.07.16.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:04:29 -0800 (PST)
Date:   Mon, 7 Dec 2020 19:04:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v3 04/24] t5310: drop size of truncated ewah bitmap
Message-ID: <055bc1fe66d415bc8e6dcef3e7201d007608e27f.1607385833.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607385833.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607385833.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We truncate the .bitmap file to 512 bytes and expect to run into
problems reading an individual ewah file. But this length is somewhat
arbitrary, and just happened to work when the test was added in
9d2e330b17 (ewah_read_mmap: bounds-check mmap reads, 2018-06-14).

An upcoming commit will change the size of the history we create in the
test repo, which will cause this test to fail. We can future-proof it a
bit more by reducing the size of the truncated bitmap file.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index dbe1ffc88a..8a2a3b2114 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -349,7 +349,7 @@ test_expect_success 'truncated bitmap fails gracefully (ewah)' '
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
-	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
+	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
-- 
2.29.2.533.g07db1f5344

