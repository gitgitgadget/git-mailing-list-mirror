Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1E1C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 17:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66906610FB
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 17:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhJDR6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 13:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhJDR6M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 13:58:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3CFC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 10:56:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p11so15193058edy.10
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bsqaWzHMB4a27v6lJu41uOUjtIy20isIZX+PhPO6Ck4=;
        b=CRW6niCBkH6bBs1o4sgHkMTt6bMuy29fm7S9qxjkHXiHuEdappQwwQlNfTs0JSrQ+E
         Imr+3zp1YbHKMgZbWKMT69t7unLRVycbjfGIv8G3nYI/R/Ttz+ELl9p+iCTeN4q5k8Gz
         za9wThprV4ATjGErxxd4BNOLSkZ2qYFdpABORbMAGAE0AWmTmycd+Ee120bnjUPLaIgm
         1VCUeTsIQYT+BEFu+vbA2khuZTAdE5cPhyZfb+Du0W078M4g3CdfZHF1GjapLwuW937m
         3IEBuZG305dxCDllmjzXbXBZkoU3XExVX8Kg8HmYVpe7BPk8VWSSPLoKh2NxmbWW+IWo
         GTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bsqaWzHMB4a27v6lJu41uOUjtIy20isIZX+PhPO6Ck4=;
        b=e/E7/hLaFPK/gtaYcxRCxcGRMt+bQ9uWHu/IAO1MVQUTCKZWVCy63yKp6Hl1ccOqNc
         sXEs+kmCnfySAiPXE/+B/2eHBOFUNwLy3wfKxeOYMwXWRPFYeBAuqNfQN+ltW2axPhp2
         xP8j4k84tXbQ6hdAyyBjJL3mOJl8ulLF5OZckoG96Y5hppomU9hFKn96SJWUMemaJUit
         H+S7Uw/LcuQeMyHIBO3OEp9Ob+fF1ooo4bQ5nw97tW2u98ZY7aqD7WREdOp2QdIAVCvZ
         BhUAvz2R8sBBIx2kZYMlMbKh8FcxawbnuXLT52hMr1v09qzUl908SKPAhvetAYBXuv83
         WtYw==
X-Gm-Message-State: AOAM533/vgGQmnBky8u/rJrHsnMsmLS5KeMQVAPVjiTIg0lg6hbNSB0O
        Iw0PvIexPptKc+5xudJ3lGaf7FqWVzrgWQ==
X-Google-Smtp-Source: ABdhPJyjaCQJNGWwrgsPL0gZt9XHJD1Vx6eHwxfJQpxuFcCBkZcbpL91dVZXNCDbmA0G9jjKrlXEKA==
X-Received: by 2002:a50:e085:: with SMTP id f5mr19739843edl.9.1633370181357;
        Mon, 04 Oct 2021 10:56:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n16sm336630edt.59.2021.10.04.10.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:56:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v4 00/10] Fix various issues around removal of
 untracked files/directories
Date:   Mon, 04 Oct 2021 18:08:05 +0200
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
 <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
 <CABPp-BEaJAG=pqyjCR93YUoqj06WwSqjiPENDHjgSTWwzd_C2A@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BEaJAG=pqyjCR93YUoqj06WwSqjiPENDHjgSTWwzd_C2A@mail.gmail.com>
Message-ID: <87bl44n070.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Elijah Newren wrote:

> On Sun, Oct 3, 2021 at 6:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> This is an RFC proposed v4 of Elijah's en/removing-untracked-fixes
>> series[1] based on top of my memory leak fixes in the "unpack-trees" &
>> "dir" APIs[2].
>>
>> As noted in [2] Elijah and I have been having a back & forth about the
>> approach his series takes to fixing memory leaks in those APIs. I
>> think submitting working code is more productive than continuing that
>> point-by-point discussion, so here we are.
>>
>> I've avoided making any changes to this series except those narrowly
>> required to rebase it on top of mine, and to those parts of Elijah's
>> commit messages that became outdated as a result. In particular
>> 3/10[3]'s is significantly changed, as much of its commit message
>> dicusses complexities that have gone away due to my preceding
>> series[2].
>>
>> The "make dir an internal-only struct" has been replaced by a commit
>> that renames that struct member from "dir" to "private_dir". I think
>> even that is unnecessary as argued in [4], but I think the judgement
>> that something must be done to address that is Elijah's design
>> decision, so I did my best to retain it.
>>
>> I did drop the dynamic allocation & it being a pointer, since with my
>> preceding [2] and subsequent unsubmitted memory leak fixes I've got on
>> top having it be embedded in "struct unpack_trees_options" makes
>> things easier to manage.
>>
>> Havingn read through all this code quite thoroughly at this point I do
>> have other comments on it, but I'll reserve those until we've found
>> out what direction we're going forward with vis-a-vis what this will
>> be based on top of.
>>
>> I'm (obviously) hoping for an answer of either on top of my series[2],
>> or alternatively that Elijah's series can stick to introducing the
>> "preserve_ignored" flag, but not change how the memory
>> management/name/type of the embedded "dir" happens (and we could thus
>> proceed in parallel).
>
> ???
>
> This really bothers me.  I'm not quite sure how to put this into
> words, so let me just try my best.  Let me start out by saying that I
> think you often provide good feedback and ideas.  Sure, I sometimes
> don't agree with some of the feedback or ideas, but overall your
> feedback and contributions are definitely valuable.  I also think your
> other series you rebased this on has some good ideas and some good
> bugfixes.  There is something that seems off here, though.

