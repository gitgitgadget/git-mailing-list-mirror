Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BFFC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 23:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6862225D
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 23:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBZYLAkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKMXtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 18:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKMXtc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 18:49:32 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AACC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 15:49:31 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id cq7so12780318edb.4
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 15:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=iUVtwKzEanoZ/MCRmEvvLQWK8z4fhUWPi5CV+w7z3xs=;
        b=HBZYLAknGrGvxtLbPMv+hyUYEaAWXlT43jaiJaAnaG/0NhQgNyYxfD3Z96go8PM6Mt
         miqbabSIWAWkocrbIIFE+3sUvy2OHCsOxbJ0gisT7Cm32/1aAVGQU0jjgIgatxZROiob
         eQ09qpfkCPKgcl8kf0qmor4dUOLEw1MeWBWz+s2iBtVBTfcYynyzIUXS0FAXAbBF86mk
         ZvfBy2FWrErLMgdGPleJHXeNPtUvk80y4OiU11OZkBrPGDs4Q9PV69cFRUqpGGeNklFO
         oqzwHz5i3lvE0L9xHFLRTF3ZAhu+Nm0/D36kglR9FBuQVwjJjGh0E/5AN6F3gaar6uII
         t2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=iUVtwKzEanoZ/MCRmEvvLQWK8z4fhUWPi5CV+w7z3xs=;
        b=pHSQAvh1u59Q4LH8xQ9GmiXChx7jrdswhiyi3xP+aMCdj6AHWKA0PLMXjTrI6JANvl
         1G69oqiQfODELdMiVyBqzrUVFMmceN1EWYXd61/KgCT2rXBSbY1vF8BBu/CnIapLQFcq
         IyOUZvVTRTvh8Vc2xC9tmj4yPA0MMt4v+wO5nnhF/QeXuzJJHOgZAl9/lo2ZSZshqNHu
         oZfhf0oFNBp+QA1aYhUOdUrfy7QXx8m0iSbecM2+Ij+2sCIpYq2e8RAyTn+u4UIrhOcf
         PPMixyh7IQtnBkAvuIHslNtA/CRZA6cBt+p/HZIRnn+LQo1c2jYwU9jbmgm+l5A4bgxp
         01iQ==
X-Gm-Message-State: AOAM532dMKaCN7aYwPYXunz74W9RpJ3LZR3IuaDZK4vLHXJ8csoTB2Ag
        x76vrCXhyAI5eARs5Zcod3o=
X-Google-Smtp-Source: ABdhPJxCP6s5Qnpev9nzGwbeLFZ2gor2DfgtyCAWiwTuYqC9eX/xzMZUEW4x7PuaJ9t6DAzlRcoJSg==
X-Received: by 2002:a05:6402:c8d:: with SMTP id cm13mr4984039edb.340.1605311370257;
        Fri, 13 Nov 2020 15:49:30 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id a17sm5152828eda.45.2020.11.13.15.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 15:49:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default branch (sort of)
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
        <20201113161320.16458-1-avarab@gmail.com>
        <20201113191418.GA764688@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet>
Date:   Sat, 14 Nov 2020 00:49:28 +0100
Message-ID: <87h7psg6lz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 13 2020, Johannes Schindelin wrote:

