Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D855C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 12:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbiC1MRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 08:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiC1MRg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 08:17:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C1E4C43E
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 05:15:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x34so16648044ede.8
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=O0qqzouii+04zyqx3FElxcC+e/FOl44zE+iEALHTScc=;
        b=GAmi6VQEA1lx4Iszm04TBD7IWd7Dq/gziV5PXSt0HVOrUVFuatNx54npkEze17VegM
         DRun05d34GEUbN92X1o061p0Zf5p/29X7n8uyNMTEh4ADn9bJemV8+ZQiqYON8t0Q5MB
         mqF6DGvWN1yMztv7X+b3/nWT8TxTeBuwceXqnh+BXvb8xgKFIEOABRRUKQYn3gUGt87H
         1s7monLFC0M8Ej6N9cUOHs3JkwqHm45qIrvwKmIOjdNTui/3QEgZ+ge1PNoQ1+/UYM2k
         K9R991S0RAHmeTMK2bXB5AHgI8AZ7XMwHnQO9wevzkMvRlOSG9ee5USHdEKAz2veerZO
         TTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=O0qqzouii+04zyqx3FElxcC+e/FOl44zE+iEALHTScc=;
        b=3IZaWeOI6znhnlzHSqWMHYL0dV4KFwHK+zioNtePI0F9IYM21OrtI7mCQEJxbfKc3t
         nGKrbXMRtrGgyiFl5BVaZb72IbLG2ENE7h8M/KOpxaEEotgJiqCIf4hIpgt/jOXS43sa
         qjyLu5/cn3iUI8vY0nILY+83CHUdJ2IJ0DhJdOqM9cMgvtzgSeh0C0aFLSpEHwg4e4BR
         2CWaGwbaAQzAOmN6gE8sNn0CqBC2FUAW5KTwmI2vEStuyBz/MgyAMBfFb+3imWK1EmjX
         B4ieNPATzwsDyrn+gr/tYvGzvXH9g66MpHhaRCYl1ihs+lSeofXsmfarMehzqnctdXl5
         9euw==
X-Gm-Message-State: AOAM531il6RoJnBDIkxKKLoAKG02bSNjnFB7UM4j0biK8QKGTQ1am71W
        SJISRZjfZ58PJl8sl6liTcQ=
X-Google-Smtp-Source: ABdhPJzKbxamS07t7aZXzc/5j1sWbwZ1hWBgceztrVZQxwAUdwPqi5Oh0GVAPda+NHJTJ0aLsQYDRQ==
X-Received: by 2002:a05:6402:274b:b0:419:3e55:7690 with SMTP id z11-20020a056402274b00b004193e557690mr16011255edd.315.1648469753139;
        Mon, 28 Mar 2022 05:15:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090606c200b006a728f4a9bcsm5893346ejb.148.2022.03.28.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 05:15:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nYoHn-003Dmy-Mz;
        Mon, 28 Mar 2022 14:15:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        'Eric Wong' <e@80x24.org>
Subject: Re: do we have too much fsync() configuration in 'next'? (was:
 [PATCH v7] core.fsync: documentation and user-friendly aggregate options)
Date:   Mon, 28 Mar 2022 13:25:02 +0200
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
        <20220315191245.17990-1-neerajsi@microsoft.com>
        <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
        <CANQDOdeeP8opTQj-j_j3=KnU99nYTnNYhyQmAojj=FZtZEkCZQ@mail.gmail.com>
        <220326.86ils1lfho.gmgdl@evledraar.gmail.com>
        <CANQDOdeduc8bFA_=R-kXmkM+nb__oTxVhjBfFYj70vCFew1EyA@mail.gmail.com>
        <220326.86sfr4k9rm.gmgdl@evledraar.gmail.com>
        <CANQDOdfWh5aO9cuJVuUccKyD9Cj+NndisokiewBH9Sq4oSUp5A@mail.gmail.com>
        <220327.86y20veeua.gmgdl@evledraar.gmail.com> <YkGUeQH4y1KIAdCc@ncase>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <YkGUeQH4y1KIAdCc@ncase>
