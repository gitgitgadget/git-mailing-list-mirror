Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B6C43463
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D76B20838
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="YROCZWIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIQUhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIQUhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 16:37:53 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AECBC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 13:37:53 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g3so3040109qtq.10
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QiQ0kO+8lF/Z138k7zUyPtaMOwszzsTtEfF+Vg9q0h4=;
        b=YROCZWIAQseUE6Pl4bXAkOl5BXyaq743DVnwo3GY/4Z7fRZLoQv1lKcEz/URHdJjB9
         tnWU4F29xgaGWiuCuCLimFbC94YyficR49QoVZFc0Fcv1qXRGBy0ZTdy8NS31i+syOeu
         sh91rMAIkqI+qppdXU+BgDsnBRIkK2LbBRXRRWRd1cfP3cS9Kqre9nmUiRf0lxElVBiU
         EbuW0fcGzF9j03ZUU/54oFVJZQRb8b+iUeEKELtVDnbGUZhF5vYCG/rCesI9UIl7XIvr
         WnVAdiHsO0xhzbZVlHga8BUFTyv35oj0DnsfqSh39IxW0hluzFdWF6ixMwavteUcg65a
         Uxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QiQ0kO+8lF/Z138k7zUyPtaMOwszzsTtEfF+Vg9q0h4=;
        b=TZ6S7ap3dMjsTZWWlZWZ+tcb+2Qli9g8+/eqQk4NBmu4tndTTB9qnEzqjjzm1CsA9v
         U3zehCtNaoWdArSgxCXbUKJU0FrQvc7CHcUytbqFrgcGj8+IaAUI7F4ceK/WoyAIsjow
         ypQGvKMwb6O9VI9dJXRCT+T1Tf9k6KuOhzgWjFKk+Pz0Ew88LceZiwR5PEuB1TVWzyNr
         O0TJIYiJ3u4BJ2HlI054G/wXFAF0GzFXhBcVwVPLhd04SoIKvuMAHQ16VxraZf8y13Zv
         uts/P1x+dmlfyNYryTnchGiMrNQ6QgwBZNfnEeLvf1+J2dwtnXdYvwDr6al1ZyZxiZma
         Vleg==
X-Gm-Message-State: AOAM532ETcIg+FnVfIuZ5VBq8nMCUwh22n5oJCW0/fJ5uJ228WyUAJ+o
        THVlPx/tGLnv1dKmwJ+CvWWJCQ==
X-Google-Smtp-Source: ABdhPJwHbSwIxtvxBYMEmQf7fuQnPjJ7tGr56g7apVRDeWG8zJzSIvcuo3Xh7jFIOxeDT3zAnhE4dw==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr29015990qti.81.1600375072316;
        Thu, 17 Sep 2020 13:37:52 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id v131sm667025qkb.15.2020.09.17.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 13:37:51 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:37:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, tytso@mit.edu,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
Message-ID: <20200917203749.GA1589021@nand.local>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-2-avarab@gmail.com>
 <20200917140912.GA27653@lst.de>
 <20200917145523.GB3076467@coredump.intra.peff.net>
 <20200917145653.GA30972@lst.de>
 <xmqqzh5os9cg.fsf@gitster.c.googlers.com>
 <20200917171212.GA3732163@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917171212.GA3732163@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 01:12:12PM -0400, Jeff King wrote:
> On Thu, Sep 17, 2020 at 08:37:19AM -0700, Junio C Hamano wrote:
> > Am I reading the above correctly?
>
> That's my understanding. It gets trickier with refs (which I think we
> also ought to consider fsyncing), as we may create arbitrarily deep
> hierarchies (so we'd have to keep track of which parts got created, or
> just conservatively fsync up the whole hierarchy).

Yeah, it definitely gets trickier, but hopefully not by much. I
appreciate Christoph's explanation, and certainly buy into it. I can't
think of any reason why we wouldn't want to apply the same reasoning to
storing refs, too.

It shouldn't be a hold-up for this series, though.

> It gets a lot easier if we move to reftables that have a more
> predictable file/disk structure.

In the sense that we don't have to worry about arbitrary-depth loose
references, yes, but I think we'll still have to deal with both cases.

> -Peff

Thanks,
Taylor