> Hi Peff and =C3=86var,
>
> On Fri, 13 Nov 2020, Jeff King wrote:
>
>> On Fri, Nov 13, 2020 at 05:13:20PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>> >  * A lot of tests (but a small minority of the total) have master
>> >    "master" hardcoded in some way. We now inventory them in
>> >    tests-that-need-master.txt, we can still remove the names from that
>> >    file and manually change the code later, but this accomplishes a
>> >    clean test run with a relatively easy-to-review diff.
>> >
>> >    We ignore GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3D<name> when it com=
es
>> >    to these files, unless
>> >    GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME_HARDER=3Dtrue is set.
>>
>> I'm confused how this is better. We could just be setting
>> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME at the top of those files, couldn't
>> we? (Likewise, I think annotating individual scripts is more
>> decentralized than a magic pattern in test-lib.sh, though it amounts to
>> the same thing).
>
> I considered this alternative very briefly, and rejected it immediately
> because it would have implied a drawn-out limbo where the test suite will
> be inconsistent. That's not what I want.
>
>> And if I understand the current state of Dscho's patches, we don't
>> _have_ to convert any tests right now. We could just annotate those
>> scripts which are not yet converted to have them use the old name.
>
> And that's what I did in some cases, see e.g. 5d5f4ea30de (t5411: finish
> preparing for `main` being the default branch name, 2020-10-31).
>
> It's just quite a ton of work to do this for all the affected test
> scripts, and I wanted to automate as much as possible of that process so
> that it'll be easier to cope with all the other topics that are in flight.
>
> Therefore, I opted to "annotate the scripts" via a `case` in
> `test-lib.sh`. It should be quite a bit easier to understand, too, for the
> occasional reader, as it shows you the complete range of scripts that have
> been handled so far.
>
>> But I don't think we want to live in that state indefinitely. It's
>> slightly annoying to have inconsistent naming within the tests. I'd be
>> happy to switch individual tests at a leisurely pace over the next
>> couple of months or whatever. But since Dscho has bothered to write all
>> of the patches now, why not use them?
>
> Yep, I am a bit puzzled why we need to consider other approaches. I would
> have thought that the more pressing issue is to verify that I
>
> 1) caught all the necessary conversions,
>
> 2) did not miss any non-trivial adjustments (such as `naster` and aligned
>    comments).
>
> At the same time, I am quite thankful for all the help =C3=86var provided;
> mentioning that I missed `naster` in t1400 was definitely super helpful.

Not being up-to-date on this whole s/master/main/g discussion, is the
context here that we've essentially pre-approved these patches & doc for
integration into the next release? If so I really don't mind doing it
this way.

I started poking at this because I noticed that on git.git's master
branch tests were being skipped due to PREPARE_FOR_MAIN_BRANCH, so it's
in some in-between state between patch serieses.

We're now in week 4/9 of a release cycle for 2.30 (or 3.00 or
whatever). I hope the one thing people for & against this master/main
change can agree on is that it would be bad to ship a git with an
incomplete migration to "main", e.g. the 28/28 patch here which changes
it but without any doc updates.

I may be reading this wrong, but it seems
pr-762/dscho/use-main-as-default-branch-name-v1...remotes/dscho/inclusive-n=
aming
(which I'm assuming is what's left) is another ~30k line diff on top of
this ~25k one.

So yes I'm very late to the discussion, sorry about that. I'm just
chiming in to say that if we're doing this as part of our regular patch
review front-loading these massive search/replace changes seems to be
too much of a change for one cycle.

But if Junio's going to chime in to say he's applying it all I don't
care & don't have any concern about it.

>> I'm much more concerned about the lack of documentation changes
>> associated with the final patch. We don't necessarily need to eradicate
>> every mention of "master" from the documentation, but I think we do need
>> to make sure that examples and instructions are consistent with how Git
>> will actually behave. And that does need to happen at the same time as
>> the user-visible flip of the default.
>
> I am sorry. This is totally my fault. I should have described this much
> better in the cover letter. This patch series deliberately omits all the

Ditto in my hastily-written RFC commit message. A better summary is:

 * Yours: All tests depend on master changed to all tests depend on main
 * Mine (well, partway there): You can set $ANY_NAME for the branch, but
   we blacklist some as being hardcoded on <name> (which I just left at
   master).

   This means we can test e.g. non-ASCII default branch names. It seems
   better to me if we're going to s/master/something/g & review it to
   have that something be \$GIT_TEST_MAIN (or another variable). Then we
   can mark that test as "accepts any default branch name" and move on.

 * Yours: Requires not running some tests while we wait for this to land
 * Mine: Run all tests & mark them as we go along for
   master||$NEWNAME. Similar to the test protocol v2 refactoring

But yeah e.g. the t/tests-that-need-master.txt I added in my RFC is
better marked in the test itself, I should have stolen your 'case
"$TEST_NUMBER"' way of doing it.

In my defense I honestly managed to miss it in skimming the ginormous
diff, which I think makes part of my argument here :)

> I _did_ prepare them, they are pretty much ready-to-go, as part of the
> `inclusive-naming` branch I track in
> https://github.com/gitgitgadget/git/pull/655 (I use the branch name
> `use-main-as-default-branch-name-docs` in the `inclusive-naming` branch
> thicket to track the documentation changes).
>
> The decision to separate them out into their own patch series was made
> consciously, to avoid having one big, honking, totally unreviewably large
> patch series.
>
> Therefore, just like I fed the preparatory patch series in a slow cadence,
> I planned on feeding the `-docs` patch series once the dust settles on
> this patch series (i.e. once it hits `next`).

