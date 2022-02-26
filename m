Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55604C433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 17:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiBZR34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 12:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiBZR3z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 12:29:55 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB881DF85D
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 09:29:19 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q4so6903975ilt.0
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 09:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MDC1yevS/WTScx4fKXxkG64xQ1qEKRuUpxCD6rgtblk=;
        b=lxO7TnOu0o04wDYXnR8fHqUeQytOQzbWoB2dg6cKL+EpQJO5rtD7HJ8ijf5WMsdfzx
         DNpvrsf8XznLkfaD/xz0eqig3ENuOm23qF82ia5vhY9CG1Y8ZK19hCrFU9M4VWNTLAmg
         gV9Mmn+iV14LkRHVZVeLxwEjJfxLxjfQHIsggOtNNYm4GQyBhETne3Vm8rcfrs/jEtAW
         +5DPUuCDNykwZ2WpJiF4WbzbWCDWbOX8YOpnT6n2XQ5/suKgtk3ExWWd84cVOgSa4tsO
         qxO6mOjgL+gytFNOvPonGVwHvqQawfj08Y0nuFTlBkOezr8XBgjBnqXy0xFzCyHzlFFW
         TjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MDC1yevS/WTScx4fKXxkG64xQ1qEKRuUpxCD6rgtblk=;
        b=saP6TYp0W7/iMgWfSt/I7uG8nXgchIIpL4H3ixA3cGLV1Ro8S98Tak96Tr4RZOGG2h
         J1bEFlFQNrs3UhjC8gg2al5veEStzGh4MLG7YrHRodZL/NmnHXSERCRNtxvC3RNISA+T
         LPe1vYzx8eV8w4HEh1YbbfLPTxgroy0+KOBvCW0OAQJi3Q/tAYFiJ1Om9gBCgVE1ljod
         E1/WqH3y5gZQ9WNQ1+EUxRx0WRP2KorxuE9/RnxF+mTNkGGcb1NrtGHTB4K+b1KbrTm+
         191AWEa4z9Xeq50otag6HtPUAfJ4miYofhg8E1uTxVCgBRFJnsslLnQv33eY0amFng7P
         e2qw==
X-Gm-Message-State: AOAM5334ub/a5eBHBKIXx8b3pxzWtfr76KXamBHnvKZxySAS5lOkYo/f
        uom9SIXlpElVku9ddOnKUEv1CKGfQvNaCwXH
X-Google-Smtp-Source: ABdhPJx4YRnYxQbwVWLCZXPmg8tIxBLX8seghzwISpEA1xXzumiiRhVPdahDb9A4+TtkuyObsrDLXQ==
X-Received: by 2002:a92:c990:0:b0:2be:4192:79d8 with SMTP id y16-20020a92c990000000b002be419279d8mr10237540iln.29.1645896558895;
        Sat, 26 Feb 2022 09:29:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d13-20020a92680d000000b002c26a84184dsm3447734ilc.51.2022.02.26.09.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 09:29:18 -0800 (PST)
Date:   Sat, 26 Feb 2022 12:29:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Message-ID: <YhpjbQeFaMNVnyP9@nand.local>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
 <YhQHYQ9b9bYYv10r@nand.local>
 <CAP8UFD3U4t-inWC5mZYhybWpjVwkqA7v4hYZ5voBOEJ=+_Y1kQ@mail.gmail.com>
 <xmqqv8x5v0qc.fsf@gitster.g>
 <36CA51FE-8B7F-4D08-A91D-95D8F76606C9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36CA51FE-8B7F-4D08-A91D-95D8F76606C9@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 26, 2022 at 11:01:46AM -0500, John Cai wrote:
> let me try to summarize (perhaps over simplify) the main concern folks
> have with this feature, so please correct me if I'm wrong!
>
> As a user, if I apply a filter that ends up deleting objects that it
> turns out do not exist anywhere else, then I have irrecoverably
> corrupted my repository.
>
> Before git allows me to delete objects from my repository, it should
> be pretty certain that I have path to recover those objects if I need
> to.
>
> Is that correct? It seems to me that, put another way, we don't want
> to give users too much rope to hang themselves.

I wrote about my concerns in some more detail in [1], but the thing I
was most unclear on was how your demo script[2] was supposed to work.

Namely, I wasn't sure if you had intended to use two separate filters to
"re-filter" a repository, one to filter objects to be uploaded to a
content store, and another to filter objects to be expunged from the
repository. I have major concerns with that approach, namely that if
each of the filters is not exactly the inverse of the other, then we
will either upload too few objects, or delete too many.

My other concern was around what guarantees we currently provide for a
promisor remote. My understanding is that we expect an object which was
received from the promisor remote to always be fetch-able later on. If
that's the case, then I don't mind the idea of refiltering a repository,
provided that you only need to specify a filter once.

So the suggestion about splitting a repository into two packs was a
potential way to mediate the "two filter" problem, since the two packs
you get exactly correspond to the set of objects that match the filter,
and the set of objects that _don't_ match the filter.

In either case, I tried to use the patches in [1] and was able to
corrupt my local repository (even when fetching from a remote that held
onto the objects I had pruned locally).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YhUeUCIetu%2FaOu6k@nand.local/
[2]: https://gitlab.com/chriscool/partial-clone-demo/-/blob/master/http-promisor/server_demo.txt#L47-52
