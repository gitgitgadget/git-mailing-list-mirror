Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE3C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FFF207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0TmGlyMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHCS5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11280C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:57:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w9so29030508qts.6
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LMuh9652CGyiO0bmz3tWXIVImi3zNm3ghnf+7Y714js=;
        b=0TmGlyMyqvK+V1LJ7tLNH0wRalU7FBTutcKzPtq14bag7bNBhuk1vDsBkLms2k06Lk
         5tjS4p8alfg/PDXb3nHmAh86XgJPBRmuetuhLIrCO4pixZxbJMmr/tfCg9HNhcJ20D6u
         Wjv5YrQEwjRjcpnF3LZdtiPc1DhaWwpdQhjQciAAiWncy8DHliy0Xu9uRTBJSslFBpWH
         sfGyLcYnETpCmDFhM7gUp4OTMyl15r7NlXPAEghzkggfx7fyuPWZL5Z00YbI3SKsxgGb
         bi+GQsjIQ5g1igH8wBe2Yen1Nz7sfnh/k0mF1ppvxYNFixdtA56MHfD5xTbqeVlQ8tbC
         /yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMuh9652CGyiO0bmz3tWXIVImi3zNm3ghnf+7Y714js=;
        b=L0b5YRQzFbW6FWsaVnl7VxsKUliXFTO2cqT4Dz5EnwkWibi37xRbnslGJQrODKjExm
         9Nl5TPK4Vrq2yy8CXAG3QbiSut+U6Gf7bltsyR+MwntfVKb+dzfxXZ58Pls1hh+6sce9
         Eq34kGGFJ+yHAqRUHoM+Q/S1gjAevvv5NfoiE/FMXIUayfav4XS3B2xrcV77iQBTdfSt
         y/FgDTw6ToOEsNfQW6EIT2kbnQgka/GKvhoHrecwh44Y5uMNUp0cwcz4AWl/Wyg3Aa5w
         t29l9SYpFugJPjegr7Ee5Aj+mdkyifrBYNDgv5TRByTyIkYNAK/KwXToYldF+7YiP54j
         ZaFw==
X-Gm-Message-State: AOAM530tRYByhlRVGVZlaw4r99SSUh2F70tOAWLHvoHVt9I8Lw3IkeMh
        jkU4CVvlXCOJal1mEVZHaNNLp5d6KqvKGw==
X-Google-Smtp-Source: ABdhPJwCO1i9H4l2kHs2fMSJZCaDXmw6HqRWFq2ALkFoQJi39ouuRIgneNN20Y9J+TmBo+PSfPp3zA==
X-Received: by 2002:ac8:d82:: with SMTP id s2mr18368388qti.164.1596481038868;
        Mon, 03 Aug 2020 11:57:18 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id p123sm18761565qkd.26.2020.08.03.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:18 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:57:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 03/10] t4216: use an '&&'-chain
Message-ID: <d12fcc4a8d1637e254fa7d4a53be354cbe5199b2.1596480582.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596480582.git.me@ttaylorr.com>
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
index c9f9bdf1ba..fe19f6a60c 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -53,7 +53,7 @@ sane_unset GIT_TRACE2_PERF_BRIEF
 sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 setup () {
-	rm "$TRASH_DIRECTORY/trace.perf"
+	rm -f "$TRASH_DIRECTORY/trace.perf" &&
 	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
 }
-- 
2.28.0.rc1.13.ge78abce653