On the topic of deprecation etc.:

>> I'm on the fence whether there should be a deprecation period or major
>> version bump for the final patch, but making the tests flexible enough
>> to handle the before and after state seems like it can be done uncoupled
>> from the actual default-flip.
>
> Hmm. On that matter, I wonder what the big fuss is all about. It's not
> like Git is forcing anybody to change their default branch. That's not at
> all what we're doing. To the contrary: _after_ many projects chose to
> change their default branch names, and _after_ GitHub started to follow
> that trend, Git added support for `init.defaultBranch` to accommodate that
> use case better. So in a sense, we're actually pretty late changing the
> fall-back of `init.defaultBranch`, at least from the perspective outside
> of the Git project.
>
> There have been plenty of articles about this in the meantime, too, and
> I could imagine that most developers are at least aware that the shift
> away from `master` is happening, in many quite visible projects.
>
> So to me, this whole discussion about whether this should bump the major
> version of Git seems a bit overblown. It's not like the median developer
> is creating new repositories on a regular basis, and if they do, chances
> are that they go with whatever branch name happens to be the initial one.
>
> What is much more common is that developers clone existing projects. And
> guess what, many of those projects already use a different default branch
> name. And developers seem to accept that and just go on with their lives.
>
> If it was up to me, I would reserve a major version increment to much
> bigger changes.
>
[I'm continuing quoting you here from your downthread
<nycvar.QRO.7.76.6.2011132324070.18437@tvgsbejvaqbjf.bet>]

> Whatever telemetry I would be able to pull would not be representative,
> and I would not be at liberty to share it anyway. So I asked Alex Mullans
> of GitHub (who is in charge of the default branch name switch to `main`
> there) whether he has any data I could share publicly and he said: "Across
> GitHub, 1/4 of daily pushes (and growing) go to `main`."
>=20
> Seeing as the branch name to be used in newly-created repositories on
> GitHub changed only very recently (October 1st, i.e. some 6 weeks ago), I
> highly suspect that this number means that _a lot_ of existing projects
> have changed their primary branch name to `main`, and seem to be quite
> happy with it.
>=20
> All this is to say that I consider it unnecessary to have a long
> deprecation period or major version bump for this patch series, based on
> available public data. The name `main` is already in wide-spread use (and
> growing) as primary branch name of Git projects.

All of that's true, but I really don't see how it's relevant to the
change we're discussing making to refs.c in git.git, which from my
generous reading of some of the threads in objection to this is the main
point of contention.

(I'm generously not engaging with some of the more howler-monkey esque
replies we've had on-list from people who seemed to have no idea what
was actually being proposed in git.git)

*That* change is not whether we approve of people using "main", or
hosting sites like GitHub etc. making it the default.

I think it's fair to say that even in some alternate universe where the
particular reasons we're switching away from "master" didn't exist and
e.g. GitHub et al had just decided on this out of the blue based on an
aesthetic preference we'd just say "uh, sure, whatever, you configure it
how you want".

Rather, we're talking about what happens when you run "git init".

Most people who are using or creating git repositories are nowadays
never going to be impacted by what "git init" does. So I think the data
you're citing here doesn't support your argument at all, it does the
opposite.

The people using these repositories with "main" on GitHub did not do so
with a patch to "git init". They clicked a button in the UI, or
copy/pasted GitHub's "how to create a local repo" which nowadays will
manually set the branch to "main" before pushing.

Then who's using "git init" who's going to be impacted by this change?
It's everyone else, like probably tens of tens of thousands of one-off
cronjobs somewhere creating a daily report of some by "init && commit &&
git diff master..".

I'm on the fence about what we should do in that case, but I'm leaning
towards some deprecation period or at least some other approach than a
s/master/main/g change precisely because of the numbers you're citing.

Because they shows how irrelevant the default shipped with git.git is to
users who want this s/master/main/g change in repositories they
regularly use. So we're really mostly talking about an impact to scripts
& some advanced users, both of who have a pretty good argument for
"init"'s default being what's been explicitly documented for ages in its
manpage.

Even if we want to just change it I think it's uncharitable to those
people not to at least consider throwing them some bone. E.g. "init"
could use the old default when it's not connected to a terminal, we
could show an advice notice and sleep(5) saying we're using a new
default etc. etc.
