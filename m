Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E120C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 14:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiLLO7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiLLO7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 09:59:35 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD5B1E4
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 06:59:33 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670857171; x=1671116371;
        bh=bq03AayrbRbd+6d62HG7TA7iXnY7pHpcrRSljHh1IQc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=pt8N3MdRx48IIIaLGFVcnHZo23AYZ4aPb9RAziIk4s2fIE4ywvg+/VBlaRJftIbno
         EGroEZ7/Q3gn9AEkjN5js5j6EjldEnjumMg07HRdrfdOa03Yg9xCEnwUedsBzkI8lJ
         vR6O/qJocgEMSlsadXGA08TK+FbIXEL6kcHdFZX8fig+33i4k3pPi9FhfELamWb0h4
         Qu090MACLinWEVszSeJrGiNzsLc7FDDZuxN9iBgfjpPezfVDck0DWBfXHWcb6WOUvP
         8OQ+F9ZaFmuNg8NH1njeaN6TYI++jSpaGTeODz3ktFIYxlbwEGRWVzl0aK2z/ZGEpx
         c0ey21jA1L+DQ==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v4 3/3] worktree add: Add hint to use --orphan when bad ref
Message-ID: <20221212145913.aftjeq6kn55zbkai@phi>
In-Reply-To: <221212.86pmcp57w4.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221212014003.20290-4-jacobabel@nullpo.dev> <221212.86pmcp57w4.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/12 09:35AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Mon, Dec 12 2022, Jacob Abel wrote:
>
> >  int git_default_advice_config(const char *var, const char *value);
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 51b247b2a7..ea306e18de 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -744,6 +744,14 @@ static int add(int ac, const char **av, const char=
 *prefix)
> >  =09=09 * If `branch` does not reference a valid commit, a new
> >  =09=09 * worktree (and/or branch) cannot be created based off of it.
> >  =09=09 */
> > +=09=09advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
> > +=09=09=09"If you meant to create a worktree containing a new orphan br=
anch\n"
> > +=09=09=09"(branch with no commits) for this repository, e.g. '%s',\n"
>
> I think this '%s' is just confusing, how is repeating the name of the
> branch at the user (which we're about to mention in the example command)
> helpful?
>
> Shouldn't we just omit it, or reword this to e.g.:
>
> =09If you'd like the '%s' branch to be a worktree containing a
> =09new....
>
>
> > +=09=09=09"you can do so using the --orphan option:\n"
> > +=09=09=09"\n"
> > +=09=09=09"=09git worktree add --orphan %s %s\n"
> > +=09=09=09"\n",

Done.

>
> Missing the usual:
>
> =09"Turn this message off by running\n"
> =09"\"git config advice.worktreeAddOrphan false\""
>
> blurb.

That blurb is added at runtime by `advise_if_enabled()`. I originally added=
 it
but it was giving me the line twice so I took it out.

>
> Also, should we really add twe newlines at the end? I see some other API
> users that don't add a \n at all.

Removed.

>
> > +# Helper function to test hints for using --orphan in an empty repo.
>
> FWIW I think we can do without the comment...

Removed.

>
> > +test_wt_add_empty_repo_orphan_hint() {
> > +=09local context=3D"$1" &&
> > +=09local opts=3D"${@:2}" &&
>
> This appears to be some shell pseudo-syntax, and my shell hard-errors on
> this.
>
> But as we don't "shift" after the "$1" I don't see how what you
> *probably* meant could work, i.e. we always have arguments, so surely
> we'd always use "$@"?

Ah. The "${@:2}" is a bashism I think. I got it from [1] to try and grab al=
l the
remaining arguments. Changed to just shifting.

The &&ing together was a mistake on my part (not paying attention and mimic=
king
the &&ing present in the test cases). I've removed that.

>
>
> > +=09test_expect_success "'worktree add' show orphan hint in empty repo =
w/ $context" '
> > +=09=09test_when_finished "rm -rf empty_repo" &&
> > +=09=09GIT_DIR=3D"empty_repo" git init --bare &&
> > +=09=09test_must_fail git -C empty_repo worktree add $opts 2> actual &&
> > +=09=09grep "hint: If you meant to create a worktree containing a new o=
rphan branch" actual
> > +=09'
> > +}
> > +
> > +test_wt_add_empty_repo_orphan_hint 'DWIM' foobar/
> > +test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch foobar/
> > +test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch foobar/
>
> You're just testing how these options interact, so let's have the
> "foobar" part provided by the test function itself.

Done.

The following are what I have made for this set of changes (against v4).

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8bb1453e0f..38f7a27927 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -732,12 +732,11 @@ static int add(int ac, const char **av, const char *p=
refix)
        } else if (!lookup_commit_reference_by_name(branch)) {
                advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
                        "If you meant to create a worktree containing a new=
 orphan branch\n"
-                       "(branch with no commits) for this repository, e.g.=
 '%s',\n"
-                       "you can do so using the --orphan option:\n"
+                       "(branch with no commits) for this repository, you =
can do so\n"
+                       "using the --orphan option:\n"
                        "\n"
-                       "       git worktree add --orphan %s %s\n"
-                       "\n",
-                        new_branch, new_branch, path);
+                       "       git worktree add --orphan %s %s\n",
+                        new_branch, path);
                die(_("invalid reference: %s"), branch);
        } else if (new_branch) {
                struct child_process cp =3D CHILD_PROCESS_INIT;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 0970989ee5..05539aa03c 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -375,21 +375,21 @@ test_expect_success '"add" worktree with orphan branc=
h, lock, and reason' '
        test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
 '

-# Helper function to test hints for using --orphan in an empty repo.
 test_wt_add_empty_repo_orphan_hint() {
-       local context=3D"$1" &&
-       local opts=3D"${@:2}" &&
+       local context=3D"$1"
+       shift
+       local opts=3D"$@"
        test_expect_success "'worktree add' show orphan hint in empty repo =
w/ $context" '
                test_when_finished "rm -rf empty_repo" &&
                GIT_DIR=3D"empty_repo" git init --bare &&
-               test_must_fail git -C empty_repo worktree add $opts 2> actu=
al &&
+               test_must_fail git -C empty_repo worktree add $opts foobar/=
 2> actual &&
                grep "hint: If you meant to create a worktree containing a =
new orphan branch" actual
        '
 }

-test_wt_add_empty_repo_orphan_hint 'DWIM' foobar/
-test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch foobar/
-test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch foobar/
+test_wt_add_empty_repo_orphan_hint 'DWIM'
+test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
+test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch

 test_expect_success 'local clone from linked checkout' '
        git clone --local here here-clone &&


Also, Is there an easier way to debug the `test_expect_success` statements?=
 I
tried enabling tracing mode but it doesn't seem to trace into those stateme=
nts.

1. https://stackoverflow.com/a/9057392/15064705

