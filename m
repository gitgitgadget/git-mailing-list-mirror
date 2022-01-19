Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988AEC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 11:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiATL1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiATL13 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 06:27:29 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CE2C06173F
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:27:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so27268216edj.7
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=k55gM3YrAC4xQjOaF5mmL6TH9VkOimQSy4Xf5DGxDRE=;
        b=nv55QF7xmR6IrLIE4kbXsLLScjSwKIK4fnsC+N3RnmY5QRGb0CxPkjv4Cp5nuo0uUy
         E8XDuZIeYQyiXPmHBqcJS+da/BNScpUnRNUvL9fRVy/2PHOB4i3005Q4p/scwDgH33/2
         t9VbCYIqsbwJvbHs9LAdcHWIWlUS+tZoTP8gKTJ7GC/hB9dX20JjsvmtETlHb7XDPuuQ
         HRGYOwM6Rd4TqtrkH/ZjXRO3yaR1O2+I6rLQoy87iCch3kbv8jjZmapcDLH7Gnx/huEv
         9OyF7LiGzNj4alZJKO8DCS8+iyuVZt6Ixz6oH89qY59o6U3aKRZeV8C5GKMx86Q+EqpA
         wTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=k55gM3YrAC4xQjOaF5mmL6TH9VkOimQSy4Xf5DGxDRE=;
        b=Q2VK3HPG/l30W13HWld7DqEhs58o/a3GI/0iD/RHaynlLiJoVqLpCWlZmJwRjHI/zA
         hHO3CA1vSKMmy/Z2FQ0RDIweNmMPmO9Yut4ZO/lg/7G2v/paKYtOyW6WVRo0xL0X26K3
         yzmu7dFMM79rpGPXhalCJ+OdjL6jt/TQVZtLQHLz+eFW2lMgWDgkFlagQxzPhAQBdr23
         eHkGB0/ISUxFB/St8ei5lj6J5dtZJ49DjQzpkmz9quA231+E5LWh5agI/Yy3Ys8dxX0H
         3yoFXwg6LfeuoWr9KQMUKFbW7lW3qtRYmVvGkvSzfX6ALrpxVQ9NpwZ9SKrXm5g0wstt
         rjYg==
X-Gm-Message-State: AOAM533fJbIDRX2FjPJgWiatwO+7mVIwraCLw4yq2+HmXEurCslsxjCb
        /Q8AFqUn9Ll9XbqPXLwZVt7+8kXovIpPTg==
X-Google-Smtp-Source: ABdhPJzl2NDyxvA4/QHImv0DNfjBPg6lScbU0/vJ1uz5aQgur5nWw1tXL7vwlVbkbt2/qPSfRTnhfw==
X-Received: by 2002:a17:906:7e56:: with SMTP id z22mr120907ejr.531.1642678047209;
        Thu, 20 Jan 2022 03:27:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lt2sm886058ejb.50.2022.01.20.03.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 03:27:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAVbC-001wpI-7S;
        Thu, 20 Jan 2022 12:27:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 8/9] show, log: include conflict/warning messages in
 --remerge-diff headers
Date:   Wed, 19 Jan 2022 17:19:14 +0100
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
        <78ec1f44e4eacdb05c9da749a2160f4748565ad3.1640907369.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <78ec1f44e4eacdb05c9da749a2160f4748565ad3.1640907369.git.gitgitgadget@gmail.com>
