Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7439BC76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 21:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDKVkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 17:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDKVkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 17:40:20 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F044A6
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:40:19 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54c17fa9ae8so283008277b3.5
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681249218; x=1683841218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hoy2O3+5f83o8Wg+c/ziAKbdUyMfLIrrcn8G0f06rmY=;
        b=Ut7tN5KEIEQmUueWzJUe0BVu4ycv45KM7LNKGQLJKocgWY/oxMo7ScldoQqsdKHNFp
         F4Y2sJ7+zrsPQ76xfDt9GdvCSexy8NQQXT8FCcj1ts5xRxTcpubvgDAs3FEkbE6XqMsW
         gENY0OF8/guEcYzZsW6z8R2X4m1dXJd8EriXNyoeUafCIDR3YjAWr2jiiYnKZEoGKdlE
         bC3XFZ4d72GqQlzNIsCE6kXKQcGazIf+tqIXcu6qg4PKusO7zNG+ymf7sNQtnk3sK08b
         Yo6Aa/wg5QQ5FeafdX98v4L2DupOclzIYWkPjYbrxS2ERDdKpLeSfSglPFQBSBHlU80p
         5JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681249218; x=1683841218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hoy2O3+5f83o8Wg+c/ziAKbdUyMfLIrrcn8G0f06rmY=;
        b=rfF1kUHruw8MgKMrLnGyNmZEMW9VFQy2J6kF5GngIoVD6r2dJ6YAAO6OYnAxu0H1aY
         9pNPEJ5zuaT/8g7JRTzKaaSwXw5NVZCiJKzbX1R1XQTE2Ene7k0qc1Xy0psgq8Otn+eE
         z2PRN2d0l9LjxoQp6m2Ibzajvy+Qrg5P9+pjR0NBn2F96FCg6FTcHK9u6/x9MnkpMy9y
         HuIiq0OAxzCIGnIuNxsxoYlCHaVzxhFdEP3l0OhWmT08uVP4+A93DH7p+TgkVZsMuRcG
         IQiD5ig5pl7/oF6MZMUb2emCyf/qlG7JRZq4iKqkyT2zNj0pl8Z/h7RPVkNYX1r2G9N1
         sxdA==
X-Gm-Message-State: AAQBX9cyPwfzM9Ohyu+SHJ3dz5qrh1f00NIdjBc/wKLziJllthTEc2NM
        t55yK3KgAfoiPTnW2XPg55Oo3g==
X-Google-Smtp-Source: AKy350Z6LJD0w/a0jdP5A0O+HH9Z9v6TRj0pThPcagsA9p6KHzAO5czJvK7cH8/V/lIGt1UqgOGeKg==
X-Received: by 2002:a0d:f443:0:b0:54e:f0d1:e3e5 with SMTP id d64-20020a0df443000000b0054ef0d1e3e5mr7822975ywf.24.1681249218657;
        Tue, 11 Apr 2023 14:40:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r22-20020a814416000000b00545a08184bdsm3295551ywa.77.2023.04.11.14.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:40:18 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:40:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] pack-revindex: enable on-disk reverse indexes by
 default
Message-ID: <ZDXTwZcRx7rGa5vW@nand.local>
References: <cover.1681166596.git.me@ttaylorr.com>
 <bfa4c23d-8b38-7505-fb57-a02e0a028292@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfa4c23d-8b38-7505-fb57-a02e0a028292@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 09:54:08AM -0400, Derrick Stolee wrote:
> On 4/10/2023 6:53 PM, Taylor Blau wrote:
> > In the vast majority of cases, this trade-off favors the on-disk ".rev"
> > files. But in certain cases, the in-memory variant performs more
> > favorably. Since these cases are narrow, and performance is machine- and
> > repository-dependent, this series also introduces a new configuration
> > option to disable reading ".rev" files in the third commit.
>
> I agree that the performance trade-off indicates that having the .rev
> files is preferred. It makes operations that _can_ be very fast as fast
> as possible (inspecting a small number of objects is much faster because
> we don't generate the in-memory index in O(N) time) and you create a knob
> for disabling it in the case that we are already doing something that
> inspects almost-all objects.

Sweet; I'm glad that you agree.

FWIW for non-GitHub folks, observing a slow-down here has never been an
issue for us. So much so that I wrote the pack.readReverseIndex knob
yesterday for the purpose of sending this series.

That said, I think that including it here is still worthwhile, since the
cases where performance really suffers (e.g., `git cat-file
--batch-all-objects --batch-check='%(objectsize:disk)'`) isn't something
that GitHub runs regularly if at all.

To accommodate different workflows, I think having the option to opt-out
of reading the on-disk ".rev" files is worthwhile.

> This was an easy series to read. I applied the patches locally and poked
> around in the resulting code as I went along. This led to a couple places
> where I recommend a few changes, including a new patch that wires
> repository pointers through a few more method layers.

Thanks for taking a look. Based on your review, there are only a couple
of things on my mind:

  - I amended the last patch to more clearly state when we would want to
    run the suite GIT_TEST_NO_WRITE_REV_INDEXES=1 set, and kept it in
    the linux-TEST-vars configuration.

  - How do you want to handle that extra patch? As I noted in [1], I
    think squashing the two together in one way or another makes sense.
    So really we have to figure out (a) if you think that is the right
    way to go, and (b) if so, how to handle attribution / the commit
    message.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZDXRajRky5XtFenU@nand.local/
