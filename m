Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9587C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 23:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiKNXUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 18:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbiKNXUp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 18:20:45 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A6B483
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:20:40 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v18-20020a637a12000000b0046ed84b94efso6443643pgc.6
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCT3Shm1UIuKFoy/LYZhYmfasnmizOqWO8TOYP4eExo=;
        b=jpPckUZM2D716Lgtojd/8ASME946pbItZr+jdu49lhhkPw1ePb7VYc/ZEoyxU6g6Wk
         imrfxLWJMaFObNyMTNQrTauO03evQeqMmYjwy4WHiPg2SQoHJDALTnEmkpbH2cnzf+sc
         5bUp90KXfAHok+tWAALoXhvr1di70+0P9hN+/CeGHnisgvtAhfWuvGdKI06a59K9QYcb
         Y+6Nh3PZ1xOSXUzR7UwWJiX6vpZ99aMx4gmytITVg5YLMBkPkNU0jpsi/YL0yNdZr7Hi
         1ryWpuPndgFPTxFaQoiZiWc1oN5jsNrBp6ww/oYwWElG+jZzlmruj/UPAib+u65tQS7F
         3+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QCT3Shm1UIuKFoy/LYZhYmfasnmizOqWO8TOYP4eExo=;
        b=PyEQKKwdVLonQao7Rrvdz1UardmJokS0jVQn1+7JSHTkg77VtnfZTFQjUw/xOWG51z
         zW4fCL6SE73LedZqokpye/49ngerrNGDWq3uDBfzYYQ2HokKWYQT9JDV3AGbojylDNEr
         v+DSLxjgaFDwK3Dla5SlSVBPFncJnwWnrAXEV9hxUn3ZSnArJlSfyCv87uNHqpc5sjq0
         Oqof8azOBxxO6B2bRl5e0qJ5ybiRz5q6/SCkrEoqiQUMCsPl3/gTDwS5CwqEe7MNufos
         SQjWlbE667AeOnFfA4o+KSGtvfRjFeiIDmNnpVFi7YIHKtID4zsykIOLPyiA9J4uEDbh
         0zEQ==
X-Gm-Message-State: ANoB5pn8h5bbtARMzkgNYl3MIhxGgJZpIHvYqdvwvHZ7OV3NotCGQE12
        jYvTyGWfwgwDJlyW3SU7d3WGlzD4y26mDQ==
X-Google-Smtp-Source: AA0mqf7N6cn2usiA14zDCdVwhJegl2N88HTwndZ22BGuW6mpGA7+rVnNVRTlbkmEXKRz14WTL2jmRWTh4T8gkA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:8745:0:b0:562:e790:dfe0 with SMTP id
 i66-20020a628745000000b00562e790dfe0mr15667830pfe.16.1668468040462; Mon, 14
 Nov 2022 15:20:40 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:20:39 -0800
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
Message-ID: <kl6lpmdpnmwo.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 00/10] Get rid of "git --super-prefix"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for taking this forward as a non-RFC (and sorry for the
coordinating confusion last week). I'm really happy to see this go
forward.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> =3D Summary
>
> What's "--super-prefix"? The "git" command takes an "internal use
> only" "--super-prefix" option, which is used to inform processes
> invoked in submodules what the path prefix to the invoking
> superproject is.
>
> This is so so that e.g. "git submodule absorbgitdirs" can report
> "sub-1/sub-2", instead of "sub-2" when being invoked in the "sub-1"
> submodule.
>
> For this the "--super-prefix" facility has been doing a
> setenv("GIT_INTERNAL_SUPER_PREFIX", "sub-1/") as soon as it got the
> "--supre-prefix=3Dsub-1/". We'd then pass that along via the environment
> when invoking the sub-process.
>
> As this series shows we don't need such a hands-off global facility to
> do this, we can instead just pass the relevant context directly in
> each command. E.g. "git submodule absorbgitdirs" can pass the path to
> the "git submodule absorbgitdirs" sub-process it's about to invoke.
>

To play devil's advocate, we don't need it now, but one could argue that
we'll need it in the future, and having some global facility for this
would continue to be helpful. In [1], I mentioned that it is "helpful"
in this way, but that this "helpfulness" is a trap, because we want to
be moving more things in-process anyway (and we're making pretty good
strides in that direction), and adding more global state makes it harder
to reason about who should own the variables when we libify the
internals (do we move the state into per-process struct?
the_repository? something else?)

