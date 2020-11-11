Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95841C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A39D2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jYc8mMMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgKKTmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgKKTmu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:42:50 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF050C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:42:48 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 63so1515857qva.7
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9OaGPAEVEXhVY/MRONUct124SfceUrdt8cXlZu/fug=;
        b=jYc8mMMn6v8/RlugAn4Hb6w7bIx+RSj+MnPEaCxKZpOlvWfu8mn3Ft9iHqkVqc2aCp
         4iMqxX7f5JwMxnu4I1Je0A1cHH4QII6lvVfBcID+ik9l8ISwuemqffvdjQXQzwod6GgI
         1T8NMVwMC+noZXsihwOB7Q0nngTTd019kn+6piKUUoMBouguF5wiAqe4z1spxfJWn0v7
         M/LE5k8Mr3i4X75xHsS2mh/pN7X3iOZ1Th4oAtX7+yP0wqSQvcZ6/70K65uM6MpHv82V
         MUMgZVkrl3rQQUcQZXRUp9IYtEz+oXvzaKTuB8ozog4WRjna0IX2N4PPK/924HbfCYIy
         KWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9OaGPAEVEXhVY/MRONUct124SfceUrdt8cXlZu/fug=;
        b=qjljlnIG/lArvgc95dYH3qMkDQzzpMRYKzjuwHBuFukAhIEPdcWgeOQ/r65GSCA253
         ZNTQNzdUX9O/aqw1mnwGVUfWDK2ylzp7frsmd4Ys/UFhR3hshHFyZREqXVXlaZheRFWm
         NDUC2XqIlVTDrf7qh3dRe+E6PZnwn6LMFEombSemlYNMqGkqbjBnxUejhiLDKH9bQT5w
         4EdaKiRXS072S9YPka1V8NJv1uAfjYk1qXBczWFfAL9aOmAvp4aTwJSk2K3D404P5e4s
         Qef0UcS/dozjRo24bD9N/rJGy3Vmu8X5Z1GXwum70EC6dcvs0/q5WEIroOFttBLsyiRI
         CZjg==
X-Gm-Message-State: AOAM531O39RznbLr/fV5xkLjHzxnsXuqXr7yzqAtH2HnBxSlFjhLrAnA
        NQXGFWLuvIv4SLUzBbOq2eRITiSgH5LuyvFg
X-Google-Smtp-Source: ABdhPJxTYHkAQlPNJn+jFlLI1mW3pG79kki8NDREePHwltyRRyQIk/nWwhPRRvQq5AgJU5N/IuWMeA==
X-Received: by 2002:a05:6214:174f:: with SMTP id dc15mr26187514qvb.25.1605123767606;
        Wed, 11 Nov 2020 11:42:47 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id n187sm3255652qkc.133.2020.11.11.11.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:42:47 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:42:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 05/23] rev-list: die when --test-bitmap detects a mismatch
Message-ID: <37af96311503c3515ebec8d6215af70c48337d40.1605123652.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

You can use "git rev-list --test-bitmap HEAD" to check that bitmaps
produce the same answer we'd get from a regular traversal. But if we
detect an error, we only print "mismatch", and still exit with a
successful error code.

That makes the uses of --test-bitmap in the test suite (e.g., in t5310)
mostly pointless: even if we saw an error, the tests wouldn't notice.
Let's instead call die(), which will let these tests work as designed,
and alert us if the bitmaps are bogus.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 42d4824c76..82c6bf2843 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1328,7 +1328,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (bitmap_equals(result, tdata.base))
 		fprintf(stderr, "OK!\n");
 	else
-		fprintf(stderr, "Mismatch!\n");
+		die("mismatch in bitmap results");
 
 	free_bitmap_index(bitmap_git);
 }
-- 
2.29.2.156.gc03786897f

