Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F30C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiBRTrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:47:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiBRTrV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:47:21 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3832722503
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:47:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w3so17226896edu.8
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=r0hfhECjlz3WMb1mh3PdN7G/2tC0I5fxeZADWKFXw4M=;
        b=eT9NzJelTIO+gWE1QRgyI26rEPJ+yFu8TWSMxPgnhQymJ4CV1pYVsxlWmIMcL4FaAR
         99Ajai5Tml2GGNIKWSSJMJpE2RDHYa0huU+xWxSqWIcyCwLCphAlplRWirui8Y5SS/OM
         g0geK4aD88KuydIzvLEKndXfKcxH/tQNiR341LrOyLRhc6ZZaUGsbo75OQvQLquERtwj
         0Bq+qe9K2EyeDrvhHv/E2ATHczbt+cJVQI4+moJgHduBbelDeVaatch/XeLXPbWdAgUR
         A58LDv1A8aX6FoWZ7ui1wddZiy/N6UeEi+5TSbApy/el4VE/Y6j/dpT1jRG+ihOPXuGd
         hXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=r0hfhECjlz3WMb1mh3PdN7G/2tC0I5fxeZADWKFXw4M=;
        b=NDups7LvRQ73EON6u4fFqGvJgnkGnCDsf+5jnTjXC30g29gs0cxwiYReIwYzDI/G/m
         MyqZndr/0nhpgVox0jOvzoc4torDpGJDl4YtxQNKiZCcNaCpGr7Aok1iWkU+rSIdsb35
         fWAGzo2BZ679OL20Ab6P+vO7tUazM5tn9S2wQhCdidkaUqgC3Ijou57/eg9tWYfu3BuI
         9G33jEshDSgv7u2wEJInMBj2CHQwkkkwLqmjDzjx5hVwjgDuWSluVn2AqfL321vPF+Tr
         cBiuv4Q/Kt9guUvlL2EuEU/8MK69vpoUe2qPyGHONUzFqrLCKghKtTNhBUPW/kpd53PY
         77VQ==
X-Gm-Message-State: AOAM530H5EnehpSfXdCUsf75ssnVI5uNF/xNo3/aNvUHcz3e+dnSeaYf
        oVmg3SAgVWyWqjDyrQ/A5J8=
X-Google-Smtp-Source: ABdhPJwN4bD4jRDmFAonZ72+QIPJj5bBPVMO0sh1R+PZwrHwdSFq0sVGfXRsD0peVGDIfr/B6sS7rg==
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id f9-20020a056402354900b00412b31c5509mr7289422edd.224.1645213621594;
        Fri, 18 Feb 2022 11:47:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j20sm1961006edt.67.2022.02.18.11.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:46:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nL9DV-004N9E-Ne;
        Fri, 18 Feb 2022 20:46:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <ajrhunt@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: Whether to keep using UNLEAK() in built-ins
Date:   Fri, 18 Feb 2022 20:31:23 +0100
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
 <patch-2.2-e3e78c9e40b-20220216T081844Z-avarab@gmail.com>
 <xmqqa6equ1rq.fsf@gitster.g> <xmqqtucyslz9.fsf@gitster.g>
 <220218.861r00ib86.gmgdl@evledraar.gmail.com> <xmqqwnhs11he.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqwnhs11he.fsf@gitster.g>
Message-ID: <220218.86fsoggdou.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> Specifically, the cited commit turned an existing strbuf_release()
>>>> on &err into UNLEAK().  If that and the other strbuf (sb) were so
>>>> easily releasable, why didn't we do so back then already?
>>>
>>> I suspect that the answer to the above question is because these
>>> allocations are in the top-level cmd_commit() function, which is
>>> never called recursively or repeatedly as a subroutine.  The only
>>> significant thing that happens after we return from it is to exit.
>>>
>>> In such a code path, marking a variable as UNLEAK() is a better
>>> thing to do than calling strbuf_release().  Both will work as a way
>>> to squelch sanitizers from reporting a leak that does not matter,
>>> but calling strbuf_release() means we'd spend extra cycles to return
>>> pieces of memory to the pool, even though we know that the pool
>>> itself will be cleaned immediately later at exit.
>>>
>>> We already have UNLEAK to tell sanitizers not to distract us from
>>> spotting and plugging real leaks by reporting these apparent leaks
>>> that do not matter.  It is of somewhat dubious value to do a "we
>>> care too much about pleasing sanitizer and spend extra cycles at
>>> runtime while real users are doing real work" change.
>
>> Per https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/ the
>> real goal I have in mind here is to use the built-ins as a stand-in for
>> testing whether the underlying APIs are leak-free.
>>
>> Because of that having to reason about UNLEAK() doing the right thing or
>> not is just unneeded distraction. Yes for a "struct strbuf" it won't
>> matter, but most of what we UNLEAK() is more complex stuff like "struct
>> rev_info". We won't really make headway making revision.c not leak
>> memory without using "git log" et al as the test subjects for whether
>> that API leaks.
>
> I have to say that you have a wrong goal and wrong priority.  The
> number of UNLEAK in cmd_foo() functions is not even a poor
> approximation of our progress.

