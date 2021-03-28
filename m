Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEDDC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13556197C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 15:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhC1PcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhC1Pb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 11:31:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F9BC061756
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:31:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u9so15624243ejj.7
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 08:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:references:user-agent:in-reply-to
         :date:mime-version:content-transfer-encoding;
        bh=4KCrUBHFrYkv3aD7Lo2+Yb+626G66xjq5gkx1U71c7E=;
        b=U1hMJnfdKJrvNE8UucGdJL/P9N1nAEE5kzk1NuO2q5biry/6LzrQ4iC7Xp52hBALqC
         Bp02hEeTfWShwA1cWmi76jJ88UnTA7KJQenufvYRErfDQpJ6U/jJaOV0/MpJ2GesieZU
         yJosW0f/L99zhJSiArh8biP3VedE0DJ+12pRSBwFRVHY2ypbG2m6Dms9pWqFyB+dCi0D
         08yXIyWMO3+fbyO3XNpPvl2G1edICatO1HeHUIoUlHxxWzPyVpeeaeoAYtua+RN13taE
         YQhyQxu3IDneXo/G9L+deObPVomMEIcNXEPG5u1kw8FR9Mk7Csf4qiM/EASABXGGwoT3
         NyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:references
         :user-agent:in-reply-to:date:mime-version:content-transfer-encoding;
        bh=4KCrUBHFrYkv3aD7Lo2+Yb+626G66xjq5gkx1U71c7E=;
        b=ICn4wXQC+8L61k3on7ay9ENhd14O4eSI0T/eQOZG2Kxb/z9tP3PrtBcZ5Dx51Xi79A
         wDIY4wSQ1vYmqyAZwmUATsK0AUFQv2YcrRh/52fPWMq8+GogWvY1O+3rPptkc5By3Pst
         8Hx2xdB8N8iFROziJ3x67PdWzvOppxHVdcr9sgB1cnZNrKpJe4rdk0QG50hNk60jar7G
         uMnzFzQUDPOkYZQ+fRJRfcA8QpElrR77cgj9PmfJqoResG8pKLa6X4MGcQeGInhmKuWJ
         6sTJdFJtq3dv1y+jzR1KDZwwZdtjTmpRLuvgJMWFr1hWPPEybdu9IpPJ+e/Y0Q1ppP4r
         s+hA==
X-Gm-Message-State: AOAM531Aqi3ZlcQRdpX67pjQtVrDyqO/0gd1SPovF8sDRUeSbBWwb9i2
        PlI3cemKs6v7ofLWt/m09c55MFsULxq+Uw==
X-Google-Smtp-Source: ABdhPJz3YJwhXOmi6rEDaezPu2wG4ZAkOq8dGQajYSEnciqQTpjQsLmwR4QDX47XGJPI3whDryPjww==
X-Received: by 2002:a17:906:7150:: with SMTP id z16mr24338300ejj.103.1616945514826;
        Sun, 28 Mar 2021 08:31:54 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bt14sm7477968edb.92.2021.03.28.08.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 08:31:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with --table
Message-ID: <87eeg0ng78.fsf@evledraar.gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
        <87r1k5pcmx.fsf@evledraar.gmail.com>
        <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
        <874kgzq4qi.fsf@evledraar.gmail.com>
        <CABPp-BGRwxn73sntpX8Q5aD-O192RZmOOy_jiU3SQp4-erivtg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CABPp-BGRwxn73sntpX8Q5aD-O192RZmOOy_jiU3SQp4-erivtg@mail.gmail.com>
Date:   Sun, 28 Mar 2021 17:31:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 26 2021, Elijah Newren wrote:

> Hi,
>
> On Wed, Mar 24, 2021 at 8:41 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Wed, Mar 24 2021, Derrick Stolee wrote:
>>
>> > On 3/23/21 9:24 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >>
>> >> On Tue, Mar 23 2021, Derrick Stolee via GitGitGadget wrote:
>> >>
>> >>> From: Derrick Stolee <dstolee@microsoft.com>
>> >>>
> ...
>> >> It's not so much that I still disagree as I feel like I'm missing
>> >> something. I haven't gone through this topic with a fine toothed comb,
>> >> so ...
>> >>
>> >> If and when these patches land and I'm using this nascent sparse
>> >> checkout support why wouldn't I want ls-files or another not-a-test-t=
ool
>> >> to support extracting this new information that's in the index?
>> >>
>> >> That's why I sent the RFC patches at
>> >> https://lore.kernel.org/git/20210317132814.30175-2-avarab@gmail.com/ =
to
>> >> roll this functionality into ls-files.
>> >
>> > And I recommend that you continue to pursue them as an independent
>> > series, but I'm not going to incorporate them into this one. I'm
>> > not going to distract from this internal data structure with changes
>> > to user-facing commands until I think it's ready to use. As the design
>> > document describes the plan, I don't expect this to be something I
>> > will recommend to users until most of "Phase 3" is complete, making
>> > the most common Git commands aware of a sparse index. (I expect to
>> > fast-track a prototype to willing users that covers that functionality
>> > while review continues on the mailing list.)
>>
>> This series is 20 patches. Your current derrickstolee/sparse-index/wip
>> is another 36, and from skimming those patches & your design doc those
>> 56 seem to be partway into Phase I of IV.
>>
>> So at the rate things tend to get reviewed / re-rolled & land in git.git
>> it seems exceedingly likely that we'll have some part-way implementation
>> of this for at least a major release or two. No?
>>
>> Which is why I'm suggesting/asking if we shouldn't have something like
>> this debugging helper as part of installed tooling, because people are
>> going to try it, it's probably going to have bugs and do other weird
>> things, and I'd rather not have to manually build some test-tool to
>> debug some local sparse checkout somewhere.
>
> I'm curious why you feel it's critical that this particular piece of
> debugging machinery needs to be prioritized early and exposed; in
> particular, I'm not sure I follow the "people are going to try it"
> assertion.

