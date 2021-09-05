Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A3C433FE
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1767F60F6D
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 07:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhIEHpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhIEHpm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 03:45:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A2C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 00:44:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e21so6809696ejz.12
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 00:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BwEgtxEjxDTIMuenzx4yttJZvF3npjvhxj3pLuxnjoE=;
        b=PZlpw9i7hBQi2x6jXXO2usOxJlL7tK8bjvkf3elnD9u/rk0yTjdUepandowaEDDfbE
         kk3RD/GOc/TS3M5SrMlnkSJR/s67yEpnOcA5Xvwgv0pvINeZWqgmnBqzl6JDr6m9jNP+
         ykqAG/GqwVdsdjug81Cmu4so49IHu/xg9VKirLXY647/cAAvLkqiflNqR8ojhbG2BeyB
         PSqjbjNeIUl8pB/NC3EuHlX6rMY/w4D/lp6b90c6LXUlX7AJfv+VeT0ceLSp/6Q7vvlz
         e5YfHB3M2mbcGTKbSa8O8ZKOV/7lOKtk+xZ/6dIWvL7n2rUd1B3SbWESRESzLER9yopk
         8OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BwEgtxEjxDTIMuenzx4yttJZvF3npjvhxj3pLuxnjoE=;
        b=C6ltuF6cwaLvc4XbpfwD7nF3fmeGnMm1gfnJaT+Q3hm0KMVdjjypQedHL5Xc9GCiHL
         Qpdc+GSr7pL2G8f++9Lw3RLrfin9i2rKjyAIUDgrAy+R/dcsw1eesDC/eER72VHDr6mE
         TjvlTpSDPjFk7Gul+T+9mdGz19PyLq+R4CzegUPepU/n6QTm7R7epxA8BgjpMV/EXEaY
         AJ+Q007cRPSyYbtfdtpofI5h50kJaOjobuyiXvx73KHsHhxt59cgGrAlAQ8L+/s9Jb+B
         YchUZSM7F8dKR3yhLVSk7KxaNaIuGEns61Hx+RzAqR0/ESXxes/lLy3Ef6SyhmvmkL0j
         EHxg==
X-Gm-Message-State: AOAM5319MzDw8D9yt6IRor9GzzF9CKO7C3CHvRR9B9LqgmhJoPeuj3VB
        kABPArezqGL9du/v4nyF/LE=
X-Google-Smtp-Source: ABdhPJxKT4ievkr7LIaxcvbs+cNoAA16Q2tU6dvHI8eOCI530Ul1PgqDQZY72nUT7wIHxlueBjBDnQ==
X-Received: by 2002:a17:906:fa10:: with SMTP id lo16mr7542782ejb.342.1630827877586;
        Sun, 05 Sep 2021 00:44:37 -0700 (PDT)
Received: from evledraar (2a02-a45a-de66-1-2cbc-c868-da6a-49d1.fixed6.kpn.net. [2a02:a45a:de66:1:2cbc:c868:da6a:49d1])
        by smtp.gmail.com with ESMTPSA id d22sm1991680ejk.5.2021.09.05.00.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 00:44:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
Date:   Sun, 05 Sep 2021 09:43:08 +0200
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com>
 <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net>
 <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
 <YTNH2vMPuEW4SBMo@coredump.intra.peff.net>
 <CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKxJDXQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKxJDXQ@mail.gmail.com>
Message-ID: <87sfyjpiu3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 04 2021, Elijah Newren wrote:

