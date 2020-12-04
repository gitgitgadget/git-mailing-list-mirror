Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0205EC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D2122CAF
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgLDTXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDTXu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:23:50 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBFEC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 11:23:03 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s27so9169603lfp.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tFyMF29pUE9RhOIMvON9G4RFfA5qez0cNb/IKhXuvTE=;
        b=UGhc2jsSe/elRs1/oCGwnnLcm7HX4KD99/yfUW0NPlXXPSpg3gL5V27J3yTuZmoxlq
         6LSNHjhINDl0Sw6RhRuk7TsXTIJQKZcEKapHk17xhoC1Mb6KzmSulAa5dnVc4t7dPPrJ
         L9Vyo53XhV+GVi8KLzo2eCOquGdalzsERRlLbEqq6IsrWwhIW60d5rNFX3O2daWPA15m
         msSVrn17mpaFX7bSVyseOi5cwHv3xCz9MtyRNDLTfM8gvbsIw6ueKSX8mmuH0Nl5vH31
         MCDC+9Zb08SGhwoz7puDzPQ2PN7mg2Du/7WtZOWVTErXqTW/yQI/pRBvAkf+GXwFcUVs
         EXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=tFyMF29pUE9RhOIMvON9G4RFfA5qez0cNb/IKhXuvTE=;
        b=Akw02mlMCASW1yULdU1grAbpnJy24lMv8vuGlWehaLMXYH2KU9QjkSgLaq4uuXFp6k
         U7QpWLG8NaWQbBap8Gd28TrXNR6wX5TD0YJ+sD/myB0plfTx8B9la6s72T5wZavZOLrr
         8Xh0vvgUXqanY6P596/vXT3Ysu/ENJlmvfEiuSFlkeG6AjaWY3W7q8LAmiWZ2csbNUGi
         bqWZh927MVFjeqd1zrNs5lyfosLA8QeFD/ujXO4Fvn//VZD3gR5Tp+cGKCgokyHOc+5+
         GSu4wQCd1LYqOnKiZOPK/0cXPZjGms3JfHMqO2+y090D9cCSdiv+oCM+SqbFTS96ACsb
         ElLA==
X-Gm-Message-State: AOAM5301JT48mQAzYpeEd6hl0vInWu+0diUoVRBnYfdaTUSo6rIdmWAu
        FsO6oLo0Q/d7aRZzMKziC8Q9Pjhj4RM=
X-Google-Smtp-Source: ABdhPJyN5kt0doD1XOoPuZ2V9HiGHkv/fUII95LmQs1Fk4dCZ6/Kfy5r7MlPTbHDCiDlGDWJaj3Wfg==
X-Received: by 2002:a19:e8a:: with SMTP id 132mr912900lfo.108.1607109781715;
        Fri, 04 Dec 2020 11:23:01 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q5sm2017475ljc.46.2020.12.04.11.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:23:00 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 00/27] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <CABPp-BHdhvLRe4jCSsRtPrbh2=kwJxEQs0Dx+Ng1Vutx8Hdqqw@mail.gmail.com>
        <871rg6hdrk.fsf@osv.gnss.ru>
        <CABPp-BGE4rA5=8NUaK5607moR13bE7PcyVKdbw6nDw5YBeq9bQ@mail.gmail.com>
