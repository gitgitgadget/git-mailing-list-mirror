Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B47C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 13:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183DB2463B
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 13:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gntUWlCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKRNc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 08:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgKRNc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 08:32:29 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8057DC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 05:32:28 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id ay21so2015364edb.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=g4aLEruUjj1S59INci/Ts6k/ptjsbq8rBZA6ps/tse4=;
        b=gntUWlCUIoNlT/FQrxGnNuqcnM4lTqWXs1t6mnp4ln9Krpc7T1CH4/K7FGbjUK5vuB
         4T/nWrpJyUzUYrxu/WTZbiEctoa/hB/MpApZeS3RWyDLdhO7PveF72pgwOzpBAauCapP
         Ss1JfLDsxT2ee9evvihPHkk8+Qk/+hgESSTGJUuhihatgIYSITHhqrIxOn/UF2+VpOwO
         xq1Dyik1xmogIJz4XKPzaRAddtL9ZxSsgOVshlOdkwjW1U8160umHaRxXVpXw4D9OIEE
         OhjnPjhnd7+02+Yb6EGO47Li0sS+l7OqYcGrsEDViBoyn8BhhFZFHL9OnwW5KYTN5IVn
         b9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=g4aLEruUjj1S59INci/Ts6k/ptjsbq8rBZA6ps/tse4=;
        b=bZgr4BQ9tPEfB6we7Oj4OwBUWnchK6y8vsU4bqI/2vQXSJzcqPskNeOmUAEoySkiZO
         aqePObwj6r4KTc0uOvYCh2tef57DoQzwxRigwqZ38Ny3+WecdIptLUajqPyQvTsoMTR2
         MWGqP/bDI8gUgGvpcYvlFVTZrQDK6zhIVvODDZKf0tfg/EAfmmkEFb6BmhkDeEjkc80J
         XEE+R4Rp2fgdsb3ABcd4Mrr02ptpDV7Pzkwy1DE8Lscb/ym7ZAKAbZhGrsb5M6rYCDwI
         bL6jfDx1BdAX6EMNQzQXzIEaHWQ02wAaRJhmQQ87rLEjqpwrJ6tLe7zf6eg8CrwxrxCG
         PTYA==
X-Gm-Message-State: AOAM530Ql7bMxCFeHXzMXna8uD6dkahYP4H2XxTbkBAAE3xjrGThI5aN
        oh/sATarfVi4Z8feaJrBupE=
X-Google-Smtp-Source: ABdhPJwb2+O8thyoPBXJm4N7MI3fuo/C4U0upjHmyrhDZ+ulfytSxT5rSo+oMNxxR3Dd3lnsUFyMzg==
X-Received: by 2002:a05:6402:b44:: with SMTP id bx4mr15008748edb.373.1605706346998;
        Wed, 18 Nov 2020 05:32:26 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id u17sm12943791eje.11.2020.11.18.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 05:32:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default branch (sort of)
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet> <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet> <87h7psg6lz.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet>
Date:   Wed, 18 Nov 2020 14:32:25 +0100
Message-ID: <87ima2rdsm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 16 2020, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Sat, 14 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Fri, Nov 13 2020, Johannes Schindelin wrote:
>>
>> > Whatever telemetry I would be able to pull would not be representative,
>> > and I would not be at liberty to share it anyway. So I asked Alex Mull=
ans
>> > of GitHub (who is in charge of the default branch name switch to `main`
>> > there) whether he has any data I could share publicly and he said: "Ac=
ross
>> > GitHub, 1/4 of daily pushes (and growing) go to `main`."
>> >
>> > Seeing as the branch name to be used in newly-created repositories on
>> > GitHub changed only very recently (October 1st, i.e. some 6 weeks ago)=
, I
>> > highly suspect that this number means that _a lot_ of existing projects
>> > have changed their primary branch name to `main`, and seem to be quite
>> > happy with it.
>> >
>> > All this is to say that I consider it unnecessary to have a long
>> > deprecation period or major version bump for this patch series, based =
on
>> > available public data. The name `main` is already in wide-spread use (=
and
>> > growing) as primary branch name of Git projects.
>>
>> [...]
>> I'm on the fence about what we should do in that case, but I'm leaning
>> towards some deprecation period or at least some other approach than a
>> s/master/main/g change precisely because of the numbers you're citing.
>>
>> Because they shows how irrelevant the default shipped with git.git is to
>> users who want this s/master/main/g change in repositories they
>> regularly use. So we're really mostly talking about an impact to scripts
>> & some advanced users, both of who have a pretty good argument for
>> "init"'s default being what's been explicitly documented for ages in its
>> manpage.
>
> I think you have a good point here. It really does not matter _all_ that
> much, yet I still would like to complete the switch to `main` at some
> stage. But as you point out, that point does not _have_ to be now.
>
> As a consequence, I reconsider my stance on "splitting off patch 28". I
> think I will send out a v2 tomorrow, including the fix you suggested for
> t1400 to also rename `naster` to `nain`, and dropping the patch that
> changes the fall-back for `init.defaultBranch` for now.
>
> I _do_ want to complete the transition to using
> `GIT_TEST_DEFAULT_INIT_BRANCH=3Dmain` to address the concern you raised
> elsewhere: a couple of test cases are skipped until that transition is
> complete.
>
> After I send out v2, I will work on that patch that imitates d18c950a69f
> (pull: warn if the user didn't say whether to rebase or to merge,
> 2020-03-09) to show some advice when `init.defaultBranch` is not set.
>
> My current thinking is that we could show this advice for about half a
> year and then make the switch to `main`, continuing to show the advice
> (now adjusted for `main`) for about another half year, and then turn the
> warning off.
>
> What do you think, does that sound too conservative of a plan?

