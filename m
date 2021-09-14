Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7155C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD9260F5B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbhINFMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 01:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhINFMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 01:12:55 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A43C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 22:11:38 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i13so12682824ilm.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 22:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VviNX/Q0wOCe5f6iZmR3hO/OUGGeEYX3uvUWEn4Crg8=;
        b=TLWHkIC2xF0Hz+ZzMWJhoIVcFpxxB9cQilCVzqdYyjPGSRvdjLHHdOTTtyjQ5tWYg5
         WDk0zSL+ms+9d9eVC6h/W6K1xnqB6ieyeQr4BvMZ40GBjY04erbVqDpDo4EDupRwTa+B
         96o73DIFMQCh8mw/U2mT4E7h2/Bxx+UG7Ot9wbUaQi2iVRtdyqeP5Zb+oHX0xD3mcSkw
         JE8ldrOh8m3bJdimqlI5iFGOxS8m9wGCRb8j5eZge7pMF9BvbJbIdopdqGcZYaatd0nc
         ioRGQVBDKagMYybiFTR+07U7H+3rH5RfdU9QvSdar0TdONWA7F4mjPikZO4Cg6DSGI43
         w1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VviNX/Q0wOCe5f6iZmR3hO/OUGGeEYX3uvUWEn4Crg8=;
        b=Ym0aIkkGQ8Go21FpTwforVg8txxhQfZljFwx4l8RW+6gb47DMJcYNECdl1+itvF9ja
         YxRxtGoA6Kid4OYR9cEP7ZpB+NUZVTyUGK9oOqbxw5qda9+5J8J4+ajqyyqehkNe4/Zj
         X3700EO1tms8ibCtNa3UGKIYb8tgJcF8hOu+MnZJv5ogLJS4pGKaEr3FvcrC3mSCVu6b
         /hu+g1LFGTfjNA6ddcXKIxygy0y9SN4ALYJ32ez4y8i2AejjPSx4WR4TdyEWJ4mysvc9
         sHSJipzQ50QogcDrj8085pa4q6Rufr/H5n86QLUwt5d2vmXtVeDpfL87qHHHVyWEhPLd
         iAQw==
X-Gm-Message-State: AOAM533Nvpn5XNNaAXCGVaJ/fxC2bpUTF0sbSzQjQfTWKBXi/h+m42kB
        7w1RX/tAC8ZmObC/oip3ZeHZ6FnprbUcvvNV
X-Google-Smtp-Source: ABdhPJxNkMOIuQ856+RlOL+EKj7+vhLLiAPHOICFaCgncTISQ/E0BdQSpLrQnnRX3k4hFKqNRb0QBQ==
X-Received: by 2002:a92:c56d:: with SMTP id b13mr10931179ilj.317.1631596296028;
        Mon, 13 Sep 2021 22:11:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s18sm6154785iov.53.2021.09.13.22.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 22:11:35 -0700 (PDT)
Date:   Tue, 14 Sep 2021 01:11:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Message-ID: <YUAvBso+UsBTYizb@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <xmqqa6khi9ph.fsf@gitster.g>
 <YT/3BuDa7KfUN/38@nand.local>
 <xmqqpmtbc3o3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmtbc3o3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 07:05:32PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Alas, there they are. They are basically no different than having the
> > name-hash for single pack bitmaps, it's just now we don't throw them
> > away when generating a MIDX bitmap from a state where the repository
> > already has a single-pack bitmap.
>
> I actually wasn't expecting any CPU/time difference.

I think it is possible to see the CPU usage go down without affecting the
resulting pack size. See below for a more detailed analysis.

> I hope that we are talking about the same name-hash, which is used
> to sort the blobs so that when pack-objects try to find a good delta
> base, the blobs from the same path will sit close to each other and
> hopefully fit in the pack window.

Yes, of course.

> The effect I was hoping to see by not discarding the information was
> that we find better delta base hence smaller deltas in the resulting
> packfiles.

I think it is possible to observe either a decrease in CPU or a decrease
in the resulting pack size.

In my experience having the name-hash filled in results in finding good
delta pairs much more quickly than without, but that in many
repositories the resulting pack size is basically the same. In other
words, the resulting pack is pretty similar whether you use the
name-hash or not, it just affects how quickly you get there.

Some experiments to back that up: I instrumented the existing p5326 by
replacing anything like "pack-objects ... --stdout >/dev/null" with
"pack-objects ... --stdout >pack.tmp" and then added test_size's to
measure the size of each pack.

On the tip of this branch, the results are:

		Test                              origin/tb/multi-pack-bitmaps   HEAD
		----------------------------------------------------------------------------
		5326.5: simulated clone size                 3.3G                 3.3G +0.0%
		5326.7: simulated fetch size                10.5M                10.5M -0.2%
		5326.21: clone (partial bitmap)              3.3G                 3.3G +0.0%

Looking at c171d3e677 (pack-bitmap: implement optional name_hash cache,
2013-10-22), I modified[1] that script to replace timing pack-objects with
counting the number of bytes it wrote.

Doing that shows that the name-hash doesn't make a substantial difference in
the resulting pack size (numbers on a recent-ish copy of the kernel):

		Test                      c171d3e677d777c50231d8dea32ae691936da819^   c171d3e677d777c50231d8dea32ae691936da819
		--------------------------------------------------------------------------------------------------------------
		9999.3: simulated clone              3.2G                                        3.2G +0.0%
		9999.4: simulated fetch                32                                          32 +0.0%
		9999.6: partial bitmap               3.1G                                        3.1G +0.0%

(As a mostly-unrelated aside, I was curious why the pack size jumped from 3.2GB
to 3.3GB, but I can reproduce that jump even in p5310--the single pack bitmap
test--on the tip of my branch. So it does appear to be a regression which I'll
look into, but it's unrelated to this branch or MIDX bitmaps).

Thanks,
Taylor

[1]: https://gist.github.com/ttaylorr/6cfa3eb9fd012f81b833873d50f96f71
