Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FCCC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 23:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhLTXgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLTXgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 18:36:14 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE4C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:36:14 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u7-20020a62d447000000b004ba7160b4a8so4611774pfl.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Ezdriwvcfo600319f8zAKrggirpwEGdOxUP487trLX8=;
        b=QQutSqK+2FbtX1SjqwFF/dfau1FmOX1u3mW1fqG6ggZpHwnjV15THjFr8RSdm5faH5
         IFvoRolsGSZPnMZzmD9r8Zrq/OOhCu2TaFlxzBk/Swi6+f//jog58mIAoaLh4f2YPL9z
         /qiwYwXUpbHyb2o5CmXXxUtd2lrngzFn7YtZA6zJzJnGayRu5ZnrSgSTqDu5uE4XE6H5
         DK8t4c/LrkH0vP7fXOwFRtvRzDTjZRHVbF3ycqT6cv2GK4gWr8jk3g2K4swhpmMvk+yR
         qh2GsjKuFr3wEX1RnDAWwmdAv3oxo1EcamcSuVEh5lU1sFoMIUKPCChmneNeJHv232yy
         o4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Ezdriwvcfo600319f8zAKrggirpwEGdOxUP487trLX8=;
        b=8A4uO1D4JZA//0Qw8l+nL/9DGfNpQKHy+ySZwZeKuILjVD3/qluXEClkCgNVC1oiFu
         sG7YyCZeo0DyLpoX/myrvhvXf/groUQT6j+TPLHKg4REo9ZclMI/KpN01B0SqwJ33cbD
         ww0MFXsNmoAIfT/qfy2Hi/KeVqz0nMBXjUGvqbl7W+W+rdkyLU2IRizvF+VCK1SYO0wC
         drUB2JrNN/iqEBHQEWDXT/7eCeFDF9zbyuDnM8UZF/fyDCk+TJOGphL/DYSRzxXqDPwn
         NVKQYhXKJ4y26NMmpZa9WP4rJNTpW5TExTYEZMj3ew9a9Tf4DI/QyqLyvs6A6Iuqwwh7
         rOcA==
X-Gm-Message-State: AOAM532mMD/2Dxm+in6ew+qIMhNeAkQqRF+IBQyimF8JmFTTgjwZ5I7Q
        zcUrwQcHQsY8yIfrCKkMS+Ez/iBQO9TmyaJNA8dkygdS1YoT7hk+Jpm/Tpj3LcFlo2yTFIC8sH+
        dwU4wpmdlKYbQp/FvgKaZ48HXexcQ3aZJ+OGcXoLM+2C2uwc750mEmXZfdrR7Y8c=
X-Google-Smtp-Source: ABdhPJxiqYHnqAQFMkeDYKUQ/fiThwUhisjAhAnWUwalDE22zUv6VhDOaNPE4rVXHCEVcoaHnSI8HROlo61SbA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:b712:b0:143:72b7:4096 with SMTP
 id d18-20020a170902b71200b0014372b74096mr564323pls.25.1640043373769; Mon, 20
 Dec 2021 15:36:13 -0800 (PST)
Date:   Mon, 20 Dec 2021 15:36:11 -0800
In-Reply-To: <20211220233459.45739-1-chooglen@google.com>
Message-Id: <kl6lilvizw5w.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211216233324.65126-1-chooglen@google.com> <20211220233459.45739-1-chooglen@google.com>
Subject: Re: [PATCH v6 0/5] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Submodule branching RFC:
> https://lore.kernel.org/git/kl6lv912uvjv.fsf@chooglen-macbookpro.roam.cor=
p.google.com/
>
> Original Submodule UX RFC/Discussion:
> https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/
>
> Contributor Summit submodules Notes:
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211148060.56@tvgsbejvaq=
bjf.bet/
>
> Submodule UX overhaul updates:
> https://lore.kernel.org/git/?q=3DSubmodule+UX+overhaul+update
>
> This series implements branch --recurse-submodules as laid out in the
> Submodule branching RFC (linked above). If there are concerns about the
> UX/behavior, I would appreciate feedback on the RFC thread as well :)
>
> v6 fixes v5's bad rebase; it was based off a merge commit in 'seen'
> instead of js/branch-track-inherit. Since v5 is mostly a no-op, I will
> also include a range-diff against v4, which is the last version that
> anyone except Junio would care about.

As mentioned, here is the range-diff against v4

Range-diff against v4:
1:  751e8ae566 < -:  ---------- branch: accept multiple upstream branches f=
or tracking
2:  5d1ebe1495 < -:  ---------- branch: add flags and config to inherit tra=
cking
3:  0080a1fb35 < -:  ---------- config: require lowercase for branch.autose=
tupmerge
4:  dfdbbaaca5 ! 1:  29669c57b4 branch: move --set-upstream-to behavior to =
dwim_and_setup_tracking()
    @@ Commit message
    =20
         This refactor is motivated by a desire to add a "dry_run" paramete=
r to
         create_branch() that will validate whether or not a branch can be
    -    created without actually creating it - this behavior be used in a
    +    created without actually creating it - this behavior will be used =