Just for Junio / anyone else following along: let's drop this RFC & the
relateded/proposed "unpack-trees & dir APIs: fix memory
leaks". Point-by-point commentary below (probably not needed/interesting
for those just interested in the state of those two serieses).

> In this particular case, to start with, Junio already said let's take
> v3 as-is[1].  So your series should be rebased on mine, not
> vice-versa.

I understand your annoyance at that, I wouldn't have submitted this if
I'd seen that before, I somehow managed to miss that mail in my mail
queue. I believed the status was at "Will merge to 'next'?" upthread of
[1].

We've then been having an extended back & forth about how to manage
"private" data/structs/leak patterns starting at
https://lore.kernel.org/git/87ilyjviiy.fsf@evledraar.gmail.com/.

At least some of which has been confused by my having quoted a working
but out of context diff from what I ended up submitting as
https://lore.kernel.org/git/cover-00.10-00000000000-20211004T002226Z-avarab=
@gmail.com/

So, sorry about stepping on your toes. I figured having a discussion
with working patches would be more productive, and that it would help
focus on the important changes in your series.

E.g. your 2nd and 3rd patch setup a "dir_clear()" that your 4th
consolidates, which as shown in this series are intermediate steps that
can be skipped. So perhaps there's some added churn, but also reduced
churn in your resulting series on top...

> Further while your other series that you are basing this on has some
> memory leak fixes; to me, it mostly looks like refactorings for
> stylistic code changes. [...]

Are you referring to the s/memset/UNPACK_TREES_OPTIONS_INIT/ bulk change
at the start?

I agree that it's not strictly necessary, but it's pretty much the same
as your earlier eceba532141 (dir: fix problematic API to avoid memory
leaks, 2020-08-18), and makes e.g. a later change you seemed to like
possible:
https://lore.kernel.org/git/CABPp-BFpyyJ-e8p5fbmCvyaEsfUow=3DRP45Nw0ckiwNEv=
VC4zrg@mail.gmail.com/

> Even though some of those stylistic changes
> are good, making a series such as mine that includes bugfixes (to a
> user reported bug no less), after multiple rounds and most reviewers
> are fine with it, suddenly depend on a new big and unrelated treewide
> stylistic refactoring series feels very off to me.  But that doesn't
> quite fully explain my misgivings either; there's a bit more:

[...]

>   * Junio has referred to several of your series as "Meh" and "code
> churn".  That makes me think we'd have a higher than normal chance of
> a user-reported bug ending up blocked on unrelated stylistic changes.
> (Two of them actually, since I have another series depending on this
> one that I've waited to submit until this merges to next.)

I'll stay out of this area for a while. Sorry about that.

> [...]
>   * You misrepresent my changes in multiple ways, including ways I had
> pointed out corrections for in our previous discussions (including
> some of which you acknowledged and agreed with), and you do so even
> after you have rebased my patches and added your signed-off-by to them
> suggesting you ought to be familiar with them[7].

You're absolutely right about that, and the comment starting at "*Sigh*"
in your linked [7] is entirely accurate. I'd like to apologize for that.

If I was in your shoes I'd be *very* annoyed at that chain from [7] to
the upthread cover-letter here making that false claim again.

For what it's worth I do know that your patches aren't allocating the
"struct dir_struct" on the heap, having rebased them etc. But through
some combination of a brainfart and it being late when I wrote that CL
last night I falsely claimed that they did, PBCAK.

What I *meant* to say was some summary that the your series's end state
has a pointer to a dir struct that's dynamically set up v.s. mine of
just initializing it via the macro from the start.

> So, I guess trying to distill what bugs me, I'd say: it seems to me
> that you have ignored what Junio said about taking my series, and then
> you rebased my series on top of unrelated stylistic churn, with that
> churn containing three issues that trigger ongoing misgivings I have
> about the care being put behind these refactorings, especially
> considering their value compared to the features and bugfixes we are
> getting, and you seem to fail to try to understand my changes and
> misrepresent them in the process.  I hope I'm not overreacting but
> something feels wrong to me here.

I don't think you're overreacting, and sorry again. Hopefully it helps
somewhat that I for the "ignoring Junio [and charging ahead with this]"
and the 2nd false claim about about heap allocation I was (believe it or
not) just honestly mistaken instead of trying to get on your nerves.

As some of my early feedback on the whole topic of gitignore
related-shredding/precious etc. should hopefully indicate I'm really
happy that you've picked up this topic.

I thought this would help it along, but that's clearly not the
case. Sorry again.
