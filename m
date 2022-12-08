Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E30BC63703
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 16:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLHQSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLHQSR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 11:18:17 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A245098967
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 08:18:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d6so2770627lfs.10
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ItozFJsernH/GsUZrgIWvdjdqICnEoRCY3dTq/HjZc=;
        b=Fk3BYZzB7HHV0Uh9Xnx+zEPCijqC2u0FRPNeb7lzcgI5njr04x6fiQFCcbZ7887mOZ
         Z2NJZ1wpWL8EpLRina9g9ZrFpZXTRnxkq172uG+bWnVp9zyPY5jLru9y3aMgPcc5iQOO
         YITnd8vW9Ec2zYLQvhUNHm4XcFezyfOxWueygpD3RN5Bhxjwx8QehwPvzBFFPRDFABcQ
         M0u7DlFhqL3YtYKZk+C7djj3kITd6oKAzcRU4roiqBPib6L1I5Wa6feledy0p3usDk2+
         gRMRFqtAKJwUukTfIuf9HpW3BW5LrlzMcZ3epm1HaekVBJgwelG2tgFZ82uKVbJuQNMW
         JzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ItozFJsernH/GsUZrgIWvdjdqICnEoRCY3dTq/HjZc=;
        b=etgTwdPG3QlH1v5v8sYqTLdAN/0xUqKPm8TiuncBQiwAgvHmsAiYzeoG/VHcIBg4OH
         cKCEdN0rxfeR7/g76oSjGpPHsikXUzXH/sEfIU4rlEVGX24ZMFvGOZAwH+o+7ib89yfj
         wcPkRrD5r8osaCoz7r26Yhkd8iKYEwGCckM7IXtNAjYd3G8wmaqp+Poi+j9+2azOCTx+
         HwuCITdKLb3xzJf4oh1rKsWIFUL0zfU3DY5vM51cpeW5bBNvq/IweUO2GxWGX0SWffzW
         K16DrMU0NvkQfm6tKVQV9ABKNX92Hv1Yrxu65gG3Qf1m5ydGlx5djMk8Uj5p207xN3eB
         tl1A==
X-Gm-Message-State: ANoB5pli7cxYLei5RsdpyicLgbSoAEPTaJYt2C3cgtZRXlxQvL7lXM9S
        h8NwzwlsqmCS6wx6ZOhphqShvrB/y5g=
X-Google-Smtp-Source: AA0mqf6q789CEqm/hSzGyNXdH/HZ1YtUfSaSMCFbcNomS3nAmDW9PzD+H1eeJXKF0+AUH+PPL5dlHw==
X-Received: by 2002:ac2:5a43:0:b0:4b5:90c5:281c with SMTP id r3-20020ac25a43000000b004b590c5281cmr722353lfn.19.1670516294244;
        Thu, 08 Dec 2022 08:18:14 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i11-20020a196d0b000000b004a03d5c2140sm3404647lfc.136.2022.12.08.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:18:13 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] diff-merges: more features
References: <20221127093721.31012-1-sorganov@gmail.com>
        <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 08 Dec 2022 19:18:12 +0300
In-Reply-To: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 07 Dec 2022 15:55:21 -0800")
Message-ID: <874ju5c1iz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> We covered this series in Review Club, thanks for coming Sergey! For
> those who are interested, the notes are here:
>
>   https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit?usp=sharing
>
> and reviewers will send feedback to the list separately anyway. I mostly
> had comments on the design, so I'll leave most of my comments here.
>
> Commenting on the cover letter as a whole, on first read, it wasn't
> obvious to me what this series was trying to achieve because the CL
> presents the 5 patches individually instead of a cohesive story. From my
> understanding, the story is as follows: we want '-m' (enable
> diff-merges) to also imply '-p', but we can't just change the default
> behavior, so we do the following instead:
>
> - Add a config option that gives the behavior that we want (2/5).
> - Deprecate '-m' by giving '--diff-merges=on;hide' as a synonym and
>   encouraging users to use that instead (1,4,5/5).

Well, very close, but not exactly. I'd rather say:

1. Provide exact semantics of '-m' trough --diff-merges UI by
   introducing 'hide' option, after which '--diff-merges=on,hide' and
   '-m' have exactly the same behavior.

2. Add a config option that gives the new behavior we want to '-m': to
   rather be a synonym for '--diff-merges=on[,hide] -p". (Please notice
   that 'hide' is not needed here as it's immediately canceled by '-p'.)

So, essentially, after (1) is there, the config option turns '-m'
meaning from default '--diff-merges=on,hide' to desired
'--diff-merges=on -p'.

Please also notice that at this point we may instead decide to just switch
'-m' meaning to new semantics, either without config at all, or with
config that'd rather restore previous semantics. In fact, the primary
reason why previously such patch has been reverted was absence of (1),
and so with (2) maybe I was just overly cautious.

> Patch 3/5 is completely separate. There was some resistance to it during
> Review Club, but if we still want this, it might be worth splitting off
> into its own series so that we can keep the discussions separate.

OK, I'll cut it off for now.

>
> During the discussion, it also appeared that this "modification of '-m'
> semantics" refers to a patch that changed the default but got reverted
> due to breaking legacy scripts. It would be extremely useful to include
> a link to that previous patch and the discussion around its revert,
> especially given the discussion about whether users actually need
> '-diff-merges=hide' ([1] and elsewhere).

Yep, please see references I've sent in my previous answer to this
message.

