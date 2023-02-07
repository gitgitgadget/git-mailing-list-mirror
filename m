Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1FBC636D4
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBGRAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 12:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBGRAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 12:00:53 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D773A5BD
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 09:00:51 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-501c3a414acso203606957b3.7
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdNsG2DY/XmXMNwF77gV6B7Zy7RG0aSYXuQS32FMK30=;
        b=onxGeZbYqtYt8Y9/pWW8bWzXtneVkh/kq/fgrsDS2jplmgXHD9VVOmE7Biyf2H1gHn
         GFa0kvDP5/SRcDMskJzV0tZmsFZLG7qIQ+CM6NW6gckZbjS5XRCaGQzCygmuaZ2uKz+g
         VL6N4BrqIRHd/1jITmvOAqNeJtaCVYupyaY4MCMsbH1uJP7y/WHFhiKx21LQ9OTXl3Uj
         3nZpDAK3D9qsBtOsyp3Fy1h5WsVfKpnaWm0o4DFSZ4zDGl72STGz+wDneUpfC3il10zs
         d0Xc9OJxh4X47lML0Wd+RZ57ynyttCYEhFc74JZT0dG8re6WFMRa5W6k8pVV9VCYYFPb
         5IjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdNsG2DY/XmXMNwF77gV6B7Zy7RG0aSYXuQS32FMK30=;
        b=d3NDpoMDq2i9/wH/0uHoEU8rwvaMKM6S/18J7nZkejg6IyXYYQN4srXtsgdT5fcLKK
         LsPCp+ZXPhDtMb0pHVxO1DNuFgG4PrJf9GuLEEgE4YYRn+6kCR3JQdiqRftQA18XmFDc
         S/GbEIe8wzsQ4fZetb5Wb4B14DbkwSA1fG6xhwdXvCjNuaXBiGAu9d1C4VJGJL13mo2v
         +9t0ycDb6OH5icJ6jMzjf7fQdN3cizfEZ3ggULvba5l1B4GyyopRs93GmT1wYZzcRqBH
         AIjJ8JSPc8ifj8fgWGpp6v/kdr2u8Xf4oc7s1OQOzSNkTIuA7De2yn0ilAT4W3GgRN1m
         e5yw==
X-Gm-Message-State: AO0yUKUKS8NNT4x2FpQ3N9UmsOMRFH/qpPndEkdY3nLqX97fkxGdATSW
        FF5QQnYXDng5KpqnZ0R0AQw=
X-Google-Smtp-Source: AK7set8Y9j+qyHLdNLxxA3NOC8eN6ZpY+hZmMjIfMcWNeFZWaQzAu56t9P9vSYeRnHp+64jSTVzMRA==
X-Received: by 2002:a81:b704:0:b0:52a:7c27:559b with SMTP id v4-20020a81b704000000b0052a7c27559bmr2042852ywh.4.1675789250891;
        Tue, 07 Feb 2023 09:00:50 -0800 (PST)
Received: from [192.168.1.205] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a448b00b0072c01a3b6aasm9960759qkp.100.2023.02.07.09.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2023 09:00:50 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Tue, 07 Feb 2023 12:00:49 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
In-Reply-To: <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 7 Feb 2023, at 9:55, Phillip Wood wrote:

> Hi John
>
> On 06/02/2023 20:37, John Cai wrote:
>> On 6 Feb 2023, at 11:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:=

>>> On Sun, Feb 05 2023, John Cai via GitGitGadget wrote:
>>> For some non-nitpicking, I do worry about exposing this as a DoS vect=
or,
>>> e.g. here's a diff between two distant points in git.git with the
>>> various algorithms:
>>>
>>> 	$ hyperfine -r 1 -L a patience,minimal,histogram,myers 'git diff --d=
iff-algorithm=3D{a} v2.0.0 v2.28.0'
>>> 	Benchmark 1: git diff --diff-algorithm=3Dpatience v2.0.0 v2.28.0
>>> 	  Time (abs =E2=89=A1):        42.121 s               [User: 41.879 =
s, System: 0.144 s]
>>> 	=

