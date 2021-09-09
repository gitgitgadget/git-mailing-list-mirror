Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66CFC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA7461157
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349324AbhIIBEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 21:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349122AbhIIBEH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 21:04:07 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53108C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 18:02:59 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f6so225402iox.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 18:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=75TikK922mqSrZhHwimt5ohUiDKucJe2HrGRMYEf498=;
        b=KDJuniO26Po6OQNtltlcgCUUGSG6d5WwQwq7LeSNHEmLhffPOu8iSC2M5illuWSLSZ
         tB/kpiGkUvkegKzaHcWzAKJXWLSI6bBn0rONJnVQu7etnMg2pZqoIkclRLYvZJAjPClJ
         NJx226q5TojNHxZ4raFjyRFHPvSRJct4ggfhafBm6KKhPimuj4iC44zJP1Ow6j3Dp4rW
         kT7xk9WFGeLKw+EDJC+NBQBRTkzlQHOhI+KXZvb7zkqrrDTYLyPq6imjJH2r0Ui781rY
         L+k9gOvvsuieChQmmq62jQDuj1PKTwK0yWmN1EeioTGxATEXiuiN8Y3/1gUM5yQUbgC0
         4JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=75TikK922mqSrZhHwimt5ohUiDKucJe2HrGRMYEf498=;
        b=3kzjnGQzhWblTmhBebQzZ4LnYdp1k0wPXu9rNiRPhW+h5Nv8scWhZ+Zjr5v6R0Ibb7
         0RdAi5RdC99+49RvzNLkZuU+n2piCDAkDzX6FnQxS/sSj/JBn7SfTb7MIuBdNLxotQGj
         kB6uf4vrki8JNv69nMkBKrTjtJJwfL4sg3Y4ROxy2fm9RHjiGZo+keDqG2cru/DG53OS
         NE+FS1jBkymn+SR6JQaKDjmeY7QPZeGShMdeYFIbRQEJSeIhCBGN7VcvLkHfoHo702QR
         P3vD7WmeoSyTqgAErvgB+vO/5WUUScJ7MdZW4yNHrab58M6Cs4YbwpgwxXRzEzZFgaH1
         8CpA==
X-Gm-Message-State: AOAM533qm4AMd5GRd/vj9IGm2CMw/xYN3UXslP5CiwVDI6uVzPo4mjoF
        Qp5Snq09VMsK2LprGkxThgACHRVLbimu4WrN
X-Google-Smtp-Source: ABdhPJxxY+jhDDGdpaXzgjsdtbY45v8wYeInc3VguYm0xVx+K+yOUvLqz4N8Nq5FetDK3+LDpg5clw==
X-Received: by 2002:a6b:c8c7:: with SMTP id y190mr336894iof.210.1631149378759;
        Wed, 08 Sep 2021 18:02:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t25sm139804ioh.51.2021.09.08.18.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 18:02:58 -0700 (PDT)
Date:   Wed, 8 Sep 2021 21:02:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
Message-ID: <YTldQR1uJqslIEZU@nand.local>
References: <xmqqsfyf5b74.fsf@gitster.g>
 <YTjjqV/4/oceM3lM@nand.local>
 <xmqq8s063m7m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8s063m7m.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 12:23:57PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, Sep 08, 2021 at 08:38:55AM -0700, Junio C Hamano wrote:
> >> * tb/pack-finalize-ordering (2021-09-07) 2 commits
> >>  - builtin/repack.c: move `.idx` files into place last
> >>  - pack-write.c: rename `.idx` file into place last
> >>
> >>  The order in which various files that make up a single (conceptual)
> >>  packfile has been reevaluated and straightened up.  This matters in
> >>  correctness, as an incomplete set of files must not be shown to a
> >>  running Git.
> >>
> >>  Will merge to 'next'?
> >
> > Ævar has a series [1] that complements this one nicely, so I would be
> > happy to see them both queued.
> >
> > I had some suggestions inline, but I don't feel strongly about whether
> > or not they are implemented.
>
> I hate to see multiple folks "competing" in the overlapping area,
> each getting reviews and responding or not responding at their own
> pace.  That would force me to keep track of which one is which and
> what their doneness are independently.
>
> Do you mind if I nominate you the team leader to come up with a
> single series that is polished to be mergeable to 'next'?

Not at all; sorry that I missed your email before submitting a v2 of the
earlier series.

Ævar seems to have combined them while I was eating dinner, but I'll
coordinate with him and send out a unified result for you to queue up.

Thanks,
Taylor
