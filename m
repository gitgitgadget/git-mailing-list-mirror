Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4831EC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2416522D2B
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="gVh8f808"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgHERDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgHERCe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:02:34 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F1C061756
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:02:23 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dd12so16037149qvb.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LMuh9652CGyiO0bmz3tWXIVImi3zNm3ghnf+7Y714js=;
        b=gVh8f808ZrRDafbEk9g5xKDZJtAi2/mpJtqbDsxNXIrBriGt97LW3OVwIsJDS8juLs
         kPHFv52B9v0daSNPqD4WL+xX2joDVH+s4baVHYQVOEqL32JTPt5zumLiTrHGeD3pQ1oo
         3o6bmlTIjK8eKUIFtOby26TZB2h62ICVIvrNhs6tK4tEgn7L1kqudd5m9vmZbxtWItTn
         Y9mb019aVlVAeMOmJMAXXPb4DB54SpQUxGgyJAb8JnthrYJmgAVuw7a3pds8XbQnlAPi
         CQfS2NQs5sTOvHXzvKm39dtcamEmFANSwq9XipNRdqcghVJ4Hl0HheM6oVtRYQ65kPdC
         GaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMuh9652CGyiO0bmz3tWXIVImi3zNm3ghnf+7Y714js=;
        b=MA9TNZ6Flh+d9hsrT9TdvLWRe5MVqwe9/y85hZHRrEnxfdPjasshZgr/n1y2a0hCq5
         KfcpM66Ooxcr0F9Sdy/fH8ySrmxPRDXusc/Sn+Bas8O/nhzHeE6GgqfulNApGsyCo2vD
         Cx/h4X0xiGR7L+JxsWsUEjqsAyM6SIQoTTYp+zU1yZKQVv2i61V+w4wWJ7V7IPd3aHpD
         wgahZPMOKRSSMAy2NdgI6lyXDJf7G4ostu3wsA7VxI+Y4bvwG8JOt7y90mDqZeVZZD0j
         ybEVz+i98ikhjMrMr8ufoguOtQYnHI7WQQWwLF4NoykXhyoa83xNaSVaZ/yHpy8AxtgV
         LxDg==
X-Gm-Message-State: AOAM531aRupAYZSzRsaacnMo4B4Xlqg7hVzs6fPdFV0rZCu16DXyWpSK
        xNvysim8zP8J7WlEZwJL5VD/TFzJHvvXAQ==
X-Google-Smtp-Source: ABdhPJx1Ed2atz6oUChitVSNE0d8ZSjPSNw7wnIAT0OPk+REZv1o1veFh8wUU9H9oEXNjsarnu6DZw==
X-Received: by 2002:a0c:f14d:: with SMTP id y13mr4370811qvl.136.1596646941979;
        Wed, 05 Aug 2020 10:02:21 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id r6sm2379403qtu.93.2020.08.05.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:02:21 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:02:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 02/14] t4216: use an '&&'-chain
Message-ID: <e4d068a4784214d15fa2c5d284704c85050e34b8.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
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

