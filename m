Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96572C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 22:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4716104F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 22:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhHLWiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 18:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbhHLWis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 18:38:48 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD12C0617AD
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 15:38:22 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s16so515973ilo.9
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lNM1KUaubm9OZLjR0UqX5ruq8sW+J+xXjOJtNxf+Fko=;
        b=LKu+P066aXCNuyy4CYhedp3xKVEMXnmctxZVDI6fLzZfGWKElNvC3D9aP7S37J4DVu
         96kfSYYhEYxSJ+fNQvbZ3MiMxd2NzPvblOKCyTivX2aJz0bDoIHh5bhR1aT9rxeRopFv
         8+M1LSNyzeNRnIqJHKRwK9JvkkVjAWYxAxVuTQe20OnZhZludajuF/CD3L35XOxzJEhy
         kwLLFdOBWH5jblCc1RmwqjFag2BhJ0GxhCKKkUmBrtUG467wpi41NaOBcmnHU458U0qV
         ScldO6Nck2dC0XtwP3AdPxPCtwMgXBQpeCEUtek3xoWRoisrlUxLvi7+8Zfm88jNDMXi
         tVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lNM1KUaubm9OZLjR0UqX5ruq8sW+J+xXjOJtNxf+Fko=;
        b=SyI01cgIZcvivCjVbGORaIOP+vMfcj2glyIkJeufWPjB8CotJWW+Y1vCOnsRhT/Ybe
         EaD9WZAI4t+xc2opNfzWUhUYxp1ipm+PNbj9bky+JpbrHZr1OGpd3o6cKb5WR1TCrj+W
         HWCd4GK3RxKU1JmDoifLvbv/ooZQYQnxpF4M470JXANS5uBt86Qus7C0tr8Jd9uLCdWM
         cnGvvR24vsD6BPzs3hydO79q6/DXhDh1GNijwWYLhgW0KeCoAxPDVlKpLcpQx9qURkxP
         rr8p5JEteia4YMTrtvt+DCf6xFuwcnSBEa46P5FAH+U2VatL2VCKcSBKwvO27Kj30vTM
         NjRA==
X-Gm-Message-State: AOAM532zHyz28TEGEtrvpv2UzTUMFlHvs/DAZ2oS+Svdj8KQaMaVRuwh
        uO1mbTrlRhNGGho8xOFOccTNcQ==
X-Google-Smtp-Source: ABdhPJzNHzQCanRsPUlGRN11l0KJHQYVD1flxYE3XlrnfiptQmWxrVpB12pQ3q5uIKQEiUcEkpWzjg==
X-Received: by 2002:a92:d112:: with SMTP id a18mr602335ilb.34.1628807902176;
        Thu, 12 Aug 2021 15:38:22 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:1990:f69a:6a7c:f79d])
        by smtp.gmail.com with ESMTPSA id x1sm573877ilg.33.2021.08.12.15.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 15:38:21 -0700 (PDT)
Date:   Thu, 12 Aug 2021 18:38:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 18/25] t5326: test multi-pack bitmap behavior
Message-ID: <YRWi3KHM2iunQ02f@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <3258ccfc1cc99038e43a37bd2d53c9d30a4f22ae.1627420428.git.me@ttaylorr.com>
 <YRWMYg2rvv7HjGE+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRWMYg2rvv7HjGE+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 05:02:26PM -0400, Jeff King wrote:
> On Tue, Jul 27, 2021 at 05:20:10PM -0400, Taylor Blau wrote:
>
> > diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> > new file mode 100755
> > index 0000000000..c1b7d633e2
> > --- /dev/null
> > +++ b/t/t5326-multi-pack-bitmaps.sh
> > @@ -0,0 +1,277 @@
> > +#!/bin/sh
> > +
> > +test_description='exercise basic multi-pack bitmap functionality'
> > +. ./test-lib.sh
> > +. "${TEST_DIRECTORY}/lib-bitmap.sh"
> > +
> > +# We'll be writing our own midx and bitmaps, so avoid getting confused by the
> > +# automatic ones.
> > +GIT_TEST_MULTI_PACK_INDEX=0
> > +GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
>
> This latter variable doesn't do anything at this point in the series.
> Probably not a big deal (it is simply a noop until then), but if it's
> not hard, it may make sense to bump the "respect ... WRITE_BITMAP" patch
> earlier in the series.

If my memory serves me correctly, I think the very first version of this
patch didn't have a GIT_TEST_MULTI_PACK_INDEX{,_WRITE_BITMAP}=0 at the
top, and so individual invocations needed to set it in their own
environment. Presumably at some point I added this, but forgot to clean
up the redundant ones. I removed the ones you mentioned in your
response, and a few others.

> > +test_expect_success 'create single-pack midx with bitmaps' '
> > +	git repack -ad &&
> > +	git multi-pack-index write --bitmap &&
> > +	test_path_is_file $midx &&
> > +	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
> > +'
> > +
> > +basic_bitmap_tests
>
> We can't use a midx bitmap without a .rev file. The basic_bitmap_tests
> function covers that, but I wonder if we should also check:
>
>   test_path_is_file $midx-$(midx_checksum $objdir).rev
>
> in that first test.

Good idea. These tests probably preceded the invention of .rev files, so
a lot of them needed updating. I made sure to add them where
appropriate.

> > +test_expect_success 'create new additional packs' '
> > +	for i in $(test_seq 1 16)
> > +	do
> > +		test_commit "$i" &&
> > +		git repack -d
> > +	done &&
>
> This loop needs an "|| return 1" inside to catch &&-chain problems (not
> that we expect "repack -d" to fail, but just on principle).

Nice catch, thanks.

> I love how the earlier refactoring made it easy to test the single- and
> multi-pack cases thoroughly.

Likewise :-).

> > +test_expect_success 'setup midx with base from later pack' '
> > +	# Write a and b so that "a" is a delta on top of base "b", since Git
> > +	# prefers to delete contents out of a base rather than add to a shorter
> > +	# object.
> > +	test_seq 1 128 >a &&
> > +	test_seq 1 130 >b &&
> > +
> > +	git add a b &&
> > +	git commit -m "initial commit" &&
> > +
> > +	a=$(git rev-parse HEAD:a) &&
> > +	b=$(git rev-parse HEAD:b) &&
> > +
> > +	# In the first pack, "a" is stored as a delta to "b".
> > +	p1=$(git pack-objects .git/objects/pack/pack <<-EOF
> > +	$a
> > +	$b
> > +	EOF
> > +	) &&
>
> This is brittle with respect to Git's delta heuristics, of course, but I
> don't think there's a better way to do it with pack-objects. And this is
> not the first test to make similar assumptions. I think you can
> construct a known set of deltas using lib-pack.sh. It may get a bit
> complicated. As an alternative, maybe it makes sense to confirm that the
> deltas are set up as expected? You can do it with cat-file
> --batch-check.

Yeah, I definitely agree that this test is brittle. But it would fail if
our assumptions about what gets delta'd with what changes, because we do
check that 'a' is a delta on top of 'b' (see the call to have_delta
towards the end of this test). That have_delta helper does use
`--batch-check=%(deltabase)`, which is (I think) the cat-file invocation
you're mentioning.

Thanks,
Taylor
