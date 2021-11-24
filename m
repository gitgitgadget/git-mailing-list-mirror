Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE7C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 01:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhKXBzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhKXBzY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 20:55:24 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F472C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 17:52:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so3124303edv.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 17:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/ndq6H0V75ff3f4Tzg+rH12gGYrJhRE3Wf3wgMH54xw=;
        b=d+Iv/DuM3oBIqH0APznN1ctNym+1/iJpHysBF2DBrQ2FHVpkMQeyf+6Ju2ogVt4g79
         xlXPjODesfRmPJ50iB04drzggSVRmYEm2LDtmZ7KfCPoM+Q/Q6XmCeqme/B03x37v5gM
         v2+skyn48Oy7td6LZEaL8wt80tkjBLBaiz9TH+Ura0tzcU0/Uv6Sp/DUHQaE8Z6hKo1c
         1TjFZm8dy45aOKfUQ8lSTy78QWwqGetAEJW8jtVszUowOUmoOWxStCH5i5p1Kp0nsx0l
         5cVlmNaLBQ+CFcTYiHehoqQFOoSnuE0mHCeR3ip5A+wEqDRpJ6aalm2O43Fih1xT8uUq
         ezAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/ndq6H0V75ff3f4Tzg+rH12gGYrJhRE3Wf3wgMH54xw=;
        b=IitaaSq4+KjaJrk4DvgXRM/8IT5UOEf7k8bBe/lVdpB4QAQzvdFJ1o0YkqyDffodWt
         ED+/CHnK9+uzrHflqBTnYoUB9szHRwVmiInH1SzxffSqYiM6zuUUIY47flSxYx4i41Ff
         ml+V9NVkX//EE7Kr9uuWEBjpW4HP4bJJRWe5xXSuOXbPc+WcD9zOR4TNPRChlwEGcH73
         zY9HU+UqsGOdSPlPYWi0FFX52kqfTNxIyoMaeRPj+uW5NGYfFQR6KgP989aUtXEr6ret
         ++Nfud2wMJmbhrS7dLL6SYD1tkMAWw80nWQoQQKybhxdnXzdQw7MRDGfykrH4rlrG+QV
         y+zQ==
X-Gm-Message-State: AOAM532O1lXCCyLoewr2ZAE/hON9+8VO04QpNk3GmbIp3SgxzE8vxx7X
        n9tiY4QR1yGNC5hEEqiVoLQNAxmFiPtxiw==
X-Google-Smtp-Source: ABdhPJyKlHdnKrDrXi/V6+iMgAUFrlSpZ6k50lyUL3FSVdDmL84xYSoU4IuGM7ViKXzhR3ylbPcfYA==
X-Received: by 2002:a50:da4e:: with SMTP id a14mr17893755edk.154.1637718733338;
        Tue, 23 Nov 2021 17:52:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id de15sm5940389ejc.70.2021.11.23.17.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 17:52:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mphSF-00082w-UM;
        Wed, 24 Nov 2021 02:52:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH 0/2] submodule: test what happens if
 submodule.superprojectGitDir isn't around
Date:   Wed, 24 Nov 2021 02:38:20 +0100
References: <20211117005701.371808-1-emilyshaffer@google.com>
 <RFC-cover-0.2-00000000000-20211117T113134Z-avarab@gmail.com>
 <YZ1KLNwsxx7IR1+5@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZ1KLNwsxx7IR1+5@google.com>
Message-ID: <211124.86a6hue2wk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Emily Shaffer wrote:

