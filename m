Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE4C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 23:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC1E61964
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 23:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhGEXYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhGEXYW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 19:24:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C9C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 16:21:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eb14so3572864edb.0
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1Jy3CMPUUDGLmJ1shTZmTw9Dk4mp9n4sCF8zRrp9aBQ=;
        b=AapBRQUwvdnJJCebl/doWmYCQSq6lbcqCE+Yby3VNbiLdUlP8qV4F4ekbdGPnoeh2B
         mVrV9YLj1VHzpPnXsDUqy7TaOKNDOOCwqHobgT4t6lo/LasH7oRVxmkTOMq/h+FfGXny
         gJskHPXbVZLYanMcFKAIWfAls6j5mc55NOJfswnPMaZxI+V6A2ouEUO7cSSxTn9UZxK9
         Ew1/axo8Y8SBpOp1qtpfa9ZSYh2inLHN4EM1sO5gGoEdLc5VvMBthjH23EbGtUzcO5xw
         damHro112jgvN0b3kExfHvZcEWtQzVUgzhcUkyZJoDF+3GcLwX/SWwsLoI8pv84XlRsg
         GOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1Jy3CMPUUDGLmJ1shTZmTw9Dk4mp9n4sCF8zRrp9aBQ=;
        b=dey1aRFQbMNx8GsW7ZNJAvfmROqu6ZgDeGqhPAWLmvQgS3BSGT3eG2DZzb/TytBSvg
         f0Esy4nr1sDkVLscjfMbywlDDf+IPx4lxo7RTqxPWW/Af1JNm31mhGvug61j1HdKxpKG
         o6Teupnga9IRFWfQ2MgSicH899lv5F9/WdhNV/ziQQVOjt5TLhvJas9KyT8LjOxh1eEW
         muz8vo9lmp+17eTG8d+M1l/owI8wgCq6qzqegicS095VAzaoAbzUI0BTxW4SM3ekTH3B
         vCmaiR7HhshH90NKF6Zqn+0wbYWdJI5ysW9+izNI1n8dVFYH3ovqSbAQ/6s6TREBGCr2
         il8A==
X-Gm-Message-State: AOAM530tEvqA5LURjR76ilv0+CzU4OrVKozye7xXtPU6jiUQXv8dSbbP
        1OSmqILkwwWKb712dj3hMDI=
X-Google-Smtp-Source: ABdhPJx6w5RBTpgtIIhKDpbWcq5P1WQvSSWuYBSxvFmxGrOvzJixZxhbGi6BQDD0MBe/xtWJ7/lfrw==
X-Received: by 2002:a50:8a9e:: with SMTP id j30mr18810658edj.72.1625527302093;
        Mon, 05 Jul 2021 16:21:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l26sm6228005edt.40.2021.07.05.16.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 16:21:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        David Turner <David.Turner@twosigma.com>
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
Date:   Tue, 06 Jul 2021 00:52:44 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <87fswyc4dz.fsf@evledraar.gmail.com>
 <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com>
 <87czs1d6uy.fsf@evledraar.gmail.com>
 <9ac45626-f995-a661-2746-6711f996e5a6@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <9ac45626-f995-a661-2746-6711f996e5a6@jeffhostetler.com>
Message-ID: <871r8c73ej.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, Jeff Hostetler wrote:

