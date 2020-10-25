Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FD1C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 13:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7ED2225E
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 13:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c28rgGd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416351AbgJYNtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414565AbgJYNtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 09:49:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91CC0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 06:49:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c20so4640293pfr.8
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iQeyDJTepvv1ZVela5c2lXY0xngXS7+uoGwG9ZqbDsg=;
        b=c28rgGd/KMcX8EboaWSFIKFdJMyd5VxX4VPXC7BZWhIDrxIAqinrrmR8dSoBku4hwH
         Oe2neIjBPMa/FaaT0RUTpj5ZgQKmRxUml8AqIBiwSyEoAPnkYneJ2zMwNIEpnGCL13ba
         +jqzfUCmI7mBdTa4s34wf/0uCSFGcH5Ij5jK+Oi56fD6kLlB7Nt8RUB689HIkOgf6hUO
         L7qlxGzyCm8VntxpivlpueJ7G2M3Gvylguxr5OsN4mTbg+Uld54PoLLUwZwvIR8IXXgs
         zCCca8haE5Gbnep3EJAISWpDLdxH+OK7wXzsZ5739G1RzJpwowpTW5V7PxnaefpBQgMV
         PI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iQeyDJTepvv1ZVela5c2lXY0xngXS7+uoGwG9ZqbDsg=;
        b=Sh7BjxDi0co4sE7GqYkmbQ8G+lBCANAd9vJTFUMVOmoVj3iRJPkkhWtQWWVnAkGwiq
         3/nZDYC4F6RVAzK7DOM1pXDaPIOytX8oJY3mBsQ+Z4TaAVb+MRw/cue4ELFYae6cWtKd
         hHiPujoMNrM2G/pNEqyfqfBUP4/KwSVEprYxhHpsY6+nPlixMxteoN/oY9ga7qVxZM+d
         o8+XvYAi+b7D/rKsUIjKKaAIjmiuXMAfIcKUaI91Hy/8MAOjROWm2Nfnn9HE2SgLWPNK
         JCGpvHJG22JEnZSp0LqACv7wDX4VSk6hp8u8nuO9KuJrEcV7W88UHz3Xs8D6opPvPsZL
         VlzQ==
X-Gm-Message-State: AOAM530HdEsa6SY8gvm+VfYGlHZPKbqIPPc8lb/zC2yMFbpND/S0FXx2
        7ahkD/tzxsEf4ahnEJEpnPQ=
X-Google-Smtp-Source: ABdhPJz9nsOIlUguNcx2ExYpuPIwovDztUsVvbN+QENuV5L+8QHlwzW8oO6AG+tLCZ45CH3SUmAmKw==
X-Received: by 2002:a63:5c5e:: with SMTP id n30mr10139623pgm.54.1603633747623;
        Sun, 25 Oct 2020 06:49:07 -0700 (PDT)
Received: from localhost ([2402:800:63a8:a664:a141:4d28:22d6:5590])
        by smtp.gmail.com with ESMTPSA id b16sm9092572pfp.195.2020.10.25.06.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 06:49:06 -0700 (PDT)
Date:   Sun, 25 Oct 2020 20:49:05 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/9] t/: new helper for tests that pass with ort but fail
 with recursive
Message-ID: <20201025134905.GB15823@danh.dev>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
 <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
 <20201024104910.GA15823@danh.dev>
 <CABPp-BHgJrQMNEm7-y7nStVjcAedsNKH+bHNM9V34netTN+NTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHgJrQMNEm7-y7nStVjcAedsNKH+bHNM9V34netTN+NTQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-24 09:53:18-0700, Elijah Newren <newren@gmail.com> wrote:
> On Sat, Oct 24, 2020 at 3:49 AM Đoàn Trần Công Danh
> <congdanhqx@gmail.com> wrote:
> >
> > On 2020-10-23 16:01:16+0000, Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > > +test_expect_merge_algorithm () {
> > > +     status_for_recursive=$1
> > > +     shift
> > > +     status_for_ort=$1
> > > +     shift
> > > +
> > > +     if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> > > +     then
> > > +             test_expect_${status_for_ort} "$@"
> > > +     else
> > > +             test_expect_${status_for_recursive} "$@"
> > > -test_expect_failure 'check symlink modify/modify' '
> > > +test_expect_merge_algorithm failure success 'check symlink modify/modify' '
> >
> > I find this series of "failure success" hard to decode without
> > understanding what it would be, then I need to keep rememberring which
> > status is corresponding with with algorithm.
> >
> > Perhaps this patch is a bit easier to read. This is largely based on
> > your patch. (I haven't read other patches, yet).
> >
> > What do you think?
> 
> It is easier to read and I think something along these lines would
> make a lot of sense if this weren't a transient change (the idea is to
> eventually drop the recursive backend in favor of ort, and then these
> can all switch to just using test_expect_success).  Maybe it still
> makes sense to make further changes here anyway, but if we do go this
> route, there are 1-2 things we can/should change:
> 
> First, while a lot of my contributions aren't that important, and the

Mine aren't that important, either

> new test_expect_* function certainly falls in that category, one of
> the driving goals behind a new merge algorithm was fixing up edge and
> corner cases that were just too problematic in the recursive backend.
> Thus, the patch where I get to flip the test expectation is one that I
> care about more than most out of the (I'm guessing on this number)

Make sense.

> 100+ patches that will be part of this new merge algorithm.  Having
> you take over ownership of that patch thus isn't right; we should
> instead keep my original patch and apply your suggested changes on top
> (or have a patch from you introducing a new function first, and then
> have a patch from me using it to flip test expectations on top).

You can take back the ownership, the patch was based on yours, anyway.

I wrote like that since I need to rewrite part of the message to match
with my changes ;)

No need to generate extra noise of additional patch.

> Second, I think that lines like
>     test_expect_merge_success recursive=failure ...
> read like a contradiction and are also confusing.  I think it'd be
> better if it read something like
>     test_expect_merge recursive=failure ort=success ...
> or something along those lines.

When I wrote the patch, I was expecting something like

	test_expect_merge_success recursive=failure,other=failure ...

in order to merge all algorithm into single parameters.

How about something like:

	test_expect_merge_success exception=recursive,other ...

Not that we have "other" algorithm to begin with.

Thanks,
-- Danh