The debugging machinery's already there, the question is why we have a
need for duplicating code in-tree.

I just did some cursory review of this topic, and wondered why its tests
couldn't use a builtin instead of (mostly) reinventing the wheel.

It seems to me that the reason for that state is based on a
misunderstanding about what we would and wouldn't add to builtin/*.c,
i.e. that we wouldn't have something like a --debug option, but as
ls-files shows that's not a problem.

So my interest is twofold:

 * Just a comment on "can we avoid this code duplication"

 * The related one of not wanting to re-learn some custom test helper as
   (presumably) we get N number of large patch serieses on this topic,
   if it turns out that we can use an existing well-known tool with
   minimal changes.

> Are you the one who is going to try it or are you going to
> give it to your users?  If so, what do you need out of the debugging
> tool?

I haven't understood the sparse index enough feature enough to know if
anyone would ever want to run this --debug-sparse outside of the test
suite.

Isn't extract info about its internal state going to be useful sooner
than later in the scenarios where you'd care enough to run "ls-files
--stage" now?

Maybe I've misunderstood this feature and it's going to be so
transparent that nobody will ever have any reason to dump how it's
working out of the index...

> You are correct that this will span multiple releases; Stolee already
> said he was planning to be working on this for most of 2021.  But just
> because pieces of the code exist and are shipped doesn't mean it'll be
> announced or supported.  For example, the git-2.30 and git-2.31
> release notes were completely silent about merge-ort.  It existed in
> both releases; in fact, the version that ships in git-2.31, could
> theoretically be used successfully by the vast majority of users for
> their daily workflow.  (But it does have known shortcomings and test
> failures so I definitely did *not* want it to be announced at that
> time.)

Yes, and that's fine. But if you'd been bending over backwards to add
merge-ort to t/helper/ "because it's not ready yet" or something I'd
have probably commented to the effect of "can't we just add it as part
of builtins but not advertise it?" which is what you did :)

>> > Making a change to a builtin is _forever_, and since the only
>> > purpose right now is to expose the data in a test environment, I
>> > don't want to adjust the builtin until either there is a real user
>> > need or the feature has otherwise stabilized. If you want to take on
>> > that responsibility, then please do.
>>
>> That's just not the case, we have plenty of unstable debug-esque options
>> in various built-in commands, in fact ls-files already has a --debug
>> option whose docs say:
>>
>>     This is intended to show as much information as possible for manual
>>     inspection; the exact format may change at any time.
>>
>> It was added in 84974217151 (ls-files: learn a debugging dump format,
>> 2010-07-31) and "just tacks all available data from the cache onto each
>> file's line" so in a way not adjusting it and using it would be a
>> regression, after all this is new data in the cache, so it should print
>> it :)
>>
>> There's also PARSE_OPT_HIDDEN for other such in-tree use. Whatever the
>> sanity/merits of me suggesting that this specific thing be in ls-files
>> instead of a test-helper, it seems far fetched that something like that
>> hidden behind a GIT_TEST_* env var (or hidden option, --debug etc.) is
>> something we'd need to worry about backwards compatibility for.
>>
>> So, whatever you think about the merits of including this functionality
>> in ls-files I think your stance of this being a no-go for adding to the
>> builtin is based on a false premise. It's fine to have
>> unstable/transitory/debug output in the builtins. We just name &
>> document them as such.
>>
>> I also had some feedback in that series and on the earlier iteration
>> that I think is appropriate to be incorporated into a re-roll of this
>> one, which doesn't have anything to do with the question of whether we
>> use ls-files or the helper in the tests. Such as us showing more stuff
>> into the read-cache.c test-tool v.s. splitting it up making that code
>> needlessly convoluted.
>
> Well:
>   * you seem to be strongly opposed to test-read-cache.c containing
> this code (though I don't quite follow why)

See above.

>   * Stolee seems to be strongly opposed to modifying
> builtin/ls-files.c until he has time to think through how builtins
> should work.

As noted above my reading of upthread is that those reasons basically
boil down to not knowing "git ls-files --debug" exists, and that we can
extend it.

> So putting it in another test file that looks slightly duplicative of
> test-read-cache.c might indeed be a good way out of this conundrum.
> :-)