Message-ID: <220120.868rvamyu9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 30 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Conflicts such as modify/delete, rename/rename, or file/directory are
> not representable via content conflict markers, and the normal output
> messages notifying users about these were dropped with --remerge-diff.
> While we don't want these messages randomly shown before the commit
> and diff headers, we do want them to still be shown; include them as
> part of the diff headers instead.
> [...]
> +test_expect_success 'setup non-content conflicts' '
> +	git switch --orphan base &&
> +
> +	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
> +	test_write_lines a b c d e f g h i >letters &&
> +	test_write_lines in the way >content &&
> +	git add numbers letters content &&
> +	git commit -m base &&
> +
> +	git branch side1 &&
> +	git branch side2 &&
> +
> +	git checkout side1 &&
> +	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
> +	git mv letters letters_side1 &&
> +	git mv content file_or_directory &&
> +	git add numbers &&
> +	git commit -m side1 &&
> +
> +	git checkout side2 &&
> +	git rm numbers &&
> +	git mv letters letters_side2 &&
> +	mkdir file_or_directory &&
> +	echo hello >file_or_directory/world &&
> +	git add file_or_directory/world &&
> +	git commit -m side2 &&
> +
> +	git checkout -b resolution side1 &&
> +	test_must_fail git merge side2 &&
> +	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
> +	git add numbers &&
> +	git add letters_side1 &&
> +	git rm letters &&
> +	git rm letters_side2 &&
> +	git add file_or_directory~HEAD &&
> +	git mv file_or_directory~HEAD wanted_content &&
> +	git commit -m resolved
> +'
> +
> +test_expect_success 'remerge-diff with non-content conflicts' '
> +	git log -1 --oneline resolution >tmp &&
> +	cat <<-EOF >>tmp &&
> +	diff --git a/file_or_directory~HASH (side1) b/wanted_content
> +	similarity index 100%
> +	rename from file_or_directory~HASH (side1)
> +	rename to wanted_content
> +	remerge CONFLICT (file/directory): directory in the way of file_or_dire=
ctory from HASH (side1); moving it to file_or_directory~HASH (side1) instea=
d.
> +	diff --git a/letters b/letters
> +	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in H=
ASH (side1) and to letters_side2 in HASH (side2).
> +	diff --git a/letters_side2 b/letters_side2
> +	deleted file mode 100644
> +	index b236ae5..0000000
> +	--- a/letters_side2
> +	+++ /dev/null
> +	@@ -1,9 +0,0 @@
> +	-a
> +	-b
> +	-c
> +	-d
> +	-e
> +	-f
> +	-g
> +	-h
> +	-i
> +	diff --git a/numbers b/numbers
> +	remerge CONFLICT (modify/delete): numbers deleted in HASH (side2) and m=
odified in HASH (side1).  Version HASH (side1) of numbers left in tree.
> +	EOF
> +	# We still have some sha1 hashes above; rip them out so test works
> +	# with sha256
> +	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
> +
> +	git show --oneline --remerge-diff resolution >tmp &&
> +	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

Re my comment about --diff-filter in an earlier round, I think testing
for that option should really be added here.

With current master and seen:

    $ git rev-parse origin/master
    50b2d72e110cad39ecaf2322bfdf1b60cd13dd96
    $ git rev-parse origin/seen
    9e835a8bdafce2aaeb6df5f57f11014051bbfdca

I will, with A, M, D get:

    for i in A M D; do echo With $i: && git -P log --oneline --remerge-diff=
 --diff-filter=3D$i origin/master..origin/seen; done

Some of which is expected, and some of which is still weird, e.g.:
=20=20=20=20
    $ git log --oneline --remerge-diff --diff-filter=3DD origin/master..ori=
gin/seen
    d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) into=
 seen
    diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
    remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh
    61239ae3ee7 Merge branch 'pw/fix-some-issues-in-reset-head' into seen
    diff --git a/reset.c b/reset.c
    remerge CONFLICT (content): Merge conflict in reset.c
    diff --git a/sequencer.c b/sequencer.c
    remerge CONFLICT (content): Merge conflict in sequencer.c
    9b44aca15e4 Merge branch 'hn/reftable-coverity-fixes' into jch
    diff --git a/reftable/stack.c b/reftable/stack.c
    remerge CONFLICT (content): Merge conflict in reftable/stack.c
    [...]

Let's take the jh/builtin-fsmonitor-part2 merge, with =3DM I get this
output:
=20=20=20=20=20=20=20=20
    $ git -P show --oneline --remerge-diff --diff-filter=3DM d120673d7cc
    d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) into=
 seen
    diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
    remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh
    index 03269b5553b..e70252ed65a 100755
    --- a/t/perf/p7519-fsmonitor.sh
    +++ b/t/perf/p7519-fsmonitor.sh
    @@ -127,18 +127,11 @@ test_expect_success "one time repo setup" '
            fi &&
=20=20=20=20=20
            mkdir 1_file 10_files 100_files 1000_files 10000_files &&
    -<<<<<<< 61239ae3ee7 (Merge branch 'pw/fix-some-issues-in-reset-head' i=
nto seen)
    -       for i in $(test_seq 1 10); do touch 10_files/$i || return 1; do=
ne &&
    -       for i in $(test_seq 1 100); do touch 100_files/$i || return 1; =
done &&
    -       for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1=
; done &&
    -       for i in $(test_seq 1 10000); do touch 10000_files/$i || return=
 1; done &&
    -=3D=3D=3D=3D=3D=3D=3D
            touch_files 1 &&
            touch_files 10 &&
            touch_files 100 &&
            touch_files 1000 &&
            touch_files 10000 &&
    ->>>>>>> e89980feb1d (t7527: test status with untracked-cache and fsmon=
itor--daemon)
            git add 1_file 10_files 100_files 1000_files 10000_files &&
            git commit -qm "Add files" &&

Which is fully expected, i.e. here the diff is modified (M).