> On Sat, Sep 4, 2021 at 3:19 AM Jeff King <peff@peff.net> wrote:
>>
>> On Sat, Sep 04, 2021 at 11:51:19AM +0200, Fedor Biryukov wrote:
>>
>> > There is no way this could be the intended behavior, but the good news
>> > is that I cannot reproduce it...
>> > Looks like it occurs only in one git version (2.31.0.windows.1, IIRC).
>> > And it does not occur in the latest git version: git version 2.33.0.windows.2.
>>
>> I think it is a bug, and it seems to reproduce easily for me (with both
>> the current tip of master, and with v2.33.0). Here's the recipe you
>> showed, with a little debugging at the end:
>>
>>   set -x
>>   git init repo
>>   cd repo
>>   git commit -m base --allow-empty
>>   git checkout -b feat
>>   echo feat >readme.txt
>>   git add readme.txt
>>   git commit -m txt=feat
>>   git checkout main
>>   echo precious >readme.txt
>>
>>   cat readme.txt
>>   git checkout feat
>>   cat readme.txt
>>   git rebase main feat
>>   cat readme.txt
>>
>> This produces:
>>
>>   + cat readme.txt
>>   precious
>>   + git checkout feat
>>   error: The following untracked working tree files would be overwritten by checkout:
>>         readme.txt
>>   Please move or remove them before you switch branches.
>>   Aborting
>>   + cat readme.txt
>>   precious
>>   + git rebase main feat
>>   Current branch feat is up to date.
>>   + cat readme.txt
>>   feat
>>
>> So git-checkout was not willing to overwrite the untracked content, but
>> rebase was happy to obliterate it.
>>
>> It does the right thing in very old versions. Bisecting, it looks like
>> the problem arrived in 5541bd5b8f (rebase: default to using the builtin
>> rebase, 2018-08-08). So the bug is in the conversion from the legacy
>> shell script to C (which makes sense; the shell version was just calling
>> "git checkout", which we know does the right thing).
>>
>> -Peff
>
> Turns out this is quite a mess.  It's also related to the "don't
> remove empty working directories" discussion we had earlier this
> week[1], because we assumed all relevant codepaths correctly avoided
> deleting untracked files and directories in the way.  But they don't.
> And rebase isn't the only offender, because this is buried in
> unpack_trees.  In fact, it traces back to (and before)
>     fcc387db9b ("read-tree -m -u: do not overwrite or remove untracked
> working tree files.", 2006-05-17)
> which has additional commentary over at
> https://lore.kernel.org/git/7v8xp1jc9h.fsf_-_@assigned-by-dhcp.cox.net/.
> It appears that before this time, git happily nuked untracked files
> and considered them expendable, in basically all cases.  However, this
> patch continued considering them as expendable whenever opts->reset
> was true.  There wasn't much comment about it at the time for the
> reasoning of how opts->reset was handled, though trying to read
> between the lines perhaps Junio was trying to limit the backward
> compatibility concerns of introducing new errors to fewer code paths?
> Anyway, Junio did mention `read-tree --reset` explicitly, but this
> opts->reset usage also occurs in am, checkout, reset -- and anything
> that calls the reset_head() function including: rebase, stash,
> sequencer.c, and add-patch.c.
>
> So, then...should we preserve untracked (and non-ignored) files in all
> these cases?  This rebase case seems clear, but others might be less
> clear.  For example, should "git reset --hard" nuke untracked files
> (what if it's a directory of untracked files getting nuked just to
> place a single file in the location of the directory)?  The
> documentation isn't explicit, but after reading it I would assume that
> untracked files should be preserved.  Since we've had bugs in "git
> reset --hard" before, such as requiring two invocations in order to
> clear out unmerged entries (see [2] and [3]), that also suggests that
> this is just another bug in the same area.  But the bug has been
> around so long that people might be expecting it; our testsuite has
> several cases that incidentally do.  Granted, it's better to throw an
> error and require explicit extra steps than to nuke potentially
> important work, but some folks might be unhappy with a change here.
> Similarly with "git checkout -f".
>
> And stash.c, which operates in that edge case area has tests with
> files nuked from the cache without nuking it from the working tree
> (causing the working tree file to be considered untracked), and then
> attempts to have multiple tests operate on that kind of case.  Those
> cases look a bit buggy to me for other reasons (I'm still digging),
> but those bugs are kind of hidden by the untracked file nuking bugs,
> so fixing the latter requires fixing the former.  And stash.c is a
> mess of shelling out to subcommands.  Ick.
>
> I have some partial patches, but don't know if I'll have anything to
> post until I figure out the stash mess...

I'd just like to applaud this effort, and also suggest that the most
useful result of any such findings would be for us to produce some new
test in t/ showing these various cases of nuking/clobbering and other
"non-precious" edge cases in this logic. See[1] and its linked [2] for
references to some of the past discussions around these cases.

1. https://lore.kernel.org/git/87a6q9kacx.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87ftsi68ke.fsf@evledraar.gmail.com/

> [1] https://lore.kernel.org/git/YS8eEtwQvF7TaLCb@coredump.intra.peff.net/
> [2] 25c200a700 ("t1015: demonstrate directory/file conflict recovery
> failures", 2018-07-31)
> [3] ad3762042a ("read-cache: fix directory/file conflict handling in
> read_index_unmerged()", 2018-07-31)

