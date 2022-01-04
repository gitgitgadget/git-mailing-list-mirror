Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F297C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 15:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiADPWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 10:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiADPWA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 10:22:00 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B91BC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 07:22:00 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id o17so34426075qtk.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 07:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dpMmWfB55eIC6T3iCyfBOrtpSGilYveOGrkQEGEZtZs=;
        b=5CxpZuBwPKAohPJx6PBzB5hqqrAcIbGG8QlNQudljuks5pD3L/thjpah7+dTF8q+YH
         2GDRsNp8zpxtULkkgBjn1PCUR3Fqfbe8KW9WWjxOdC5yM4vo/5ZSC8jIfLz8nD9dlQVY
         t9if7LJhyvs3UcmGodBOXHJ1dDCN/i43yRPXrF8lwdXZfFSC5eO9o9xKzQ4dBbVquyFk
         ez+zraV/6Gu1082I1aE4I4FrZI3fljiSqH8kp2yYgmwRQ9bm9hOXEOMVAcR4uEoLUsVi
         b3DUJHMTl9q2S8UWGM2ZDGtc1Or46749xjFB8xD7VFduQ/rmgXfApGBavXIgAibmE3Lu
         DhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dpMmWfB55eIC6T3iCyfBOrtpSGilYveOGrkQEGEZtZs=;
        b=ruUb9qd4PLda0nmk6LpIxtO5d2pzgqFBTnSV3u+iS0rT9zMFMpZ3a+zHeSK2gyLlPz
         NaPM610Y8Io9hjGhtYlIU9I0bBs7BdIfZVo71gTgZlMW8esrxZmh9mdkJmd59M36kxIh
         nwfAeHnONmJqJDK6OD0whPJBulEfKPjPvqqyLUhFBcR5oxsW8ch4rms6Hq00RpYUXpJf
         Dn5pcf7zAGfZ9gVS0D7EG2kYQgqKvn6JmxgSlEEXOLKQCqFkrEDrYxjM14kSWptkoPV8
         q+eu0xt7f8+UxI677oSq8YVkZtn0piOMEPmoduiCOi4GC6JBQjemhxJbc4c6VynychPO
         iAjQ==
X-Gm-Message-State: AOAM532pl6Dt4eZGFkl/tF46Q8eh4cEWs6zj/HjE9fIUQqJbu9foIQ1p
        qByAlUF8DOPOCQWoMVayyMigrg==
X-Google-Smtp-Source: ABdhPJytWNqfUsK+EK4B9JfO/JnRvywz0SkPZgmZAjrJgp2axCQnkOM0Qcw17wplzv3TUPmqgvGs0w==
X-Received: by 2002:ac8:7f15:: with SMTP id f21mr44953768qtk.392.1641309719295;
        Tue, 04 Jan 2022 07:21:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6sm2666852qtx.22.2022.01.04.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:21:58 -0800 (PST)
Date:   Tue, 4 Jan 2022 10:21:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 8/8] midx: read `RIDX` chunk when present
Message-ID: <YdRmFRHNeOGcSwJ0@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
 <993bfa8dd8480e74d64f657539b0c518ad155e5c.1639446906.git.me@ttaylorr.com>
 <92d50859-ecfa-e7c5-d68b-d90a11579cd0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92d50859-ecfa-e7c5-d68b-d90a11579cd0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 01:42:24PM -0500, Derrick Stolee wrote:
> > diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> > index 100ac90d15..8c92acb0ce 100755
> > --- a/t/t5326-multi-pack-bitmaps.sh
> > +++ b/t/t5326-multi-pack-bitmaps.sh
> > @@ -9,6 +9,11 @@ test_description='exercise basic multi-pack bitmap functionality'
> >  GIT_TEST_MULTI_PACK_INDEX=0
> >  GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
> >
> > +GIT_TEST_MIDX_WRITE_REV=0
> > +GIT_TEST_MIDX_READ_RIDX=1
> > +export GIT_TEST_MIDX_WRITE_REV
> > +export GIT_TEST_MIDX_READ_RIDX
>
> Technically, we could unset these variables, right? ("...=")

We absolutely could, and I can't think of any reason not to (other than
these tests would be fragile with respect to the default values of these
special "GIT_TEST_" environment variables, but these are unlikely to
change ever).

> > diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
> ...
> > +# We'll be writing our own midx and bitmaps, so avoid getting confused by the
> > +# automatic ones.
> > +GIT_TEST_MULTI_PACK_INDEX=0
> > +GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
> > +
> > +# Unlike t5326, this test exercise multi-pack bitmap functionality where the
> > +# object order is stored in a separate .rev file.
> > +GIT_TEST_MIDX_WRITE_REV=1
> > +GIT_TEST_MIDX_READ_RIDX=0
> > +export GIT_TEST_MIDX_WRITE_REV
> > +export GIT_TEST_MIDX_READ_RIDX
> > +
> > +midx_bitmap_core rev
> > +midx_bitmap_partial_tests rev
> > +
> > +test_done
>
> Nice that now we get the payoff of the test refactor. This new script exists
> only to verify that we can still read the old .rev files, which is important
> for compatibility.

Exactly. Though I certainly wavered on testing the legacy .rev behavior
as much as I did. But that had much more to do with how awkward the
tests came out. That behavior is important enough IMHO that it's worth
the awkwardness.

Thanks,
Taylor