To clarify I'm not saying it's an approximation of how close we are to
getting rid of memory leaks. I think I'll know better than anyone what
the current state of shoveling shit uphill that is.

I was suggesting that these's a trivial number of these, and mostly we
strbuf_release() already, and that on modern libc's free() is pretty
much free anyway, so worrying about using UNLEAK() v.s. just freeing
before exit is some combination of a premature optimization and
needlessly retaining a special-case for the built-ins.

> Imagine that a subsystem that are repeatedly set-up and used during
> a single program invocation was leaky.  Let's say a program calls
> diff_setup() to prepare the diff_options structure, feeds two things
> to compare, and calls diff_flush() to show the comparison result,
> but let's assume this sequence leaks some resources.
>
> Now cmd_diff() may be such a program that does a setup, feeds two
> trees, calls diff_flush() and exits.  If we didn't do anything to
> it, diff_options may "leak".  Marking it with UNLEAK may be a good
> measure, if we want to keep the leak checker from reporting a leak
> that does not matter in practice so that we can concentrate on
> plugging real leaks that matter.
>
> But consider cmd_log(), running something like "git log -p".  It
> iterates over commits, does the <setup, compare two trees, flush>
> repeatedly for each commit it encounters during the walk on the same
> diff_options structure.  Now, the leak in the code path does matter.
> If diff_flush() is left leaky, it will show up in the leak checker's
> output, and that is reporting real leaks that matter.  The thing is,
> the <setup, compare, flush> sequence whose leak matters is not in
> cmd_log(); it is much deeper in the revision walking machinery.  We
> do not want to paper over such leaks with UNLEAK.
>
> See the difference?  The number of UNLEAK OUTside built-ins does
> matter.  We do not want to have UNLEAK there to hide leaks in
> possible callees that may be called arbitrary number of times in
> arbitrary order.  Compared to that, UNLEAK in cmd_foo() to mark an
> on-stack variable that was used only once without even a recursion
> is purely to squelch the leak checker from reporting leaks that does
> not matter.  For simple things like strbuf on stack of the top-level
> cmd_foo() functions, we could even leave strbuf_release() not called
> and leave the resource reclamation to _exit(2).  That would cause
> the leak checkers to report them and distract us, and UNLEAK is a
> better way to squelch the distraction without wasting extra cycles
> at runtime to actually free them.
>
> So, don't look at "built-ins as a stand-in".  It is a wrong
> direction to go in to let the "leak checker" tail wag the dog.

Yes, I see the difference and I fully accept the point you're making.

I just don't find it to be a useful distinction in practice, because for
e.g. "git log" we do have certain uses of the API which are only
performed by the top-level part of a "git log --whatever".

So if we take the view that e.g. the "struct rev_info rev" should be
UNLEAK()'d because "we're about to exit anyway" then as soon as we *do*
use that part of the API we'll run into the previously unfixed and
hidden leak.

Which is why as noted in the linked-to-above
https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/ I think
it's useful to fix leaks even in built-ins, because they're useful
canaries for those APIs.

Now, in this case does it really matter? No, it doesn't currently. But I
think the direction we should be heading in is turning more of these
cmd_whatever() into properly functioning libraries, as e.g. John Cai's
just-sent series to do that for "reflog delete" does:
https://lore.kernel.org/git/pull.1218.git.git.1645209647.gitgitgadget@gmail=
.com/

Once we do that the UNLEAK() here will absolutely need to be changed to
a strbuf_release() or equivalent, since if you make two commits with
that new library we'll have leaked memory.

So I think it makes sense to just fix leaks everywhere if it's easy
without worrying about the distinction, particularly since I haven't
seen that "wasting cycles" concern matter in practice.

If it did I'd think adding a "GIT_DESTRUCT_LEVEL" as I suggested in the
linked E-Mail would make more sense, since e.g. you could also use that
if you knew you were walking 100 commits & exiting, which can be useful
to further reduce free() churn, and is how a similar global in the Perl
API (PERL_DESTRUCT_LEVEL) works.
