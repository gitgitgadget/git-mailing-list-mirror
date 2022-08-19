Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44BC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 15:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349638AbiHSPKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 11:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349236AbiHSPK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 11:10:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CF3BCC26
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 08:10:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h24so5514771wrb.8
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=/R94YPTCi0LOuMEf4/DoRyls6QID5XMSwv6XQ2Wjxr0=;
        b=SvasRI50EhjU6lVwff6dH3C7nNDbZfbreUL0o9iRZAJVPxygF7AJV27DPv1TBjI6hK
         p6SpjEpTgs51ZWchqTxwulXCjekegqIR7W34fvO3/+VrXajJ5/Lks/iTHKHOwzE62+e6
         O0+lLqleNof7FK15BHWIi183459heZORcjk+44GLuEQHQzi90eXwvJbS3T7AaQt3Vdh2
         LjN9ncuu6QNBHtOaVQ9odiUDZHAyJAjLLEqX6ElvNTlS0adN+f+DibaIBpG95nunSmUe
         OVxmiyQEdJ2QVBGmRo64FVCQVTkf6gHNevw4oe75hJqC2V61t7/CtTtzVYCYzdFWva6l
         qkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/R94YPTCi0LOuMEf4/DoRyls6QID5XMSwv6XQ2Wjxr0=;
        b=awknkDs4Wv+K8m37xRO6lT0DFy0M9W2vCRHbXDS3xliEpsWVMlKqM84GDc5ahetvt5
         ibMVv7YcX8G8X+HeVZiUNUnUOIOSRpbETNq03aPJvXycY38mh/Qpcg8H+eF03JGqczWk
         DZ8YgOC4T/w+96gEeDpFQhDyH5S0REyCGMtA3SXhu9SklHrhu9BFYirL2Q3gWXS1y57o
         KLsJNSfYq9GsWw7+ebqDCvf3Qlf/4ikm4+lLHmE3OJcjJZJy3b3QGBLVvyDu3x0nhru9
         WtphiW91QloV4NUX9IVNYDxSw6eRJZuFQWR2vXnHcKaKpp24j3uDan2KPswV4Fu6srWi
         YLQA==
X-Gm-Message-State: ACgBeo352jxYoY58+VSXlbgciHEJliq3v644rd6QP5CnLNxAXE+8MIJ5
        JSSrDovfGpWCYyn3h/S1oZfUPuTQe9tFUQ==
X-Google-Smtp-Source: AA6agR6wiYktBDY7WD8YmtvnerrwFEoaGwSkB06a9k9XhMNzgM0BiC0B7pWGwbn6bad8tw5EPHCRbw==
X-Received: by 2002:a5d:494d:0:b0:225:1bfc:6820 with SMTP id r13-20020a5d494d000000b002251bfc6820mr4579937wrs.473.1660921821014;
        Fri, 19 Aug 2022 08:10:21 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003a500b612fcsm8697112wmi.12.2022.08.19.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 08:10:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP3db-000lI3-0J;
        Fri, 19 Aug 2022 17:10:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Aug 2022,
 #05; Mon, 15)
Date:   Fri, 19 Aug 2022 16:40:04 +0200
References: <xmqq5yityzcu.fsf@gitster.g>
        <p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr>
        <CABPp-BFAERLt_z-D=7gbXWVA9JgsqTP_2iW9BLe5S=YbsQ1V6w@mail.gmail.com>
        <xmqqtu6avgub.fsf@gitster.g>
        <CABPp-BHBOqnU7DSLkYPig=c6+emWGaE1vdzaPk0D90yQdof+6A@mail.gmail.com>
        <xmqq35duvdow.fsf@gitster.g>
        <snn8r5pn-rr6n-376r-s663-92s81pos077p@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <snn8r5pn-rr6n-376r-s663-92s81pos077p@tzk.qr>