FWIW I think that read-cache.c split is worth doing even if this series
doesn't modify t/helper/read-cache.c.

The "this is for fsmonitor" and "this is for the perf test" use-cases
are (as I think my RFC patch shows) clearer once they're split up.

> (I'm not opposed to any of the three solutions, I'm mostly chiming in
> here because I'm worried about possible bubbling frustration; see
> below.)
>
>> I don't see how recommending that I pursue that as an independent series
>> is productive for anyone. So as you re-roll this I should submit another
>> series on top to refactor your in-flight code & tests?
>
> Your tone suggests some frustration; I have a suspicion there's some
> lack of understanding or misreading that has occurred (perhaps on my
> part too), and before that misunderstanding morphs into motive
> questioning, let me see if I might be able to help...

Honestly more flabbergasted than anything, so I'm trying to clarify what
the author thinks of this direction.

I mean it's fine if it's just a "I don't think this is important and
don't want to spend time on it, but it seems like a good idea", in which
case others have the option of re-rolling some of these patches if they
care (at this point I wouldn't).

Or "this is just a bad idea for XYZ reason", which is also fine, and
even more valuable to document for future work in the area.

But to have another series built on this with refactorings back and
forth before code's landed on master just seems like needless churn.

> So far, you have advocated for:
>   A) Moving the checks to ls-files with a permanent new flag (--sparse)
>   B) Duplicating test-read-cache.c (which is admittedly pretty small)
> and then modifying the duplicate to have the new behavior, or
> alternatively:
>   C) Just stating files to get the information
>   D) Creating new debug option(s) to ls-files so that end users can
> use this in the next few releases before the feature is ready for
> prime time
> You also mentioned you had read just part of the series.
>
> Option D comes with the problem that it's not at all clear who these
> end-users are, why they want the option, or how we should design it. [...]

I think s/advocated/read the series and sent an flow-of-thought
not-ready-for-anything RFC patches on top/ would be more accurate :)

I.e. the A) --sparse thing was just reading the patch and seeing if
ls-files couldn't be made to do this, but yes, having the documented
--sparse interface might not make sense.

we discussed B) above.

C) Was a question to clarify what was meant with stat data, since it's
an offhand comment in the commit message. Does it mean "stat after the
fact" or "this will have a mode like ls-files --debug has now"?

Right now I'm just suggesting with D) that this might be rolled into the
dev-only-not-for-end-users --debug mode.=20

> I'm totally onboard that ls-files should generally have
> the ability to show information in the index (e.g. if there are tree
> entries in addition to blob entries, it should be able to show both),
> but I'm not following the reasoning for why it needs to be there as
> part of the early stages of development of the sparse-index feature
> and who it's supposed to be helping in these next few releases.

We already are extracting the info at this early stage, just with a
custom helper. All I'm suggesting right now is that the motivation for
the custom helper is "this isn't for end users" then surely having a
patch around 1/2 the size to add it to already reviewed/tested ls-files
code under a --debug option makes more sense.

Especially since the upthread commit mentions wanting to incorporate
stat() data. I'm not sure how exactly (there's no outstanding patches,
even on a WIP branch for it, AFAICT), but most likely it's further
duplication of data "ls-files --debug" already spews out.

So the patch would be 1/2 the size, and instead of saying "let's do stat
stuff in the future" it would get it for free.

Or not, part of that's speculation on information that's just in
Stolee's head. Hence this side-discussion.

> [...]

[Cut parts hopefully all clarified with the above comments]

>> [..]
>> At which point you'd be adjusting your tests that expect ls-tree format
>> output to using ls-files output, instead of using ls-files-like output
>> from the beginning?
>
> I don't understand what you're getting at here.  I was the one who
> requested Stolee make the output look like ls-trees in his original
> RFC series, so if there's a problem with this style of output, I'm to
> blame.

I didn't read the RFC series, so I missed that there was past discussion
on this point.

Perhaps something to roll into an updated commit message? My reading of
the current version is that it suggests that the ls-tree-like output is
important to get at the data we need, which my patch-for-discussion
shows isn't the case.

> [...] Once you have different types included in the index, then
> ls-files has to print all the same fields that ls-tree does...so why
> not make it look similar?

I don't have a problem with how the output looks, I happen to like the
ls-tree output better, I've just been suggesting that differing output
=3D=3D code duplication.

In any case. I'm sorry about any comments I've made that came across as
snarky or whatever. Since we're talking in a text-based medium I'm going
to take the reading of a third-party native speaker (you) over mine.

I didn't mean any comments I've made that way, I'm very interested in
seeing this feature land, and just want to try to help it along. Given
the size of this thread over a relatively trivial matter I think that
"help" is probably counterproductive at this point.

I don't think this is criticial or needs to be done or whatever. I've
only kept up this thread for the reasons stated above, i.e. it seeming
to me to be based on the premise that we can't add certain code to
builtin/*.c, and if we can get around that we can make this simpler.
