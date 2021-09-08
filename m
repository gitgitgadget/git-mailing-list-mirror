Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8796CC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 03:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAA76113E
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 03:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbhIHDvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 23:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhIHDvW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 23:51:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D365C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 20:50:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so479458wmi.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 20:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tXredH4z12HAZER4vCXFnoa/dMLcdshIVtjgZ8Rg70A=;
        b=pU8I4Sw2LeQIvptcbqt0sm7bZQQpPdj5bcoEk22HOhriNRG9lYUk9MJoUA91PqWAPn
         tD5qoLwj73j1RzkKeLgw9CrdTpTCQsU9o0q6fDP+RcEOv3Y2WwbWxGt8PbqxU0j2z+Gn
         BmQqH2HNecbPEjunpxm04FONTGdMpMdyHEf/k1QDVwVceJXw/OjAt1Z2s2yiBDq82nq8
         q3sGvRuGVZAyl+VNkggqAs6n3VkZgoqsnRpkn3K1ZUsvvhNwNUCGLMg6JQ9dNMo+MCZN
         BqaTdKaWTH/4nullshAHTa785F15nsJ1Hao1d9Jv9BPWUM4KRS+5/V+Ua31Kduzb7G4Y
         Bt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tXredH4z12HAZER4vCXFnoa/dMLcdshIVtjgZ8Rg70A=;
        b=h7r49G4kS1u6J/+O6W2v/M8vxqZujbBDOv1cqBlXRfq+fCW5i2kNhcF3JZ63DqjKgZ
         Ga+d9quXb29dD8yfTfWUXxbfbHJHMfoE1w+eOZuk+52jLw0/OXed3+cqMP5V7B4h2ueI
         qmSn0/cocutG5Ws7JQiFPJkHyhySPWnNWoH4Ysns5JC3EV/oltX2LnGlGU4YIjQAeiRf
         DTr+yU1o8E75GFE5o0I0CNjlO98bvJ6R7ZK03/D2WAPfZsmHDbXGmOilo72YPQH0IHIG
         nPEMX1I+ZL9/OI7n4xTzT6dIEEAIVcDHyd0mRRRQtHCiekWSKfFewed/l05gFzLWfuyJ
         3b7w==
X-Gm-Message-State: AOAM5306aILl1ns/Bc5D0qLAws7u+8nG9Xt6w+FSV5N0ke/jcIBQ6SKO
        dBXOAcuivKw9Mn80Lvh9vCNveQ==
X-Google-Smtp-Source: ABdhPJx1pgUwBQlbvmnvGkmy1IltzBbpAU3fr0UgSRO3QbnQJ5FuySjshaM5IbXwkjL8dbaTxLL+fA==
X-Received: by 2002:a05:600c:1d27:: with SMTP id l39mr1257143wms.146.1631073014139;
        Tue, 07 Sep 2021 20:50:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9sm783913wrd.69.2021.09.07.20.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 20:50:13 -0700 (PDT)
Date:   Tue, 7 Sep 2021 23:50:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] pack-write: skip *.rev work when not writing *.rev
Message-ID: <YTgy85aiCL1bJjKE@nand.local>
References: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
 <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
 <YTglEreI7nFCII/b@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTglEreI7nFCII/b@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 10:50:58PM -0400, Taylor Blau wrote:
> Of the two, I think the former is more appealing (since no other
> functions called by finish_tmp_packfile() are guarded like that; they
> conditionally behave as noops depending on `flags`).

Sorry; this is nonsensical. The only other function we call is
write_idx_file() which merely changes its behavior based on flags, but
it never behaves as a noop.

That doesn't change my thinking about preferring the former of my two
suggestions, but just wanted to correct my error.

Thanks,
Taylor
