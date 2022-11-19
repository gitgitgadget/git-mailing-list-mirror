Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4EFC4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 02:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiKSC51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKSC5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 21:57:25 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EE79DB96
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 18:57:22 -0800 (PST)
Date:   Sat, 19 Nov 2022 02:57:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1668826639; x=1669085839;
        bh=2sV0QnnBCrd7xuj8nw4uLZHD7OddYEVD90dnrPO7c18=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ha2q5I4RiORCh+qoT8aPyfxN5RJZDpreb+gYW9YD4qhE1f9IK1r7Olq5CkQ8SV7ts
         jQY0z/wXc9ZKsI03TJWndhBl9bYky7BCAXKRHp6A9l8TyOwF9/HDPuYeHBcU4SOeC8
         FavKkbQhWjDl5ooFx4vpadrbJenQiQVzQ6utzU05+LL0DFhxROCTkL8kSmpG6oF/Yk
         +zaqI4zQg/rzC2Mqb81iSYE9Xz8H5lEYjmrKkbvJBNRdAoxxRyL5+TjqjFvqFjS/Gp
         9h+WYgrXJ/F1ypHgEm5MiP1dg8zqa7uJpvcQ2nZtZB75GL5lUXYNWgbtbgDz8BjS98
         c5DtZYXtvmDKw==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
Message-ID: <20221119025701.syuscuoqjuqhqsoz@phi>
In-Reply-To: <221115.86edu3kfqz.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221110233137.10414-3-jacobabel@nullpo.dev> <221115.86edu3kfqz.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/15 11:09PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Thu, Nov 10 2022, Jacob Abel wrote:
>
> So, on a second read-through...
>
> >  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <str=
ing>]]
> > -=09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
> > +=09=09   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]
>
> This synopsis is now at least partially wrong, and ....
>
> > +--orphan <new-branch>::
> > +=09With `add`, create a new orphan branch named `<new-branch>` in the =
new
> > +=09worktree. See `--orphan` in linkgit:git-switch[1] for details.
> > +
> >  --porcelain::
> > ....
> >  #define BUILTIN_WORKTREE_ADD_USAGE \
> >  =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason=
 <string>]]\n" \
> > -=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]=
")
> > +=09   "                 [[-b | -B | --orphan] <new-branch>] <path> [<c=
ommit-ish>]")
>
>
> ...here we say the same, but surely it's only:
>
> =09git worktree add --orphan new-branch /tmp/orphan
>
> And not e.g.:
>
> =09git worktree add --orphan new-branch /tmp/orphan origin/next
>
> Or whatever, but it's incompatible with <commit-ish>. I think this on
> top should fix it up:
>
> =09diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktr=
ee.txt
> =09index 1310bfb564f..3afef985154 100644
> =09--- a/Documentation/git-worktree.txt
> =09+++ b/Documentation/git-worktree.txt
> =09@@ -10,7 +10,9 @@ SYNOPSIS
> =09 --------
> =09 [verse]
> =09 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]
> =09-=09=09   [[-b | -B | --orphan] <new-branch>] <path> [<commit-ish>]
> =09+=09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
> =09+'git worktree add' [-f] [--lock [--reason <string>]]
> =09+=09=09   --orphan <new-branch> <path>
> =09 'git worktree list' [-v | --porcelain [-z]]
> =09 'git worktree lock' [--reason <string>] <worktree>
> =09 'git worktree move' <worktree> <new-path>
> =09diff --git a/builtin/worktree.c b/builtin/worktree.c
> =09index 71786b72f6b..2b811630b3a 100644
> =09--- a/builtin/worktree.c
> =09+++ b/builtin/worktree.c
> =09@@ -17,7 +17,10 @@
>
> =09 #define BUILTIN_WORKTREE_ADD_USAGE \
> =09 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reaso=
n <string>]]\n" \
> =09-=09   "                 [[-b | -B | --orphan] <new-branch>] <path> [<=
commit-ish>]")
> =09+=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>=
]"), \
> =09+=09N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
> =09+=09   "                 --orphan <new-branch> <path>")
> =09+
> =09 #define BUILTIN_WORKTREE_LIST_USAGE \
> =09 =09N_("git worktree list [-v | --porcelain [-z]]")
> =09 #define BUILTIN_WORKTREE_LOCK_USAGE \
> =09@@ -668,6 +671,9 @@ static int add(int ac, const char **av, const char=
 *prefix)
