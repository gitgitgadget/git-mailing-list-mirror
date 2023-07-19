Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADEFC001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 17:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGSRzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSRzo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 13:55:44 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F761FC1
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:43 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a3efebcc24so5256967b6e.1
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689789342; x=1692381342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d55AM8YCulrPNykENyrNyE2LYwVO76JVYSql5cNJv8c=;
        b=NNEzwk87XQk8OnmdPosbdonOeCMJzGpxxZQFMIKJpsVMfpI4VfJCnsAPJQC4ps0tgt
         DwKtkWprzem3m3iUiBTCo4m71CR6CnMX8h/W0eX8etZJbPRTgofR0XuEOIN7iBcEX8cd
         lanBkawjY7C1lSwNTb5bGt7ceJWKvcX8lnAMUVYan8ub1b6ZmjlMEADVaG6rWCLHba1t
         VxN8MhM6ukzrApmX5iSmNKsyWLbTJkZXTGIaxBQDCJ4hyAc3wyA2LIaKPFZH++z2Why/
         q6GlcmBs8Q28NGMb1Ih00JxdcANgrIIR+ghGCZiT4WauF9z+D2Oiqf0UYrZoEZlGTRc0
         jiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789342; x=1692381342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d55AM8YCulrPNykENyrNyE2LYwVO76JVYSql5cNJv8c=;
        b=O9bM1zhmmyUrV+c4D9hSfpRm8Z/33qSzdt6YrxaZOLPYrOIzAArHxnyWqG5+Wezdri
         8d8i1O08rdkqq24vxH6dnQ/o9GRSA6rXLgwqDS1KX0phuUvD6/lUt/m2hT/eNIBV5PNw
         iXUCp92T4xC7RkJu/hcEAuI49SfrurnGudysFAtq68i+xxxVFUi95Uu6m5dOmNw+2Hcz
         mzSCGiFuFHoM1CNsVyCVNkkjDLtldzbXIP23QXQl9DoYcd1F46d5Y/AYPdVBJnxzS2w6
         GN0jkvlU0eklGCLahGIl3zZWgMguzJMFEj2qtMoIEObAOhzfJcVR6DrtsSu+ZrJ1VKl7
         KsKg==
X-Gm-Message-State: ABy/qLZ+pnFpN9LrMmciBucnHyjVCw2bZmYwloI9DVWfna6nQ5E3qKvT
        RMaBFom57M6iDMBdSE8m0qBlDolZvShwq4isfh2LIA==
X-Google-Smtp-Source: APBJJlFOh/FjEdcccJYgjm7kOZIDWQQac18Kt0kQF+Gsdt+yQwW0TVj1Fy2dBrIuj7S/N2achloj3g==
X-Received: by 2002:a05:6808:1314:b0:3a4:7afb:2ac6 with SMTP id y20-20020a056808131400b003a47afb2ac6mr5631996oiv.44.1689789342314;
        Wed, 19 Jul 2023 10:55:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z6-20020a818906000000b0057a93844c15sm1126958ywf.127.2023.07.19.10.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:55:41 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:55:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] commit-graph: avoid looking at Bloom filter data directly
Message-ID: <cover.1689789226.git.me@ttaylorr.com>
References: <ZLgc5q0FrL1s7j0j@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLgc5q0FrL1s7j0j@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Here's a few commits (and one fixup!) that could go before the second
patch of your series, with the fixup! getting squashed into the second
patch itself.

The first three are preparatory, but the fourth patch should allow us to
drop the Perl hackery necessary to dump the raw contents of arbitrary
Bloom filters.

Feel free to pick up these patches (or not), just wanted to get these
out there as a possible suggestion.

Taylor Blau (4):
  t/helper/test-read-graph.c: extract `dump_graph_info()`
  bloom.h: make `load_bloom_filter_from_graph()` public
  t/helper/test-read-graph: implement `bloom-filters` mode
  fixup! t4216: test changed path filters with high bit paths

 bloom.c                    |  6 ++--
 bloom.h                    |  5 +++
 t/helper/test-read-graph.c | 67 ++++++++++++++++++++++++++++++--------
 t/t4216-log-bloom.sh       | 14 ++------
 4 files changed, 64 insertions(+), 28 deletions(-)

--
2.41.0.366.g215419bf3c2.dirty