Date:   Fri, 04 Dec 2020 22:23:00 +0300
In-Reply-To: <CABPp-BGE4rA5=8NUaK5607moR13bE7PcyVKdbw6nDw5YBeq9bQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 3 Dec 2020 12:39:15 -0800")
Message-ID: <87sg8lnzor.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Dec 3, 2020 at 11:48 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Sun, Nov 8, 2020 at 1:43 PM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> These patch series implement new set of options governing the diff output
>> >> of merge commits, all under the umbrella of the single
>> >> --diff-merges=<mode>
>> >> option. Most of the new options being synonyms for -m/-c/--cc options,
>> >> there is also additional functionality provided, allowing to get
>> >> the format
>> >> of "-p --first-parent" without change in history traversal that
>> >> --first-parent option causes.
>> >>
>> >> The net result of these series are the following new options:
>> >>
>> >> --diff-merges=   |  old equivalent
>> >> -----------------+----------------
>> >> first-parent     | --first-parent (only format implications)
>> >> separate         | -m
>> >> combined         | -c
>> >> dense-combined   | --cc
>> >
>> > Interesting.  I have some local patches implementing another choice,
>> > with the new flag --remerge-diff.  This flag will cause `git show` or
>> > `git log` to automatically remerge the two parents in a 2-parent merge
>> > commit, and then diff the merge commit against that automatic merge,
>> > showing the result.  Thus, the diff for a merge commit is likely to be
>> > empty if the merge was clean, and is likely to show the removal of
>> > conflict markers if the merge was not clean.
>> >
>> > I'm curious how it'd interact with this new option.  Would it also get
>> > a name, e.g. --diff-merges=remerge-diff?  Feels like a mouthful, but I
>> > can't come up with anything better.
>>
>> Maybe, --diff-merges=remerge?
>>
>> >
>> > Also, I'm curious how it'd interact with another option I added, named
>> > --remerge-diff-only.  This latter option modifies revision traversal
>> > in that it skips octopus merges, root commits, and single parent
>> > commits IF no cherry-pick or revert information can be found.  If it
>> > finds a 2-parent merge commit, it behaves like --remerge-diff.  If it
>> > finds a 1-parent commit with cherry-pick or revert information, it'll
>> > do an in memory repeat of that cherry-pick (or revert) and then diff
>> > the actual commit against what the automatic cherry-pick would
>> > perform.  Again, that likely means an empty diff if the automatic
>> > cherry-pick was clean, and showing any changes made by the user to
>> > complete the original cherry-pick (such as deleting conflict markers
>> > and picking which chunks from which side to keep) if the automatic
>> > cherry-pick was not clean.  (I suspect --remerge-diff-only is much
>> > more likely to be used with `git show` than with `git log`.)  Anyway,
>> > your changes seem to suggest that anything relating to how diffs for
>> > merges are handled should be documented in the same section, but
>> > --remerge-diff-only doesn't fit.  And it'd seem odd to have
>> > --remerge-diff and --remerge-diff-only not show up in adjacently but
>> > be split into separate sections.  Any ideas?
>>
>> Sounds like commits limiting option to me. I think it could be named by
>> its limiting behavior only, say, --remerges. Then it will imply
>> --diff-merges=remerge, that'd allow user to re-define diff format if she
>> needs to.
>
> It is commit limiting, but the focus is more on the behavioral change
> in how diffs are shown:
>   * for 2-parent merges
>   * for single-parent commits with cherry-pick or revert information
> and acknowledging that since it has _altered_ the normal way of
> showing diffs for a number of single-parent commits, that it'd be
> confusing to show normal diffs of unaffected commits (how would you be
> able to tell what type of diff you're looking at if both appear in the
> log?).  Thus, it does commit limiting to only select commits which
> will make use of the new diff type.

That's how you currently look at it.

For me it looks like pure commit limiting with these criteria might be
useful by itself, and with my suggestion one could then achieve it
using, say:

--remerge-diff-only --diff-merges=off

>
> (I suspect it will be more common for folks to use the
> --remerge-diff-only option, or whatever we end up calling it, with
> `git show` where the commit limiting doesn't matter -- but I have used
> it with log to go looking for "evil" reverts/cherry-picks that might
> have occurred in history.)

What you describe is complex enough to doubt it could be entirely
described by option name, so shorter --evils might be better choice
in this case.

Overall, if you add --diff-merges=remerge as a new diff format, and then
--evils that implies the former, then it seems like all possible
use-cases will be covered, and you have short option name for the most
useful case.

-- Sergey Organov