> On Wed, Nov 17, 2021 at 12:43:38PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Tue, Nov 16 2021, Emily Shaffer wrote:
>>=20
>> > [...]
>> > A couple things. Firstly, a semantics change *back* to the semantics of
>> > v3 - we map from gitdir to gitdir, *not* from common dir to common dir,
>> > so that theoretically a submodule with multiple worktrees in multiple
>> > superproject worktrees will be able to figure out which worktree of the
>> > superproject it's in. (Realistically, that's not really possible right
>> > now, but I'd like to change that soon.)
>> >
>> > Secondly, a rewording of comments and commit messages to indicate that
>> > this isn't a cache of some expensive operation, but rather intended to
>> > be the source of truth for all submodules. I also added a fifth commit
>> > rewriting `git rev-parse --show-superproject-working-tree` to
>> > demonstrate what that means in practice - but from a practical
>> > standpoint, I'm a little worried about that fifth patch. More details =
in
>> > the patch 5 description.
>> >
>> > I did discuss =C3=86var's idea of relying on in-process filesystem dig=
ging to
>> > find the superproject's gitdir with the rest of the Google team, but in
>> > the end decided that there are some worries about filesystem digging in
>> > this way (namely, some ugly interactions with network drives that are
>> > actually already an issue for Googler Linux machines). Plus, the allure
>> > of being able to definitively know that we're a submodule is pretty
>> > strong. ;) But overall, this is the direction I'd prefer to keep
>> > going
>> > in, rather than trying to guess from the filesystem going forward.
>>=20
>> Did you try running the ad-hoc benchmark I included in [1] on that
>> Google NFS? I've dealt with some slow-ish network filesystems, but if
>> it's slower than AIX's local FS (where I couldn't see a difference) I'd
>> put money on it being a cross-Atlantic mount or something :)
>>=20
>> Re your:
>>=20
>>     "this isn't a cache of some expensive operation, but rather
>> intended to be the source of truth for all submodules."
>>=20
>> In your 5/5 it says, in seeming contradiction to this:
>>=20
>>     This commit may be more of an RFC - to demonstrate what life looks l=
ike
>>     if we use submodule.superprojectGitDir as the source of truth. But s=
ince
>>     'git rev-parse --show-superproject-working-tree' is used in a lot of
>>     scripts in the wild[1], I'm not so sure it's a great example.
>>=20
>>     To be honest, I'd prefer to die("Try running 'git submodule update'")
>>     here, but I don't think that's very script-friendly. However, falling
>>     back on the old implementation kind of undermines the idea of treati=
ng
>>     submodule.superprojectGitDir as the point of truth.
>>=20
>> Most of what I've been suggesting in my [1] and related is that I'm
>> confused about if & how this is a pure caching mechanism.
>>=20
>> Removing mentions of it being a cache but it seemingly still being a
>> cache at the tip of this series has just added to that confusion for
>> me :)
>
> Yeah, I think this was a bad choice for me to include that patch. I was
> really hopeful that I could show off "look, we don't need to ever hunt
> in the FS above us", but for established repos, that's a bad idea
> (because lots of people are already using this 'git rev-parse
> --show-superproject-work-tree' thing in scripts, like I mentioned). So I
> think it was a mistake to include it at all. Rather, I think it's
> probably a better idea to treat that particular entry point as "legacy"
> and implement other things using 'submodule.superprojectGitDir'
> directly.
>
> Because the patch 5 illustrates: "I'm saying that this new config isn't
> a cache, but look, here's how I can treat it like a cache that might be
> invalid and here's how I can fall back on a potentially expensive
> operation anyways." I think I could have illustrated it a little better
> with something like "here's a brand new 'git rev-parse
> --show-superproject-gitdir'" which directly calls on the new config.
>
> So, sorry about that.

The RFC series here shows that the config & the on-the-fly discovery 1=3D1
map to each other (at least in terms of the tests your series adds).

Why wouldn't the same be the case with a --show-superproject-gitdir?
Unless the fallback implementation was intentionally removed.

>>=20
>> Anyway. While I do think this caching mechanism is probably
>> unnecessary in the short to medium term, i.e. it seems to the extent
>> that it was ever needed was due to some bridging of *.sh<->*.c that
>> we're *this* close to eliminating anyway.
>>=20
>> But maybe I'm wrong. The benchmark I suggested above on that Google
>> NFS might be indicative. I don't really see how something that'll be
>> doing a bunch of FS ops anyway is going to be noticeably slower with
>> that approach, but maybe opening the index/tree of the superproject is
>> more expensive than I'm expecting.
>>=20
>> In any case, all of that's not the hill I'm picking to die on. If
>> you'd like to go ahead with this cache-or-not-a-cache then sure, I
>> won't belabor that point.
>
> Yeah, I think I would. I've heard some serious reservations from others
> on my team about trying to use filesystem traversal here at all, so I
> think that would be an uphill battle.

Do they have any benchmarks to share? :)

>>=20
>> I *do* strongly think if we're doing so though that we should have
>> something like this on top. I.e. let's test wha happens if we do and
>> don't have this "caching" variable, which is demonstrably easy to do.
>>=20
>> Benchmarking the two gives me:
>>=20
>>     $ git hyperfine -L rev HEAD~0 -L s true,false -s 'make -j8 all' '(cd=
 t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=3D{s} ./t7412-submodule-abs=
orbgitdirs.sh)'
>>     Benchmark 1: (cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=3Dtr=
ue ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0
>>       Time (mean =C2=B1 =CF=83):     545.9 ms =C2=B1   1.6 ms    [User: =
490.3 ms, System: 114.0 ms]
>>       Range (min =E2=80=A6 max):   543.5 ms =E2=80=A6 548.1 ms    10 runs
>>=20=20=20=20=20=20
>>     Benchmark 2: (cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=3Dfa=
lse ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD~0
>>       Time (mean =C2=B1 =CF=83):     537.9 ms =C2=B1  11.4 ms    [User: =
476.8 ms, System: 117.6 ms]
>>       Range (min =E2=80=A6 max):   532.7 ms =E2=80=A6 570.1 ms    10 runs
>>=20=20=20=20=20=20
>>     Summary
>>       '(cd t && GIT_TEST_SUBMODULE_CACHE_SUPERPROJECT_DIR=3Dfalse ./t741=
2-submodule-absorbgitdirs.sh)' in 'HEAD~0' ran
>>         1.01 =C2=B1 0.02 times faster than '(cd t && GIT_TEST_SUBMODULE_=
CACHE_SUPERPROJECT_DIR=3Dtrue ./t7412-submodule-absorbgitdirs.sh)' in 'HEAD=
~0'
>>=20
>> I.e. not using the cache is either indistinguishable or a bit faster
>> (the "a bit faster" is definitely due to just running less test code
>> though).
>
> Yeah, once again, I think it is better to treat "git rev-parse
> --show-superproject-work-tree" as "legacy" and to rely solely on the
> config for new options, meaning that "what happens without this
> variable" is as simple as "we treat it like it's a standalone repository
> with no superproject", rather than a performance difference at all.

Why would it be better to have a hard reliance on the config for new
features or options? Your original CL says[1]:

    It's expensive and non-definitive to try and guess whether or not the
    current repo is a submodule.

Maybe that's the case somewhere, I haven't been able to dig up the
"expensive" part (aside from the fixable case of exec-ing rev-parse in a
loop).

Which leaves "non-definitive", that may be the case, but as the RFC
patches here show if there is such a case, it's not covered by any of
your existing tests in this series.

I'd think if those two things hold true (not expensive, and we can
unambiguously discover it on the fly) our bias should be towards not
introducing an indirection in the config, as such a thing needs to be
kept up-to-date, and which may become inaccurate for whatever
reason. Whereas the FS relationship between the won't ever be
out-of-date.

1. https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer@google=
.com
