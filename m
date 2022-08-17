Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B333C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 01:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiHQBiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 21:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiHQBiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 21:38:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079EB95696
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 18:38:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so14524656wrp.10
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=14jKGMIPK6WS/g8csQwlmJklijiHXw0t7Y1OPyxdZMc=;
        b=LgTRpHMY6OngWs+Meoglzy0sL6tmsbkQmtg8iXDd4mfPWciged8DdI9cK/f9qiHfYK
         X6at/Vl+0VIHzDu60vt0kUbSSe2Qvh3pXY+mAxyvVjag84Q2mryCOK3WWx+2G2926k3I
         p+gbkX4kQjYZ/JbvRbYW0Vt3hjA9BE25y2Kbtm9+/FvW+n5CdR0+cfya1PIfM64B6IAd
         P1Iy1qzfWjPwj7Wy91IsBfo2nI2XU9Ge+DOhmRyARy6PIyB6T8QVodCl1k1FsGQ20gpj
         l10Zxzz9+BQqblsoqy098xA6KXv8toaQEVWIEU2C8DmsN6rHBreyaLa5aC8XrWmTr1Dx
         xMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=14jKGMIPK6WS/g8csQwlmJklijiHXw0t7Y1OPyxdZMc=;
        b=hm962otdFdV628M789jumqztKPFAKVbdZJzsn6TcJQjxBfYsgoMzh1wRgBAjbxUJkM
         R/Z1a5DwGDuy8zLOh14qS4u5Nfe2iJ8H+DXe8BjHE9W/5Q0mXpUeTtx4D2Bf/g3DYJYS
         RNKMhYNSCpEmxguAOndqugPkWV98xvntTu3e/1lYXdi4dbyhqkexFJ6HvqePi9nxuUyu
         zCzZz0EAu7eZ1QbDFtXv9HbposXCq3/YbDVG/iw2+Fky+GTZAeNj68mHDwIAWLtKNCxU
         9PjkH0dLLKVkcO5Xh4CxcZPPWJqc7b+a0HAjvc05PrMNh5wwBrImtMSZCiFgzIn72SuX
         diqg==
X-Gm-Message-State: ACgBeo362E3R7uPA3bBNM+MqC54LPdS/6eFc95BZZ8VDa+EQpiN1/jrt
        fke+7Tqaea7Svv7lmXblXFu4RIkDeKVydg==
X-Google-Smtp-Source: AA6agR7fGj/CBUiKbTm5rghQWnI9RBMratq4vPwp7os/KvfWDHk2Ah+dwZmsffsed4Mm+bspwsQ3Rw==
X-Received: by 2002:a05:6000:168e:b0:220:87da:c3e4 with SMTP id y14-20020a056000168e00b0022087dac3e4mr12525177wrd.559.1660700278434;
        Tue, 16 Aug 2022 18:37:58 -0700 (PDT)
Received: from gmgdl ([213.220.121.135])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003a541d893desm424662wmq.38.2022.08.16.18.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 18:37:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oO80J-0006j7-2m;
        Wed, 17 Aug 2022 03:37:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Jul 2022, #03;
        Mon, 11)
Date:   Wed, 17 Aug 2022 02:49:14 +0200
References: <xmqqo7xufee7.fsf@gitster.g>
        <s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr>
        <220713.865yk1456z.gmgdl@evledraar.gmail.com>
        <xmqqtu7ldmrz.fsf@gitster.g>
        <p8srrprq-s23s-711n-n452-34qr856qso29@tzk.qr>
        <220714.86mtdb1jmp.gmgdl@evledraar.gmail.com>
        <8o63pp64-4s00-1000-42s1-38so68398337@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8o63pp64-4s00-1000-42s1-38so68398337@tzk.qr>