> =09 =09if (opts.orphan_branch && !opts.checkout)
> =09 =09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
> =09 =09=09    "--no-checkout");
> =09+=09if (opts.orphan_branch && ac =3D=3D 2)
> =09+=09=09die(_("'%s' and '%s' cannot be used together"), "--orphan",
> =09+=09=09    _("<commit-ish>"));
> =09 =09if (lock_reason && !keep_locked)
> =09 =09=09die(_("the option '%s' requires '%s'"), "--reason", "--lock");
> =09 =09if (lock_reason)
> =09diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> =09index 93c340f4aff..47461d02115 100755
> =09--- a/t/t2400-worktree-add.sh
> =09+++ b/t/t2400-worktree-add.sh
> =09@@ -326,6 +326,10 @@ test_expect_success '"add" --orphan/--no-checkout=
 mutually exclusive' '
> =09 =09test_must_fail git worktree add --orphan poodle --no-checkout bamb=
oo
> =09 '
>
> =09+test_expect_success '"add" --orphan and <commit-ish> mutually exclusi=
ve' '
> =09+=09test_must_fail git worktree add --orphan poodle bamboo main
> =09+'
> =09+
> =09 test_expect_success '"add" -B/--detach mutually exclusive' '
> =09 =09test_must_fail git worktree add -B poodle --detach bamboo main
> =09 '

Yep, you are right. I applied the patch as part of this 2/2 patch and will
include it in v4. When it comes to attribution, is there a preferred way to
handle this?

>
> > -=09if (ac < 2 && !new_branch && !opts.detach) {
> > +=09/*
> > +=09 * As the orphan cannot be created until the contents of branch
> > +=09 * are staged, opts.orphan_branch should be treated as both a boole=
an
> > +=09 * indicating that `--orphan` was selected and as the name of the n=
ew
> > +=09 * orphan branch from this point on.
> > +=09 */
>
> I've re-read this a couple of times, and I honestly still don't see what
> point is trying to drive home.
>
> So, "--orphan" is an OPT_STRING(), so it always has a value:
>
> =09$ ./git worktree add --orphan
> =09error: option `orphan' requires a value
>
> But we init it to NULL, and above we just used it as a boolean *and*
> below.
>
> I.e. this comment would seem to me to fit with code where the reader
> might be surprised that we're using "opts.orphan_branch" as a string
> from then on, but we're just copying that to "new_branch", then we
> always use "opts.orphan_branch" as a boolean for the rest of the
> function.
>
> I may be missing something, but I think this would probably be better
> just without this comment. E.g. we use "--track", "--lock-reason"
> etc. in similar ways, and those don't have a comment like that.
>

Originally the new orphan branch's name was passed into
`add_worktree(path, refname, opts)` via the `orphan_branch` field in `opts`=
 and
the branch which was to be checked out first(to mimic `git checkout --orpha=
n`)
was passed in via `refname`.

Now that the behavior was changed to use `git switch`, that
"checkout then make orphan" behavior was unneeded and `refname` also contai=
ns
the name of the orphan branch.

For `make_worktree_orphan(opts, child_env)` however since I used the same
function signature as `checkout_worktree(opts, child_env)`, `refname` wasn'=
t
passed in and I used `opts->orphan_branch` to access the branch name from
that scope.

I can change `make_worktree_orphan(opts, child_env)` to
`make_worktree_orphan(ref, opts, child_env)` instead and then `orphan_branc=
h`
would be able to be treated as a boolean like those other flags.

>
> > +=09if (opts.orphan_branch) {
> > +=09=09new_branch =3D opts.orphan_branch;
> > +=09}
> > +
> > +=09if (ac < 2 && !new_branch && !opts.detach && !opts.orphan_branch) {
>
> In general we shouldn't combine random "if"'s just because a a
> sufficiently smart compiler could discover a way to reduce work.
>
> But in this case these seem to be inherently connected, we always want
> the not-DWIM behavior with "orphan", no?
>
> So shouldn't this just be:
>
> =09if (opts.orphan_branch) {
> =09=09...
> =09} else if (ac < 2 && !new_branch && !opts.detach) {
> =09=09....
> =09}
>
> ?

Yes. I've updated that for v4.