Message-ID: <220328.86pmm6e0i0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 28 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> On Sun, Mar 27, 2022 at 02:43:48PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Sat, Mar 26 2022, Neeraj Singh wrote:
>>=20
>> > On Sat, Mar 26, 2022 at 8:34 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >>
>> >>
>> >> On Fri, Mar 25 2022, Neeraj Singh wrote:
>> >>
>> >> > On Fri, Mar 25, 2022 at 5:33 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
>> >> > <avarab@gmail.com> wrote:
>> [...]
>> >> > I want to make a comment about the Index here.  Syncing the index is
>> >> > strictly required for the "added" level of consistency, so that we
>> >> > don't lose stuff that leaves the work tree but is staged.  But my
>> >> > Windows enlistment has an index that's 266MB, which would be painful
>> >> > to sync even with all the optimizations.  Maybe with split-index, t=
his
>> >> > wouldn't be so bad, but I just wanted to call out that some advanced
>> >> > users may really care about the configurability.
>> >>
>> >> So for that use-case you'd like to fsync the loose objects (if any), =
but
>> >> not the index? So the FS will "flush" up to the index, and then queue
>> >> the index for later syncing to platter?
>> >>
>> >>
>> >> But even in that case don't the settings need to be tied to one anoth=
er,
>> >> because in the method=3Dbulk sync=3Dindex && sync=3D!loose case would=
n't we be
>> >> syncing "loose" in any case?
>> >>
>> >> > As Git's various database implementations improve, the fsync stuff
>> >> > will hopefully be more optimal and self-tuning.  But as that happen=
s,
>> >> > Git could just start ignoring settings that lose meaning without ty=
ing
>> >> > anyones hands.
>> >>
>> >> Yeah that would alleviate most of my concerns here, but the docs aren=
't
>> >> saying anything like that. Since you added them & they just landed, do
>> >> you mind doing a small follow-up where we e.g. say that these new
>> >> settings are "EXPERIMENTAL" or whatever, and subject to drastic chang=
e?
>> >
>> > The doc is already pretty prescriptive.  It has this line at the end
>> > of the first  paragraph:
>> > "Unless you
>> > have special requirements, it is recommended that you leave
>> > this option empty or pick one of `committed`, `added`,
>> > or `all`."
>> >
>> > Those values are already designed to change as Git changes.
>>=20
>> I'm referring to the documentation as it stands not being marked as
>> experimental in the sense that we might decide to re-do this to a large
>> extent, i.e. something like the diff I suggested upthread in
>> https://lore.kernel.org/git/220323.86fsn8ohg8.gmgdl@evledraar.gmail.com/
>>=20
>> So yes, I agree that it e.g. clearly states that you can add a new
>> core.git=3Dfoobar or whatever down the line, but it clearly doesn't
>> suggest that e.g. core.fsync might have boolean semantics in some later
>> version, or that the rest might simply be ignored, even if that
>> e.g. means that we wouldn't sync loose objects on
>> core.fsync=3Dloose-object, as we'd just warn with a "we don't provide th=
is
>> anymore".
>>=20
>> Or do you disagree with that? IOW I mean that we'd do something like
>> this, either in docs or code:
>>=20
>> diff --git a/config.c b/config.c
>> index 3c9b6b589ab..94548566073 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1675,6 +1675,9 @@ static int git_default_core_config(const char *var=
, const char *value, void *cb)
>>  	}
>>=20=20
>>  	if (!strcmp(var, "core.fsync")) {
>> +		if (!the_repository->settings.feature_experimental)
>> +			warning(_("the '%s' configuration option is EXPERIMENTAL. opt-in to =
use it with feature.experimental=3Dtrue"),
>> +				var);
>>  		if (!value)
>>  			return config_error_nonbool(var);
>>  		fsync_components =3D parse_fsync_components(var, value);
>> @@ -1682,6 +1685,9 @@ static int git_default_core_config(const char *var=
, const char *value, void *cb)
>>  	}
>>=20=20
>>  	if (!strcmp(var, "core.fsyncmethod")) {
>> +		if (!the_repository->settings.feature_experimental)
>> +			warning(_("the '%s' configuration option is EXPERIMENTAL. opt-in to =
use it with feature.experimental=3Dtrue"),
>> +				var);
>>  		if (!value)
>>  			return config_error_nonbool(var);
>>  		if (!strcmp(value, "fsync"))
>
> Let's please not tie this to `feature.experimental=3Dtrue`. Setting that
> option has unintended sideeffects and will also change defaults which we
> may not want to have in production. I don't mind adding a warning in the
> docs though that the specific items which can be configured may be
> subject to change in the future.

Yes, that was a bad (throwaway) idea. I think probably any sort of
warning is over-doing it, but having the same in the docs would be good,
as in:

    git gre EXPERIMENTAL -- Documentation

> At GitLab, we've got a three-step plan:
>
>     1. We need to migrate to `core.fsync` in the first place. In order
>        to not migrate and change behaviour at the same point in time we
>        already benefit from the fine-grainedness of this config because
>        we can simply say `core.fsync=3Dloose-objects` and have the same
>        behaviour as before with `core.fsyncLooseObjects=3Dtrue`.

*nod*.

>     2. We'll want to enable syncing of packfiles, which I think wasn't
>        previously covered by `core.fsyncLooseobjects`.

We've always fsynced packfiles and other things that use the
finalize_hashfile() API. I.e. the pack metadata (idx,midx,bitmap etc.),
commit-graph etc.

Which is one thing I find a bit uncomfortable about the proposed config
schema, i.e. it's allowing *granular* unsafe behavior we didn't allow
before.

I think we *should* allow disabling fsync() entirely via:

    core.fsync=3Dfalse

Per Eric Wong's [added to CC] proposal here:
https://lore.kernel.org/git/20211028002102.19384-1-e@80x24.org/; I think
that's useful for e.g. running git in CI, one off scripted mass-imports
where you run "sync(1)" after (or not...).

But I don't really see the use-case for turning off say "index" or
"pack-metadata", but otherwise keeping the default fsync().

>     3. We'll add `refs` to also sync loose refs to disk.

Maybe I'm reading this wrong, but AFAICT if you upgrade from pre-v2.36.0
to v2.36.0 you'll have no way to do fsync()-ing as it was done before
with your bc22d845c43 (core.fsync: new option to harden references,
2022-03-11).

I.e. I first thought you meant to start with:

    core.fsync=3D-loose-objects
    core.fsync=3D-reference

And then remove that "core.fsync=3D-reference" line to get the behavior
that'll be new in v2.36.0, but that won't do that. The new "reference"
category doesn't just affect loose refs, but all ref updates.

So we don't have any way to move to v2.36.0 and get exactly the fsync()
behavior we did before, or have I misread the code?

Now, I don't think we need it to be configurable at all.

I.e. I think your is a bc22d845c43 good change, but it feels weird to
make it and leave the default of core.fsyncLooseObjects=3Dfalse on the
table. I.e. what you're summarizing there is true, but it's also true of
the loose objects.

To the extent that we've had any reason at all not to sync those by
default (which has really mostly been "we didn't re-visit it for a
while") it's been performance.

And both loose refs & loose objects will suffer from the same
degradation in performance from many fsync()'s.

IOW I think it's perfectly fine not to add a config knob for it other
than core.fsync=3Dfalse, and VERY SOON turn on
core.fsyncLooseobjects=3Dtrue, especially if we can get most of the
performance benefits with the "bulk" mode.

But why half-way with bc22d845c43? I mean, *that change* should be
narrow, but in terms of where we go next what do you think of the above?

> So while the end result will be the same as `committed`, having this
> level of control helps us to assess the impact in a nicer way by being
> able to do this step by step with feature flags.

*Nod*, although leaving aside the new syncing of loose refs the plan you
 outlined above could be done with the proposal of the simpler:

    core.fsync=3Dtrue
    core.fsyncLooseObjects=3Dfalse

> On the other hand, many of the other parts we don't really care about.
> Auxiliary metadata like the commit-graph or pack indices are data that
> can in the worst case be regenerated by us, so it's not clear to me
> whether it makes to also enable fsyncing those in production.

I'm not familiar with all of those in detail, i.e. how we behave
specifically in the face of them being corrupt.

The commit-graph I am, we *should* recover "gracefully" there, but you
might have an incident shortly there after due to "for-each-ref
--contains" slowdowns by 1000x or whatever.

For e.g. *.idx we'd be hosed until manual recovery.

So I think those area all in the same bucket as core.fsync=3Dfalse, and
that we don't need the granularity.

> So altogether, I agree with Neeraj: having the fine-grainedness greatly
> helps us to roll out changes like this and be able to pick what we deem
> to be important. Personally I would be fine with explicitly pointing out
> that there are two groups of this config in our docs though:

Yes, that's fair. But pending replies to the above I think the main
point & proposal of us having too much config stands. I.e. depending on
what you want to do with loose object refs we'd just need this:

    core.fsync=3D[<bool>] # true by default
    core.fsyncLooseObjects=3D[<bool>] # false by default
    core.fsyncLooseRefs=3D[<bool>] # true by default?

And then the "bulk" config, which would be orthagonal to this.

I.e. do we really have a use-case for the rest of the kitchen sink?

>     1. The "porcelain" group: "committed", "added", "all", "none". These
>        are abstract groups whose behaviour should adapt as we change
>        implementations, and are those that should typically be set by a
>        user, if intended.
>
>     2. The "plumbing" or "expert" group: these are fine-grained options
>        which shouldn't typically be used by Git users. They still have
>        merit though in hosting environments, where requirements are
>        typically a lot more specific.
>
> We may also provide different guarantees for both groups. The first one
> should definitely be stable, but we might state that the second group is
> subject to change in the future.

I hope we can work something out :)

Overall: I think you've left one of the the main things I brought up[1]
unaddressed, i.e. that the core.fsync config schema in its current form
assumes that we can sync A or B, and configure those separately.

Which AFAIKT is because Neeraj's initial implementation & the discussion
was focused on finishing A or B with a per-"group" "cookie" to flush the
files.

But as [2] shows it's more performant for us to simply defer the fsync
of A until the committing of B.

Which is the main reason I think we should be re-visiting this. Sure, if
we were just syncing A, B or C having per-[ABC] config options might be
a bit overdoing it, but would be relatively simple.

But once we start using a more optimized version of the "bulk" mode the
config schema will be making promises about individual steps in a
transaction that I think we'll want to leave opaque, and only promise
that when git returns it will have synced all the relevant assets as
efficiently as possible.

1. https://lore.kernel.org/git/220323.86fsn8ohg8.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/RFC-patch-v2-4.7-61f4f3d7ef4-20220323T140753=
Z-avarab@gmail.com/
