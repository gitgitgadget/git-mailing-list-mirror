Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02252C433FE
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 05:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiKMFBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 00:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMFBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 00:01:54 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027013E2A
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 21:01:53 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e189so6166912iof.1
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 21:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j56K9k3dlqCw2MZvMkOSsU5zlXr723f6bZL+pPkDrY4=;
        b=MGIPRKdvofBdSTfDLngmeVBvozO++utfjO5ZbhgkObG55gqTJ/alPTn66plwiBDLUi
         8hnExQtDFpMpj628cjqMXm0xoU0Dsxl/TtvhDYJMrwZYWYyEQYmvIHhs3PVeRBImEOfh
         vhE2o7CdrEVw4AHpXQ8f1kScvzTFq3mZYfO4l9GRQI8tceNKstxkse8CDDQEfKNF6e8q
         ioeRp2blwxKCKYVugnOlqns3N17mFcdCAlCvx05LUToleIjMvJMJgtO4IUIQhP1L1+A3
         60PPjojvVVI3jYGZAgv4XAw3ZAMQh6EIfaA8jnalvzrgdyTtgJEftvxVMMY0vbtaeyl3
         uDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j56K9k3dlqCw2MZvMkOSsU5zlXr723f6bZL+pPkDrY4=;
        b=R4hVQYkIMzU+w7Tkfdk5MkCYQtOy1YKGi8CUwkq5/IoB1IfEYW77ubYgmD5O1PypEJ
         Ygn621LTvnjw1gTdUOAC5rnBaADXNp5lHzs45uaiQTnHdguz2q84rtnKWTyysA6M02VW
         A+3J0CoEj6aN1ubUkVYsJn9t4usSYJSklSDk4Eogw1Qc9C0qNAmOnYZs0+xrjebdZL4U
         5Vg7rXzKwFT/DuKgV1QWyt8HvSHkPhinEyUCyOr+3ecr582YhtMrVS9B3dGTf6N3vGRT
         rWdyul1V9Aw8l8e/yNpETDXz9rSIC65A0NVz4bUmXaTn7DVaKt+QhpSlaVokJoJ7QuvI
         qzcg==
X-Gm-Message-State: ANoB5pnUu8BpJ/4nL8ftE/wR5M8DeCBdwJIi/Qih2ITaUAatHFiFZ9Er
        nHwOXvnl1XPwBnqeC5dQeiZkdg==
X-Google-Smtp-Source: AA0mqf4aFb23HcWa+mYFmehBbTEfWiwW+e5p03x5Sa+znl7A6p7Bs+DzQMWwuzAAUFENpCt+C1NzRQ==
X-Received: by 2002:a05:6638:3d07:b0:363:46aa:76e9 with SMTP id cl7-20020a0566383d0700b0036346aa76e9mr3712541jab.249.1668315713042;
        Sat, 12 Nov 2022 21:01:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y7-20020a056602178700b006cf3a1c02e6sm2429838iox.15.2022.11.12.21.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 21:01:52 -0800 (PST)
Date:   Sun, 13 Nov 2022 00:01:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] pack-objects: fix handling of multiple --filter
 options
Message-ID: <Y3B6PxNaZvmm5OD2@nand.local>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <53bffbf4-8308-0dd7-bca5-7c85b8334e05@web.de>
 <Y2/QxOnM/7UI4R8c@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2/QxOnM/7UI4R8c@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 11:58:44AM -0500, Jeff King wrote:
> On Sat, Nov 12, 2022 at 11:44:00AM +0100, René Scharfe wrote:
>
> > Since 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't
> > leak, 2022-03-28) --filter options given to git pack-objects overrule
> > earlier ones, letting only the leftmost win and leaking the memory
> > allocated for earlier ones.  Fix that by only initializing the rev_info
> > struct once.
>
> Yikes. I wondered how we managed to miss this in the tests. Surely we
> have some examples that use multiple filters?
>
> I think the answer is that we do in t5616, but in practice they didn't
> hit this bug because of the way filter-specs are treated server-sid3.
> Even if we say "clone --filter=foo --filter=bar" on the client, the
> server upload-pack coalesces that into a single "combine:foo+bar"
> string, and that's what its pack-objects sees.

...Or in other words, clients aren't broken here because we always send
"combine" filters when multiple `--filter` arguments are passed to `git
clone`, `git fetch`, etc.

Is that always the case? I *think* so, but it would be nice to know if
there was a way that clients would not send the `combine` filter with >1
filter.

Thanks,
Taylor
