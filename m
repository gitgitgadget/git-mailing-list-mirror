Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8547C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E037206D4
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Fgs0yulu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgIIRTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgIIP1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D3C0619CA
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 08:22:56 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y11so2205253qtn.9
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPefqbMWPlnCd/bpwOqnWQD/4KM4Ty9r1KCsjRikXYI=;
        b=Fgs0yulu+gvCuz7l4g0dMUY93O8tdCefqx+VcxOegkKCbif2TMv1zBp7cSv6XmEzYn
         1eK73XOq00w4l0EFHP+ujziCxY/wF+C5Y87181TFlrBL8vNIRvU1uXlDOV9D+CbVWCvi
         DmPOAE8MVKvQvBGH3UWYHySFZFFQCxLs6SeyNDCrUS6KNcVEqS7DDpt0/w5V6hzjeaYi
         cT/bk66Gtb6Jg5PpBPrT2uQBSmfOtwphHSLloNeARFWBidLj7AC8MbXa4Ha7k0NBKti8
         DnKzxuUXd+N9Se8+tL+QAmeDRnVBIQZ+WD5Nnuxj8jVtgP7EwquPqaCT0dbtqAgw/8tE
         FI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPefqbMWPlnCd/bpwOqnWQD/4KM4Ty9r1KCsjRikXYI=;
        b=UB6RWbRvhyR+6z/ahonW6C3vCbts/ZA7JEqXSrgh8q/OOxyHBtE1/LTys2K0fhS94i
         z/lDDA/HvYt2gurjcPIIti1XSypH87yciCL/qnsumKlxfYS0lkw7ldfqOPA6Jz3e3gaf
         JKO6xHoPInfIm10+uMLx3TXmtPh9nNJo9sRy3imx7vNwkMl2L4wKmJu/QwRD2OD2ZXKr
         pq/JkM3LY0O2DNV7TWcL3W11UekkYp7tUtqZGRG1MSzoUzlX+g1ePw9jL5M6pLpl0A7h
         DaMKLSbcnrPUkWDgt4LaO+jYD4o1WhwaU5P7b71NEvcu30kVf+CkPjbltPonwHkiKDBr
         0c5A==
X-Gm-Message-State: AOAM532wJXJputaGpurAZDE2d2wqZnUFai9TeYY5f7c72yVv2s3N2Qs0
        xKnZpG5Apqh93C8y6XEYIwxIAHOUM/7zmgWh
X-Google-Smtp-Source: ABdhPJzJsiUM2T9uH/0K0hB8QvVxW0ibRXlmic8wPG3AtAG9oO/g5IHvFIu1ZBeFBiTNqJdGnkM+rg==
X-Received: by 2002:ac8:12c1:: with SMTP id b1mr3845397qtj.148.1599664973461;
        Wed, 09 Sep 2020 08:22:53 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:10e2:cf5e:922:2af0])
        by smtp.gmail.com with ESMTPSA id g131sm2777880qkb.135.2020.09.09.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:22:52 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:22:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 02/12] t4216: use an '&&'-chain
Message-ID: <44df936e51e88e41d5ed9aa02d0bd3ca86696f09.1599664389.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599664389.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a759bfa9ee (t4216: add end to end tests for git log with Bloom
filters, 2020-04-06), a 'rm' invocation was added without a
corresponding '&&' chain.

When 'trace.perf' already exists, everything works fine. However, the
function can be executed without 'trace.perf' on disk (eg., when the
subset of tests run is altered with '--run'), and so the bare 'rm'
complains about a missing file.

To remove some noise from the test log, invoke 'rm' with '-f', at which
point it is sensible to place the 'rm -f' in an '&&'-chain, which is
both (1) our usual style, and (2) avoids a broken chain in the future if
more commands are added at the beginning of the function.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 715912ad0f..cd89c75002 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -58,7 +58,7 @@ sane_unset GIT_TRACE2_PERF_BRIEF
 sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 setup () {
-	rm "$TRASH_DIRECTORY/trace.perf"
+	rm -f "$TRASH_DIRECTORY/trace.perf" &&
 	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
 }
-- 
2.28.0.462.g4ff11cec37

