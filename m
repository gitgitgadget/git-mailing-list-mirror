Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F8DC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 17:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiC2RLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbiC2RLY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 13:11:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9248FA1475
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:09:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p15so31417775lfk.8
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=694eIyYjkNW8FU6j/YwkTLj0R+IHtHA5ctGl8Yg82uk=;
        b=GaXPvf8gSZDCM2uAetivlMW8JTQIkb0TXKDD6wqtKD5p5FG82g6mBfstYDLimMUPNr
         pVyt+ECBES0RvLLChXE//JUdNQ9RiCJj8YtI9iqUxlCKe/k8F55mCadoGzZ/nZi0e2hn
         hIRIyyV05xYRR7qX3vTsd97s/mOEg95gWdU/eTR4K2RDYAIKynFBO9tEHDcQGvevy+ot
         o7xxpI0KfSZkFGPgnXjqSHfTEyiQUvweaGBh1upvcannzA5v5RU94JiS5p3Jd5G9gWya
         ocqLUnCcJdSuwjrhjAGDVzEfUCINRXpMIfPxGyXHdAsMsha/7xz8N6ysiOBkMF0BMrB6
         oo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=694eIyYjkNW8FU6j/YwkTLj0R+IHtHA5ctGl8Yg82uk=;
        b=lTY+MDV7yRktdnzpu/bfbF/6NyVTMtLXUKbGLcru5JFjhSLMy1m8xE8dlNPBJJ/zNo
         7D4Udhif9YwHzRheI+/Wroslqelh7OaXYpAYXoWF2LvlVui8bO5LO8fuMik555dr+TZn
         Bdd5KoIWYFEgy0onJO9AroMwgvKabBq7jMCFIjdBR0/hP/IowN5axIKgk7m8kU5wbpGH
         P5tJ2/Ob7HMZyFHSuEh0fMI3w7H/cx1kWcwoc1FGVN1VF2Ofm2WBa1Mxw3vilm3hKx0r
         jlrXqgM2CrKkCDPNXP8WC+fK387CAjz7SPRmA71idpXOcu8bV14XbcuvYI+g6Zs6CiTk
         oqGw==
X-Gm-Message-State: AOAM530zLGrbU60jh2j5vhvUaUay7uicU3dTHlkWatsOxbfwDeE9W6FS
        WR3hXrCA9oA532Mxh8aFHGwsqRun/4szaS4M4bWgycQ/xz0XUw==
X-Google-Smtp-Source: ABdhPJz+iObl/QCkp2F+/qza9SSs+Zl/Lu09vhVuLZJokykfSqoumO/1y3/8/Fgv9HzC555V6QMZIpvv+SkVXyt0kvE=
X-Received: by 2002:a05:6512:1684:b0:448:a0e6:9fa6 with SMTP id
 bu4-20020a056512168400b00448a0e69fa6mr3668053lfb.592.1648573778658; Tue, 29
 Mar 2022 10:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
 <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com> <220329.86czi52ekn.gmgdl@evledraar.gmail.com>
In-Reply-To: <220329.86czi52ekn.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 29 Mar 2022 10:09:26 -0700
Message-ID: <CANQDOdf2tXM6f2U5=68Htw+AGyrAM0C6UAVPmfxCk8Ga7pek2g@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 4:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Mar 29 2022, Neeraj K. Singh via GitGitGadget wrote:
>
> > V4 changes:
> >
> >  * Make ODB transactions nestable.
> >  * Add an ODB transaction around writing out the cached tree.
> >  * Change update-index to use a more straightforward way of managing OD=
B
> >    transactions.
> >  * Fix missing 'local's in lib-unique-files
> >  * Add a per-iteration setup mechanism to test_perf.
> >  * Fix camelCasing in warning message.
>
> I haven't looked at the bulk of this in any detail, but:
>
> >  10:  b99b32a469c ! 12:  fdf90d45f52 core.fsyncmethod: performance test=
s for add and stash
> >      @@ t/perf/p3700-add.sh (new)
> >       +# core.fsyncMethod=3Dbatch mode, which is why we are testing dif=
ferent values
> >       +# of that setting explicitly and creating a lot of unique object=
s.
> >       +
> >      -+test_description=3D"Tests performance of add"
> >      ++test_description=3D"Tests performance of adding things to the ob=
ject database"
>
> Now having both tests for "add" and "stash" in a test named p3700-add.sh
> isn't better, the rest of the perf tests are split up by command,
> perhaps just add a helper library and have both use it?
>

I was getting tired of editing two files that were nearly identical
and thought that reviewers would be tired of reading them.  At least
in the main test suite, t/t3700-add.sh covers update-index in addition
to git-add.