Message-ID: <220817.86pmgzabv0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 16 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 14 Jul 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Thu, Jul 14 2022, Johannes Schindelin wrote:
>>
>> > On Wed, 13 Jul 2022, Junio C Hamano wrote:
>> >
>> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> >>
>> >> > I'm not claiming that we always use 129 when we're fed bad options =
etc.,
>> >> > but rather that that's what parse_options() does, so at this point =
most
>> >> > commands do that consistently.
>> >> >
>> >> > 	./git --blah >/dev/null 2>&1; echo $?
>> >> > 	129
>> >> > 	./git status --blah >/dev/null 2>&1; echo $?
>> >> > 	129
>> >> >
>> >> > But yes, you can find exceptions still, e.g. try that with "git log=
" and
>> >> > it'll return 128.
>> >>
>> >> Yup, that was my understanding as well.  We may have existing
>> >> breakage that we shouldn't be actively imitating when we do not have
>> >> to.
>> >
>> > This patch series already implements `git bisect` in the desired way:
>> >
>> > 	$ ./git bisect --invalid; echo $?
>> > 	usage: git bisect [help|start|bad|good|new|old|terms|skip|next|reset|=
visualize|view|replay|log|run]
>> > 	129
>>
>> It doesn't, the claim isn't that there's no way to have it return exit
>> code 129 on *some* invalid usage. In this case we do the "right" thing.
>>
>> Rather that as noted in [1] there's other cases where we call die() and
>> should call usage_msg_opt().
>
> It would have been better to take the time to spell out clearly that you
> are taking offense in `git bisect start -h` not behaving in the way you
> think is the rule in Git: to print a _subcommand_ usage and exit with code
> 129.
>
> However, this feedback fails to recognize the scope of this patch series.

No, I'm pointing out that you could *also* get more benefit from moving
more towards the way we do things with other sub-commands in
builtin/bisect.c.

But the core feedback was on your 11/16
(https://lore.kernel.org/git/ce508583e455a1dbb7620a238edb11dae195f00d.16563=
54677.git.gitgitgadget@gmail.com/)
changing ("correct[ing") the return code

If we're going out of our way to change the behavior of bisect
while-we're-at-it let's change it to the actually correct thing. I think
Junio concurred with that here:
https://lore.kernel.org/git/xmqqtu7ldmrz.fsf@gitster.g/

> The patch series' intention is not to fix anything that is currently
> broken. And it is already broken, my patch series does not introduce that
> breakage.

I think that would be completely fair if it aimed to bug-for-bug
re-implement the current git-bisect.sh behavior, without the unnecessary
while-we're-at-it changes.

> (and it would make more sense to address this breakage _after_
> the conversion, to avoid doubling the effort): The current output of `git
> bisect start -h` shows the usage of `bisect--helper`!
>
> Instead, the scope of the patch series is to finalize converting the
> `bisect` command to a full built-in, implemented in C, and avoiding the
> portability cost of running a POSIX shell script.
>
> Note: I agree with you that it would be nice for `git bisect start -h` to
> output a proper usage. There will be a time to discuss that, that time is
> just simply not right now.

I agree with all of that, but that's not what I've been pointing out to
you, except to note that your bisect.sh->C conversion is making some
subsequent follow-up work harder than it needs to be.

> Since the scope is so different from what your feedback suggests, I have
> to admit that it taxes my patience to see that laser focus on aspects that
> are almost irrelevant compared to the aspects that should concern any
> good review of this series: the correctness of the conversion, with a
> heavy focus on the non-failure modes.

...

> No user would care about the exit code of a failure mode (as long as it is
> non-zero), if there are regressions e.g. in how `git bisect start
> --good=3D=C3=86var --bad=3DDscho` behaves.

If users don't care about the specific exit code of failure modes why is
your series (the 11/16 noted above) going out of its way to change those
exit codes?

