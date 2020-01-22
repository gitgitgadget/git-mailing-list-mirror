Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC57C2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01062467F
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 12:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sH7qLGKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAVMzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:55:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37631 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAVMze (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 07:55:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so5492496qtk.4
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 04:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b0joDC3BrR5hCqjs+I+yOY2WawGbGyuCpOYvMq2MqiY=;
        b=sH7qLGKD/dtn8SOYyThiB6PO1EXDFYKTToRTJB1XQB7YbGB/FLSpeLDodyzoqlQGLa
         fcwkTchuld0ChaY0YLZw7Un0a7v18v6nlWLx6+Q1AbJCdfld4r4qnSPxwC6Wm4JwwjhK
         3x7YGeifreVNY0dA5BoDpHECLHg8qEyWbpALTFqdw+4bFemWIp61xnzydHfpKMyJ5L3O
         V/32TVHbIhSwgDlGUaAv2oUPAIhPnfVigbTINfJZw21zV0Zj52zIA3+iFW93st8X30GK
         GQ3kdnfN/m9bx07aLiM/8KmgjciiZMzxpfLwWU0x51mCU6Nc+Equ1iKOtktBLEJGvvlh
         FYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b0joDC3BrR5hCqjs+I+yOY2WawGbGyuCpOYvMq2MqiY=;
        b=hQuBRwo13hpYEUJi1ufxtH3QBo/A3GQq1zx4jIth/HowyL/66Ba2IbyiMZicb0IPn7
         U3U8wibmabApxO5QV/UjuZ7/SQevOgFgu6Dcz/9zrnVq6t3B++zMaQIH2rhL5CeVpJnH
         tWVSpTjMz6PuWcebay7cz8g9NB/ws7yo1ol64GWqjQb9AbqwN3F+iWi7jsTT5I8wXeIK
         4kR6wZ3z5ICyKi7FxLfxQLUqYRAE5BE87Ke0Sggud//gEYOh7hpGxupOTxru33gFYzUk
         suAJSM90bv7sy1jlKSFfqphJdxk9hno91EAMhB65LGuPAKP6klHhmLUAkqVREb7b+kAf
         f95Q==
X-Gm-Message-State: APjAAAXyCmUkpD2/qMm4EPwyxgqaWggjbxJj6BP2A42Yj3IXvGkFbRIn
        hohYay9MBYvlAyBMB4fly9u9s/HGcew=
X-Google-Smtp-Source: APXvYqyqPY3lzfhKI2gAGQLgtHA65hlPjSKnSxUzQY+kwsozSoT39gUr1x7l6Ld127CUgStp+dqQ0Q==
X-Received: by 2002:ac8:540d:: with SMTP id b13mr9775945qtq.244.1579697733264;
        Wed, 22 Jan 2020 04:55:33 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id k9sm20872212qtq.75.2020.01.22.04.55.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Jan 2020 04:55:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/4] checkout/reset/read-tree: fix --recurse-submodules in linked worktree
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
Date:   Wed, 22 Jan 2020 07:55:30 -0500
Cc:     Brandon Williams <bwilliams.eng@gmail.com>,
        Max Kirillov <max@max630.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2F66C31-851E-42D0-BAF7-2DE8BF0F3D72@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com> <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Here is v2 of my series. I realized that Gitgitgadget failed to parse =
the Cc: footer in my PR description and thus both v1 and v2 got sent to =
the list without any Cc:s.

Cheers,

Philippe.

> Le 21 janv. 2020 =C3=A0 10:01, Philippe Blain via GitGitGadget =
<gitgitgadget@gmail.com> a =C3=A9crit :
>=20
> Changes since v1:
>=20
> * revert the addition of a dash in "file1 updated" by correctly using =
the
>   'tag' argument of test_commit
> * improve the commit message for the 3rd patch, as suggested by Eric
> * fix spacing when redirecting into 'expect' and 'actual'
> * harden the tests by echoing expected values into expect, as =
suggested by
>   Stolee (I did that in both tests)
> * remove test_might_fail and use test_expect_code
> * add the 'git log' test suggested by Stolee
>=20
> v1: This series fixes the behaviour of git checkout/reset/read-tree
> --recurse-submodules when they are called in a linked worktree =
(created by=20
> git worktree add).=20
>=20
> Although submodules are cloned in =
$GIT_COMMON_DIR/worktrees/<name>/modules=20
> upon issuing git submodule update in the linked worktree, any =
invocation of=20
> git checkout/reset/read-tree --recurse-submodules that changes the =
state of
> the submodule(s) will incorrectly operate on the repositories of the
> submodules in the main worktree, i.e. the ones at =
$GIT_COMMON_DIR/modules/.=20
>=20
> The fourth patch fixes this behaviour by using get_git_dir() instead =
of=20
> git_common_dir() in submodule.c::submodule_move_head and=20
> submodule.c::submodule_unset_core_worktree to construct the path to =
the
> submodule repository.
>=20
> The first 3 patches are clean-up patches on =
t7410-submodule-checkout-to.sh
> (renamed to t2405-worktree-submodule.sh) to bring it up to date.
>=20
> Cc:Max Kirillov max@max630.net [max@max630.net] Brandon Williams=20
> bwilliams.eng@gmail.com [bwilliams.eng@gmail.com] Jonathan Tan=20
> jonathantanmy@google.com [jonathantanmy@google.com] Stefan Beller=20
> stefanbeller@gmail.com [stefanbeller@gmail.com] Nguy=E1=BB=85n Th=C3=A1i=
 Ng=E1=BB=8Dc Duy=20
