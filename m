Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F146CC433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B385B20678
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aMTF8CAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgIBUXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBUXm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 16:23:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4CC061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 13:23:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so942986qke.13
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yYjlOzRnhdrjidxqbEJfrtctAbAdE7c7UnfO3uolbxw=;
        b=aMTF8CAFsgwVaNrUFgssPhTdfvQmHvmZDywxgdhvR22G5D2uMqsD5ZvqHGQfJE9e5w
         +qof5UgmKYCE+Qfx41ofrnqcxMEG+IW8hKl6zB5bJMTHOujlUqkzZnZWbg+t04/Diql4
         IghvCCiiY3dX8B8K07Wjl/DgzIamc8F+JTlkAzciAjsL3jaBpGWJY/KRc5+YGQo/cqNN
         rR9+tOBs3QUsEDAmi3YziaDPKCBACXbtsAsIunO1mb/WsKcyyvyRakKGs1qtxt0DM5mg
         /TtxhOz2TgPnZb+IOA3Y1yj8hx+LFafS5qR4JtkcjXJDedWbexvYQg0zaGn+eEc18jwb
         DxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yYjlOzRnhdrjidxqbEJfrtctAbAdE7c7UnfO3uolbxw=;
        b=at47RV2pcemDospdCxkqmch8J5TC+RdsPJKyNlm6LpBG6xZWWagR9663UbhXUTf1Ze
         OkTjgjeJV2rB1g2dHbM6wQ28/wUNdouz5FnhtUNXaYzhboOSdSUj1Ygp72uamT83DCcG
         N6umdRTzliOkQ4l/mPhYs0yXB6a18N3VdsMAt9Djo60XLn56MODEoK/mCy7YZDl35151
         V13O9O1WKF/3SSUSXOdErpDn3pofko0ImrzsheE+NxoJ1c0fZBPnwfTiGZY9O44x5oVZ
         2PmAn6apbcN+UcbhWkAsJZLUDzVlDbGHPXo1GaAvSJHNYyqK7wy2Iyrg6+fQ4VuBqrG5
         4gug==
X-Gm-Message-State: AOAM533YVqSkbSb5vRhBz84arK8D8dNr6R4p3wbzNepQbegpt7HgINkA
        uQ2HZ+/pjJvR7BgYEGZwhzKcCw==
X-Google-Smtp-Source: ABdhPJyv6W599WWPsSnijV/jhNo0Vfu+H/aqYTy30U6oY5aLTUclKNtwWDQyRPVeBQxF4fwsA9uOUg==
X-Received: by 2002:a37:885:: with SMTP id 127mr8493379qki.392.1599078220526;
        Wed, 02 Sep 2020 13:23:40 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:945e:14e0:5690:8262])
        by smtp.gmail.com with ESMTPSA id n203sm563719qke.66.2020.09.02.13.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 13:23:39 -0700 (PDT)
Date:   Wed, 2 Sep 2020 16:23:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 12/14] commit-graph: add large-filters bitmap chunk
Message-ID: <20200902202323.GA5281@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <619e0c619dd12e2bea2b80c7d249ba66fe2a315c.1597178915.git.me@ttaylorr.com>
 <20200819133526.GE29528@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819133526.GE29528@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Finally getting back to this review after working on some other topics
for a while..., sorry for the late response).

On Wed, Aug 19, 2020 at 03:35:26PM +0200, SZEDER Gábor wrote:
> On Tue, Aug 11, 2020 at 04:52:07PM -0400, Taylor Blau wrote:
> > When a commit has more than a certain number of changed paths (commonly
> > 512), the commit-graph machinery represents it as a zero-length filter.
> > This is done since having many entries in the Bloom filter has
> > undesirable effects on the false positivity rate.
>
> This is not the case, the false positive probability depends on the
> ratio of the Bloom filter's size and the number of elements it
> contains, and we size the filters proportional to the number of
> elements they contain, so the number of elements shouldn't affect the
> false positive rate.

I'm not sure that I understand. I agree that the FPR depends on the
ratio between the number of elements in the filter and the filter's
"size". But, consider a Bloom filter that is too small to faithfully
represent all its elements. Such a filter would likely have all its bits
set high, in which case every query would return "maybe", and the FPR
would go up.

> On the contrary, it's the small filters, up to around 30-35 bytes,
> that tend to have larger than expected false positive rate when using
> double hashing.

I agree that small filters suffer from the same, but I think this is an
"in addition" not an "on the contrary".

In either case, I don't think that this is an important detail for the
commit message. What matters is the representation (that we truncate >=
512 elements to a length-zero filter), not why (that can be found in
another commit). I'd have expected to find the rationale in ed591febb4
(bloom.c: core Bloom filter implementation for changed paths.,
2020-03-30), but I couldn't find anything there.

So, I'll drop this sentence entirely to avoid an unimportant detail.

Thanks,
Taylor