Message-ID: <220819.86sfls6zhh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Wed, 17 Aug 2022, Junio C Hamano wrote:
>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > Ah, gotcha.  My impression was that the exit codes did match what the
>> > previous shell code had done, but didn't match what other builtins
>> > usually return.  Perhaps I misread those discussion comments.
>>
>> Or perhaps I did ;-)
>
> The exit codes before and after this patch series are a red herring. The
> _current_ code prints this when calling `git bisect start -h`:
>
> 	$ git bisect start -h
> 	usage: git bisect--helper --bisect-reset [<commit>]
> 	   or: git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]
> 	   or: git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>] [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
> 	   or: git bisect--helper --bisect-next
> 	   or: git bisect--helper --bisect-state (bad|new) [<rev>]
> 	   or: git bisect--helper --bisect-state (good|old) [<rev>...]
> 	   or: git bisect--helper --bisect-replay <filename>
> 	   or: git bisect--helper --bisect-skip [(<rev>|<range>)...]
> 	   or: git bisect--helper --bisect-visualize
> 	   or: git bisect--helper --bisect-run <cmd>...
>
> 	    --bisect-reset        reset the bisection state
> 	    --bisect-next-check   check whether bad or good terms exist
> 	    --bisect-terms        print out the bisect terms
> 	    --bisect-start        start the bisect session
> 	    --bisect-next         find the next bisection commit
> 	    --bisect-state        mark the state of ref (or refs)
> 	    --bisect-log          list the bisection steps so far
> 	    --bisect-replay       replay the bisection process from the given file
> 	    --bisect-skip         skip some commits for checkout
> 	    --bisect-visualize    visualize the bisection
> 	    --bisect-run          use <cmd>... to automatically bisect
> 	    --no-log              no log for BISECT_WRITE
>
> Notice how this talks about `bisect--helper` and about `--bisect-reset`.
>
> Also, the _current_ code exits with code 0 when calling `git bisect -h`.
>
> This has been the case even as far back as v2.25.1, and possibly even
> longer.
>
> Given these issues, I was mistakenly assuming that it would be okay to
> postpone these problems that are exclusively related to incorrect
> invocation of `git bisect`, and that it would make sense to focus on the
> conversion from shell code to C in _this_ patch series, and take care of
> these problems afterwards, instead of hodgepodging fixes for them into the
> same patch series as the conversion to C, the latter being hard enough to
> review as it stands, so much so that it received only a single high
> quality review.
>
> But I see that you somehow got the idea that the review that lacked
> attention to the common code path somehow was a valid review and you
> somehow got it in your mind that this was valid feedback and that the
> patch series needs to be reworked so that it _also_ addresses issues that
> have been broken _before_ it.

I really think these remarks about "high quality review" and "the review
that lacked attention" are overly snide and don't contribute to a
friendly ML atmosphere.

We can all be wrong about stuff, e.g. [1] is one very recent case where
I just plain misread something in a review. But can we just ask for a
clarification etc?

In this case I fully agree with you that any existing issues in the
conversion of bisect to C should be out of scope for your series, but
that's not what your series is doing.

I've specifically been pointing out issues where the behavior is changed
as a result.

For example, on "master" (and there's a lot more of these):

	$ ./git --exec-path=$PWD bisect terms a b c; echo $?
	error: --bisect-terms requires 0 or 1 argument
	255

On "seen", with your series:

	$ ./git --exec-path=$PWD bisect terms a b c; echo $?
	fatal: 'terms' requires 0 or 1 argument
        128

That's one of the things I pointed out to you, and clearly a behavior
change in both the exit code emitted, and the message emitted.

I don't think it's unacceptable to have some behavior change as we
migrate to the C version.

I'd just pointed out cases where that either seemed unnecessary, or
migrated to some unusual pattern. E.g in the case of exiting with code
128 instead of 129 on usage errors, as we usually do.

> I'll try to get to it next week. It does leave a foul taste that we're not
> separating concerns properly in the Git project, but block a patch series
> that has a specific, already large scope, just because one reviewer wants
> it to have another scope and for some reason that now must be the scope of
> the patch series.

I'd really like you to find and quote back to me somewhere I've
attempted to "block" these patches, or anything of the kind. That's
simply not true.

If you had actually asked: Aside from any outstanding issues with your
series, I think as it stands that it's a net improvement on "master". I
would not mind it advanced in its current state. We can fix any
outstanding issues with it later, particularly due to what seem like
time constraints on your end, and how unproductive reviewing it seems to
be getting.

I think the only thing I've said which could be construed as "blocking"
this series has been:

 * In
   https://lore.kernel.org/git/220627.86mtdxhnwk.gmgdl@evledraar.gmail.com/
   noting (and I'm paraphrasing here) that I couldn't in good conscience
   give it something like my Reviewed-by due to the various behavior
   changes it introduces, *and* the fact that large parts of the bisect
   interface it touches are completely untested.

   Now, of course "untested" is an existing issue, but I think it's fair
   to point that out when a series proposes to refactor some code that
   it's doing so on an interface that's not well tested, to the point
   that you can remove at least one "bisect" sub-command entirely and
   have the test suite still pass.

 * Pointing out specific bugs etc, as above.

 * In these "js/bisect-in-c" threads noting the outstanding issues with
   it, particularly as I think your own summaries have been.

   I don't see how you your remark that you "did not see any feedback
   that focuses on the actual scope of the patch series" in [2] with
   e.g. claim above that this behavior was "broken _before_ it" as
   anything except contradictory.

If your own summaries were something to the effect that no major issues
had been raised, that you didn't have time to re-roll it, and could it
either be picked up as-is or could others propose fix-ups on top I
really wouldn't mind, or see any reason to comment in these threads.

1. https://lore.kernel.org/git/220819.86a6817xyw.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr/
