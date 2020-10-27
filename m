Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E9C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 12:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E132022456
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 12:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcZE5Zsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750702AbgJ0MKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:10:11 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:35069 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750660AbgJ0MKI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 08:10:08 -0400
Received: by mail-ej1-f54.google.com with SMTP id p5so1893020ejj.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cxcWHmRMuXAm0jtjesYQP+XjNz/Iu/DclwP7vhXRb88=;
        b=GcZE5Zsn6Zq19RWlOOUC4q5i8rZQv6tzeS2MRT1zQ392uoJ+sTd5Gz5BIllv2p82EA
         A9PUfb4q3Mugtof8iU9CPernzwuvOQXsokYa6lGH6uZLjqoYjkrm5VhG3fCViyWG2YAv
         Ha8HacaqZfcIDlRQwCQHv8D7X+2ZV0Ci1zTVpzawz4IjGQerq0QoDcD3V6c79n2x/5M1
         gJXhlzjQURiHWy6Bia6j06Ba3NJNKrtf3/WNp4xo6fonxzdVy6cRnlMIcSGcLCn14ssm
         mkZ9aB6IDGuRhj+ymc7k5PVPo/RMZNXLJ1izgII1+G5EWO/CkCzRK8wIRyJ1N3pk5mb+
         atwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cxcWHmRMuXAm0jtjesYQP+XjNz/Iu/DclwP7vhXRb88=;
        b=eAtqfe18UV1kyVHRSS5q4JHm3eRwweomk91XUHly6tCsrCzGgWg3yqnwTVXBtQk6kd
         3XIwnZSkT9HIwIMoawB7CkvtTia54+qCyHangtUgi/2OlICyeGr2aOBQHzE6c09u+3nT
         e31+0SBSpA5s2EtxGvUMbJC/curKNAmv//VtcnHeHL7AltQyqvXOMeT5oDmGSPyMw/qK
         ogRt0hIHzD7ACPyP/Xe9or+mBmgNEK43n94jqIX9bPfQeLUkLLFjSAz6lhjUYQSdadfS
         +thIEy83s1GDgIDwk3JF6RmsUNznIEeTWlwZhGbXLimr9YliKL0yYldTq7BIznCW7Wr0
         ofQw==
X-Gm-Message-State: AOAM530sZdLeTsejc2K1WPdSq7gnsF7wFw9fAqvnqe6DU8kCmt09rhnh
        IJnSE5G5pifNc+lFMqye1G9OpDzgmqGqdg==
X-Google-Smtp-Source: ABdhPJzHXu0mMGPIB0vlwVwvhB5X2zpwrqAcgRup4OuDhYogOxX8DMPrYTLxozwSHUBsh19CemBNFw==
X-Received: by 2002:a17:906:5e49:: with SMTP id b9mr2082510eju.436.1603800605209;
        Tue, 27 Oct 2020 05:10:05 -0700 (PDT)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id q9sm926794ejr.115.2020.10.27.05.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:10:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Manuel =?utf-8?Q?B=C3=A4renz?= <manuel@enigmage.de>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: Feature request: Exponential search in git bisect
References: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de>
Date:   Tue, 27 Oct 2020 13:10:03 +0100
Message-ID: <87wnzbhntw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 09 2020, Manuel B=C3=A4renz wrote:

> This feature was requested 8 years ago and briefly discussed:
> https://public-inbox.org/git/20120318212957.GS1219@chaosreigns.com/
>
>
>   TL;DR
>
> Before doing git bisect, I want to use exponential search to
> automatically find a good commit, in logarithmic time.
>
>
>   Scenario
>
>   * I have a bug in HEAD.
>   * I strongly suspect that it was introduced some time ago, but I don't
>     know when exactly.
>   * I have an automated test that will find the bug if the test can run
>     properly.
>   * Most of the commits in the repository are not testable, i.e. the
>     test doesn't run properly. (E.g. because the feature it tests wasn't
>     introduced yet, refactoring, etc.)
>   * I have no idea what a good commit might be, because I don't know
>     when the first /testable/ good commit is.
>
> This sounds like a standard application for git bisect. No matter how
> big the repo, with binary search we would expect to find the first bad
> commit in logarithmic time.
>
>
>   Failed attempt
>
> The zeroth idea might be trying to find the good commit by hand, by
> reading changelogs, by trying some commits, whatever. In some
> situations, this is not feasible. In fact, such situations occur
> frequently for me, for example for undocumented features, unversioned
> rolling releases, incidental complexity leading to older commits not
> being testable, etc.
>
> The first idea that comes to mind - and it was recommended 8 years agos,
> and I've tried it a few times already - is to simply mark the root
> commit as good. (Now, there might be several roots, but that's a puzzle
> you typically only have to figure out once per repo.) This sounds great
> in theory because binary search should get through the good old commits
> in logarithmic time.
>
> The problem with this approach is that if most older commits are
> untestable, I have to git bisect skip them. This basically kills the
> logarithmic performance, because bisect skip doesn't do binary search,
> but something rather random. Just yesterday I killed a bisect search
> that took hours because it kept skipping and didn't find actual good
> commits.
>
> You might say that instead of skipping old commits, one should mark them
> as good. That's problematic because then I might accidentally mark a
> commit as good that was already untestable bad. Given that bisect has no
> undo functionality, that can quickly mess up my search. Distinguishing
> untestable good from untestable bad is really hard automatically. I
> shouldn't have to do that.
>
> Long story short: Going from the root commit typically isn't feasible.
> I've tried it.
>
>
>   Proposal: Exponential search
>
> Instead of going from the root commit, what I do manually before
> starting git bisect is this:
>
> git checkout HEAD~10
> ./test.sh # Says: "Bug is present"
> git checkout HEAD~20
> ./test.sh # Says: "Bug is still present"
> git checkout HEAD~40
> ./test.sh # Says: "Bug is still present"
> [...] # Proceed exponentially
> git checkout HEAD~640
> ./test.sh # Says: "Bug is GONE!"
> git bisect good
>
> This technique is known as
> https://en.wikipedia.org/wiki/Exponential_search, and it works very well
> in practice. I find a good commit long before I enter the "untestable
> good" region. But it's tedious to do this manually. In this example, I
> needed to run the script 8 times manually, but of course it can be more
> often, and compiling and running the test may take time. This is ok for
> a one-off search, but it's tedious for regular usages.
>
> Yes, I could wrap this up in a shell script, but I guess there are
> caveats that I didn't think of when the history isn't linear. Maybe
> someone even already has, and I'm unaware of that. But it feels like
> this could be a proper git bisect feature, and a very useful one.

