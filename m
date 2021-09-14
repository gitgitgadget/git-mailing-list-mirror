Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BF8C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDE4610A2
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbhINFcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 01:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbhINFcU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 01:32:20 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D41C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 22:31:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g9so15390502ioq.11
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 22:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B0NYC+iCo7/7+M7U2CWbRRe/W+21g3BjF2Qg0HAFLfY=;
        b=Ljn0R3eYcdnNMDsCSY5/BjGPVvzHdnizuMjxsQEqCfHY/QkgHZJQ6Qat+8P646k2N7
         CkdQYkpKZKymbGHV62D4yKgJeKzoPa03Y4quYPeQbSv+12zevOsHgRvJtARsXLVrg6aU
         MRmQLDMefL4S2tNPyJH7TfwZjY0xMxNLp7xOLPxbYmvj1yVN62EDBgUyhWVQJQAm5unY
         D77E+R/afWqHj9gqEUx+ieK7gP9oA5eldl3CRoPQyumzKBwb6tENygwQdPX2ecSkFYt0
         GWscZJxwElAMB64GwpqhpWLtBR9wNrgb/3UcoWE5upByYM4HCbvIstGjiU3+BnciLYA6
         bvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0NYC+iCo7/7+M7U2CWbRRe/W+21g3BjF2Qg0HAFLfY=;
        b=nzw9qg5n1PcF9KqY6EypIwhnrevqPT/3a3YA9AHJ0ncj84FdwAW9wMhvpYF8sP8pDs
         HvP6zMZb4rSuxsALGGRrcEwv4Xy3rABTf/z8hEtfZ2+pMEjiioQ3wt+CBtZ2A8v/3nUj
         5POvpHagyDO8FA3RBBxrIuA7RCDyeGmjwQ0p966L6c3Qut2IG5e/IV/oCt6keDhQKM2n
         DgNU45C4tiMEA60N0+Itmv8QhfykwZp8Quafe10fWuV/vC9mQSmen4SsVQveprPbkXLi
         quer2xY2TcGcKvrqPxflu4vuc/NUYqBcGNuY1jNGpkMBDj5ofqBu70eYt119Ut/LGqIK
         8eqw==
X-Gm-Message-State: AOAM530jG8vM5wGI5oTaNfkL589mAG1KpIq14YuUUZXAQjKY0/Dxk2Mp
        62izCUyigaaAdcRID2uenK7cJFp4QiwwsmLE
X-Google-Smtp-Source: ABdhPJy9nUar5h3MdeDQKY9byYIX5BR17IStPC7B7N0pW2wI4xbZQ4S/bPSy9dtSudj/t2bCS2eYgQ==
X-Received: by 2002:a6b:b44f:: with SMTP id d76mr11989307iof.189.1631597462725;
        Mon, 13 Sep 2021 22:31:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c1sm5207018iot.44.2021.09.13.22.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 22:31:02 -0700 (PDT)
Date:   Tue, 14 Sep 2021 01:31:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Message-ID: <YUAzlYYeUG0Xa8Sj@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <xmqqa6khi9ph.fsf@gitster.g>
 <YT/3BuDa7KfUN/38@nand.local>
 <xmqqpmtbc3o3.fsf@gitster.g>
 <YUAvBso+UsBTYizb@nand.local>
 <YUAyw+qVkKBEZtLx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUAyw+qVkKBEZtLx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 01:27:31AM -0400, Jeff King wrote:
> On Tue, Sep 14, 2021 at 01:11:34AM -0400, Taylor Blau wrote:
>
> > Some experiments to back that up: I instrumented the existing p5326 by
> > replacing anything like "pack-objects ... --stdout >/dev/null" with
> > "pack-objects ... --stdout >pack.tmp" and then added test_size's to
> > measure the size of each pack.
> >
> > On the tip of this branch, the results are:
> >
> > 		Test                              origin/tb/multi-pack-bitmaps   HEAD
> > 		----------------------------------------------------------------------------
> > 		5326.5: simulated clone size                 3.3G                 3.3G +0.0%
> > 		5326.7: simulated fetch size                10.5M                10.5M -0.2%
> > 		5326.21: clone (partial bitmap)              3.3G                 3.3G +0.0%
>
> I wouldn't expect a change in the clone size. We're already including
> all the objects from the single pack, so we won't even look for new
> deltas.
>
> In my run, I did see a small improvement in the fetch size (though my
> size both before and after was larger than yours). This is going to
> depend on the exact set of deltas we have (which in turn depends on how
> your repo happens to have been packed before the script even starts) and
> which ones the client actually wants (which may depend on the exact tip
> of your repo).

Yes, I agree with all of that. I am still interested in trying to figure
out why the resulting clone size seems to go up (independent of the
changes here). I'm bisecting it, but it's slow, since every step
requires you to repack the kernel.

> Presumably you also saw a decrease in the user CPU time of 5326.6 here.
> If not, you may have forgotten the extra patch to create the pack
> bitmap.

I did, but didn't bother to include the timings in the quoted part,
since I already shared them in [1].

I have a handful of new patches for an updated version of this series
which explains the extra patch you are talking about, too.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YT%2F3BuDa7KfUN%2F38@nand.local/
