Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD1CC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49A120679
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="l/Y1q0pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgFOVV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFOVV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 17:21:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1CC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:21:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t7so8167310pgt.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BTwRFKem02bv7dtY32RYbIteYp59zXdwWRoAJFklhDI=;
        b=l/Y1q0pFJg7tYIkqcdfM79wKeQ7sO7PCOGqZD8ah2pnSpNDVRLLwVj6bT29+VMAb34
         blQQk0D8mpJtXMg3vMGxMxA/ThywuUdebU3Zam8JRw94BQg3khrlW0jG4j0pIi4b7edn
         bl0ZTKizYvovMnOciOACzcmWLUCJwWbpw4vXTUGTBgKq/QWOHNqHMAKZuWc4sOKKx3fa
         lvVwuqLXoSEKmPfMCouW6xONbOqFY4/m1N8LIvmb43LhvhKDyOTqr3VqI55odZelqlPA
         b8a7oeiTFs39jrwsnEHkX8i/P8jOTzUATvoT9Wk7setyNG4t6JCQUvDwqveGFxz8n4e1
         aY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BTwRFKem02bv7dtY32RYbIteYp59zXdwWRoAJFklhDI=;
        b=hBRM793YSYfBO+CQMegNNsJ5ycYlxjMyMha3d3SXAShCE7mwil4yAZtEU+UBFPHaJM
         WKei55g+k4/MCHPpkf4rjPSBQOWH+igszwp0giV+S22yJcU4K9kBsmlONGXxnuoglHtQ
         5asy03MfIStwALGzPJgF3+QJDz8tfH0lFxgLNztziNwlnNSOfA8c8D93D76dsU+dUT/x
         MnsWnbGskcLLdS5MQDUrqYebNy80ocd/ruC5XnGpAfpOTkFKtE0KZg7+h0OoTGRpVUcv
         +fKMX11hAAQfxBe8qICEkKQTfM2pOr1m/3DBLnC5hI3VEX7yxX4Ye11xq0h3w0ekvNZe
         m5BA==
X-Gm-Message-State: AOAM530iKee7KH0eBU1lCa05TAVTEPeFtmlc63+UlfCkucbvkdYcPu3y
        wJfyHtjGIKWSnB9y4dxIfmAGrg==
X-Google-Smtp-Source: ABdhPJzEwdY4RvkDuCi4pXKYvIFfkN6cs496Z+x6kTMElgPQBJREAr09XsFJKzQemlpfy3HIt5G1AQ==
X-Received: by 2002:a63:9211:: with SMTP id o17mr22572085pgd.339.1592256116503;
        Mon, 15 Jun 2020 14:21:56 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y4sm12742370pgr.76.2020.06.15.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:21:55 -0700 (PDT)
Date:   Mon, 15 Jun 2020 15:21:54 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200615212154.GA79696@syl.local>
References: <20200615205722.GG71506@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200615205722.GG71506@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just correcting an incorrect 'Cc:' for James Ramsay, which I am fixing
in this email (and for anybody who replies to it).

On Mon, Jun 15, 2020 at 02:57:22PM -0600, Taylor Blau wrote:
> Hello,
>
> Over the past few days or so, there has been significant discussion [1] and
> patches [2] about changing the name of the default branch away from 'master' and
> towards something else.
>
> Concurrently with this, GitHub, GitLab [3], and Bitbucket are working together
> in order to make a similar change across our respective products. Because of
> this, we are met with a bit of a challenge: we would like to make these changes
> before the next version(s) (and so need to settle on a new default branch name),
> but we also want to avoid a situation where the community is fractured (eg.,
> GitHub uses 'main', Git uses 'default', etc).
>
> A related question is whether or not we plan to change the default value of
> 'core.defaultBranchName' at all (once Johannes' patches land, of course). That
> seems to be the intent in [4], but forming consensus around this would be good,
> too.
>
> So, I would like to form some consensus here as to what the new name should be,
> if that is something we're committing to doing. This way, we can make this
> decision now (and allow hosts to make their corresponding changes) while still
> giving us on the list some time to work on the implementation across one or
> more release boundaries.
>
> My interpretation thus far is that 'main' is the planned replacement for
> 'master'. Consensus seems to have formed around this name [5], but if that's
> incorrect--or there are yet-unvoiced opinions that you would like to share--now
> is the time to discuss further.
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com/
> [2]: https://lore.kernel.org/git/pull.656.v2.git.1592225416.gitgitgadget@gmail.com/
> [3]: https://gitlab.com/gitlab-org/gitlab/-/issues/222204
> [4]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006111610000.56@tvgsbejvaqbjf.bet/
> [5]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva/

Thanks,
Taylor