> And re the unaddressed feedback I ad of "why the random data"
> inhttps://lore.kernel.org/git/220326.86o81sk9ao.gmgdl@evledraar.gmail.com=
/
> I tried patching it on top to do what I suggested there, allowing us to
> run these against any arbitrary repository and came up with this:
>

The advantage of the random data is that it's easy to scale the number
of files and change the tree shape.  I wanted the
test_create_unique_files helper anyway, so using it here made sense.
Also, I'm quite confident that I'm really getting new objects added to
the repo with this test scheme.

> diff --git a/t/perf/p3700-add.sh b/t/perf/p3700-add.sh
> index ef6024f9897..60abd5ee076 100755
> --- a/t/perf/p3700-add.sh
> +++ b/t/perf/p3700-add.sh
> @@ -13,47 +13,26 @@ export GIT_TEST_FSYNC
>
>  . ./perf-lib.sh
>
> -. $TEST_DIRECTORY/lib-unique-files.sh
> -
> -test_perf_fresh_repo
> +test_perf_default_repo
>  test_checkout_worktree
>
> -dir_count=3D10
> -files_per_dir=3D50
> -total_files=3D$((dir_count * files_per_dir))
> -
> -for mode in false true batch
> +for cfg in \
> +       '-c core.fsync=3D-loose-object -c core.fsyncmethod=3Dfsync' \
> +       '-c core.fsync=3Dloose-object -c core.fsyncmethod=3Dfsync' \
> +       '-c core.fsync=3Dloose-object -c core.fsyncmethod=3Dbatch' \
> +       '-c core.fsyncmethod=3Dbatch'
>  do
> -       case $mode in
> -       false)
> -               FSYNC_CONFIG=3D'-c core.fsync=3D-loose-object -c core.fsy=
ncmethod=3Dfsync'
> -               ;;
> -       true)
> -               FSYNC_CONFIG=3D'-c core.fsync=3Dloose-object -c core.fsyn=
cmethod=3Dfsync'
> -               ;;
> -       batch)
> -               FSYNC_CONFIG=3D'-c core.fsync=3Dloose-object -c core.fsyn=
cmethod=3Dbatch'
> -               ;;
> -       esac
> -
> -       test_perf "add $total_files files (object_fsyncing=3D$mode)" \
> -               --setup "
> -               (rm -rf .git || 1) &&
> -               git init &&
> -               test_create_unique_files $dir_count $files_per_dir files_=
$mode
> -       " "
> -               git $FSYNC_CONFIG add files_$mode
> -       "
> -
> -       test_perf "stash $total_files files (object_fsyncing=3D$mode)" \
> -               --setup "
> -               (rm -rf .git || 1) &&
> -               git init &&
> -               test_commit first &&
> -               test_create_unique_files $dir_count $files_per_dir stash_=
files_$mode
> -       " "
> -               git $FSYNC_CONFIG stash push -u -- stash_files_$mode
> -       "
> +       test_perf "'git add' with '$cfg'" \
> +               --setup '
> +                       mv -v .git .git.old &&
> +                       git init .
> +               ' \
> +               --cleanup '
> +                       rm -rf .git &&
> +                       mv .git.old .git
> +               ' '
> +               git $cfg add -f -- ":!.git.old/"
> +       '
>  done
>
>  test_done
> diff --git a/t/perf/p3900-stash.sh b/t/perf/p3900-stash.sh
> new file mode 100755
> index 00000000000..12c489069ba
> --- /dev/null
> +++ b/t/perf/p3900-stash.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description=3D'performance of "git stash" with different fsync sett=
ings'
> +
> +# Fsync is normally turned off for the test suite.
> +GIT_TEST_FSYNC=3D1
> +export GIT_TEST_FSYNC
> +
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +test_checkout_worktree
> +
> +for cfg in \
> +       '-c core.fsync=3D-loose-object -c core.fsyncmethod=3Dfsync' \
> +       '-c core.fsync=3Dloose-object -c core.fsyncmethod=3Dfsync' \
> +       '-c core.fsync=3Dloose-object -c core.fsyncmethod=3Dbatch' \
> +       '-c core.fsyncmethod=3Dbatch'
> +do
> +       test_perf "'stash push -u' with '$cfg'" \
> +               --setup '
> +                       mv -v .git .git.old &&
> +                       git init . &&
> +                       test_commit dummy
> +               ' \
> +               --cleanup '
> +                       rm -rf .git &&
> +                       mv .git.old .git
> +               ' '
> +               git $cfg stash push -a -u ":!.git.old/" ":!test*" "."
> +       '
> +done
> +
> +test_done
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index a935ad622d3..24a5108f234 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -194,6 +194,7 @@ test_wrapper_ () {
>         test_start_
>         test_prereq=3D
>         test_perf_setup_=3D
> +       test_perf_cleanup_=3D
>         while test $# !=3D 0
>         do
>                 case $1 in
> @@ -205,6 +206,10 @@ test_wrapper_ () {
>                         test_perf_setup_=3D$2
>                         shift
>                         ;;
> +               --cleanup)
> +                       test_perf_cleanup_=3D$2
> +                       shift
> +                       ;;
>                 *)
>                         break
>                         ;;
> @@ -214,6 +219,7 @@ test_wrapper_ () {
>         test "$#" =3D 1 || BUG "test_wrapper_ needs 2 positional paramete=
rs"
>         export test_prereq
>         export test_perf_setup_
> +       export test_perf_cleanup_
>         if ! test_skip "$test_title_" "$@"
>         then
>                 base=3D$(basename "$0" .sh)
> @@ -256,6 +262,16 @@ test_perf_ () {
>                         test_failure_ "$@"
>                         break
>                 fi
> +               if test -n "$test_perf_cleanup_"
> +               then
> +                       say >&3 "cleanup: $test_perf_cleanup_"
> +                       if ! test_eval_ $test_perf_cleanup_
> +                       then
> +                               test_failure_ "$test_perf_cleanup_"
> +                               break
> +                       fi
> +
> +               fi
>         done
>         if test -z "$verbose"; then
>                 echo " ok"
>
>
> Here it is against Cor.git (a random small-ish repo I had laying around):
>
>         $ GIT_SKIP_TESTS=3D'p3[79]00.[12]' GIT_PERF_MAKE_OPTS=3D'CFLAGS=
=3D-O3' GIT_PERF_REPO=3D~/g/Cor/ ./run origin/master HEAD -- p3900-stash.sh
>         =3D=3D=3D Building abf474a5dd901f28013c52155411a48fd4c09922 (orig=
in/master) =3D=3D=3D
>             GEN git-add--interactive
>             GEN git-archimport
>             GEN git-cvsexportcommit
>             GEN git-cvsimport
>             GEN git-cvsserver
>             GEN git-send-email
>             GEN git-svn
>             GEN git-p4
>             SUBDIR templates
>         =3D=3D=3D Running 1 tests in /home/avar/g/git/t/perf/build/abf474=
a5dd901f28013c52155411a48fd4c09922/bin-wrappers =3D=3D=3D
>         ok 1 # skip 'stash push -u' with '-c core.fsync=3D-loose-object -=
c core.fsyncmethod=3Dfsync' (GIT_SKIP_TESTS)
>         ok 2 # skip 'stash push -u' with '-c core.fsync=3Dloose-object -c=
 core.fsyncmethod=3Dfsync' (GIT_SKIP_TESTS)
>         perf 3 - 'stash push -u' with '-c core.fsync=3Dloose-object -c co=
re.fsyncmethod=3Dbatch': 1 2 3 ok
>         perf 4 - 'stash push -u' with '-c core.fsyncmethod=3Dbatch': 1 2 =
3 ok
>         # passed all 4 test(s)
>         1..4
>         =3D=3D=3D Building ecda9c2b029e35d239e369b875b245f45fd2a097 (HEAD=
) =3D=3D=3D
>             GEN git-add--interactive
>             GEN git-archimport
>             GEN git-cvsexportcommit
>             GEN git-cvsimport
>             GEN git-cvsserver
>             GEN git-send-email
>             GEN git-svn
>             GEN git-p4
>             SUBDIR templates
>         =3D=3D=3D Running 1 tests in /home/avar/g/git/t/perf/build/ecda9c=
2b029e35d239e369b875b245f45fd2a097/bin-wrappers =3D=3D=3D
>         ok 1 # skip 'stash push -u' with '-c core.fsync=3D-loose-object -=
c core.fsyncmethod=3Dfsync' (GIT_SKIP_TESTS)
>         ok 2 # skip 'stash push -u' with '-c core.fsync=3Dloose-object -c=
 core.fsyncmethod=3Dfsync' (GIT_SKIP_TESTS)
>         perf 3 - 'stash push -u' with '-c core.fsync=3Dloose-object -c co=
re.fsyncmethod=3Dbatch': 1 2 3 ok
>         perf 4 - 'stash push -u' with '-c core.fsyncmethod=3Dbatch': 1 2 =
3 ok
>         # passed all 4 test(s)
>         1..4
>         Test       origin/master     HEAD
>         ---------------------------------------------------
>         3900.3:    0.03(0.00+0.00)   0.02(0.00+0.00) -33.3%
>         3900.4:    0.02(0.00+0.00)   0.03(0.00+0.00) +50.0%
>

Something is wrong with your data here.  Or your repo is too small to
highlight the differences.

I'd suggest that if you want to write a different perf test for this
feature, that it be a follow-on change.

Thanks,
Neeraj