In addition, you also mentioned earlier in the [1] thread that this
global state also makes it possible accidentally affect commands we
didn't mean to, and having less global state makes behavior easier to
reason about.

So I think the argument I find most convincing isn't just "We don't need
it now.", but also "Global state is the wrong way to do this, so let's
stop.".

[1] https://lore.kernel.org/git/kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.c=
orp.google.com

> It's also proposing to replace Glen's one-patch[6], which is working
> around the problem shown in the test added in 1/10 here. Per
> downthread of [7] I think Glen was aiming for getting a more narrow
> fix in case we split off 9/10 here into some later fix.
>
> As we're fixing an edge case in something that's always been broken
> (and thus wouldn't backport) I think it's better to just fix the
> problem directly, rather than introducing new "--super-prefix" use,
> just to take it away later.

(I'll share my thoughts on this on another email).

> =3D Changes since the RFC
>
> * Added Glen's "git fetch" test as a 1/10, with an updated commit message
> * Updated 2/10's commit message for the non-RFC, and adjusted and
>   incorporated a variant of Glen's fsmonitor test change.
> * 9/10: Correctly re-arrange bitfield define's when removing one, make
>   the test added in 1/10 pass.
>
> * 10/10: New commit to make "git fetch" use our own "--super-prefix"
>   instead of its "--submodule-prefix", which makes it consistent with
>   the other command-level "--super-prefix" introduced here.
>
>   Personally I'm rather "meh" on this. It's not actually needed by the
>   main body of the series, but Glen seems to prefer it in[9], and
>   doing it is easy enough.
>
>   That change is a pure refactoring clean-up for consistency. The only
>   reason it's 10/10 and not 1/10 is because it uses the
>   "OPT__SUPER_PREFIX()" introduced in 2/10.

Thanks for this, I really appreciate it :)

> =3D CI & fetch URL
>
> Passing at: https://github.com/avar/git/tree/avar/nuke-global-super-prefi=
x-use-local-2
>
> 1. https://lore.kernel.org/git/RFC-cover-0.8-00000000000-20221109T192315Z=
-avarab@gmail.com/
> 2. https://lore.kernel.org/git/20221109004708.97668-1-chooglen@google.com=
/
> 3. https://lore.kernel.org/git/kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.=
corp.google.com/
> 4. c0c4f4d1c33 (Merge branch 'ab/submodule-helper-prep-only' into next, 2=
022-11-08)
> 5. https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-ava=
rab@gmail.com/
> 6. https://lore.kernel.org/git/pull.1378.git.git.1668210935360.gitgitgadg=
et@gmail.com/
> 7. https://lore.kernel.org/git/221111.86fsepmbhe.gmgdl@evledraar.gmail.co=
m/
> 8. https://lore.kernel.org/git/20221109004708.97668-3-chooglen@google.com=
/
> 9. https://lore.kernel.org/git/kl6lsfip0yfx.fsf@chooglen-macbookpro.roam.=
corp.google.com/
>
> Glen Choo (1):
>   read-tree + fetch tests: test failing "--super-prefix" interaction
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
>   submodule--helper: don't use global --super-prefix in "absorbgitdirs"
>   submodule--helper: "deinit" has never used "--super-prefix"
>   submodule--helper: convert "foreach" to its own "--super-prefix"
>   submodule--helper: convert "sync" to its own "--super-prefix"
>   submodule--helper: convert "status" to its own "--super-prefix"
>   submodule--helper: convert "{update,clone}" to their own
>     "--super-prefix"
>   submodule tests: test "git branch -t" output and stderr
>   read-tree: add "--super-prefix" option, eliminate global
>   fetch: rename "--submodule-prefix" to "--super-prefix"
>
>  Documentation/fetch-options.txt |  5 --
>  Documentation/git.txt           |  8 +--
>  builtin.h                       |  4 --
>  builtin/checkout.c              |  2 +-
>  builtin/fetch.c                 |  7 +--
>  builtin/read-tree.c             |  1 +
>  builtin/submodule--helper.c     | 95 ++++++++++++++++++--------------
>  cache.h                         |  2 -
>  entry.c                         | 12 ++--
>  entry.h                         |  6 +-
>  environment.c                   | 13 -----
>  git.c                           | 41 +++-----------
>  parse-options.h                 |  4 ++
>  submodule.c                     | 70 +++++++++++------------
>  submodule.h                     | 12 ++--
>  t/lib-submodule-update.sh       | 98 ++++++++++++++++++---------------
>  t/t1001-read-tree-m-2way.sh     |  2 +-
>  t/t5616-partial-clone.sh        | 43 +++++++++++++++
>  t/t7527-builtin-fsmonitor.sh    | 33 +++--------
>  unpack-trees.c                  | 23 ++++----
>  unpack-trees.h                  |  1 +
>  21 files changed, 244 insertions(+), 238 deletions(-)
>
> Range-diff against v1:
>  -:  ----------- >  1:  1114a4ff666 read-tree + fetch tests: test failing=
 "--super-prefix" interaction
>  1:  ad0356b596f !  2:  5a35f7b75b3 submodule--helper: don't use global -=
-super-prefix in "absorbgitdirs"
>     @@ Commit message
>          declare "fsmonitor--daemon" as accepting it too, even though it
>          doesn't care about it.
>     =20
>     -    There's a parallel proposal to remove "--super-prefix" as an opt=
ion to
>     -    "git" in [3], and some of the approach might be the easiest rout=
e in
>     -    some cases.
>     -
>          But in the case of "absorbgitdirs" it only needed "--super-prefi=
x" to
>          invoke itself recursively, and we'd never have another "in-betwe=
en"
>          process in the chain. So we didn't need the bigger hammer of "gi=
t
>     @@ Commit message
>          stone makes such an eventual change easier, as we'll need to dea=
l with
>          less global state at that point.
>     =20
>     +    The "fsmonitor--daemon" test adjusted here was added in [3]. The
>     +    comment added in that commit has been out-of-date from the begin=
ning,
>     +    and the "have_t2_error_event()" was being overly specific in tes=
ting
>     +    for a bug that we *don't* have. Let's instead test for the stdou=
t and
>     +    stderr that we *do have*.
>     +
>          1. 74866d75793 (git: make super-prefix option, 2016-10-07)
>          2. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument=
,
>             2022-05-26)
>     -    3. https://lore.kernel.org/git/20221109004708.97668-1-chooglen@g=
oogle.com/
>     +    3. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument=
,
>     +       2022-05-26)
>     =20
>     +    Signed-off-by: Glen Choo <chooglen@google.com>
>          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
>     =20
>       ## builtin/submodule--helper.c ##
>     @@ submodule.h: void submodule_unset_core_worktree(const struct submo=
dule *sub);
>      =20
>       /*
>        * Return the absolute path of the working tree of the superproject=
, which this
>     +
>     + ## t/t7527-builtin-fsmonitor.sh ##
>     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'submodule alwa=
ys visited' '
>     + # the submodule, and someone does a `git submodule absorbgitdirs`
>     + # in the super, Git will recursively invoke `git submodule--helper`
>     + # to do the work and this may try to read the index.  This will
>     +-# try to start the daemon in the submodule *and* pass (either
>     +-# directly or via inheritance) the `--super-prefix` arg to the
>     +-# `git fsmonitor--daemon start` command inside the submodule.
>     +-# This causes a warning because fsmonitor--daemon does take that
>     +-# global arg (see the table in git.c)
>     +-#
>     +-# This causes a warning when trying to start the daemon that is
>     +-# somewhat confusing.  It does not seem to hurt anything because
>     +-# the fsmonitor code maps the query failure into a trivial response
>     +-# and does the work anyway.
>     +-#
>     +-# It would be nice to silence the warning, however.
>     +-
>     +-have_t2_error_event () {
>     +-	log=3D$1
>     +-	msg=3D"fsmonitor--daemon doesnQt support --super-prefix" &&
>     +-
>     +-	tr '\047' Q <$1 | grep -e "$msg"
>     +-}
>     ++# try to start the daemon in the submodule.
>     +=20
>     + test_expect_success "stray submodule super-prefix warning" '
>     + 	test_when_finished "rm -rf super; \
>     +-			    rm -rf sub;   \
>     +-			    rm super-sub.trace" &&
>     ++			    rm -rf sub" &&
>     +=20
>     + 	create_super super &&
>     + 	create_sub sub &&
>     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "stray submodul=
e super-prefix warning" '
>     +=20
>     + 	test_path_is_dir super/dir_1/dir_2/sub/.git &&
>     +=20
>     +-	GIT_TRACE2_EVENT=3D"$PWD/super-sub.trace" \
>     +-		git -C super submodule absorbgitdirs &&
>     +-
>     +-	! have_t2_error_event super-sub.trace
>     ++	cat >expect <<-\EOF &&
>     ++	Migrating git directory of '\''dir_1/dir_2/sub'\'' from '\''dir_1/=
dir_2/sub/.git'\'' to '\''.git/modules/dir_1/dir_2/sub'\''
>     ++	EOF
>     ++	git -C super submodule absorbgitdirs >out 2>actual &&
>     ++	test_cmp expect actual &&
>     ++	test_must_be_empty out
>     + '
>     +=20
>     + # On a case-insensitive file system, confirm that the daemon
>  2:  87a780eb9bf =3D  3:  a7a1f9487dc submodule--helper: "deinit" has nev=
er used "--super-prefix"
>  3:  4858e2ad0ed =3D  4:  935d8070834 submodule--helper: convert "foreach=
" to its own "--super-prefix"
>  4:  5ffe4407e46 =3D  5:  933c752513d submodule--helper: convert "sync" t=
o its own "--super-prefix"
>  5:  a46540b63c2 =3D  6:  67273f729e0 submodule--helper: convert "status"=
 to its own "--super-prefix"
>  6:  78ebf0e2abf =3D  7:  eaa73f5b1e4 submodule--helper: convert "{update=
,clone}" to their own "--super-prefix"
>  7:  00a9e789be7 =3D  8:  172b5865811 submodule tests: test "git branch -=
t" output and stderr
>  8:  3ba894a6698 !  9:  9fdeab60773 read-tree: add "--super-prefix" optio=
n, eliminate global
>     @@ git.c
>        */
>       #define NEED_WORK_TREE		(1<<3)
>      -#define SUPPORT_SUPER_PREFIX	(1<<4)
>     - #define DELAY_PAGER_CONFIG	(1<<5)
>     - #define NO_PARSEOPT		(1<<6) /* parse-options is not used */
>     +-#define DELAY_PAGER_CONFIG	(1<<5)
>     +-#define NO_PARSEOPT		(1<<6) /* parse-options is not used */
>     ++#define DELAY_PAGER_CONFIG	(1<<4)
>     ++#define NO_PARSEOPT		(1<<5) /* parse-options is not used */
>      =20
>     + struct cmd_struct {
>     + 	const char *cmd;
>      @@ git.c: const char git_usage_string[] =3D
>       	   "           [--exec-path[=3D<path>]] [--html-path] [--man-path]=
 [--info-path]\n"
>       	   "           [-p | --paginate | -P | --no-pager] [--no-replace-o=
bjects] [--bare]\n"
>     @@ t/t1001-read-tree-m-2way.sh: test_expect_success 'read-tree suppor=
ts the super-p
>       '
>      =20
>     =20
>     + ## t/t5616-partial-clone.sh ##
>     +@@ t/t5616-partial-clone.sh: test_expect_success 'repack does not lo=
osen promisor objects' '
>     + 	grep "loosen_unused_packed_objects/loosened:0" trace
>     + '
>     +=20
>     +-test_expect_failure 'lazy-fetch in submodule succeeds' '
>     ++test_expect_success 'lazy-fetch in submodule succeeds' '
>     + 	# setup
>     + 	test_config_global protocol.file.allow always &&
>     +=20
>     +
>       ## unpack-trees.c ##
>      @@ unpack-trees.c: static const char *unpack_plumbing_errors[NB_UNPA=
CK_TREES_WARNING_TYPES] =3D {
>       	  ? ((o)->msgs[(type)])      \
>  -:  ----------- > 10:  100ba36dfb7 fetch: rename "--submodule-prefix" to=
 "--super-prefix"
> --=20
> 2.38.0.1471.ge4d8947e7aa
