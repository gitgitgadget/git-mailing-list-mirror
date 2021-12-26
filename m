Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70ECC433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 22:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhLZW2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 17:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhLZW2O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 17:28:14 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F6C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:28:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id bm14so55177417edb.5
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=M6h8Kb9N5iY85CXcD0riLfKKaMWXrDgsAOueZUvLkZs=;
        b=QhpyldSrZMxGHzJeDUt/Y94mv/QO72C6JReE2A843dt+/wCb4xMHhvSo0WgEwv6I3s
         nyRwBA20S4Wx6ycozM7xHcyGVchvY9RLIisQDysqY9i5a1F9lwRN3aPQIn3vowSbBVxN
         EYLqZauVB8ryKqJtF3PMdN4U4b899GXdF79e6YwGBXYL87HdzGZTVdVZ9k+JJnyIcPfe
         69oNsAs/Hfa3VaCyB+sHFNB0JCWwha3aUgLLHb8OguyNBNaswYIY+ZTO5e5a6ydZEcR2
         BXh3HMQj74UI95uS9XjmAgNYYGgiUlNgJSoAnEbvgifq4yWpFxO4wzIbZuCLaYDf6zYe
         YdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=M6h8Kb9N5iY85CXcD0riLfKKaMWXrDgsAOueZUvLkZs=;
        b=2akEz8zPk1PetiXmc4HEEbH6nfUbnYZIA5lOlbhgqMrRfQ48NLOH+aDpBPG8EHicfc
         p1INo8C7YwnZVKOLmqcS5MC+JTGDx9cDDa13q7GbhZptS71qgBOPLCdh6Q/2FzbrITOO
         SJfoYTZx5w84SM7ok+jh9X59EO1pKspe8tqhN6Ov79bY5Ddx/HMkcYeuReEu5c2dGD6Q
         RCpf2FVx75RgLjkU98yNUO2Nx7p9LYiYJ5/X4/iphCMzMEBM2geOwqLKme2AtOEQ3ErR
         gVLtfY+law5N9aGp6u3bXuBql0GCYCsKcOgnONzEbYrYzB6BXGmekGtbX2CmJHtCk0KS
         ilpQ==
X-Gm-Message-State: AOAM533paMHC30wvmsjmoHQOIW+gbq4iVExxVlM+iULP8fka885JjUR/
        /ayiBYggYzFI+EASYrMPPcFaq4u5+GdLew==
X-Google-Smtp-Source: ABdhPJxKBJ/BA21wx5BbZy+cqQi3i5Fe0xVM1QAzbkcht+ZsskAw9iUV/8no65Cw3JXh1yRZJ1H2lw==
X-Received: by 2002:aa7:dad0:: with SMTP id x16mr14272149eds.404.1640557692417;
        Sun, 26 Dec 2021 14:28:12 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id ec4sm5454372edb.79.2021.12.26.14.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 14:28:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n1bzu-000G6g-Ep;
        Sun, 26 Dec 2021 23:28:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/8] Add a new --remerge-diff capability to show & log
Date:   Sun, 26 Dec 2021 22:52:56 +0100
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
Message-ID: <211226.86lf07f1c5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 25 2021, Elijah Newren via GitGitGadget wrote:

> =3D=3D=3D FURTHER BACKGROUND (original cover letter material) =3D=3D
>
> Here are some example commits you can try this out on (with git show
> --remerge-diff $COMMIT):
>
>  * git.git conflicted merge: 07601b5b36
>  * git.git non-conflicted change: bf04590ecd
>  * linux.git conflicted merge: eab3540562fb
>  * linux.git non-conflicted change: 223cea6a4f05
>
> Many more can be found by just running git log --merges --remerge-diff in
> your repository of choice and searching for diffs (most merges tend to be
> clean and unmodified and thus produce no diff but a search of '^diff' in =
the
> log output tends to find the examples nicely).
>
> Some basic high level details about this new option:
>
>  * This option is most naturally compared to --cc, though the output seems
>    to be much more understandable to most users than --cc output.
>  * Since merges are often clean and unmodified, this new option results in
>    an empty diff for most merges.
>  * This new option shows things like the removal of conflict markers, whi=
ch
>    hunks users picked from the various conflicted sides to keep or remove,
>    and shows changes made outside of conflict markers (which might reflect
>    changes needed to resolve semantic conflicts or cleanups of e.g.
>    compilation warnings or other additional changes an integrator felt
>    belonged in the merged result).
>  * This new option does not (currently) work for octopus merges, since
>    merge-ort is specific to two-parent merges[1].
>  * This option will not work on a read-only or full filesystem[2].
>  * We discussed this capability at Git Merge 2020, and one of the
>    suggestions was doing a periodic git gc --auto during the operation (d=
ue
>    to potential new blobs and trees created during the operation). I foun=
d a
>    way to avoid that; see [2].
>  * This option is faster than you'd probably expect; it handles 33.5 merge
>    commits per second in linux.git on my computer; see below.
>
> In regards to the performance point above, the timing for running the
> following command:
>
> time git log --min-parents=3D2 --max-parents=3D2 $DIFF_FLAG | wc -l

I've been trying to come up with some other useful recipies for this new
option (which is already very useful, thanks!)