> pclouds@gmail.com [pclouds@gmail.com] Eric Sunshine =
sunshine@sunshineco.com
> [sunshine@sunshineco.com] Derrick Stolee stolee@gmail.com =
[stolee@gmail.com]
>=20
> Philippe Blain (4):
>  t7410: rename to t2405-worktree-submodule.sh
>  t2405: use git -C and test_commit -C instead of subshells
>  t2405: clarify test descriptions and simplify test
>  submodule.c: use get_git_dir() instead of get_git_common_dir()
>=20
> submodule.c                      |  6 +--
> t/t2405-worktree-submodule.sh    | 90 ++++++++++++++++++++++++++++++++
> t/t7410-submodule-checkout-to.sh | 77 ---------------------------
> 3 files changed, 93 insertions(+), 80 deletions(-)
> create mode 100755 t/t2405-worktree-submodule.sh
> delete mode 100755 t/t7410-submodule-checkout-to.sh
>=20
>=20
> base-commit: b4615e40a8125477e18490d868f7b65954372b43
> Published-As: =
https://github.com/gitgitgadget/git/releases/tag/pr-523%2Fphil-blain%2Fche=
ckout-recurse-in-linked-worktree-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git =
pr-523/phil-blain/checkout-recurse-in-linked-worktree-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/523
>=20
> Range-diff vs v1:
>=20
> 1:  ff33339690 =3D 1:  1a4eae1ef5 t7410: rename to =
t2405-worktree-submodule.sh
> 2:  5060ce3d64 ! 2:  f06d2c4aa5 t2405: use git -C and test_commit -C =
instead of subshells
>     @@ -41,7 +41,7 @@
>      +	git init origin/main &&
>      +	git -C origin/main submodule add ../sub &&
>      +	git -C origin/main commit -m "add sub" &&
>     -+	test_commit -C origin/sub "file1-updated" file1 =
file1updated &&
>     ++	test_commit -C origin/sub "file1 updated" file1 =
file1updated file1updated &&
>       	git -C origin/main/sub pull &&
>      -	(
>      -		cd origin/main &&
>     @@ -53,30 +53,3 @@
>       '
>=20
>       test_expect_success 'setup: clone' '
>     -@@
>     -=20
>     - test_expect_failure 'can see submodule diffs just after =
checkout' '
>     - 	git -C default_checkout/main diff --submodule master"^!" =
>out &&
>     --	grep "file1 updated" out
>     -+	grep "file1-updated" out
>     - '
>     -=20
>     - test_expect_success 'checkout main and initialize independent =
clones' '
>     -@@
>     -=20
>     - test_expect_success 'can see submodule diffs after independent =
cloning' '
>     - 	git -C fully_cloned_submodule/main diff --submodule =
master"^!" >out &&
>     --	grep "file1 updated" out
>     -+	grep "file1-updated" out
>     - '
>     -=20
>     - test_expect_success 'checkout sub manually' '
>     -@@
>     -=20
>     - test_expect_success 'can see submodule diffs after manual =
checkout of linked submodule' '
>     - 	git -C linked_submodule/main diff --submodule master"^!" =
>out &&
>     --	grep "file1 updated" out
>     -+	grep "file1-updated" out
>     - '
>     -=20
>     - test_done
> 3:  6e0e664026 ! 3:  10727275a2 t2405: clarify test descriptions and =
simplify test
>     @@ -10,7 +10,13 @@
>          descriptions were not updated, keeping 'checkout' instead of =
using the new
>          terminology (linked worktrees).
>=20
>     -    Clarify the tests by using the right terminology. While at =
it, remove some unnecessary
>     +    Also, in the test each worktree is created in
>     +    $TRASH_DIRECTORY/<leading-directory>/main, where the name of =
<leading-directory>
>     +    carries some information about what behavior each test =
verifies. This directory
>     +    structure is not mandatory for the tests; the worktrees can =
live next to one
>     +    another in the trash directory.
>     +
>     +    Clarify the tests by using the right terminology, and remove =
the unnecessary
>          leading directories such that all superproject worktrees are =
directly next to one
>          another in the trash directory.
>=20
>     @@ -44,7 +50,7 @@
>      -	git -C default_checkout/main diff --submodule master"^!" =
>out &&
>      +test_expect_failure 'submodule is checked out just after =
worktree add' '
>      +	git -C worktree diff --submodule master"^!" >out &&
>     - 	grep "file1-updated" out
>     + 	grep "file1 updated" out
>       '
>=20
>      -test_expect_success 'checkout main and initialize independent =
clones' '
>     @@ -60,7 +66,7 @@
>      -	git -C fully_cloned_submodule/main diff --submodule =
master"^!" >out &&
>      +test_expect_success 'submodule is checked out just after =
submodule update in linked worktree' '
>      +	git -C worktree-submodule-update diff --submodule =
master"^!" >out &&
>     - 	grep "file1-updated" out
>     + 	grep "file1 updated" out
>       '
>=20
>      -test_expect_success 'checkout sub manually' '
>     @@ -76,6 +82,6 @@
>      -	git -C linked_submodule/main diff --submodule master"^!" =
>out &&
>      +test_expect_success 'submodule is checked out after manually =
adding submodule worktree' '
>      +	git -C linked_submodule diff --submodule master"^!" >out =
&&
>     - 	grep "file1-updated" out
>     + 	grep "file1 updated" out
>       '
>=20
> 4:  72cdb2f95d ! 4:  614bccd31b submodule.c: use get_git_dir() instead =
of get_git_common_dir()
>     @@ -24,7 +24,7 @@
>          This leads to an incorrect (and confusing!) state in the =
submodule working tree
>          of the main superproject worktree.
>=20
>     -    Additionnally, if switching to a commit where the submodule =
is not present,
>     +    Additionally, if switching to a commit where the submodule is =
not present,
>          submodule_unset_core_worktree will be called and will =
incorrectly remove
>          'core.wortree' from the config file of the submodule in the =
main superproject worktree,
>          $GIT_COMMON_DIR/modules/<name>/config.
>     @@ -75,30 +75,41 @@
>      +	test_commit -C origin/main first &&
>       	git -C origin/main submodule add ../sub &&
>       	git -C origin/main commit -m "add sub" &&
>     - 	test_commit -C origin/sub "file1-updated" file1 =
file1updated &&
>     + 	test_commit -C origin/sub "file1 updated" file1 =
file1updated file1updated &&
>      @@
>     - 	grep "file1-updated" out
>     + 	grep "file1 updated" out
>       '
>=20
>      +test_expect_success 'checkout --recurse-submodules uses $GIT_DIR =
for submodules in a linked worktree' '
>      +	git -C main worktree add "$base_path/checkout-recurse" =
--detach  &&
>      +	git -C checkout-recurse submodule update --init &&
>     -+	cat checkout-recurse/sub/.git > expect-gitfile &&
>     -+	git -C main/sub rev-parse HEAD > expect-head-main &&
>     ++	echo "gitdir: =
../../main/.git/worktrees/checkout-recurse/modules/sub" >expect-gitfile =
&&
>     ++	cat checkout-recurse/sub/.git >actual-gitfile &&
>     ++	test_cmp expect-gitfile actual-gitfile &&
>     ++	git -C main/sub rev-parse HEAD >expect-head-main &&
>      +	git -C checkout-recurse checkout --recurse-submodules =
HEAD~1 &&
>     -+	cat checkout-recurse/sub/.git > actual-gitfile &&
>     -+	git -C main/sub rev-parse HEAD > actual-head-main &&
>     ++	cat checkout-recurse/sub/.git >actual-gitfile &&
>     ++	git -C main/sub rev-parse HEAD >actual-head-main &&
>      +	test_cmp expect-gitfile actual-gitfile &&
>      +	test_cmp expect-head-main actual-head-main
>      +'
>      +
>      +test_expect_success 'core.worktree is removed in =
$GIT_DIR/modules/<name>/config, not in =
$GIT_COMMON_DIR/modules/<name>/config' '
>     -+	git -C main/sub config --get core.worktree > expect &&
>     ++	echo "../../../sub" >expect-main &&
>     ++	git -C main/sub config --get core.worktree >actual-main =
&&
>     ++	test_cmp expect-main actual-main &&
>     ++	echo "../../../../../../checkout-recurse/sub" =
>expect-linked &&
>     ++	git -C checkout-recurse/sub config --get core.worktree =
>actual-linked &&
>     ++	test_cmp expect-linked actual-linked &&
>      +	git -C checkout-recurse checkout --recurse-submodules =
first &&
>     -+	test_might_fail git -C =
main/.git/worktrees/checkout-recurse/modules/sub config --get =
core.worktree > linked-config &&
>     ++	test_expect_code 1 git -C =
main/.git/worktrees/checkout-recurse/modules/sub config --get =
core.worktree >linked-config &&
>      +	test_must_be_empty linked-config &&
>     -+	test_might_fail git -C main/sub config --get =
core.worktree > actual &&
>     -+	test_cmp expect actual
>     ++	git -C main/sub config --get core.worktree >actual-main =
&&
>     ++	test_cmp expect-main actual-main
>     ++'
>     ++
>     ++test_expect_success 'unsetting core.worktree does not prevent =
running commands directly against the submodule repository' '
>     ++	git -C main/.git/worktrees/checkout-recurse/modules/sub =
log
>      +'
>      +
>       test_done
>=20
> --=20
> gitgitgadget

