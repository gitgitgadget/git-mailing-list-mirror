Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B152C07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A36861249
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhGLVBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 17:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhGLVBp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 17:01:45 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1281C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:58:56 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so20354708otl.0
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=y2TNZKujECe00cwvkylJ566H5xHTFs/6B8dpXpoDY1A=;
        b=je/6M2PBVvGdBrIyAJ1SbHJciZRR0uQ1DgVTQ1qpU8odVubQd/8f9XQS+PIpS+59To
         WbXOR6H0mDgTjj+nlGmDFYAjE4Ga3VaIbeN361GmGO1VpmTQ053dVap4LTVajRJGHxUP
         gLqEl2IzCU6nVyqYd1PwGUj1A1dJ0SQQ8yrgt8JBXcX+9ZXfB3sQrKe//koDr2MeKake
         CkOs1plAKZS99Ia7iJi3LDl7xLPedj1+pIjCqo1xfLNBBOJm8Yks9OOvFU7iqEZieAft
         lxuPDDQzMqr/YkFiPW7H0vn3kIJo8eWE3xeqWgygw/ZxqL1ExWyIE4aBasm25zTLuHXe
         /feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=y2TNZKujECe00cwvkylJ566H5xHTFs/6B8dpXpoDY1A=;
        b=GgtqcyMD+lOYfZdYz2yVVrUxTAQozV7FtYK+hqrZoCgkpmYWhLFi/MduZuAQ/PqXSS
         Gmbuz4oQNr39Q/wxx5mZR3YLwmWzZ0rSwTspqXxxZs/pCQLJ3JtMeU318dV8EqbHP+JJ
         JYlNNvlXqS7ycx1MyqyJ81tvfDa/uHjmpNM2EciE3L25C85qbpz1fY3R8E1TRq085nC2
         gfn+plVwEsg2AScSo9dybv23khrDa9016Oz7KIXaDrQDwoyQtz22VLWfU/XZFWl45Tuq
         /dxSw6fU19ROoHBsuNvk/ilD43XWwirEqIJZmnX/bnr2bMpcfW1cOZzpiuQgi0ccD3x2
         L+9A==
X-Gm-Message-State: AOAM531LiCb5vwe6PBX8daL/NOX7KYLFeYX/bYimC4OK7PwINkQupiUK
        ZdrxvaIrYSi1XOMJc1orxyA=
X-Google-Smtp-Source: ABdhPJzppAq4+Tw/5ESCDft8EBnUBvIG++UaiUT4sHxiPim5xgUCpAjlA0Qvn7OPBeTSIFtLnKuXpQ==
X-Received: by 2002:a9d:17d0:: with SMTP id j74mr715255otj.92.1626123536329;
        Mon, 12 Jul 2021 13:58:56 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id 68sm3243038otd.74.2021.07.12.13.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 13:58:55 -0700 (PDT)
Date:   Mon, 12 Jul 2021 15:58:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60ecad0dadf2c_a68ed208e7@natae.notmuch>
In-Reply-To: <CABPp-BEdUmxXVCx=5pb0=LN-0YBtrEB-wngPC5vys6fjVctgaQ@mail.gmail.com>
References: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
 <YOx43fqGyQMy7+tR@coredump.intra.peff.net>
 <CABPp-BEdUmxXVCx=5pb0=LN-0YBtrEB-wngPC5vys6fjVctgaQ@mail.gmail.com>
Subject: Re: [RFC] Bump {diff,merge}.renameLimit ?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Mon, Jul 12, 2021 at 10:16 AM Jeff King <peff@peff.net> wrote:

> > > * I think the median file size is a better predictor of rename
> > >   performance than mean file size, and median file size is ~2.5x smaller
> > >   than the mean[18].
> >
> > There you might get hit with the quadratic-update thing again, though.
> > The big files are more likely to be touched, so could be weighted more
> > (though are they more likely to have been added/delete/renamed? Who
> > knows).
> 
> I'll agree that big files are more likely to be updated, but I don't
> think renames are weighted towards bigger files.  In fact, I wrote a
> quick script to look at the sizes of all the renamed files in the
> history of v2.6.25, and the mean (8034.1) and median (3866) of the
> renamed files sizes in that history are comparable to the mean
> (11150.3) and median (4198) of the files sizes in the v2.6.25 tree.
> 
> I re-did the calculations using v5.5, and found that the mean
> (12495.1) and median (3702) sizes of renames in all linux history up
> to that point again were a bit less than the mean (13449.2) and median
> (3860) file size of a file in the final v5.5 tree.
> 
> Granted, this is a bit hand-wavy (what about creations or deletions?
> Is there too much bias from the fact that I did rename sizes over all
> history (due to needing enough to get statistics) while just grabbing
> regular file sizes just in the end tree?), but I think it provides
> pretty good first order approximation suggesting that mean/median
> sizes of files involved in rename detection will be similar to the
> mean/median sizes of other files within the relevant trees.
> 
> > I don't think file size matters all _that_ much, though, as it has a
> > linear relationship to time spent. Whereas the number of entries is
> > quadratic. And of course the whole experiment is ball-parking in the
> > first place. We're looking for order-of-magnitude approximations, I'd
> > think.
> 
> I agree that the number of entries is what's important; in fact,
> that's why I think the median file size is more important than the
> mean file size:

That is almost always the case (except in unskewed distributions where
the mean is equal to the median).

Another option instead of an opaque configuration like 'renamelimit'
--which is almost entirely arbitrary for most users--would be to have
'renamelevel'. A renamelevel of 5 would be the median, so that's already
more meaningul than any value of renamelimit.

A renamelevel of 9 would be the equivalent of the 9th decile, so that
would catch 90% of renames.

If the distribution follows a Pareto distribution (which is often the
case), the formula to calculate the different deciles is trivial, but it
would also be possible to hard-code all the different levels.

-- 
Felipe Contreras