Some of these (if correct) are suggestions for incorporating into the
(now rather sparse) documentation. I.e. walking users through how to use
this, and how (if at all) it combines with other options.

I wanted to find all merges between "master".."seen" for which Junio's
had to resolve a conflict, a na=C3=AFve version is:

    $ git log --oneline --remerge-diff -p --min-parents=3D2 origin/master..=
origin/seen|grep ^diff -B1 | grep Merge
    [...]

But I found that this new option nicely integrates with --diff-filter,
i.e. we'll end up showing a diff, and the diff machinery allows you to
to filter on it.

It seems to me like all the diffs you show fall under "M", so for
master..seen (2ae0a9cb829..61055c2920d) this is equivalent (and the
output is the same as the above):

    $ git -P log --oneline --remerge-diff --no-patch --min-parents=3D2 --di=
ff-filter=3DM origin/master..origin/seen=20
    95daa54b1c3 Merge branch 'hn/reftable-fixes' into seen
    26c4c09dd34 Merge branch 'gc/fetch-negotiate-only-early-return' into se=
en
    e3dc8d073f6 Merge branch 'gc/branch-recurse-submodules' into seen
    aeada898196 Merge branch 'js/branch-track-inherit' into seen
    4dd30e0da45 Merge branch 'jh/builtin-fsmonitor-part2' into seen
    337743b17d0 Merge branch 'ab/config-based-hooks-2' into seen
    261672178c0 Merge branch 'pw/fix-some-issues-in-reset-head' into seen
    1296d35b041 Merge branch 'ms/customizable-ident-expansion' into seen
    7a3d7d05126 Merge branch 'ja/i18n-similar-messages' into seen
    eda714bb8bc Merge branch 'tb/midx-bitmap-corruption-fix' into seen
    ba02295e3f8 Merge branch 'jh/p4-human-unit-numbers' into jch
    751773fc38b Merge branch 'es/test-chain-lint' into jch
    ec17879f495 Merge branch 'tb/cruft-packs' into tb/midx-bitmap-corruptio=
n-fix

However for "origin/master..origin/next" (next =3D 510f9eba9a2 currently)
we'll oddly show this with "-p":
=20=20=20=20
    9af51fd1d0d Sync with 'master'
    diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
    CONFLICT (content): Merge conflict in t/lib-gpg.sh
    d6f56f3248e Merge branch 'es/test-chain-lint' into next
    diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
    CONFLICT (content): Merge conflict in t/t4126-apply-empty.sh
    index 996c93329c6..33860d38290 100755
    --- a/t/t4126-apply-empty.sh
    +++ b/t/t4126-apply-empty.sh
    [...]

The "oddly" applying only to that "9af51fd1d0d Sync with 'master'", not
the second d6f56f3248e, which shows the sort of conflict I'd expect. The
two-line "diff" of:

    diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
    CONFLICT (content): Merge conflict in t/lib-gpg.sh

Shows up with -p --remerge-diff, not a mere -p. I also tried the other
--diff-merges=3D* options, that behavior is new in
--diff-merges=3Dremerge. Is this a bug?

My local build also has a --pickaxe-patch option. It's something I
submitted on-list before[1] and have been meaning to re-roll.

I'm discussing it here because it skips the stripping of the "+ " and "-
" prefixes under -G<regex> and allows you to search through the -U<n>
context. With that I'm able to do:

    git log --oneline --remerge-diff -p --min-parents=3D2 --pickaxe-patch -=
G'^\+' --diff-filter=3DM origin/master..origin/seen

I.e. on top of the above filter only show those diffs that have
additions. FAICT the conflicting diffs where the committer of the merge
conflict picked one side or the other will only have "-" lines".

So those diffs that have additions look to be those where the person
doing the merge needed to combine the two.

Well, usually. E.g. 26c4c09dd34 (Merge branch
'gc/fetch-negotiate-only-early-return' into seen, 2021-12-25) in that
range shows that isn't strictly true. Most such deletion-only diffs are
less interesting in picking one side or the other of the conflict, but
that one combines the two:
=20=20=20=20
    -<<<<<<< d3419aac9f4 (Merge branch 'pw/add-p-hunk-split-fix' into seen)
                            warning(_("protocol does not support --negotiat=
e-only, exiting"));
    -                       return 1;
    -=3D=3D=3D=3D=3D=3D=3D
    -                       warning(_("Protocol does not support --negotiat=
e-only, exiting."));
                            result =3D 1;
                            goto cleanup;
    ->>>>>>> 495e8601f28 (builtin/fetch: die on --negotiate-only and --recu=
rse-submodules)

Which I guess is partially commentary and partially a request (either
for this series, or some follow-up) for something like a
--remerge-diff-filter option. I.e. it would be very useful to be able to
filter on some combination of:

 * Which side(s) of the conflict(s) were picked, or a combination?
 * Is there "new work" in the diff to resolve the conflict?
   AFIACT this will always mean we'll have "+ " lines.

Or maybe that's not useful at all, and just -G<rx> (maybe combined with
my --pickaxe-patch) will cover it?

1. https://lore.kernel.org/git/20190424152215.16251-3-avarab@gmail.com/
