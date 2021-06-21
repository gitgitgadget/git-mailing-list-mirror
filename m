Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB0AC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B9F6124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhFUW2I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhFUW2E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:28:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17706C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:50 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h2so5931373iob.11
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C5Yl6mIwi9zLmDdBydnpT2kQELkZPYxenRWJSBxoMY8=;
        b=RrdGSL6UJPy1QayCFJwMh2eEYSAAMgR99Wi+zpZxR/wlEU2dizuTY+/1+2uoLlQLXn
         JWOxCwK7FzmdlAPH0myd7QwnN0abM6fFukva9nrFZZ46NedH1QzRL8RP31m/WRZuvJje
         oexk3jRLNHy1mGtg1fxOQuuwIv+G7rjWQSxMHBNyJ0DE8MUlGHQXSbqpq1OJ9DFeo++X
         RCNeQBsmJ0g7Rt4PCvXaCbe2iEWXTUD7TNbvTMKOL3/wg1yB8b/mHTyuhpG0aFcOWxHj
         XJjdQo1hDz3/TPQsjul2387fxlUohyY/6wYWssyp5pZn1Qh3F4He4RSXOj2jIE9Tfhjz
         7OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5Yl6mIwi9zLmDdBydnpT2kQELkZPYxenRWJSBxoMY8=;
        b=Uh60+PjcZEeQLmdoY+B5lcoOdUypiP4JEVBnEUsoaesvMZmifxwgLxac74dA3G6uw1
         A9QHR5oP12jHucmzWHK9C0Z7oT01goy9lkbg1bbdeQ6N+WssWt75BOVmEaezljfv/QK4
         1nYWQuetkcPXEBIYY1KCXyNWOZmmkVzPQvP85KksW+EApaE9pWKMETU4xMqRnxaO51Hu
         NnrLjyqELeksUi0WtHTO0qGGrMdNf6JeP10V1csg9/bAQpe1NIsnT6tQmiTjMeimFjEa
         1AOZn34+PXYvaqLfF1Xd06PZNQRIF06eC+X/3utNIL7jtM0FErgGYWa2eK0c9Qw44BHv
         82Ig==
X-Gm-Message-State: AOAM532k0spsRkeo1T/sXZbBsJJ+Nsn5GpuAo3tfb8f2PGFCkfa0jRK+
        l03CvYvlfg0kFEs8skF0WvZOlJH4RKNAzWdd
X-Google-Smtp-Source: ABdhPJwceOsun8EpY6cD5VjABUveic4B/g/dJwLzxLTvnJWq07yz1BHrs2kuMLINGkDJCC5K8CMG6A==
X-Received: by 2002:a02:8241:: with SMTP id q1mr660572jag.134.1624314349346;
        Mon, 21 Jun 2021 15:25:49 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id b23sm10682044ior.4.2021.06.21.15.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:49 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 19/24] t5310: disable
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
Message-ID: <2d24c5b7ad0835f433428c16dfd137449688d93b.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Generating a MIDX bitmap confuses many of the tests in t5310, which
expect to control whether and how bitmaps are written. Since the
relevant MIDX-bitmap tests here are covered already in t5326, let's just
disable the flag for the whole t5310 script.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 4318f84d53..673baa5c3c 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -8,6 +8,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$TEST_DIRECTORY"/lib-bundle.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
+# t5310 deals only with single-pack bitmaps, so don't write MIDX bitmaps in
+# their place.
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
 objpath () {
 	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
 }
-- 
2.31.1.163.ga65ce7f831

