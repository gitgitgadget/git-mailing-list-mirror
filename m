Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834FAC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 21:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbhLAVTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbhLAVTq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 16:19:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E7C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 13:16:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so107510347edd.0
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 13:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=R2kapFrP7JNInm0ICWGr54LItFn9VZh6EZ7hS7A3p+k=;
        b=BmDspn63/GETpAR3P65Jf0T/YTx4OvJwftzH2v5k1Vvw7wH0ZwaFPtHRelOjfUXlLV
         sGTLeoMe26I6ueB0TQKGcJRw3xLqWEfkK/2pScfPw8iH4VqOOrinnMPLenyyvI1pOvSR
         eFAb8KoSadHZfYfgcaTeG0C9l+83epm0ydLFTazpUAZc7j2Zns/StXUZVejiJAWmWJqC
         wfJLAPOjKQFRw/YzNMeZM96IhRVcrv5lua97eDvy55al3u0ZhyqVy3zPgOkJfOCjaWhm
         npYji0NEkoC87911cuAKV0qL01vtYzy0O56farRXicgYlD9HKHFtA6zNIfao3htZiJlV
         Z00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=R2kapFrP7JNInm0ICWGr54LItFn9VZh6EZ7hS7A3p+k=;
        b=my9bL+i0D/cnYAlanGif/qKI1gg6ZJrE+p01gWtxODgRWW1uw6tXX5v1cG7KD74UdZ
         abClAS4o2w0xjuxugZoFUpmHcjaP+6DMlYerCoQ65C4ALOlbSJ7JLkItLTVVdZUK1JOY
         QaC6M2GngRYH7vKlc4TTEzgIxavx52sf3eqIh2MYhTYuHv6fZvGbXWXkv527xi5Aoy9e
         x29TKfcTJYuOM2mbJhOTOI0M+9kBAPbtm+dekkhavd3iUWXFac/mT7vgyTWUknSROfae
         uHUkIMf6wyzZ/RJTn+4/XlUenovDs8vEpbm6DTpvaRnMnloTLcch/AO6Wba9+Rc8Xq4W
         sPlA==
X-Gm-Message-State: AOAM5331wabxf4QxR9fHhxMFLEk2N13OC8T2miORdoieOstTbY8+sitA
        h4SahpNbs6HoTZ/OvgGUXOEH+VHALoDD8Q==
X-Google-Smtp-Source: ABdhPJwjRnFG2vUW/uIA7kMQIdYDu2M6loGz90mCnskov4N3gEkUDFpNdzJyKDFLw13Yuprb/ujIMQ==
X-Received: by 2002:a17:907:2d10:: with SMTP id gs16mr9606445ejc.353.1638393383159;
        Wed, 01 Dec 2021 13:16:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f7sm554210edw.44.2021.12.01.13.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:16:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msWxi-001Pdc-2g;
        Wed, 01 Dec 2021 22:16:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        David Peter <mail@david-peter.de>
Subject: "git hyperfine" (was: [PATCH v3 5/5] unpack-objects[...])
Date:   Wed, 01 Dec 2021 21:37:00 +0100
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
 <20211122033220.32883-6-chiyutianyi@gmail.com>
 <8ff89e50-1b80-7932-f0e2-af401ee04bb1@gmail.com>
 <CAO0brD0oPHMwGNQXpC2XVhU=fY7XrrtBeu-x8GmJndeVptJaBg@mail.gmail.com>
 <446c3677-140f-3033-138f-1ef9b1f546a5@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <446c3677-140f-3033-138f-1ef9b1f546a5@gmail.com>
Message-ID: <211201.86r1aw9gbd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I hadn't sent a shameless plug for my "git hyperfine" script to the
list, perhaps this is a good time. It's just a thin shellscript wrapper
around "hyperfine" that I wrote the other day, which...

On Tue, Nov 30 2021, Derrick Stolee wrote:

> [...]
> I used a pack-file from an internal repo. It happened to be using
> partial clone, so here is a repro with the git/git repository
> after cloning this way:
>
> $ git clone --no-checkout --filter=3Dblob:none https://github.com/git/git
>
> (copy the large .pack from git/.git/objects/pack/ to big.pack)
>
> $ hyperfine \
> 	--prepare 'rm -rf dest.git && git init --bare dest.git' \
> 	-n 'old' '~/_git/git-upstream/git -C dest.git unpack-objects <big.pack' \
> 	-n 'new' '~/_git/git/git -C dest.git unpack-objects <big.pack' \
> 	-n 'new (small threshold)' '~/_git/git/git -c core.bigfilethreshold=3D64=
k -C dest.git unpack-objects <big.pack'
>
> Benchmark 1: old
>   Time (mean =C2=B1 =CF=83):     82.748 s =C2=B1  0.445 s    [User: 50.51=
2 s, System: 32.049 s]
>   Range (min =E2=80=A6 max):   82.042 s =E2=80=A6 83.587 s    10 runs
>=20=20
> Benchmark 2: new
>   Time (mean =C2=B1 =CF=83):     101.644 s =C2=B1  0.524 s    [User: 67.4=
70 s, System: 34.047 s]
>   Range (min =E2=80=A6 max):   100.866 s =E2=80=A6 102.633 s    10 runs
>=20=20
> Benchmark 3: new (small threshold)
>   Time (mean =C2=B1 =CF=83):     101.093 s =C2=B1  0.269 s    [User: 67.4=
04 s, System: 33.559 s]
>   Range (min =E2=80=A6 max):   100.639 s =E2=80=A6 101.375 s    10 runs
>=20=20
> Summary
>   'old' ran
>     1.22 =C2=B1 0.01 times faster than 'new (small threshold)'
>     1.23 =C2=B1 0.01 times faster than 'new'

