Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF1C433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 19:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB7761037
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 19:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhKMTjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 14:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhKMTi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 14:38:59 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC06C061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 11:36:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g14so52333541edz.2
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 11:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XEbySPLSE26SeIy3/RKKBH3XIhD3zkwRb5A5MaW4h5k=;
        b=i1YUNQO5iS1jCbPqoOwUIqTH51FiiCb0NxDS/H13yTxxCQiC9MqMJek/tQjkISr5OA
         UfeOSC2lYbXLi0fRW4PEmZDNciqGcvT3a8XrWrSbBPlsyNo8Qbq9KA51DhNKGi0NsxYi
         LX6eo8KMN+Lp3rCbxgzsAzVGKkNQc9NKpO9HuDZwl4E/9jf4qtdZhiuQDSOiDqMBhxvz
         DMCwnYVZGo7tZ+cEKqf1GnzyJdJBvKAxyZohNeiVuCKJXhy71UJSTL7YHV55amcKtbKR
         yv5ZSwcwxs1koCkPeJof9lgk55qxqY8zf2KNyF9d63Mqjj9vcGlEYYntr5aUsYES204U
         oV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XEbySPLSE26SeIy3/RKKBH3XIhD3zkwRb5A5MaW4h5k=;
        b=MZ8xkUtpfKXf+4eCJOGF/MtdqK6pxs++nQsCoY8QHttc10e38+cXNb3m8FSHZIFkob
         CWAmHyYWbxMLQBnvohFZUf/jTHmaLFv5/1j9UEOcY6xv1MfrwUiEHSUsI7iTY6Eico87
         U56XcrzEpyBQvIp9gwoNr/BoQ1X7AFigp3jo5NZmwcZb10tTfQx9ajNRxFZTQ/jSTkD0
         I/4cxGjPvOQh9S0xsdQseRFgJHFF7Px6wtEYckPinO3alfCR6alCIHDF5kWP2hZ2JaSF
         v9H2g9iqZwoeSKeSkBDWrouM/GD1VZdTmnITraRhFJQM2HyGHCjsP1HLChteoLpS8kzo
         udKQ==
X-Gm-Message-State: AOAM533Cl/lC2pZyjg6Odf4aTu1A/Uvz6yF4uORJ6zGEUhTKZfgBA8Pv
        oafyoBwxnex7OKfJctmjeg+KE13PK5pt9hlV8C0=
X-Google-Smtp-Source: ABdhPJyJokdWZ2GRSxaQj47mG0pZdWyXtley1100OOL2MqLv7hlRKZzGeRhj2OElEWdIgL3lbUfwKh19Wm+ea4nwe00=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr31995082eji.434.1636832164837;
 Sat, 13 Nov 2021 11:36:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com> <211113.86pmr4tm7p.gmgdl@evledraar.gmail.com>
In-Reply-To: <211113.86pmr4tm7p.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 13 Nov 2021 11:35:53 -0800
Message-ID: <CABPp-BEeUM+3NLKDVdak90_UUeNghYCx=Dgir6=8ixvYmvyq3Q@mail.gmail.com>
Subject: Re: [PATCH] name-rev: prefer shorter names over following merges
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Sat, Nov 13, 2021 at 1:54 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Nov 13 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > name-rev has a MERGE_TRAVERSAL_WEIGHT to say that traversing a second o=
r
> > later parent of a merge should be 65535 times more expensive than a
> > first-parent traversal, as per ac076c29ae8d (name-rev: Fix non-shortest
> > description, 2007-08-27).  The point of this weight is to prefer names
> > like
> >
> >     v2.32.0~1471^2
> >
> > over names like
> >
> >     v2.32.0~43^2~15^2~11^2~20^2~31^2
> >
> > which are two equally valid names in git.git for the same commit.  Note
> > that the first follows 1472 parent traversals compared to a mere 125 fo=
r
> > the second.  Weighting all traversals equally would clearly prefer the
> > second name since it has fewer parent traversals, but humans aren't
> > going to be traversing commits and they tend to have an easier time
> > digesting names with fewer segments.  The fact that the former only has
> > two segments (~1471, ^2) makes it much simpler than the latter which ha=
s
> > six segments (~43, ^2, ~15, etc.).  Since name-rev is meant to "find
> > symbolic names suitable for human digestion", we prefer fewer segments.
> >
> > However, the particular rule implemented in name-rev would actually
> > prefer
> >
> >     v2.33.0-rc0~11^2~1
> >
> > over
> >
> >     v2.33.0-rc0~20^2
> >
> > because both have precisely one second parent traversal, and it gives
> > the tie breaker to shortest number of total parent traversals.  Fewer
> > segments is more important for human consumption than number of hops, s=
o
> > we'd rather see the latter which has one fewer segment.