>>> 	Benchmark 2: git diff --diff-algorithm=3Dminimal v2.0.0 v2.28.0
>>> 	  Time (abs =E2=89=A1):        35.634 s               [User: 35.473 =
s, System: 0.160 s]
>>> 	=

>>> 	Benchmark 3: git diff --diff-algorithm=3Dhistogram v2.0.0 v2.28.0
>>> 	  Time (abs =E2=89=A1):        46.912 s               [User: 46.657 =
s, System: 0.228 s]
>>> 	=

>>> 	Benchmark 4: git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0
>>> 	  Time (abs =E2=89=A1):        33.233 s               [User: 33.072 =
s, System: 0.160 s]
>>> 	=

>>> 	Summary
>>> 	  'git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0' ran
>>> 	    1.07 times faster than 'git diff --diff-algorithm=3Dminimal v2.0=
=2E0 v2.28.0'
>>> 	    1.27 times faster than 'git diff --diff-algorithm=3Dpatience v2.=
0.0 v2.28.0'
>>> 	    1.41 times faster than 'git diff --diff-algorithm=3Dhistogram v2=
=2E0.0 v2.28.0'
>>
>> Thanks for this analysis. To clarify, .gitconfig's diff.algorithm sett=
ing is
>> already an attack vector right?
>
> .gitconfig is under the user's control though whereas .gitattributes is=
 attacker controlled if one clones a malicious repository. Having said th=
e worst results above are for the historgram algorithm that merge-ort use=
s internally and no one has complained about ort's performance.
>
>> I see how this would be adding another one.
>>
>> That being said, here's a separate issue. I benchmarked the usage of
>> .gitattributes as introduced in this patch series, and indeed it does =
look like
>> there is additional latency:
>>
>> $ echo "* diff-algorithm=3Dpatience >> .gitattributes
>> $ hyperfine -r 5 'git-bin-wrapper diff --diff-algorithm=3Dpatience v2.=
0.0 v2.28.0'                      =E2=9C=AD
>> Benchmark 1: git-bin-wrapper diff --diff-algorithm=3Dpatience v2.0.0 v=
2.28.0
>>    Time (mean =C2=B1 =CF=83):     889.4 ms =C2=B1 113.8 ms    [User: 7=
15.7 ms, System: 65.3 ms]
>>    Range (min =E2=80=A6 max):   764.1 ms =E2=80=A6 1029.3 ms    5 runs=

>>
>> $ hyperfine -r 5 'git-bin-wrapper diff v2.0.0 v2.28.0'                =
                                =E2=9C=AD
>> Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0
>>    Time (mean =C2=B1 =CF=83):      2.146 s =C2=B1  0.368 s    [User: 0=
=2E827 s, System: 0.243 s]
>>    Range (min =E2=80=A6 max):    1.883 s =E2=80=A6  2.795 s    5 runs
>>
>> and I imagine the latency scales with the size of .gitattributes. Alth=
ough I'm
>> not familiar with other parts of the codebase and how it deals with th=
e latency
>> introduced by reading attributes files.
>
> Ouch! Thanks for benchmarking that is a suspiciously large slow down. I=
've a feeling the attributes code parses all the .gitattribute files from=
 scratch for each path that's queried, so there may be scope for making i=
t a bit smarter. I see some slow down but no where near as much

Yes, definitely worth looking into how this can be sped up.

