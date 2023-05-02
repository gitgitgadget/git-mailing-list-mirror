Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460BC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 16:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjEBQpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 12:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjEBQpS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 12:45:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397F1AB
        for <git@vger.kernel.org>; Tue,  2 May 2023 09:45:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bcae898b2so3424538a12.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683045916; x=1685637916;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VxCJn1vvJbTctjqLu8ItH1xrVGPVMZgB5dSRyKrCD6g=;
        b=AzaMYGPm8GHtuHD+DV5FvdBK3CnEVSCXAI89omoJ126iZJEl5phcYHvHiGKfYwpkmR
         CQoSj8ze+Fe2tkyVauk1d+3DejghszK4HX3/F67GIccVbUMgI+eCr25AAufhIx1USkZC
         18RrPStZESBicsGumviWz+FIsGYT1seRkWfwvg2YlwhZZzJeDf+DmJ4NQ5SryU/vjoZs
         fUdCAkwbcyfwB8wWGFvfkK41B6LYHzjwxIfGldea2XJ6V/riw/vbdq4Wx68wkQeKANJj
         8Go0SxKu2jndjqQlXKqPuP71icGkZw6vqO+dZxjo0M9QcPpIGovZNzpOdk4oPDoIsdVH
         gGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683045916; x=1685637916;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxCJn1vvJbTctjqLu8ItH1xrVGPVMZgB5dSRyKrCD6g=;
        b=VNuGexO5XzKIn0U5dOyVZ5mCo53FguZQS+pvzRbdfkK7kxQ13y2YHLsVZjtOp/sDHU
         YSnG5G/05r8lsIiukJMvJwQufL8gJJ+RajVGRrdHkka8cNzLCI9wQecKPsjwrzI66fdV
         jdw/YCDoR1mFg5WwBfXc4pIc470Bei4wBizqMidCZcow6WC9fTwmvhd5n2rZ3qPm+9rx
         KEuY3joCgLTBGdOLleFHQDXNTyJ8bD5Vnj8efGZ3b4zbFSF8Y5ggrl2J91t4CYJasapm
         WNQaAJ1N3IT7FBUCbIzLv88iJTF9yz7bteZgG/+HOPitkxs2BE4u7Lzes7WLnptPySzc
         znbA==
X-Gm-Message-State: AC+VfDzMRt9sQ4vM8e+qLbtpW9bvlM07Fs2ncHa8gNq4+M4b6wJ3F6V4
        bZGyI9mQS9dLmvysXB93Li8=
X-Google-Smtp-Source: ACHHUZ4htGPR/rVAEn1zhwtvzo3jZ/On+SpsUzCi1wRYw9FD3/QpMHiBoZ92H5EIVHX+VpMLpv4eiw==
X-Received: by 2002:a05:6402:114f:b0:504:7171:4542 with SMTP id g15-20020a056402114f00b0050471714542mr10973301edw.0.1683045915666;
        Tue, 02 May 2023 09:45:15 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7cc03000000b0050bc5727507sm2456978edt.73.2023.05.02.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 09:45:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptt7q-000ZJT-2q;
        Tue, 02 May 2023 18:45:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Date:   Tue, 02 May 2023 18:39:37 +0200
References: <20230427175007.902278-1-calvinwan@google.com>
        <20230427175007.902278-2-calvinwan@google.com>
        <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
        <6451324ed84e2_1ba2d29454@chronos.notmuch>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <6451324ed84e2_1ba2d29454@chronos.notmuch>
Message-ID: <230502.86sfcehecl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 02 2023, Felipe Contreras wrote:

> Phillip Wood wrote:
>
>> Unfortunately this library doesn't seem to offer any of those features. 
>> It does support a lazy test plan but uses atexit() so will not detect if 
>> the test program exits before all the tests have run.
>
> I think there's a fundamental misunderstanding of how we use TAP.
>
> If a program generates this output:
>
>   1..3
>   ok 1 - test 1
>   ok 2 - test 2
>
> That's clearly not complete. It shouldn't be the job a test script to check for
> those cases.
>
> If you run the programm through a TAP harness such as prove, you get:
>
>   foo.t .. Failed 1/3 subtests 
>
>   Test Summary Report
>   -------------------
>   foo.t (Wstat: 0 Tests: 2 Failed: 0)
>     Parse errors: Bad plan.  You planned 3 tests but ran 2.
>   Files=1, Tests=2,  0 wallclock secs ( 0.01 usr +  0.00 sys =  0.01 CPU)
>   Result: FAIL
>
> Why do we bother generaing a TAP output if we are not going to take advantage
> of it?

(As the person who added the TAP output to git.git)

Yeah, we could do the "plan ahead", but it would mean that tests would
need to pre-declare the number of tests they have.

In the Perl world that's the usual pattern, but as it involves having a:

	plan tests => 123;

At the top of the file that's guaranteed to give you merge conflicts if
two topics add/remove tests in different parts of the file.

It also doesn't work well in cases where the number of tests is hard to
determine in advance, i.e. when they're determined programatically.

I don't think there's any practical downside to using the "test_done"
pattern to print a plan at the end as far as missing tests go.

There *is* a minor practical downside to it though, which is that we'll
get output like "25/?" or whatever, but not "25/100", as we don't know
yet that we've got a total of 100 tests.

But I think that's a minor drawback, and really only matters if you're
eyeballing the prove(1) output of a very slow test as it scrolls by.

I think on balance the "plan at the end" approach we're using now is
much better, and would also be better in a future (or hypothetical)
pure-C test framework.

Well, there are ways to avoid the painful conflicts, e.g. by mandating
that all tests are driven by callbacks in an array or something, so then
you won't get merge conflicts on the "plan" line, as it'll just be "the
number of tests is the number of items in this array".

But such a thing is painful to mandate, and has its own drawbacks,
i.e. not being able to do a "test" at anything less than a function
callback level of granularity.