Since you bring up semantic meaning of the names with more second
parents (which I'll address below), let me add an aside here on
semantic meaning of the names that prefer first-parent traversals:

In addition to shorter names just being easier for humans to consume,
for many repositories the first-parent-traversal-preferred names also
answer the question: "How or when did this commit get merged?"

For example, let's look at commit cbdca289fb -- the second to last
commit of en/ort-perf-batch-11.

Prior to my changes:

* `git name-rev cbdca289fb` used to report tags/v2.33.0-rc0~57^2~5
* v2.33.0-rc0~57^2 is en/ort-perf-batch-12
* v2.33.0-rc0~57 is "Merge branch 'en/ort-perf-batch-12'"
* None of this tells us when cbdca289fb was merged into master.

After my changes:

* `git name-rev cbdca289fb` reports tags/v2.33.0-rc0~112^2~1 [*]
* v2.33.0-rc0~112^2 is the tip of en/ort-perf-batch-11
* v2.33.0-rc0~112 is "Merge branch 'en/ort-perf-batch-11'"
* The commit above identifies exactly when cbdca289fb was merged into maste=
r.

Granted, this semantic meaning isn't guaranteed since it is possible
for multiple folks to merge each other's work.  So I didn't mention
this auxiliary advantage in my commit message, instead just focusing
on the primary advantage of "easier for human consumption".  However,
for many common repositories (I can only think of a couple
counter-examples out of the hundreds of repositories I have worked
with), the shorter names do have this extra semantic meaning.


[*] If you're curious why my changes provide this alternate name
despite having the same number of segments as the old name: (a)
cbdca289fb is the parent of 25e65b6dd5 -- thus the name for cbdca289fb
is the first parent of the preferred name for 25e65b6dd5, (b)
25e65b6dd5 could be named either v2.33.0-rc0~112^2 or
v2.33.0-rc0~57^2~4, but the former is preferred over the latter due to
fewer segments, (c) combine the two previous facts, and we get the
name "v2.33.0-rc0~112^2~1" rather than "v2.33.0-rc0~57^2~5".

> >
> > Include the generation in is_better_name() and use a new
> > effective_distance() calculation so that we prefer fewer segments in
> > the printed name over fewer total parent traversals performed to get th=
e
> > answer.
>
> So it's the case that if you were to print out the output of "git log
> --graph --oneline" for these ranges and draw the path we'd take for
> either variant of these examples we'd take different path, i.e. the
> first version takes the ^1 parent every time, and the second traverses
> various ^2 parents.

Not quite, no.  The shorter names do not exclude second parent
traversals (both of the shorter names had one second parent traversal
at the end, because the commits in question are unreachable solely by
first parent traversals).  But I think your intended point was that
the shorter names _prefer_ first parent traversals when possible.
That is certainly true.

> I think this change looks good in the context of name-rev

Awesome, thanks for reviewing.  :-)

>, but I wonder
> if longer names wouldn't be easier to understand in some cases,
> i.e. you'd more clearly get an idea of how this change was tangled up
> with other topics.

Interesting thought, but no.  You'd have to perform a much different
kind of search to find that info.

I think these longer names following more second parents only give you
a quasi-random selection of topics and what commit was "recently
stable as a base" at the time they were applied.  We can see this by
using the example from the commit message; the name
"v2.32.0~43^2~15^2~11^2~20^2~31^2" gives us five chances to look for
tangling or dependencies.  Let's see how many of them show some:

=3D=3D 1st example =3D=3D

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~43^2~15^2~11^2~20^2~31^2
062a309d36,Ren=C3=A9 Scharfe,remote-curl: use argv_array in parse_push()

Now let's trim off the "~31^2" portion of the above and we see:

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~43^2~15^2~11^2~20^2
63020f175f,Derrick Stolee,commit-graph: prefer default size_mult when given=
 zero

Was Stolee's patch based on Rene's?  No, just following its first parent we=
 see:

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~43^2~15^2~11^2~20^2~1
53a06cf39b,Johannes Schindelin,Git 2.24.1


=3D=3D 2nd example =3D=3D

Trimming off the trailing "~20^2" portion from the name for Stolee's
commit, we see:

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~43^2~15^2~11^2
70e24186c0,Elijah Newren,t6022, t6046: fix flaky files-are-updated checks

That was not tangled or dependent upon Stolee's commit, rather it was a
6-patch series that just happened to be rooted at:

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~43^2~15^2~11^2~6
d0654dc308,Junio C Hamano,Git 2.25


=3D=3D 3rd example =3D=3D

Trimming off the trailing "~11^2" portion from the name for my commit, we s=
ee:

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~43^2~15^2
173cb08d5b,Carlo Marcelo Arenas Bel=C3=B3n,bisect: avoid tailing CR
characters from revision in replay