Let's suppose we have a repository with 700 linear commits:
=20=20=20=20
    set -e
=20=20=20=20
    cd /tmp
    rm -rf /tmp/test-repo
    mkdir /tmp/test-repo
    cd /tmp/test-repo
    git init
=20=20=20=20
    for i in $(seq 1 700)
    do
        touch $i
        git add $i
        git commit -m"add $i"
    done

Then let's bisect it from the root:
=20=20=20=20
    git bisect start HEAD HEAD~699

And let's further suppose that the feature wasn't introduced until
commit 650, and it's broken since 653.

With the bisect method of finding this we're going to start our session
with these commits:

    [bef4b96adf5f082b1103c170eb6a41d1526fa919] add 350 =3D> good
    [d271fdb29129dbba723d3eac1035b58b6dc6f583] add 525 =3D> good
    [b0c9b7da646334a6c7eadb333b5ae77ec35388b3] add 612 =3D> good
    [2a78858d04cc5542e176dd8f68fa2660b8b48ab3] add 656 =3D> bad (or skip)

Whereas with this proposed exponential search it'll be commits #:
=20=20=20=20
    2
    4
    8
    16
    32
    64
    128
    256
    512

So we're going to test 8 commits before we get past the mid-point that
bisect now starts with. Of course that may be more efficient, but if the
regression is in some random place I don't see why we wouldn't test the
middle instead of weighing things towards the start of the history. If
the relevant commit is an early one like #50 bisect is still faster.

With the disclaimer that I may be missing something, I'm just plowing
ahead:

I don't see the usefulness of this proposed exponential search, but I
definitely *do* see the usefulness of a "bisect undo", and I've been
bitten many times by the lack of that myself. We should definitely have
that.

And as Christian pointed out in [1] it seems you're (understandably, it
can be confusing) conflating skip and "good" in your example. So to
re-state the problem you have, if I were to use "skip" in the above
example bisect for me will do:
=20=20=20=20
    [bef4b96adf5f082b1103c170eb6a41d1526fa919] add 350 =3D> skip
    [15c181442dcbd785bf2b28cfddcf1932aaa71c42] add 351 =3D> skip
    [c985feffa2c92b2d3d9804a43b215e26c7275549] add 374 =3D> skip
    [effa691ec5dc2d80c0b070c4d8ac9fa70cbfea9f] add 168 =3D> skip
    [212a5ee3ff55834196661d0632f584098e9f6fb2] add 369 =3D> skip
    [2ca67a4500c9f3cd489b9e529d41eb99252dc8f6] add 179 =3D> skip
    [4067ee067e2298e1b104f4ff9aab15f4e815e101] add 337 =3D> skip
    [...]

If only there was a way to be on 350 and say "skip everything up to this
point", so I implemented it!:

    [bef4b96adf5f082b1103c170eb6a41d1526fa919] add 350 =3D> skip-to-here
    [15c181442dcbd785bf2b28cfddcf1932aaa71c42] add 351 =3D> skip
    [6f7b5ca1dcc21c28af658a172136e503d7a2d0ea] add 420
    [...]

etc. now we're not jumping around in 1..350:

    $ git config alias.bisect-skip-to-here
    !f() { good=3D$(git for-each-ref refs/bisect/good* --format=3D"%(object=
name)"); git bisect skip $good..HEAD; }; f

Great eh? Not really, because I've just discovered a really tedious and
expensive (I created 350 "skip" refs) of re-inventing what I could do if
I just did "good" on commit 350[2] :)

I started looking at how to implement "git bisect undo", it should be
possible by either winding .git/refs/bisect based on the BISECT_LOG, or
simply keeping copies of .git/refs/bisect (and adjusting HEAD), but then
I wondered if this was something we could get for free with the ref
transactions in the reftable. CC'd Han-Wen in case he's got feedback,
maybe it's trivial, or maybe I'm imagining things.

1. https://lore.kernel.org/git/CAP8UFD2dWrUXJUuiFtgCu6krbnbGGqJZ7K+6KqstGTc=
NmSc_xQ@mail.gmail.com/
2. Not exactly, because in skip-to-here on 350 we'll next test 351, but
   "good" will test 525, but as argued earlier that's a feature.
