Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254C3C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5B861244
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhGUQfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGUQfG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 12:35:06 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE54BC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:15:42 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id p3so2924412ilg.8
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7eQuS8nwtUe147zRy33bza66BCB/oV/Xr3yGikBoZVw=;
        b=NDLmBGPnoYa7JXOB9ae6T8QszTmG6SOLXl8Jgqeu+v9vyehPaA5tT2k6o3fVLQdk7G
         xZrwosq/Y7ilj8wU9VqecXt5A3J2k63RuN3+1KgqoKEO9dftAHl5R9h0d2QJh6kvSAnK
         EYV/g/2+b3FOTHd5g7I/yazq23UscNFEH/sVZQEd9WScPbSuSvkD3wgwvR9HmopbJ0UQ
         2pa8Cj6E4Q31FD2hOmA/Q5jcyqCSJn+6WMb0YIVdBPcqbNT+W66/z7biH5+MjSaOC23F
         FqraXiaYF1HcyYXF0Bl3I7ecSg3vhB+JS+TPxpxpuDMbAhIUC/AjOnZ04u2XILlz/j8U
         BzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7eQuS8nwtUe147zRy33bza66BCB/oV/Xr3yGikBoZVw=;
        b=B++g4DmRzI1vaETyvOjMSl+VTARK5bDf794AB6JzFj0+PJa/9Kb57CwP+UkAwXGz0U
         hxNE+oz7W1HI7KKv775rDaueeG9RAT0xCyW/hxwX0yobYjVY56GXgmpnGbNIqLED0z3o
         Q85SIocJrQPlV/WmisTr/uYUQDNvwZbHotuahW6yJ5JlCtLVJi6NMKg9iWFDebIjUGpp
         hG41GdVQmc0cu6VsPlYT+4+qlcoWv9uyPJLjvuw+YGxnS1IO54vrkY1TquMq8npiQmIX
         Oob9txf9H09ssk82qDpp9hl04oLnhvykDoC5gME339hyatMcFg4k8jQ9BiNyWrTrHqs+
         kLHQ==
X-Gm-Message-State: AOAM531Pm30HTg+IBFY2OwrfIbNccV9LEIgqkim3pIy65EiqAmazAdpB
        6HgIFTApeCvCRUFz8l/KQJN++w==
X-Google-Smtp-Source: ABdhPJyYz2hxL3fGlrkHYVpZ8C2EQchO1Oq2bIUoba7XF6yd28IfAOWdyK2xMhdJw5DiNapmdKySMQ==
X-Received: by 2002:a92:c266:: with SMTP id h6mr1976132ild.273.1626887742453;
        Wed, 21 Jul 2021 10:15:42 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:2c46:d8ae:a4c3:9466])
        by smtp.gmail.com with ESMTPSA id r1sm12873156ilt.37.2021.07.21.10.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 10:15:41 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:15:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 01/24] pack-bitmap.c: harden 'test_bitmap_walk()' to
 check type bitmaps
Message-ID: <YPhWPVpiGufLVysG@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a18baeb0b42994ebcb216df5fe69459ba9a33795.1624314293.git.me@ttaylorr.com>
 <YPfsqJrCTFQXhltJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPfsqJrCTFQXhltJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 05:45:12AM -0400, Jeff King wrote:
> > +{
> > +	enum object_type bitmap_type = OBJ_NONE;
> > [...]
> > +
> > +	if (!bitmap_type)
> > +		die("object %s not found in type bitmaps",
> > +		    oid_to_hex(&obj->oid));
>
> I think the suggestion to do:
>
>   if (bitmap_type == OBJ_NONE)
>
> is reasonable here, as it assumes less about the enum. I do think
> OBJ_BAD and OBJ_NONE were chosen with these kind of numeric comparisons
> in mind, but there is no reason to rely on them in places we don't need
> to.

I had to double check your suggestion, because my first question was
"what if bitmap_type is OBJ_BAD?" We can call type_name() on OBJ_BAD, but
it will return NULL, and we use the return value in a format string
unconditionally.

So that would be a problem, but it's impossible for this to ever be
OBJ_BAD, because we only set it based on the type bitmaps; so it's
either a commit/tree/blob/tag, or none (but not bad).

I took your suggestion, thanks.

> -Peff

Thanks,
Taylor