But that commit wasn't tangled with or dependent on mine.  It was a
2-patch series based on:

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~43^2~15^2~2
af6b65d45e,Jonathan Nieder,Git 2.26.2


=3D=3D 4th example =3D=3D

Trimming off the trailing "~15^2" portion from the name for Carlo's
commit, we see:

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~43^2
3a7f0908b6,Matheus Tavares,clean: remove unnecessary variable

That series didn't depend on Carlo's commit; it was a single
standalone patch that depended on

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~43^2~1
6ff7f46039,Johannes Schindelin,Git 2.27.1


=3D=3D 5th example =3D=3D

Trimming off the trailing "~43^2" portion from the name for Matheus's
commit, we see:

$ git log -1 --format=3D'%h,%an,%s' v2.32.0
ebf3c04b26,Junio C Hamano,Git 2.32

Pretty obvious.  Should be clear this didn't depend on Matheus's
commit; in fact, it was just a commit on top of:

$ git log -1 --format=3D'%h,%an,%s' v2.32.0~1
15664a5f35,Junio C Hamano,Merge tag 'l10n-2.32.0-rnd1.1' of
git://github.com/git-l10n/git-po


So 0 of the 5 showed any kind of tangling or dependencies.  This
commit dates back nearly to the 2.24.1 era and we've had lots of
topics that depended on other topics in the meantime, but it clearly
missed all of them.  I see it as five random topics between v2.32.0
and v2.24.1.  The odds of those hitting a tangled topic are slim since
most of our topics are standalone; but even if it does hit one, it's
almost certainly going to miss all the other dependent topics between
the commit and relevant tag used as the basis of the name.

> Does one or the other of these versions provide a better hint for the
> "this branch is used by" relationships in What's Cooking?

It can, but it's rather unlikely to be very helpful.  Most of the time
it won't provide any hint, and even if it does provide an interesting
name that suggests there might be a relationship, you'd have to double
check it to make sure it's not a false positive (as per the five
examples above).  But, let's put it to the test.  I had to do two
things to try this out:

* name-rev normally fails on topics in "What's Cooking" becasue none
of them are tagged yet, but we can force the issue by telling name-rev
to use "seen" for naming things.
* I modified builtin/name-rev.c to change the MERGE_TRAVERSAL_WEIGHT
from 65535 to 1 (so that shortest distance is preferred rather than
fewest name segments, causing it to be much more likely to follow
second parents).

With those changes, let's look at all three examples from the most
recent "What's cooking":

1. ld/sparse-diff-blame uses vd/sparse-reset

$ git name-rev --refs=3Drefs/remotes/origin/seen gitster/ld/sparse-diff-bla=
me
gitster/ld/sparse-diff-blame remotes/origin/seen~6^2
$ git name-rev --refs=3Drefs/remotes/origin/seen gitster/vd/sparse-reset
gitster/vd/sparse-reset remotes/origin/seen~7^2

Doesn't hint at the relationship at all.

2. ns/batched-fsync uses ns/tmp-objdir

$ git name-rev --refs=3Drefs/remotes/origin/seen gitster/ns/batched-fsync
gitster/ns/batched-fsync remotes/origin/seen~50^2
$ git name-rev --refs=3Drefs/remotes/origin/seen gitster/ns/tmp-objdir
gitster/ns/tmp-objdir remotes/origin/seen~8^2~7^2

Doesn't hint at the relationship between the two at all.

3. ns/remerge-diff uses ns/tmp-objdir

$ git name-rev --refs=3Drefs/remotes/origin/seen gitster/ns/remerge-diff
gitster/ns/remerge-diff remotes/origin/seen~8^2
$ git name-rev --refs=3Drefs/remotes/origin/seen gitster/ns/tmp-objdir
gitster/ns/tmp-objdir remotes/origin/seen~8^2~7^2

Ahah, there we actually see what might be a relationship.  As noted
above, though, one would have to first check whether ns/remerge-diff
was actually a 7 patch series (turns out that it is) in order to
verify that one is based directly on the other; otherwise it's just a
false positive like the five we looked at above.


I also repeated this with the Sept. 20 "What's cooking email".  In
that case, only 1 out of 6 of the generated names hinted at a
relationship.  That's few enough to not be useful, especially when
there's also risk of false positives that would need to be double
checked by a different means anyway.  So, in short, the longer names
that follow second parents generally don't seem to provide any useful
semantic meaning I can think of beyond "what's the fewest parent
traversals I can use from my base tag to get to the commit in
question".  If you can think of one, perhaps it would be useful to add
a flag to request the alternate name.  I just can't think of any.