>
> [1] https://lore.kernel.org/git/CABPp-BHaPpQdO-uBT6ENHAM1Y-c=SBxktH-S_BTtxJvfd1qSpw@mail.gmail.com/
>
> Sergey Organov <sorganov@gmail.com> writes:
>
>> 1. --diff-merges=[no]-hide
>>
>> The set of diff-merges options happened to be incomplete, and failed
>> to implement exact semantics of -m option that hides output of diffs
>> for merge commits unless -p option is active as well.
>>
>> The new "hide" option fixes this issue, so that now
>>
>>   --diff-merges=on --diff-merges=hide
>>
>> combo is the exact synonym for -m.
>>
>> The log.diffMerges configuration also accepts "hide" and "no-hide"
>> values, and governs the default value for the hide bit. The
>> configuration behaves as if "--diff-merges=[no-]hide" is inserted
>> first in the command-line.
>
> I had the same concerns as Elijah, which is that this behavior is
> probably clearer as a separate flag (like "--hide-diff-merges"), which
> is more consistent with how '--diff-options' is used today, which means
> that:
>
> a) it is easier to explain to users
> b) the implementation is simpler (I'll comment on Patch 1 code
>    separately)
> c) it makes Patch 4 obsolete

I'd postpone implementation/design discussion till we get to agreement
of the need for this option in the first place.

> But I'm not convinced that we actually want this behavior at all. I
> don't see why a user would use a flag that says "do nothing unless
> other flags are given". don't find the 'alias use case' compelling,
> because the user still has to choose whether to pass '-p', so at that
> point they could just add a different alias.

If one travels back the history, they will find that originally all -m,
-c, and --cc were behaving exactly this way: "do nothing, unless diffs
are actually requested", i.e. they specified only diff format to be used
once requested, and did not request the output themselves. I prefer to
stay on the safe side, and assume that such behavior is still useful,
even though -c/--cc turned to imply '-p' eventually, as doing the same
to '-m' caused so much desire and resistance simultaneously.

OTOH, --diff-merges=<format> does two things: specifies the format and
requests the output for merge commits. It could have been design
mistake, even though it has been discussed at the time of introduction,
but now the only way to get another behavior is to turn off one of the
actions they do: turn off requesting the actual output for merge
commits, and that's what proposed 'hide' means.

> I haven't dug through the code/ML to figure out whether '-m' requiring
> '-p' was an intentional feature or not, but if you could find the old
> thread where you changed the default (and it got reverted), that would
> help the discussion a lot :)

Yep, I gave the links in my first answer to this message.

>
>> 2. log.diffMerges-m-imply-p
>>
>> Historically, '-m' doesn't imply '-p' whereas similar '-c' and '--cc'
>> options do. Simply fixing this inconsistency by unconditional
>> modification of '-m' semantics appeared to be a bad idea, as it broke
>> some legacy scripts/aliases. This patch rather provides configuration
>> variable to tweak '-m' behavior accordingly.
>
> I thought that Junio's suggestion to implement a flag that acts like
> '-m' with '-p' [2] was quite a good one (maybe '-M' or
> '--diff-merges=show'), since I think that very few users would actually
> set this config, but the ones that would actually use it can just
> replace '-m' with '-M'.

Introducing new short convenience option(s) is out of scope of these
series, and suggested --diff-merges=show, as I see it, is essentially
"--diff-merges=on -p" that I find hard to explain inside the
'--diff-merges=' context which name suggests it affects merge commits
only.

That said, saying: "we have slightly broken '-m' that we refrain to fix,
so let's introduce '-M' instead of fixing '-m'" does not sound very
convincing either.

>
> [2] https://lore.kernel.org/git/xmqqfse37c0n.fsf@gitster.g/
>
>> 3. log.diffMergesForce
>>
>> Force specific log format for -c, --cc, and --remerge-diff options
>> instead of their respective formats. The override is useful when some
>> external tool hard-codes diff for merges format option.
>
> This might be better off as its own series, since the change isn't
> related to '-m',

Yep, I'm sorry to mix it into the series, -- the only excuse is that it
looked very relevant to me when I did it :)

> but I'm worried about the precedent that this sets.
> To my knowledge, CLI options always overwrite config, but this is the
> opposite. I would prefer not to do this, especially if the use case is
> to work around an external tool (since it is arguably the tool that is
> broken).

The tool was only an initial motivation for the patch. From following a
few discussions on the list I got feeling that every person has their
own preference for --diff-merges format, and rarely wants to see
anything else. This config essentially gives them a way to say "please
use my preferred format everywhere, unless I explicitly say otherwise",
in a centralized manner.

>
>> 5. Issue warning for lone '-m'.
>>
>> Lone '-m' is in use by scripts/aliases that aim at enabling diff
>> output for merge commits, but only if '-p' is then specified as well.
>>
>> As '-m' may now be configured to imply '-p' (using
>> 'log.diffMerges-m-imply-p'), issue warning if lone '-m' is specified,
>> and suggest to instead use '--diff-merges=on,hide' that does not
>> depend on user configuration.
>>
>> This is expected to give a provision for enabling
>> log.diffMerges-m-imply-p by default in the future.
>
> Since '-m' without '-p' is a mistake in most cases, I wonder if we
> should just emit this warning today (maybe via the advise() API). Even
> if we don't keep '--diff-options=hide', deprecating lone '-m' and giving
> a warning seems good to keep.

I'd tend to rather not.

Actually, as far as I'm aware, the only actual use that has been
detected was "--fist-parent -m", and that use case was exactly what you
guys don't find useful: specify default format for merge commits. In
this particular case it is the diff to the first parent, and dates back
to the days before --diff-merges, when using history traversal option
--first-parent was the only way to get diffs with respect to the first
parent for merges.

Maybe we should instead flag the "--first-parent -m" as a warning, as
producing a warning for lone "-m" without these patches is effectively
getting users out of using lone "-m" instead of fixing the latter.

I rather see the bright future as using "-m" all the time, as it's now
extremely configurable.

Thanks,
-- 
Sergey Organov