> So this hyper focus on what look like less relevant aspects is not only
> irritating, it actively distracts me, others and even yourself from the
> thorough review I would like to get: There have not been any thorough
> reviews of this patch series so far, and I think it is because of this
> here distraction.
>
> The cost of this distraction is quite real: not only is there a
> performance penalty of running POSIX shell scripts on Windows, there are
> also problems with anti-malware disliking the way the POSIX emulation
> layer works that we currently have to use on Windows to run `git bisect`,
> which would be fixed by `bisect` being a full built-in. This distracting
> feedback that prevents a thorough code review delays that fix for those
> users.
>
> To understand what I am aiming for, look at the deep analysis of the
> rot13 filter conversion from Perl to C in
> https://lore.kernel.org/git/4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr/,
> where I carefully compared the behavior of the scripted code with the C
> code that was designed to replace it.
>
> At this point, it is good to recall Parkinson's law of triviality:
>
> 	Parkinson observed and illustrated that a committee whose job was
> 	to approve plans for a nuclear power plant spent the majority of
> 	its time with pointless discussions on relatively trivial and
> 	unimportant but easy-to-grasp issues, such as what materials to
> 	use for the staff bike-shed, while neglecting the less-trivial
> 	proposed design of the nuclear power plant itself, which is far
> 	more important but also a far more difficult and complex task to
> 	criticise constructively.
>
> We've seen quite a few regressions as of recent that would have likely
> been prevented by thorough reviews that do not distract themselves with
> tangents, pet peeves and personal taste.

One way to avoid regressions is to change fewer things, I've given you
some feedback about how you can accomplish the same things your series
is trying to do with much less churn.

> It would do good if we the reviewers on the Git mailing list took to heart
> that Git is a software that millions of users depend on, not just our toy
> to play with, and therefore the purpose of our reviews should aim to keep
> Git working and safe. We will achieve that only if we avoid what Parkinson
> called pointless discussions and instead put in the effort to provide
> high-quality feedback that helps improve the design and the correctness of
> the code.
>
> In this instance, the discussion about exit codes and usage messages
> should be postponed, in favor of focusing on the actual scope of this
> patch series.

You're replying downthread of a message where among other things I
pointed out a specific bug that's introduced in your series,
i.e. exactly the sort of code correctness feedback you claim to be
asking for.

Which is also a roundabout way of replying to your larger point
here. I.e. you're lamenting that I didn't provide you more feedback on
the specifics of your series.

That's true, but the reason I haven't spent time on doing that is from
past experience with you routinely ignoring feedback on your patches.

So as pointed to you (and not for the first time) upthread this is still
broken:

	$ ./git --list-cmds=3Dparseopt | grep -o bisect
	bisect
	$ ./git bisect --git-completion-helper
	usage: git bisect [help|start|bad|good|new|old|terms|skip|next|reset|visua=
lize|view|replay|log|run]

I.e. it should be:

	$ ./git --list-cmds=3Dparseopt | grep -o bisect
        $

The fix on top of your series is easy:
=09
	diff --git a/git.c b/git.c
	index 182ae9474de..ae99630b3c7 100644
	--- a/git.c
	+++ b/git.c
	@@ -492,7 +492,7 @@ static struct cmd_struct commands[] =3D {
	 	{ "annotate", cmd_annotate, RUN_SETUP },
	 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
	 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
	-	{ "bisect", cmd_bisect, RUN_SETUP },
	+	{ "bisect", cmd_bisect, RUN_SETUP | NO_PARSEOPT },
	 	{ "blame", cmd_blame, RUN_SETUP },
	 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
	 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },

I think your participation in reviews would be much improved if you
replied more point-by-point, e.g. the initial report of this specific
issue in your series has been sitting on-list for 2 months ([1]) without
a follow-up.

When you do send something in reply it shows that you either haven't
read the feedback on your own series, or are deciding to actively ignore
it (but without really clarifying that that's what you're doing in those
specific cases). Or perhps you've just not understood what I've pointed
out to you (which might be on me). In any case having the discussion on
the original thread would be much more productive.

1. https://lore.kernel.org/git/220627.86mtdxhnwk.gmgdl@evledraar.gmail.com/
