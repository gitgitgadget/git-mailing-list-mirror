Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFEAC433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 08:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiFIIVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 04:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiFIIVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 04:21:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41523BD4F4
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 01:21:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c2so30138016edf.5
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 01:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YpDTMv2CDPQt1XZOYN87wN8d9uIONR/sFU0QYO/n6IQ=;
        b=D7s6WCxDWd1elkk7cJwvaA0zFHgd8m9C2t28nJPwt/9vs97yPpoXMlhHPhHS11RP2Q
         MD9WAjOmRto3y4QKDXgxSRczZ1Yy5Vitz+D171VipSRKHjzuKNH8/cAcOxe2ZHRdHljv
         /D1cTe9FVMVDj0kqOiqigohRCqoGD2Lc8gL/8XTXsbMlSBzFxbbcLhR/HIJ1B+sOYxa/
         0bpjFpRqCpAq8sL6COscAIxzivBlhy/IXtcbmEFjY81c0cZQN1bcmG0TiPY2QCFFV/hc
         FkadP/aclQ8jiPdq7ThtUmvDCBRXL1/ujTg3UCm94KzDFaZrAJ9rHHnxNCTP26PdGnZw
         SAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YpDTMv2CDPQt1XZOYN87wN8d9uIONR/sFU0QYO/n6IQ=;
        b=ua8Ft0LGhnaHkSLeiawiBWPzvDMlUXGzsZt/eDnxOs97S7Mq5FB+pLQ9yGvvN3afvL
         ux2Kg5WOPEp66ANxReHPYmy2eGNAUfN+fv98IBEf55A8R+26ptq5lUzGBRt2L2Rl2SRe
         7prx3d+9j3xVdLpNhKeWmX0B5AVdk+Fg6o7wtW3UJKSOOcmTjTOnYpKCAdcdr82Ler5f
         QcowI1Q9RLeuh0AH/RFtYUB149aCNlyVzO7uzo7M5yYDrDUwTQk4wSkw0roVpS+OT7z5
         UkD2NOK/T1b8xmX17bo6fbJGPhXUZmWTf+oq2NjdBAGKibXIBIkREPZoy15ttthKofVe
         FV8Q==
X-Gm-Message-State: AOAM533sYMzURPPeGaSx5vUyPIiu/Kb9DYwafsqhll+Jz1mgdsfRWlDW
        XrP432d+9DBoREC5UXJdJ1o=
X-Google-Smtp-Source: ABdhPJw99voVzsgGcEEMW3pIeYFP60y/smt+OKZhRvyrTipirfYKnoqrsOH/j/89hLvcqPD+Dj6YUw==
X-Received: by 2002:a05:6402:3706:b0:433:3771:57ec with SMTP id ek6-20020a056402370600b00433377157ecmr3185144edb.30.1654762861511;
        Thu, 09 Jun 2022 01:21:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a26-20020a1709062b1a00b006f3ef214db4sm9472560ejg.26.2022.06.09.01.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 01:21:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzDPY-002lwh-AC;
        Thu, 09 Jun 2022 10:21:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 1/3] test-tool: don't fake up BUG() exits as code 99
Date:   Thu, 09 Jun 2022 10:09:25 +0200
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
 <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
 <xmqqv8theehf.fsf@gitster.g> <xmqqczfpe9ua.fsf@gitster.g>
 <YqD100DRVJoZCC+x@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YqD100DRVJoZCC+x@coredump.intra.peff.net>
Message-ID: <220609.86czfitfgz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 08 2022, Jeff King wrote:

> On Fri, Jun 03, 2022 at 02:05:49PM -0700, Junio C Hamano wrote:
>
>> > Are we sure that the reason no longer applies?  How do we know?  We
>> > would want to explain that to future developers in the proposed log
>> > message, I would think.
>> 
>> We can flip it the other way around.  
>> 
>> I do not think I ever saw anybody asked anybody on this list who got
>> a BUG() message to use the coredump to do something useful.  Don't
>> modern distros ship with "ulimit -c 0" these days?
>
> Certainly I have found the coredumps useful, though I would expect most
> Git developers to be able to run under a debugger and stop at BUG()
> anyway. So we could probably live without that, but...
>
>> It might be possible that a better direction is to introduce
>> GIT_ABORT_ON_BUG environment or core.abortOnBUG configuration that
>> chooses between abort() and exit(99), or something like that, and
>> then we switch to use the latter by default over time?
>
> It really should continue to die with a signal (or an exit code that
> pretends to be one) to continue triggering even under test_must_fail().
>
> IMHO the whole "let's trigger BUG() intentionally via test-tool" stuff
> in t1406 is misguided. It's literally introducing broken code that is
> not run in the normal Git binary in order to make sure that it's broken.

I haven't looked at that ref code in particular, but in general adding
coverage for the case we actually expect to defend against with BUG()
via a test-tool is something I think we could use in more cases.

E.g. parse-options.c will BUG() out on various bad options structs,
there it makes sense to feed those bad structs in to make sure our
assertion code is doing what we still expect, but we don't have those
tests.

> If that were the only spot, I'd suggest just getting rid of it entirely.
> But the code in t0210 that checks the handling of trace2 and BUG() is
> probably worth keeping.

Yes, we definitely want to test what *actually* happens as far as 

> I do agree that an environment variable would be a better selector than
> "this code is linked against test-tool". I thought so even back in:
>
>   https://lore.kernel.org/git/20180507090109.GA367@sigill.intra.peff.net/
>
> :) That message also covers the flip-side case discussed earlier in this
> thread: why calling abort() unconditionally in the test suite can be a
> pain.

I didn't know about that Jenkins case, but in any case I think we can
probably stop worrying about this given that we haven't had complaints
about ac14de13b22 (t4058: explore duplicate tree entry handling in a bit
more detail, 2020-12-11) (although I've noticed in in "dmesg" before).

I.e. since v2.31.0 running the test suite has produced at least 2
segfaults per run:

    $ (sudo dmesg -c; ./t4058-diff-duplicates.sh) >/dev/null; sudo dmesg | grep segfault
    [17687265.247252] git[11336]: segfault at 40 ip 0000000000700916 sp 00007ffc10d5dda0 error 4 in git[405000+33d000]
    [17687265.297027] git[11397]: segfault at 40 ip 0000000000700916 sp 00007ffd7dfd5310 error 4 in git[405000+33d000]

Perhaps those tests aren't valuable, but I think that shows that the
GIT_BUG_ABORT approach you suggested should probably be tweaked to
instead be some test prereq like SEGFAULT_AND_ABORT_OK.

On the other hand those segfaults in t4058 should probably be converted
to a BUG()...