But there aren't any added lines, so why do I get it under =3DA, and why
isn't the diff shown with =3DD (compare a normal 'git log --diff-filter=3DD
-p')?:
=20=20=20=20
    $ for i in A D; do echo With $i: && git -P show --oneline --remerge-dif=
f --diff-filter=3D$i d120673d7cc; done
    With A:
    d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) into=
 seen
    diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
    remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh
    With D:
    d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) into=
 seen
    diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
    remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh

Furthermore pathspec arguments seem to be broken. I.e. to use that
commit we can see without --remerge-diff that it's not directly modified
in a non-merge in that range:
=20=20=20=20
    $ git -P log --oneline origin/master..origin/next -- t/perf/p7519-fsmon=
itor.sh
    d6f56f3248e Merge branch 'es/test-chain-lint' into next
=20=20=20=20
But this should surely work, but doesn't. It's faking up a diff with =3DM,
so the pathspec filters should show it, shouldn't they?

    $ for i in A M D; do git -P show --oneline --remerge-diff --diff-filter=
=3D$i d120673d7cc -- t/perf/p7519-fsmonitor.sh; done
    $

Probably what's happening is that the filtering is being done on the
pre-"-remerge-diff" output. I.e. the traversal code needs to be updated
to inject modified paths into the commits we show --remerge-diff commits
for (but I'm just guessing).

For the rest of the --diff-filter flags the behavior also seems wrong, I
really didn't expect this to show any output:

    $ for i in R T U X B; do echo With $i: && git -P show --oneline --remer=
ge-diff --diff-filter=3D$i d120673d7cc; done
    With R:
    d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) into=
 seen
    diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
    remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh
    With T:
    d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) into=
 seen
    diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
    remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh
    With U:
    d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) into=
 seen
    diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
    remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh
    With X:
    d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) into=
 seen
    diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
    remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh
    With B:
    d120673d7cc Merge branch 'jh/builtin-fsmonitor-part2' (early part) into=
 seen
    diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
    remerge CONFLICT (content): Merge conflict in t/perf/p7519-fsmonitor.sh

I.e. we don't have a (R)ename, (T)type change, (U)nmerged (well, maybe,
but isn't it just for the index? See t6060-merge-index.sh) or Unknown
(X) there. Are they all being shown because of that generic "remerge
CONFLICT" line?

If the answer to all of the above is "yes, some of it is weird or
unintended, but let's deal with it later" I'd think that would also be
fine.

But let's then at least add something like what I added to the
git-range-diff.txt docs in df569c3f31f (range-diff doc: add a section
about output stability, 2018-11-09). I.e. explicitly say that we might
change the output when combined with other log options in the future,
and that any combination not currently documented won't be supported.

Re the CL mention of:
=20=20=20=20
     * =C3=86var suggested also extending the docs with usage guidelines, b=
ut the
       example he picked was IMO best handled by just add --remerge-diff, s=
o I'm
       not sure what to add to the docs. Maybe the log -S<string> --remerge=
-diff
       example as a way to more reliably determine when a string was added =
to or
       removed from the codebase? Where would that go anyway?

I don't think we need to document how --remerge-diff interacts with -S,
-G, or perhaps even most of --diff-filter.

But per the above it seems to me that we should at least have basic
tests (perhaps TODO tests), or explicitly document/note that some of the
interactions are buggy/weird (or not, maybe I'm just missing something).

The same goes for some other diff options, particularly those where
we're showing output we didn't before because of --remerge-diff,
e.g. --check is one such option. When I alter your tests with:
=20=20=20=20
    diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
    index c1b44138145..d96320e6ab8 100755
    --- a/t/t4069-remerge-diff.sh
    +++ b/t/t4069-remerge-diff.sh
    @@ -120,7 +120,8 @@ test_expect_success 'setup non-content conflicts' '
=20=20=20=20=20
            git checkout -b resolution side1 &&
            test_must_fail git merge side2 &&
    -       test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
    +       test_write_lines 1 2 three 4 5 6 7 8 >numbers &&
    +       echo "9 " >>numbers &&
            git add numbers &&
            git add letters_side1 &&
            git rm letters &&

The --check option works as expected, but we've got no test for the
combination of the two. Maybe we don't need them since we're confident
enough in the shared machinery, but I'd think it would be better to
consider this a black box and test it. I.e. maybe another --check
implementation would filter on whatever we use for the pathspecs
(showing it doesn't need to look at merge commits), and show nothing.
=20=20=20=20
All of the above is just noting the journy of testing this, i.e. "hrm,
will it work with XYZ? No? Seems odd, and it's not tested at all...".

As noted before I find the current output really useful already. I've
just been trying to poke it in various ways to see if I can uncover any
bugs or unintended behavior.
