Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF4C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 20:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjHIUjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjHIUjU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 16:39:20 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA72D79
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 13:38:56 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-586a3159588so3374997b3.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691613509; x=1692218309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3E7rMMT1BrQFH2PRKWBDWxJCVmnGUekzyEFVHfr7rNk=;
        b=3RbD3UAdchBZ2cxIhHxtY0IGv0EZaNaEKbjP2E+y8sCn7/eJkod9uWlMAUCVd1XKG9
         8QpI4txJ8EuvWP3eBq4i1Ed2KJr+lDDaPrfd822dXU2eYcuOM+gvDEwoo2eM9JWYqSih
         uOgfhfNfg8poosi+cZtCs13cZHbzYFptGnksAwfhtuSb9VH/5X0tqYCxbScigTIeZVRK
         pWWPFgcgQMbni3DoaS1Z6vVutJqK8joAlPbxfD5rJNDAA+JL4BSdylas5Y48T94pEW0m
         6M41DFqMlRrW1ztU1JLqBGieoIXVbtUgN4OsHVFfHB3uhVy677RpqWHQyMwW1mkn5lB8
         Mz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613509; x=1692218309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3E7rMMT1BrQFH2PRKWBDWxJCVmnGUekzyEFVHfr7rNk=;
        b=H96SfxjDwJCw7jCmb/HNS96nlKjGXV9docemrWqtFaLDY8r8QCT/14sxOD9KYOfDgv
         v36qymQRoQb2SaIPyM+5AadHn1A71P3UdbYPAZL7syoe+nuaaOtTANrmqkDMchTl0mot
         C8bAC8Cds9i0bwZ7qQw6jgD6fOjPDBJvhhryNW9f8zmymzhumLqk1jSQpNjxcQUZP6ku
         VRLhzLWfHwmWW7RQCD3ULk3+2e9rC9pNxzBIpnMrqvscy0HrPSMkrcVusO8diSajvOEd
         Fiah3xUl8R1CxgBX3nSBpib5EvHM47osT+tO5tTONKXJawXDmA/5Bnodu5o8w5K8fOml
         /xhQ==
X-Gm-Message-State: AOJu0Yw9Grb7ZkOojFn4pvMgODEheIGKdYWJN7kLgZJ2p/e+jqVcQYFR
        8txn4LDZPdU5X7UKWZgl/L9R/w==
X-Google-Smtp-Source: AGHT+IGcugTnKRCFLuMpVi7HqEhYvDkLFBxvn3QD85W9UhsEtfyPFKVBR3k3kI5zZ9gWcz62V11xYw==
X-Received: by 2002:a81:49d4:0:b0:56f:f0db:759a with SMTP id w203-20020a8149d4000000b0056ff0db759amr569ywa.13.1691613509228;
        Wed, 09 Aug 2023 13:38:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d17-20020a0ddb11000000b00586108dd8f5sm4214546ywe.18.2023.08.09.13.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:38:28 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:38:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
Message-ID: <ZNP5RNJgTU698ra6@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230705060812.2865188-6-christian.couder@gmail.com>
 <xmqqh6qi1byn.fsf@gitster.g>
 <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
 <xmqqila9p3j8.fsf@gitster.g>
 <CAP8UFD3b6gCog5P7WKzTuPQV2Lhf51=xO7ys+W7o0pGewJMcFg@mail.gmail.com>
 <xmqqcz0fnbs8.fsf@gitster.g>
 <xmqqo7jzh9mh.fsf@gitster.g>
 <CAP8UFD1eX8JMd91Say_sC7h_V08oRq32Wu9RM+SFtAQnhRPO2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1eX8JMd91Say_sC7h_V08oRq32Wu9RM+SFtAQnhRPO2w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 10:45:48AM +0200, Christian Couder wrote:
> On Wed, Jul 26, 2023 at 1:09 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Thanks for walking through the codepaths involved.  We are good
> > > then.
> >
> > Sorry, but not so fast.
> >
> > https://github.com/git/git/actions/runs/5661445152 (seen with this topic)
> > https://github.com/git/git/actions/runs/5662517690 (seen w/o this topic)
> >
> > The former fails t7700 in the linux-TEST-vars job, while the latter
> > passes the same job.
>
> I think this was because I added the following test:
>
> +test_expect_success '--filter fails with --write-bitmap-index' '
> +    test_must_fail git -C bare.git repack -a -d --write-bitmap-index \
> +        --filter=blob:none &&
> +
> +    git -C bare.git repack -a -d --no-write-bitmap-index \
> +        --filter=blob:none
> +'
>
> which fails because in the linux-TEST-vars job the
> GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP env variable is set to 1 and
> this counteracts the `--write-bitmap-index` option.

Makes sense. That linux-TEST-vars job always seems to get me, too.

(As an aside, and definitely not related to your patch here, I wonder if
we should consider dropping some of the older TEST variables that belong
to features that we no longer consider experimental).

> I have tried to fix it like this:
>
> +test_expect_success '--filter fails with --write-bitmap-index' '
> +    GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 test_must_fail git -C
> bare.git repack \
> +        -a -d --write-bitmap-index --filter=blob:none
> +'
>
> but I haven't been able to check that this works on CI as all the job
> seems to fail these days before they even start:

I think the cannonical way to do this is with env, like so:

    test_must_fail env GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
      git -C bare.git repack -ad --write-bitmap-index --filter=blob:none 2>err

Thanks,
Taylor