> On 7/1/21 5:26 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jul 01 2021, Jeff Hostetler wrote:
>>=20
>>> On 7/1/21 1:40 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>>>
>>>>> Here is V3 of my patch series to add a builtin FSMonitor daemon to Gi=
t. I
>>>>> rebased this series onto v2.32.0.
>>>>>
>>>>> V3 addresses most of the previous review comments and things we've le=
arned
>>>>> from our experimental testing of V2. (A version of V2 was shipped as =
an
>>>>> experimental feature in the v2.32.0-based releases of Git for Windows=
 and
>>>>> VFS for Git.)
>>>>>
>>>>> There are still a few items that I need to address, but that list is =
getting
>>>>> very short.
>>>> ...
>>>>>     fsmonitor-fs-listen-win32: stub in backend for Windows
>>>>>     fsmonitor-fs-listen-macos: stub in backend for MacOS
>>>> I left some light comments on the repo-settings.c part of this to
>>>> follow
>>>> up from a previous round.
>>>
>>> Thanks.
>>>
>>>> Any other testing of it is stalled by there being no linux backend
>>>> for
>>>> it as part of this series. I see from spelunking repos that Johannes h=
ad
>>>> a WIP compat/fsmonitor/linux.c which looks like it could/should mostly
>>>> work, but the API names all changed since then, and after a short try I
>>>> gave up on trying to rebase it.
>>>
>>> The early Linux version was dropped because inotify does not give
>>> recursive coverage -- only the requested directory.  Using inotify
>>> requires adding a watch to each subdirectory (recursively) in the
>>> worktree.  There's a system limit on the maximum number of watched
>>> directories (defaults to 8K IIRC) and that limit is system-wide.
>>>
>>> Since the whole point was to support large very large repos, using
>>> inotify was a non-starter, so I removed the Linux version from our
>>> patch series.  For example, the first repo I tried it on (outside
>>> of the test suite) had 25K subdirectories.
>>>
>>> I'm told there is a new fanotify API in recent Linux kernels that
>>> is a better fit for what we need, but we haven't had time to investigate
>>> it yet.
>> That default limit is a bit annoying, but I don't see how it's a
>> blocker
>> in any way.
>> You simply adjust the limit. E.g. I deployed and tested the hook
>> version
>> of inotify (using watchman) in a sizable development environment, and
>> written my own code using the API. This was all before fanotify(7)
>> existed. IIRC I set most of the limits to 2^24 or 2^20. I've used it
>> with really large Git repos, including with David Turner's
>> 2015-04-03-1M-git for testing (`git ls-files | wc -l` on that is around
>> a quarter-million).
>> If you have a humongous repository and don't have root on your own
>> machine you're out of luck. But I think most people who'd use this are
>> either using their own laptop, or e.g. in a corporate setting where
>> administrators would tweak the sysctl limits given the performance
>> advantages (as I did).
>> Once you adjust the limits Linux deals with large trees just fine,
>> it
>> just has overly conservative limits for most things in sysctl. The API
>> is a bit annoying, your event loop needs to run around and add watches.
>> AFAICT you need Linux 5.1 for fanotify(7) to be useful, e.g. Debian
>> stable, RHEL etc. aren't using anything that new. So having an inotify
>> backend as well as possibly a fanotify one would be very useful.
>> And linux.git's docs suggest that the default limit was bumped from
>> 8192
>> to 1M in v5.10, a really recent kernel, so if you've got that you've
>> also got fanotify.
>> In any case, even if Linux's inotify limit was something hardcoded
>> and
>> impossible to change you could still use such an API to test & debug the
>> basics of this feature on that platform.
>
> Good points.  If the inotify limits can be increased into the millions
> then we can revisit supporting it.

I also replied in the side-thread on this topic:
https://lore.kernel.org/git/874kd874qv.fsf@evledraar.gmail.com/

> [...] I do worry about possible race
> conditions as we have to scan the worktree and add/delete a watch for
> each directory, but we don't need to worry about that right now.

In the watchman code there's a scheduleRecrawl() in such cases, but it's
not just something that happens on Linux.

On Windows it's if ReadDirectoryChangesW() returns
ERROR_NOTIFY_ENUM_DIR. This builtin version doesn't check that at
all. Here's someone who seems to work at MSFT talking about it:

    https://devblogs.microsoft.com/oldnewthing/20110812-00/?p=3D9913

So isn't this an issue on Windows as well?

> I do want to have Linux support eventually, but I was saving it for
> a later effort (and/or looking for volunteers).

OK, upthread you said it was a "non-starter" because of the adjustable
limits we've been discussing...

> My IPC-based builtin daemon complements the existing hook-based
> fsmonitor support that Ben Peart and Kevin Willford added a few years
> ago.  That model (and PERL hook script and Watchman integration) work
> fine for Linux, so the advantages of a builtin monitor aren't as
> compelling.
>
> For example, on Linux, hook process creation is fast, PERL is fast,[...]