The v2 looks good to me. I just had a suggestion in [1] to apply
something on top to restore the test coverage until while whatever comes
after it lands.

In case I didn't make it clear I have no objection entirely replacing
"master" with "main" in the tests. I just had a practical
concern/question about coverage while it was landing, and a suggestion
of whether perhaps there was an easier/faster way to do the "init"
change first by omitting some of the test churn.

But if you want to do all the legwork that's fine by me :)

I just thought that a sober estimation of how long it takes patches to
land would mean the v1 would be in some in-between state for the next
release.

FWIW I'm not necessarily for some warning. I mainly wanted to attempt to
mediate some of the discussion about the concern to something more
productive.

At the risk of repeating too much of my past overly long E-Mails, but if
I'm being difficult for you when you're submitting patches & causing
work for you I think I owe you an unambiguous explanation for why that
is:

I think some of the people advocating this change can rightly look at
some of the previous E-Mail traffic and see what are at best rants and
at worst some political grandstanding that's at best pretty irrelevant
to any proposed changes in git.git.

But that doesn't mean that there aren't some legitimate concerns. Those
are in my mind separate from the particular political motivations of the
s/master/main/ change, we'd have those with any change to the defaults
in the core tooling.

I think in general with such changes that replies like Theodore Ts'o
here [2] (not picking on him in particular, I just thought it was
representative) reflect a rather insular view of how we need to think
about these sorts of changes.

I.e. a *lot* of git users probably aren't aware that there's even a git
config (they use some 3rd party UI), and I'd say the vast majority are
likely to never find or read any sort of release notes about changes we
make.

Most people's relation to git is like my relation to netcat. It's some
tool I use 1-2 levels down in my stack, and I only bothered to find out
about it because "ssh" stopped working one day.

If at the end of the day we decide to keep something like your original
v1 28/28 patch + docs after some realistic look at the impact that would
be fine by me. Just as long as we understand who we're likely to break
stuff for, and whether it's worth the trade-off.

To Theodore's point about some people's motivations in [2], just to make
my stance/opinion on the end-state clear (so far in all these threads
I've been commenting on the "how" of the incremental transition):

I do 100% agree that the s/master/main/g change of the default should be
made in one form or another. In my mind that doesn't even require a
consideration of the political motivations at this point as far as
git.git is concerned, just:

 1. Major Git hosting providers already made the change

 2. Realistically a lot/majority of git's user base interact with that
    in a major way.

 3. A discrepancy in any default between /usr/bin/git and those
    providers is more confusing than not.

 4. #3 doesn't mean they say "jump" we say "how high" whatever the
    change is.

    But in this case the default is an entirely arbitrary default. Not
    e.g. that they decided to add some ill-thought out header to the
    object format or whatever.

P.S.: Shouldn't the pull patch in d18c950a69f be using the advice
     facility, not warning()?

1. https://public-inbox.org/git/20201118114834.11137-1-avarab@gmail.com/

2. https://public-inbox.org/git/20201115034649.GC3985404@mit.edu/