in a
         subsequent commit that adds `git branch --recurse-submodules topic=
`.
    =20
         Adding "dry_run" is not obvious because create_branch() is also us=
ed to
    @@ branch.c: static void setup_tracking(const char *new_ref, const char=
 *orig_ref,
     =20
      	if (tracking.matches > 1)
     @@ branch.c: static void setup_tracking(const char *new_ref, const cha=
r *orig_ref,
    - 			      tracking.srcs) < 0)
    + 				tracking.remote, tracking.srcs) < 0)
      		exit(-1);
     =20
     +cleanup:
5:  e22a177cb7 ! 2:  ac2532a953 branch: make create_branch() always create =
a branch
    @@ Commit message
    =20
         create_branch() was formerly used to set tracking without creating=
 a
         branch. Since the previous commit replaces this use case with
    -    setup_tracking(), we can simplify create_branch() so that it alway=
s
    -    creates a branch.
    +    dwim_and_setup_tracking(), we can simplify create_branch() so that=
 it
    +    always creates a branch.
    =20
         Do this simplification, in particular:
    =20
6:  8a895aa401 ! 3:  a0ed3fa438 branch: add a dry_run parameter to create_b=
ranch()
    @@ builtin/checkout.c: static void update_refs_for_switch(const struct =
checkout_opt
     -				      opts->track);
     +				      opts->track,
     +				      0);
    - 		new_branch_info->name =3D opts->new_branch;
    - 		setup_branch_path(new_branch_info);
    - 	}
    + 		free(new_branch_info->name);
    + 		free(new_branch_info->refname);
    + 		new_branch_info->name =3D xstrdup(opts->new_branch);
7:  971c53ec85 =3D 4:  ebded31c96 builtin/branch: clean up action-picking l=
ogic in cmd_branch()
8:  cd88f3ad92 =3D 5:  0a7ec6ee75 branch: add --recurse-submodules option f=
or branch creation