Did you or Ben ever try to reproduce what I noted at:

    https://lore.kernel.org/git/CACBZZX5e58bWuf3NdDYTxu2KyZj29hHONzN=3Drp-7=
vXd8nURyWQ@mail.gmail.com/

And more recently with reference to that at:

    https://lore.kernel.org/git/87h7lgfchm.fsf@evledraar.gmail.com/

I.e. when I tested it back then the issue wasn't Perl's performance, it
was something between watchman and the user, happening in
git. I.e. watchman would return in the single-digit milliseconds, git
would take hundreds or thousands of ms.

Maybe I missed some intervening analysis, but this didn't have to do
with process overhead back then.

Also, watchman has a JSON network interface. So for a "native" solution
I also wonder if you or Ben tried a solution that involved just talking
to that over the local network. The hook/perl script was just a trivial
aid to make doing that easier. Wouldn't that be just as fast (or near
enough) on Windows?

Ben mentioned in the linked thread that there was some talks between
Microsoft (or well, the "Git team") and the watchman people. So again, I
missed some in-between discussions. I'm just wondering about the design
choices...

> and it is easy to just apt-get a tool like Watchman.  But on
> Windows, process creation is slow, NTFS is slow, PERL is available
> as part of the Git-for-Windows distribution, and installing third-party
> tools like Watchman onto a collection of enterprise users' machines is
> a chore, so it made sense of us to pick platforms where the existing
> hook model has issues and add other platforms later.

If we're trying to do an end-run around package systems being a pain
would including the relevant part of watchman in contrib + talking to it
over its network interface be a replacement for some/most/all of this
series?

> Besides, this patch series is already at 34 commits.  And some of
> them are quite large.  Adding another platform would just make it
> even larger.
>
> Right now I'm more interested in the larger question of whether
> we WANT to have a builtin fsmonitor and do we like the overall
> design of what I have here?  Picking up a new platform, whether
> it is Linux, or AIX, or Solaris, or Nonstop, or whatever, should
> nicely fit into one platform-specific file in compat/fsmonitor
> and not take that long.

Sure, FWIW I'm not opposed to this being a built-in per-se, or us
re-implementing parts of watchman here, and not being able to test this
series meaningfully a lot of these questions are probably easy to answer
on a supported OS...

>>>> I'd really prefer for git not to have features that place free
>>>> platforms
>>>> at a disadvantage against proprietary platforms if it can be avoided,
>>>> and in this case the lack of a Linux backend also means much less
>>>> widespread testing of the feature among the development community / CI.
>>>>
>>>
>>> This feature is always going to have platform-specific components,
>>> so the lack of one platform or another should not stop us from
>>> discussing it for the platforms that can be supported.
>> (I think per the above that's s/can be/are/)
>>=20
>>> And given the size and complexity of the platform-specific code,
>>> we should not assume that "just test it on Linux" is sufficient.
>>> Yes, there are some common/shared routines/data structures in the
>>> daemon, but hard/tricky parts are in the platform layer.
>> I think we're talking past each other a bit here. I'm not saying
>> that
>> you can get full or meaningful testing for it on Windows if you test it
>> on Linux, or the other way around.
>> Of course there's platform-specific stuff, although there's also a
>> lot
>> of non-platform-specific stuff, so even a very basic implementation of
>> inotify would make reviwing this easier / give access to more reviewers.
>> I'm saying that I prefer that Git as a free software project not be
>> in
>> the situation of saying the best use-case for a given size/shape of repo
>> is to use Git in combination with proprietary operating systems over
>> freely licensed ones.
>
> I wouldn't worry about that.  Even without Watchman integration,
> Linux runs things so much faster than anything else it's not funny.
>
> If anything, we need things like fsmonitor on Windows to help keep
> up with Linux.

Even on Linux if you do a "git status" on a humongous repository it can
take 1-2 seconds (see old but still valid linked numbers above), whereas
if you've been logging fs events and ask a daemon "what changed since
time xyz" it can take <5ms.

But that's just been on repositories I've tested. I'd assumed that this
part of GVFS wasn't something that could have been fairly easily
replaced by having the relevant developers run a Linux distro in vmware
or whatever, adn that's been consistent with my own testing on
still-big-but-smaller repos than that.