...adds enough sugar around "hyperfine" itself to do this as e.g. (the
"-s" is a feature I submitted to hyperfine itself, it's not in a release
yet[1], but in this case you could also use "-p"):

    git hyperfine -L rev v2.20.0,origin/master \
        -s 'if ! test -d redis.git; then git clone --bare --filter=3Dblob:n=
one https://github.com/redis/redis; fi && make' \
        -p 'rm -rf dest.git; git init --bare dest.git' \
        './git -C dest.git unpack-objects <$(echo redis.git/objects/pack/*.=
pack)'

The sugar being that for each named "rev" parameter it'll set up "git
worktree" for you, so under the hood each of those is chdir-ing to the
respective revision of:
=20=20=20=20
    $ git worktree list
    [...]
    /run/user/1001/git-hyperfine/origin/master  abe6bb39053 (detached HEAD)
    /run/user/1001/git-hyperfine/v2.33.0        225bc32a989 (detached HEAD)

That they're named revisions and not git-rev-parse'd is intentional,
since you'll benefit from faster incremental "make" (even if using
"ccache"). I'm typically benchmarking HEAD~1,HEAD~0.

The output will then use those "rev" parameters, and be e.g.:
=20=20=20=20
    Benchmark 1: ./git -C dest.git unpack-objects <$(echo redis.git/objects=
/pack/*.pack)' in 'v2.20.0
      Time (mean =C2=B1 =CF=83):      6.678 s =C2=B1  0.046 s    [User: 4.5=
25 s, System: 2.117 s]
      Range (min =E2=80=A6 max):    6.619 s =E2=80=A6  6.765 s    10 runs
=20=20=20=20=20
    Benchmark 2: ./git -C dest.git unpack-objects <$(echo redis.git/objects=
/pack/*.pack)' in 'origin/master
      Time (mean =C2=B1 =CF=83):      6.756 s =C2=B1  0.074 s    [User: 4.5=
86 s, System: 2.134 s]
      Range (min =E2=80=A6 max):    6.691 s =E2=80=A6  6.941 s    10 runs
=20=20=20=20=20
    Summary
      './git -C dest.git unpack-objects <$(echo redis.git/objects/pack/*.pa=
ck)' in 'v2.20.0' ran
        1.01 =C2=B1 0.01 times faster than './git -C dest.git unpack-object=
s <$(echo redis.git/objects/pack/*.pack)' in 'origin/master'

I think if you're routinely benchmarking N different git versions you'll
find it handy, it also has configurable hook support (using git config),
so e.g. it's easy to copy your config.mak in-place in the
worktrees. E.g. my config is:

    $ git -P config --get-regexp '^hyperfine'
    hyperfine.run-dir $XDG_RUNTIME_DIR/git-hyperfine
    hyperfine.xargs-options -r
    hyperfine.hook.setup ~/g/git.meta/config.mak.sh

It's hosted at https://github.com/avar/git-hyperfine/ and
https://gitlab.com/avar/git-hyperfine/; It's implemented in (portable)
POSIX shell script.

There's surely some bugs in it, one known one is that unlike hyperfine
it doesn't accept there being spaces in the parameters to -L, because
I'm screwing up some quoting-within-quoting in the (shellscript)
implementation (suggestions for that particular one most welcome).

I hacked it up after this suggestion from Jeff King[2] of moving t/perf
over to it.

I haven't done any of that legwork, but I think a wrapper like
"git-hyperfine" that prepares worktrees for the N revisions we're
benchmarking is a good direction to go in.

We don't use git-worktrees in t/perf, but probably could for most/all
tests. In any case it would be easy to have the script setup the revs to
be benchmarked in some hookable custom manner to have it do exactly what
t/perf/run is doing now.

1. https://github.com/sharkdp/hyperfine/commit/017d55a
2. https://lore.kernel.org/git/YV+zFqi4VmBVJYex@coredump.intra.peff.net/