> This version is based off Josh's js/branch-track-inherit v7. Because that
> is not yet in 'seen', I applied those patches onto abe6bb3905 (The first
> batch to start the current cycle, 2021-11-29). The base commit can be
> found at https://github.com/chooglen/git/tree/js/branch-track-inherit-v7.
> I really hope I got right this time, but if not, hopefully the paper
> trail is obvious.
>
> Future work:
> * `git branch -d --recurse-submodules` so that users can clean up
>   extraneous branches.
> * `git [checkout | switch] --recurse-submodules` +
>   submodule.propagateBranches so that users can actually checkout the
>   branches.
> * After [1], it seems clear that --recurse-submodules parsing could
>   really benefit from some standardization. It's not obvious which
>   RECURSE_SUBMODULE_* enums are applicable to which commands, and there
>   is no way to distinguish between an explicit --recurse-submodules from
>   argv vs submodule.recurse from the config.
>
>   I chose not to use them in this series because their usage is already
>   inconsistent (grep.c doesn't use them either), and it would be _more_
>   confusing to use the enum (handling RECURSE_SUBMODULES_DEFAULT =3D 1 is
>   trickier than boolean 0 and 1).
>
>   At this point, I think it would be too noisy to introduce the enum,
>   but this would be a nice cleanup to do later.
> * As documented in branch.c, we create branches using a child process
>   only because install_branch_config() does not support submodules.
>   It should be possible to remove the child process once we make the
>   appropriate changes to config.c. I attempted this in [2] but chose to
>   punt it because it was too time-consuming at the time.
>
> Changes since v5:
> * Rebase onto v7 of js/branch-track-inherit
>   (https://lore.kernel.org/git/cover.1639717481.git.steadmon@google.com)
>
> Changes since v4:
> * Rebase correctly onto 'gitster/seen^{/^Merge branch .js/branch-track-in=
herit.}'
>   (see base-commit) as suggested in [3] (thanks Junio!)
> * These patches were also verified on top of 'next'.
>
> Changes since v3:
> * Split up the old patch 1. Patch 1 had a big diff because it used to
>   move lines, remove dead code and introduce repo_* functions (thanks
>   Jonathan!)
> ** repo_* functions have been dropped; they added noise and are not
>    necessary for correctness.
> * Use a new, harder-to-misuse function in --set-upstream-to,
>   dwim_and_setup_tracking(). Now, setup_tracking() never does DWIM and
>   dwim_and_setup_tracking() always does DWIM.
> * Move create_branch() dry_run to its own patch.
> * Fix an oversight where submodules in subtrees were ignored. This was
>   because submodules_of_tree() and tree_entry() didn't recurse into
>   subtrees. Test this accordingly (thanks Jonathan!).
> * cmd_branch() possible actions are more consistently ordered.
> * Documentation fixes (thanks Philippe!).
> * Additional comments and explanation.
> * Drop patch 5 (optional cleanup).
> * Rebase onto js/branch-track-inherit v6.
>
> Changes since v2:
> * Rebase onto js/branch-track-inherit. This series should continue to be
>   the case going forward.
> * Patch 1 has a smaller diff because the introduction of
>   validate_branch_start() no longer changes the function order thanks to =
a
>   forward declaration. This artificial forward declaration is removed in =
a
>   patch 2 (which can just be squashed into patch 1).
> * Optional cleanup: fix questionable exit codes in patch 5.
>
> Changes since v1:
> * Move the functionality of "git branch --dry-run" into "git submodule-he=
lper create-branch --dry-run"
> * Add more fields to the submodules_of_tree() struct to reduce the
>   number of allocations made by the caller. Move this functionality
>   to patch 3 (formerly patch 4) and drop patch 1.
> * Make submodules_of_tree() ignore inactive submodules
> * Structure the output of the submodules a bit better by adding prefixes
>   to the child process' output (instead of inconsistently indenting the
>   output).
> ** I wasn't able to find a good way to interleave stdout/stderr
>    correctly, so a less-than-desirable workaround was to route the child
>    process output to stdout/stderr depending on the exit code.
> ** Eventually, I would like to structure the output of submodules in a
>    report, as =C3=86var suggested. But at this stage, I think that it's
>    better to spend time getting user feedback on the submodules
>    branching UX and it'll be easier to standardize the output when we've
>    implemented more of the UX :)
>
> [1] https://lore.kernel.org/git/kl6lbl1p9zjf.fsf@chooglen-macbookpro.roam=
.corp.google.com/
> [2] https://lore.kernel.org/git/kl6lv90ytd4v.fsf@chooglen-macbookpro.roam=
.corp.google.com/
> [3] https://lore.kernel.org/git/xmqqlf0lz6os.fsf@gitster.g=20
>
> Glen Choo (5):
>   branch: move --set-upstream-to behavior to dwim_and_setup_tracking()
>   branch: make create_branch() always create a branch
>   branch: add a dry_run parameter to create_branch()
>   builtin/branch: clean up action-picking logic in cmd_branch()
>   branch: add --recurse-submodules option for branch creation
>
>  Documentation/config/advice.txt    |   3 +
>  Documentation/config/submodule.txt |  24 ++-
>  Documentation/git-branch.txt       |  11 +-
>  advice.c                           |   1 +
>  advice.h                           |   1 +
>  branch.c                           | 257 ++++++++++++++++++++-----
>  branch.h                           |  57 +++++-
>  builtin/branch.c                   |  70 +++++--
>  builtin/checkout.c                 |   3 +-
>  builtin/submodule--helper.c        |  38 ++++
>  submodule-config.c                 |  60 ++++++
>  submodule-config.h                 |  34 ++++
>  submodule.c                        |  11 +-
>  submodule.h                        |   3 +
>  t/t3200-branch.sh                  |  17 ++
>  t/t3207-branch-submodule.sh        | 291 +++++++++++++++++++++++++++++
>  16 files changed, 805 insertions(+), 76 deletions(-)
>  create mode 100755 t/t3207-branch-submodule.sh
>
> Range-diff against v5:
> 1:  a9d1108b3e ! 1:  29669c57b4 branch: move --set-upstream-to behavior t=
o dwim_and_setup_tracking()
>     @@ branch.c: static void setup_tracking(const char *new_ref, const ch=
ar *orig_ref,
>      =20
>       	if (tracking.matches > 1)
>      @@ branch.c: static void setup_tracking(const char *new_ref, const c=
har *orig_ref,
>     - 			      tracking.srcs) < 0)
>     + 				tracking.remote, tracking.srcs) < 0)
>       		exit(-1);
>      =20
>      +cleanup:
>     @@ branch.c: N_("\n"
>      @@ branch.c: void create_branch(struct repository *r,
>      =20
>       	if ((commit =3D lookup_commit_reference(r, &oid)) =3D=3D NULL)
>     - 		die(_("not a valid branch point: '%s'"), start_name);
>     + 		die(_("Not a valid branch point: '%s'."), start_name);
>      -	oidcpy(&oid, &commit->object.oid);
>      +	if (out_real_ref)
>      +		*out_real_ref =3D real_ref ? xstrdup(real_ref) : NULL;
> 2:  c543c1412a =3D 2:  ac2532a953 branch: make create_branch() always cre=
ate a branch
> 3:  dddd434d7a =3D 3:  a0ed3fa438 branch: add a dry_run parameter to crea=
te_branch()
> 4:  41cca3bd52 =3D 4:  ebded31c96 builtin/branch: clean up action-picking=
 logic in cmd_branch()
> 5:  540eeab183 ! 5:  0a7ec6ee75 branch: add --recurse-submodules option f=
or branch creation
>     @@ t/t3207-branch-submodule.sh (new)
>      +		test_must_fail git rev-parse branch-a &&
>      +
>      +		cat >expected <<-EOF &&
>     -+		submodule ${SQ}sub${SQ}: fatal: a branch named ${SQ}branch-a${SQ}=
 already exists
>     ++		submodule ${SQ}sub${SQ}: fatal: A branch named ${SQ}branch-a${SQ}=
 already exists.
>      +		fatal: submodule ${SQ}sub${SQ}: cannot create branch ${SQ}branch-=
a${SQ}
>      +		EOF
>      +		test_cmp expected actual
>
> base-commit: e1c6879cf24f90693ca108542ec1db970764e1dc
> --=20
> 2.33.GIT
