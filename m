Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B009C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361B061212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhHXQRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhHXQRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:25 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40E2C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:40 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v16so21067290ilo.10
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QA6urUWCpbAiRBEZ742+N7KEWTKsPkPBK/kej7S+Hsc=;
        b=SWn4hXwieyg0QDYuTvRBWZD20ZWoUya44qE2LpGdhKsrA0aIHKi5y0/UasS8PL+M1a
         4MoSptuWl7rBpBIHhYevf9dU9hpibVcHJEQv60xRz5HjHVtZkNarLdLL4cQyDEHEJ5wA
         CUbgoauQthZAjJOXSDWLlnKullp0/DlfUVbOAkHosLzFvPKkG0eaBseNrcBZtZLeFQ5B
         O3BQ3vSbcMZ6q8YHeb2Uwu1eoYmh9MQv1dNqBcUFKeUiTM/k/GjP4Fx7mY19atLHsS7F
         V6Zyhp/I9mVcmHCP17Cja+ePJYbLLx+QYaYCkjT9lAkndSaJu+02JlD1hok7tUHktYUu
         o1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QA6urUWCpbAiRBEZ742+N7KEWTKsPkPBK/kej7S+Hsc=;
        b=iJJ0PG+TxQlQTjJiIAn7ATrm1zY/l3+R2qbbsIMJxOS0eNIVB2/RHOqEmxUfwnVptV
         UAXK+0gRbzo8dauYGgZxUr6eIVonR45Oh4R4vvJcYs7hUjJZdpx45sqOhblu1QCUXkXq
         V3Z/hU6MFregDazjgLaOrl3oQqOmsOl/ihM6fM1D2dOEmCWG4Ey5YnE6vN2/UOLLnUoJ
         QsWwafJXf0day4MdF82SuysFra3TW6XBbb7RQEcjPsQCEYeLaldV08spgR0g0fw2YJTG
         z92p9mJgyS+5gOr/LBy0RRvYIzW6RMitsF530APDtXXbtXDYMIIawbRc2MSi69kjWdcr
         WlFg==
X-Gm-Message-State: AOAM533UQx9WqoBCQaCinntua/L8wQp1hDL0MKyvIWmvvPSLkTqkuQWo
        ajDkIPregfzJBWGGlRHy9EE2RlM1f18NOzQG
X-Google-Smtp-Source: ABdhPJwXbGzHpaXMAE+xC10Qf3V8QGBhQxYRLmSEEtTwBolYDXSCI3OQyn3jQ8XpBCZMGVy9wnm6LQ==
X-Received: by 2002:a92:ab0c:: with SMTP id v12mr13034698ilh.292.1629821800037;
        Tue, 24 Aug 2021 09:16:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r18sm10171454ilo.38.2021.08.24.09.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:39 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 19/25] t0410: disable
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
Message-ID: <3e0da7e5ed0da144a5305c0bb211ecebd71e798b.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Generating a MIDX bitmap causes tests which repack in a partial clone to
fail because they are missing objects. Missing objects is an expected
component of tests in t0410, so disable this knob altogether. Graceful
degradation when writing a bitmap with missing objects is tested in
t5326.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t0410-partial-clone.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index bbcc51ee8e..bba679685f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -4,6 +4,9 @@ test_description='partial clone'
 
 . ./test-lib.sh
 
+# missing promisor objects cause repacks which write bitmaps to fail
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
 delete_object () {
 	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
 }
-- 
2.31.1.163.ga65ce7f831