>
>
> $ hyperfine -r 3 'bin-wrappers/git diff --diff-algorithm=3Dpatience --n=
o-color --no-color-moved v2.0.0 v2.28.0'
> Benchmark 1: bin-wrappers/git diff --diff-algorithm=3Dpatience --no-col=
or --no-color-moved v2.0.0 v2.28.0
>   Time (mean =C2=B1 =CF=83):      1.996 s =C2=B1  0.008 s    [User: 1.7=
06 s, System: 0.286 s]
>   Range (min =E2=80=A6 max):    1.989 s =E2=80=A6  2.004 s    3 runs
>
> $ hyperfine -r 5 'bin-wrappers/git diff --no-color --no-color-moved v2.=
0.0 v2.28.0'
> Benchmark 1: bin-wrappers/git diff --no-color --no-color-moved v2.0.0 v=
2.28.0
>   Time (mean =C2=B1 =CF=83):      2.238 s =C2=B1  0.037 s    [User: 1.8=
80 s, System: 0.350 s]
>   Range (min =E2=80=A6 max):    2.216 s =E2=80=A6  2.303 s    5 runs
>
>
> Perhaps I'm over simplifying but having read the issue you linked to I =
couldn't help feeling that the majority of users might be satisfied by ju=
st changing gitlab to use the patience algorithm when generating diffs.

Right, I recognize this is a judgment call that may be best left up to th=
e list.

We don't have a way in GitLab to change the diff algorithm currently. Of =
course
that can be implemented outside of Git, but having it as part of Git may =
have a
wider benefit for users who would appreciate the convenience of automatic=
ally
having certain files use one diff algorithm and other files use another, =
without
having to pass in the diff algorithm through the command line each time.

>
> The idea to use .gitattributes seems to have come from Patrick rather t=
han a user request.
>
> This is slightly off topic but one thing I'd really like is a way to te=
ll diff use automatically use --diff-words on some files (e.g. Documentat=
ion/*)

I think it's a bit similar to the spirit of this desired feature.

thanks
John

>
> Best Wishes
>
> Phillip
>
>>> Now, all of those are very slow overall, but some much more than
>>> others. I seem to recall that the non-default ones also had some
>>> pathological cases.
>>>
>>> Another thing to think about is that we've so far considered the diff=

>>> algorithm to be purely about presentation, with some notable exceptio=
ns
>>> such as "patch-id".
>>>
>>> I've advocated for us getting to the point of having an in-repo
>>> .gitconfig or .gitattributes before with a whitelist of settings like=

>>> diff.context for certain paths, or a diff.orderFile.
>>>
>>> But those seem easy to promise future behavior for, v.s. an entire di=
ff
>>> algorithm (which we of course had before, but now we'd have it in
>>> repository data).
>>>
>>> Maybe that's not a distinction worth worrying about, just putting tha=
t
>>> out there.
>>>
>>> I think if others are concerned about the above something that would
>>> neatly side-step those is to have it opt-in via the .git/config someh=
ow,
>>> similar to e.g. how you can commit *.gpg content, put this in
>>> .gitattributes:
>>>
>>> 	*.gpg diff=3Dgpg
>>>
>>> But not have it do anything until this is in the repo's .git/config (=
or
>>> similar):
>>>
>>> 	[diff "gpg"]
>>>          	textconv =3D gpg --no-tty --decrypt
>>>
>>> For that you could still keep the exact .gitattributes format you hav=
e
>>> here, i.e.:
>>>
>>> 	file* diff-algorithm=3D$STRATEGY
>>>
>>> But we to pick it up we'd need either:
>>>
>>> 	[diff-algorithm]
>>>          	histogram =3D myers
>>>
>>> Or:
>>>
>>> 	[diff-algorithm "histogram"]
>>>          	allow =3D true
>>
>> This would help address slowness from the diff algorithm itself. I'm n=
ot opposed
>> to adding this config if this attack vector is concerning to people.
>>
>> However, it wouldn't help address the additional latency of scanning
>> .gitattributes to find the diff algorithm.
>>
>> Would a separate config to allow gitattributes be helpful here?
>>
>> [diff-algorithm]
>> 	attributes =3D true
>>
>>>
>>> The former form being one that would allow you to map the .gitattribu=
tes
>>> of the repo (but maybe that would be redundant to
>>> .git/info/attributes)...
