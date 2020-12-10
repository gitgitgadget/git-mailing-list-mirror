Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE0C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7007923CD1
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgLJAmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbgLJAma (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:42:30 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E6CC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 16:41:49 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id f132so3831729oib.12
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 16:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o6zwGvFqE+rSephq+iOt8dbWKj299s7p5+FwfEUrx2k=;
        b=hNgYQz3aiole0aTaaF4Wua/0j2mv6vgECugxrGn6abMZd9F18LTW+ft//h5y6XogxJ
         opdR8GtRm/M4Hwwh2eqsKTkVt/UsqFAoezOtLVbBU4qxMXvKF2zjYcPcLa/LBxQ5dMg5
         kcGtt6AcDxeUOyHg35ca7wnNmU2f95UO/p3h6IaEau8E71TlVHidHItXqVl68rg1L0ZO
         VphfOUPlHp7fBc5CD726L4BKF2fxeL+M8IAoPY+5KEy5zq+om7w9qBFhdyRe+bbcrADD
         b/KktqnQk4UGdCpYDGANgz/62jbJycMb1oarCUQTTBXTpoiayugJzLsWmz+r2doBsbEy
         sZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6zwGvFqE+rSephq+iOt8dbWKj299s7p5+FwfEUrx2k=;
        b=WasdWcIyZsLz2fc6Q2zqdOhxakte+w4wVUR5AQBwL5B75357bwDj9qzxajcaUMlHBH
         VNfUm9YjX7Y8D2EUKciVVOlfFozk/2H2bJrlo6Jw9WZpG5ZCNUKS/xkCzD+24uKYg4VR
         PUKueVxFwtUAOlhBR94mzTALRN7iPEBEUA6jlHy2PesjkNzI9VAGrgWX7Gk/NqjYD7JZ
         qiPvhY0n/ln0x07TZ0KkkIKor7rt8hC920Gm+vUF9PXrcXNlAV0lOnBX2s3OpqL7QPAA
         7Sc26qaXjaFojXButIgbKOyi3v7CZHoxQ1Go2ttLu2vUpXxVuGp6EIfsH/xwAQR2YvKZ
         fJGw==
X-Gm-Message-State: AOAM531GAfqqAnnwLxbZAIUzJiMo0+g1REswwmhFdeLJWupe7IpjhgK+
        0XTWITYbTw5u06XMi44G6QUkQA==
X-Google-Smtp-Source: ABdhPJwbAyQO2tzxp+dsh/l+mZwmvivOv3L6QU1Csgb8zLNhBwN5r0wVvCXSel8cFNkTsPohchO/+A==
X-Received: by 2002:a05:6808:8e4:: with SMTP id d4mr3711253oic.160.1607560909028;
        Wed, 09 Dec 2020 16:41:49 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t5sm746442oth.16.2020.12.09.16.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 16:41:48 -0800 (PST)
Date:   Wed, 9 Dec 2020 19:41:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/7] diffcore-rename: simplify and accelerate
 register_rename_src()
Message-ID: <X9FuycVtX7aK/wrU@nand.local>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <306a48820dd3c338d2b9e2288e5a3e1c7c89f36e.1607223276.git.gitgitgadget@gmail.com>
 <X9FScb3pzY0EBLvS@nand.local>
 <CABPp-BGPfdFj1q09XVa7UOVz-0K9yf9Lp-h2wh6+nVVbVu94yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGPfdFj1q09XVa7UOVz-0K9yf9Lp-h2wh6+nVVbVu94yg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 04:25:18PM -0800, Elijah Newren wrote:
> On Wed, Dec 9, 2020 at 2:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> > > Technically, there is one difference in the end result for the code.  IF
> >
> > s/IF/If ?
>
> Indeed; will fix.

:-). In fairness, I did read it with _emphasis_, so it at least gave me
a laugh!

> > > the caller of diffcore-rename provides a set of pairs with a duplicate
> > > filename in the sources (an erroneous input condition), the old code
> > > would simply ignore the duplicate (without warning or error).  The new
> > > code will simply swallow it and thus allow multiple pairings for the
> > > "same" source file.  Checking for this error condition is expensive
> > > (basically undoing the optimization) and the only existing callers
> > > already avoid passing such an invalid input.  If someone really wants to
> > > add some error checking here on this input condition, I believe they
> > > should add a separate function which can be called before
> > > diffcore_rename(), and then other callers that don't need additional
> > > checks because of their design (such as merge-ort) can avoid the extra
> > > overhead.
> >
> > It seems like this is currently impossible to trigger, making any extra
> > (expensive) checking of it worthless, no?
>
> I believe that's what it currently amounts to, and I debated just
> ripping the paragraph out.
>
> [ ... ]

No, no need to be sorry: this is exactly the sort of discussion I had
hoped to provoke by sanity checking my understanding of what you had
written. I think that the paragraph does belong in the patch message,
and interested readers can find our discussion here.

Thanks,
Taylor
