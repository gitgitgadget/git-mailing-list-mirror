Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B15C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 21:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjHIVMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjHIVMc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 17:12:32 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B43138
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 14:12:32 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-584034c706dso4143217b3.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691615551; x=1692220351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9LPeYErJHZybypSN3gPbkBVz4bnV6lNBLHdZDfJgZo=;
        b=5HPV2rXefLJjt0jcE55msdi6FQZeQpVYU6Bs3zFzX2g+NHSORyhVVC8xfq0pG2rjqI
         5rKSSIcV3Uh+2fjgmldH2mSMW9H+hZygpOmYuzo47fzD7bAyAFrRjZB0W17d0aoriL8Z
         WyHUDFl24GnT4DC1JND3j93Y7FuQQPryn4vDBWVK92jc35qGyjWqNxUrbHB4wlnRt2ih
         Y/DMASaRuMhopxX9gQFKo9MtgL0sfjv+mRJfGO+vIYO6mC1RD28fNA1y6L7Aq1iIqOuL
         Ac//RLpkmLOfp0GW/MwyF7uTekG8Hhg0YgWNWnbZWwtebCqCOO54TXKvIWrjxGv5hmO7
         dHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615551; x=1692220351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9LPeYErJHZybypSN3gPbkBVz4bnV6lNBLHdZDfJgZo=;
        b=F406tqR69h19Z3hKSZFr5xLMSsos5XcP465nxl8U2JD/sebM8U5KR38ZHXsK8fQv3i
         V6japdBWl6GVDa0nCK+OLyO50RxxTYnE498uJ4WCDtQA7dT4UzNdtGl1nlZ4gkTFwdod
         CzreSpm1LOW2NkFTonBH2m95Mx+NN7HNYwPicHQ/gtZw2OQtjn6eg6PDzCbUIw/QH+wm
         Z1sgr/v5Zs312XB4gLESbBoVoWB8v3McxEPxk1z6Lwyod3aPhJeyumumo2IqF1UROTix
         1zRCcZ7i5O3LS2IPWRLiNgd1XlH6CA9vaLXTbKj2o4BpBs7TjkevXjPbWxMol2enDcfd
         nCzQ==
X-Gm-Message-State: AOJu0YwcNFAYx4K158xtJh2uADdnB5xZ1t7NRaMnxCKer5Fl80F7UKPo
        YLva6w8dSLfITcAT9udYAKSm+A==
X-Google-Smtp-Source: AGHT+IG3vY9ATqGw8tjoGlKr78Nx19nAeI9rBBU23fIblunogstJVbGVZZhK0zCufUq8qn6QZBmjBg==
X-Received: by 2002:a25:497:0:b0:d07:fd57:ab1f with SMTP id 145-20020a250497000000b00d07fd57ab1fmr590366ybe.38.1691615551118;
        Wed, 09 Aug 2023 14:12:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q20-20020a25f414000000b00d5116b6867dsm79663ybd.37.2023.08.09.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:12:30 -0700 (PDT)
Date:   Wed, 9 Aug 2023 17:12:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 5/8] repack: add `--filter=<filter-spec>` option
Message-ID: <ZNQBOQwaVsRL4suR@nand.local>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230724085909.3831831-6-christian.couder@gmail.com>
 <ZMBU+SALVQthOgC7@nand.local>
 <CAP8UFD3BiZQ4-M91sc6p2wBFrzPQQfja_xKpT26BcBS7OVA4MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3BiZQ4-M91sc6p2wBFrzPQQfja_xKpT26BcBS7OVA4MA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 10:34:25AM +0200, Christian Couder wrote:
> > > +     git -C bare.git -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
> > > +     test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
> > > +     commit_pack=$(test-tool -C bare.git find-pack HEAD) &&
> > > +     test -n "$commit_pack" &&
> >
> > I wonder if the test-tool itself should exit with a non-zero code if it
> > can't find the given object in any pack. It would at least allow us to
> > drop the "test -n $foo" after every invocation of the test-helper in
> > this test.
> >
> > Arguably callers may want to ensure that an object doesn't exist in any
> > pack, and this would be inconvenient for them, since they'd have to
> > write something like:
> >
> >     test_must_fail test-tool find-pack $obj
> >
> > but I think a more direct test like
> >
> >     test_must_fail git cat-file -t $obj
> >
> > would do just as well.
>
> Thanks for these suggestions, but I prefered to add the `--check-count
> <n>` option to `test-tool find-pack` in version 4.
>
> This way `--check-count 0` or `-c 0` for short can be used to check
> that an object is in no packfile, though it could be for example in a
> promisor remote or a loose object file. It's also nice to be able to
> check that an object is in exactly 2 packfiles in some cases.

"--check-count 0" is a nice approach, thanks!

> > This all looks good, but I think there are a couple of more things that
> > we'd want to test for here:
> >
> >   - That the list of all objects appears the same before and after all
> >     of the repacking. I think that this is tested implicitly already in
> >     your test, but having it written down explicitly would harden this
> >     against regressions that cause us to inadvertently delete an object
> >     we shouldn't have.
>
> I don't think we need to test this. `git pack-objects
> --filter=<filter-spec>` already existed before this series and is
> tested elsewhere. We can trust that command and its tests, and just
> check that we used it correctly by checking that only a few objects
> are in the right packfiles.

Yeah, I don't think we should be worried about whether or not
pack-objects is doing the right thing here: I agree that we have
sufficient coverage for that elsewhere throughout the test suite. I was
more concerned at catching bugs or regressions at the 'repack' layer.

But you're more familiar with these changes than I am, so I trust your
judgement.

> > > +test_expect_success '--filter fails with --write-bitmap-index' '
> > > +     test_must_fail git -C bare.git repack -a -d --write-bitmap-index \
> > > +             --filter=blob:none &&
> >
> > Do we want to ensure that we get the exit code corresponding with
> > showing the usage text? I could go either way, but I do think that we
> > should grep through the output on stderr to ensure that we get the
> > appropriate error message.
>
> I am not sure that testing the exit code and the stderr output is
> always needed. Here I think that this test is more for documentation
> purposes than really enforcing something important. In fact if the
> behavior would change and `--write-bitmap-index` would understand that
> it should write an MIDX instead of a regular index, that behavior
> change could be considered in some ways as an improvement and we would
> only need to remove 'test_must_fail' here.

I don't feel that strongly about it, TBH, I think I was more commenting
on that we seem to have many of these tests that go

    test_must_fail git <some arguments that don't go together> 2>err &&
    grep "appropriate error message" err

throughout the suite. I don't feel strongly enough to suggest that we
add more for this specific purpose.

Thanks,
Taylor
