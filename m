Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B760C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiF3WdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiF3WdO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:33:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA0113B
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:33:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o9so681574edt.12
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=B/jSXKKj75fCNCmaRu74A1gV192BpwZY+qVkYbP7mF0=;
        b=jKORuutCUqocc+IRVU8ut6TO7AH43WpdRRp3hNn/b92rhNky5LO/6YEsOGDPD8itRa
         zKVhe/n11o4g75OEHj+5yJYCo+B7Ny5tRcvJhVav4LWQij6GFayiQgNtmSn4aIztcoV1
         JJCKixAnVlglNWlbVu+v9/MC+zBnD+XvZsI1VKZFqaD9LpgxxuutcsZuywWUyZv7QEbR
         /BDoVUuulJTIgpU9icZBxAoJUA4zw9oWl6CREBJRBi9l2c/ffMF7S6GWULzATlvnyEwy
         eS5BSq2P01ImkPcVC06OAme63ZJiJ3Bd20ZHBn4H56c3f2DvZz8ICuaa0aDxU4bUs3bG
         ZIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=B/jSXKKj75fCNCmaRu74A1gV192BpwZY+qVkYbP7mF0=;
        b=bz4lLJGD/OW6ofdFl0AqGitvyW+IgTzc6Y0vThyoUS8tU/1h7pXYeLEWdY/uwYgtGw
         xx338lt/LiLEEUeFtd3ZGdqyMkhBqMgCm8aDEa/Imu6Y9fS4zTF3H3/sm+f5IY244zwJ
         7QEMQ4i+i/5adDwo7L87m35tXocwroxY61kXypzQ5wtAVAS/lPPeDDAeuV2uJOvBZRzp
         kON4RketrChpbWKO1P7Pzbdk2+nTr3NigsWTtmjwsGSU56uWnRDFpi46duTbUMlQquia
         7dkiHk2IGZi+xsgq3Wei97ciEHbYMke84/y2bYJ3OC7o9KdCLqq1gbW4zliQ30Yu5/MB
         17TQ==
X-Gm-Message-State: AJIora8sRVh8MelhOeKcUJc4FTKCnBu9+KZFw9PD5y6uAONTpxWS3Vul
        mVGLBsxzPFL1M7m5HCd3LE3JKk72JACMDQ==
X-Google-Smtp-Source: AGRyM1twK23lhUk2D+74QERcSzR6d7JMRcbqjarKqDyfhitECQYLz8JpDG/0uGf5krlbrwgd/AwOAw==
X-Received: by 2002:a05:6402:3481:b0:435:b12d:a66d with SMTP id v1-20020a056402348100b00435b12da66dmr14740648edc.135.1656628389517;
        Thu, 30 Jun 2022 15:33:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709061baa00b0072a815f569bsm466976ejg.185.2022.06.30.15.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:33:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o72ih-002aOe-QJ;
        Fri, 01 Jul 2022 00:33:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 00/18] submodule: remove "--recursive-prefix"
Date:   Fri, 01 Jul 2022 00:16:47 +0200
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
 <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
Message-ID: <220701.865ykhdboc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Glen Choo via GitGitGadget wrote:

> Thanks =C3=86var for the feedback! I've incorporated all of the suggestio=
ns,
> except breaking up the tests in 1/6 into their own patch - I wasn't
> convinced of the value of having prescriptive tests (with
> test_expect_failure), and I found it difficult to discuss descriptive tes=
ts
> (with test_expect_success) without also having the code in the same diff.
> FWIW, this version (and the previous one) "git rebase -x 'make test'"
> cleanly :)
>
> Note for Junio: this version is based on ab/submodule-cleanup (and so will
> future versions).
>
> =3D Description
>
> This series is a refactor of "git submodule--helper update" that replaces
> "--recursive-prefix" with "--super-prefix" (see Background). This was
> initially motivated by:
>
>  * Junio's suggestion to simplify the code [1] (in response to a memory l=
eak
>    found by Johannes Schindelin [2]).
>  * A desire to use the module_list API + get_submodule_displaypath() outs=
ide
>    of builtin/submodule--helper.c (I expect to use this to check out
>    branches in each submodule).
>
> But it also happens to remove some overly complicated/duplicated code that
> was literally converted from shell :)
>
> =3D Background
>
> When recursing into nested submodules, Git commands keep track of the path
> from the superproject to the submodule in order to print a "display path"=
 to
> the user, e.g.
>
> Submodule path '../super/sub/nested-sub': checked out 'abcdef'
>
> For historical reasons, "git submodule--helper update" uses
> "--recursive-prefix" for this purpose, but it should use "--super-prefix"
> instead because:
>
>  * That's what every other command uses (not just submodule--helper
>    subcommands).
>  * Using the "--super-prefix" helper functions makes the "git
>    submodule--helper update" code simpler
>
> =3D Patch organization
>
>  * Patch 1/6 makes sure that display paths are only computed using display
>    path helper functions ([do_]get_submodule_displaypath()) and fixes some
>    display paths that we never realized were broken.
>  * Patches 2-3/6 simplify and deduplicate some display path computations.
>  * Patch 4/6 (authored by =C3=86var) removes SUPPORT_SUPER_PREFIX where i=
t's not
>    needed.
>    * This doesn't affect correctness, but we want to do this eventually, =
so
>      do it now to make 5/6 a bit cleaner.
>  * Patch 5/6 replaces "--recursive-prefix" with "--super-prefix", making
>    do_get_submodule_displaypath() obsolete.
>    * GGG outputs an odd diff; I recommend viewing it with "--histogram"
>  * Patch 6/6 removes do_get_submodule_displaypath().
>
> =3D Series history
>
> Changes in v2:
>
>  * Rebase onto ab/submodule-cleanup (previously master)
>  * Cherry pick https://github.com/avar/git/commit/f445c57490d into 4/6
>  * Style fixes in .c and tests

Thanks for the update, Looks like something happened with GGG to send
the base series + yours, I confirmed that 1-13/18 are the same as my
series in gitster/ab/submodule-cleanup.

I played around with this a bit, and pushed some amends to
https://github.com/avar/git/tree/avar/pr-git-1282/chooglen/submodule/remove=
-recursive-prefix-v2;
which you should take more as the results of poking around, I think this
is fine as-is if Junio would like to pick it up, sans the possible bug
mentioned below.

A range-diff of the changes I made follows below, changes:

 * Split up the "add tests" to a new commit :) You mentioned
   "test_expect_failure", I just assumed we'd use test_expect_succes,
   and then the 2nd commit has this test change:
=09
	diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
	index 9a076e025f3..6cc07460dd2 100755
	--- a/t/t7406-submodule-update.sh
	+++ b/t/t7406-submodule-update.sh
	@@ -1163 +1163 @@ test_expect_success 'submodule update should skip unmerg=
ed submodules' '
	-       Skipping unmerged submodule middle//bottom
	+       Skipping unmerged submodule middle/bottom
	@@ -1176 +1176 @@ test_expect_success 'submodule update --recursive skip s=
ubmodules with strategy=3D
	-       Skipping submodule '\''../middle/'\''
	+       Skipping submodule '\''middle/bottom'\''

   Which I think makes it much easier to explain the change itself, the
   first commit basically just says "tests for existing behavior, see
   the next commit for details".

 * Used test_cmp instead of "grep -F", makes for easier to grok output :)

 * I had to squint a bit at the change from strvec_pushl() to
   strvec_pushf().

   I.e. we're changing both that we're passing "--foo bar"
   v.s. "--foo=3Dbar" *and* "bar" v.s. "bar/", but as the commit message
   notes it's just the latter that matters.

   Just a nit, but I think it's a bit easier to reason about just
   changing the one thing we need to change there, although that means
   giving the "if" braces. This also leaves the "--super-prefix" code
   consistent with all the other places where we
   "strvec.*--super-prefix" at the end.

 * We can just declare some of the variables and initialize them at the
   beginning, but couldn't when they were a strbuf.

 * Your 18/18 has some odd code formatting of "var =3D\n\t\tvalue(..."
   when we usually do "var =3D value(...\n...".

 * You appear to have (and I haven't "fixed" it here) in 13/18 mentioned
   "While we're fixing the display names, also fix inconsistent quoting
   of the submodule name", but as the test_cmp shows we appear not to
   have done that part at all? Is this referring to a forgotten change
   where we should be saying (note the added '-quotes):

       Skipping unmerged submodule 'middle/bottom'

   Either that's what you mean & you forgot, or we're missing a test, or
   I'm misunderstanding it...

I hope this helps, at least some of it...

1:  64c138df196 ! 1:  3d9977006d3 submodule--helper update: use display pat=
h helper
    @@ Metadata
     Author: Glen Choo <chooglen@google.com>
=20=20=20=20=20
      ## Commit message ##
    -    submodule--helper update: use display path helper
    +    submodule--helper tests: add missing "display path" coverage
=20=20=20=20=20
         There are two locations in prepare_to_clone_next_submodule() that
    -    manually calculate the submodule display path, but should just use
    -    do_get_submodule_displaypath() for consistency.
    -
    -    Do this replacement and reorder the code slightly to avoid computi=
ng
    -    the display path twice.
    -
    -    This code was never tested, and adding tests shows that both these=
 sites
    -    have been computing the display path incorrectly ever since they w=
ere
    -    introduced in 48308681b0 (git submodule update: have a dedicated h=
elper
    -    for cloning, 2016-02-29) [1]:
    -
    -    - The first hunk puts a "/" between recursive_prefix and ce->name,=
 but
    -      recursive_prefix already ends with "/".
    -    - The second hunk calls relative_path() on recursive_prefix and
    -      ce->name, but relative_path() only makes sense when both paths s=
hare
    -      the same base directory. This is never the case here:
    -      - recursive_prefix is the path from the topmost superproject to =
the
    -        current submodule
    -      - ce->name is the path from the root of the current submodule to=
 its
    -        submodule.
    -      so, e.g. recursive_prefix=3D"super" and ce->name=3D"submodule" p=
roduces
    -      displayname=3D"../super" instead of "super/submodule".
    -
    -    While we're fixing the display names, also fix inconsistent quotin=
g of
    -    the submodule name.
    -
    -    [1] I verified this by applying the tests to 48308681b0.
    +    manually calculate the submodule display path, as discussed in the
    +    next commit the "Skipping" output isn't exactly what we want, but
    +    let's test how we behave now, before changing the existing behavio=
r.
=20=20=20=20=20
         Signed-off-by: Glen Choo <chooglen@google.com>
    -
    - ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int prepare_to_clone_next_submo=
dule(const struct cache_entry *ce,
    - 	const char *update_string;
    - 	enum submodule_update_type update_type;
    - 	char *key;
    --	struct strbuf displaypath_sb =3D STRBUF_INIT;
    - 	struct strbuf sb =3D STRBUF_INIT;
    --	const char *displaypath =3D NULL;
    -+	char *displaypath;
    - 	int needs_cloning =3D 0;
    - 	int need_free_url =3D 0;
    -=20
    -+	displaypath =3D do_get_submodule_displaypath(ce->name,
    -+						   suc->update_data->prefix,
    -+						   suc->update_data->recursive_prefix);
    -+
    - 	if (ce_stage(ce)) {
    --		if (suc->update_data->recursive_prefix)
    --			strbuf_addf(&sb, "%s/%s", suc->update_data->recursive_prefix, ce->=
name);
    --		else
    --			strbuf_addstr(&sb, ce->name);
    --		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
    -+		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
    - 		strbuf_addch(out, '\n');
    - 		goto cleanup;
    - 	}
    -=20
    - 	sub =3D submodule_from_path(the_repository, null_oid(), ce->name);
    -=20
    --	if (suc->update_data->recursive_prefix)
    --		displaypath =3D relative_path(suc->update_data->recursive_prefix,
    --					    ce->name, &displaypath_sb);
    --	else
    --		displaypath =3D ce->name;
    --
    - 	if (!sub) {
    - 		next_submodule_warn_missing(suc, out, displaypath);
    - 		goto cleanup;
    -@@ builtin/submodule--helper.c: static int prepare_to_clone_next_submo=
dule(const struct cache_entry *ce,
    - 					      "--no-single-branch");
    -=20
    - cleanup:
    --	strbuf_release(&displaypath_sb);
    -+	free(displaypath);
    - 	strbuf_release(&sb);
    - 	if (need_free_url)
    - 		free((void*)url);
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## t/t7406-submodule-update.sh ##
     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update =
--filter sets partial clone settings' '
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-filter sets
     +	# because of its unmerged state
     +	test_config -C top-cloned submodule.middle.update !true &&
     +	git -C top-cloned submodule update --recursive 2>actual.err &&
    -+	grep -F "Skipping unmerged submodule middle/bottom" actual.err
    ++	cat >expect.err <<-\EOF &&
    ++	Skipping unmerged submodule middle//bottom
    ++	EOF
    ++	test_cmp expect.err actual.err
     +'
     +
     +test_expect_success 'submodule update --recursive skip submodules wit=
h strategy=3Dnone' '
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-filter sets
     +	test_commit -C top-cloned/middle/bottom downstream_commit &&
     +	git -C top-cloned/middle config submodule.bottom.update none &&
     +	git -C top-cloned submodule update --recursive 2>actual.err &&
    -+	grep -F "Skipping submodule ${SQ}middle/bottom${SQ}" actual.err
    ++	cat >expect.err <<-\EOF &&
    ++	Skipping submodule '\''../middle/'\''
    ++	EOF
    ++	test_cmp expect.err actual.err
     +'
     +
      test_done
-:  ----------- > 2:  d1a47d302ee submodule--helper update: use display pat=
h helper
2:  d3e803a4630 ! 3:  a5b30ac94e6 submodule--helper: don't recreate recursi=
ve prefix
    @@ builtin/submodule--helper.c: static void update_data_to_args(struct =
update_data
     -	if (update_data->recursive_prefix)
     -		strvec_pushl(args, "--recursive-prefix",
     -			     update_data->recursive_prefix, NULL);
    -+	if (update_data->displaypath)
    -+		strvec_pushf(args, "--recursive-prefix=3D%s/",
    -+			     update_data->displaypath);
    ++	if (update_data->displaypath) {
    ++		strvec_push(args, "--recursive-prefix");
    ++		strvec_pushf(args, "%s/", update_data->displaypath);
    ++	}
      	if (update_data->quiet)
      		strvec_push(args, "--quiet");
      	if (update_data->force)
3:  1f7cf6ffaf1 =3D 4:  0ea102882a7 submodule--helper: use correct display =
path helper
4:  85e65f143b6 =3D 5:  8085bc83a0c submodule--helper: remove unused SUPPOR=
T_SUPER_PREFIX flags
5:  1d8b6b244dc ! 6:  4c00a1b496a submodule--helper update: use --super-pre=
fix
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	enum submodule_update_type update_default;
      	struct object_id suboid;
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submo=
dule(const struct cache_entry *ce,
    -=20
    - 	displaypath =3D do_get_submodule_displaypath(ce->name,
    - 						   suc->update_data->prefix,
    --						   suc->update_data->recursive_prefix);
    -+						   get_super_prefix());
    -=20
    - 	if (ce_stage(ce)) {
    - 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
    + 	char *key;
    + 	struct update_data *ud =3D suc->update_data;
    + 	char *displaypath =3D do_get_submodule_displaypath(ce->name, ud->pre=
fix,
    +-							 ud->recursive_prefix);
    ++							 get_super_prefix());
    + 	struct strbuf sb =3D STRBUF_INIT;
    + 	int needs_cloning =3D 0;
    + 	int need_free_url =3D 0;
     @@ builtin/submodule--helper.c: static void update_data_to_args(struct=
 update_data *update_data, struct strvec *
      {
      	enum submodule_update_type update_type =3D update_data->update_defau=
lt;
=20=20=20=20=20=20
     -	strvec_pushl(args, "submodule--helper", "update", "--recursive", NUL=
L);
     -	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
    - 	if (update_data->displaypath)
    --		strvec_pushf(args, "--recursive-prefix=3D%s/",
    -+		strvec_pushf(args, "--super-prefix=3D%s/",
    - 			     update_data->displaypath);
    + 	if (update_data->displaypath) {
    +-		strvec_push(args, "--recursive-prefix");
    ++		strvec_push(args, "--super-prefix");
    + 		strvec_pushf(args, "%s/", update_data->displaypath);
    + 	}
     +	strvec_pushl(args, "submodule--helper", "update", "--recursive", NUL=
L);
     +	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
      	if (update_data->quiet)
6:  a21e8cd174d ! 7:  639f07e4b84 submodule--helper: remove display path he=
lper
    @@ builtin/submodule--helper.c: static void init_submodule(const char *=
path, const
      	sub =3D submodule_from_path(the_repository, null_oid(), path);
=20=20=20=20=20=20
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submo=
dule(const struct cache_entry *ce,
    + 	enum submodule_update_type update_type;
    + 	char *key;
    + 	struct update_data *ud =3D suc->update_data;
    +-	char *displaypath =3D do_get_submodule_displaypath(ce->name, ud->pre=
fix,
    +-							 get_super_prefix());
    ++	char *displaypath =3D get_submodule_displaypath(ce->name, ud->prefix=
);
    + 	struct strbuf sb =3D STRBUF_INIT;
      	int needs_cloning =3D 0;
      	int need_free_url =3D 0;
    -=20
    --	displaypath =3D do_get_submodule_displaypath(ce->name,
    --						   suc->update_data->prefix,
    --						   get_super_prefix());
    -+	displaypath =3D
    -+		get_submodule_displaypath(ce->name, suc->update_data->prefix);
    -=20
    - 	if (ce_stage(ce)) {
    - 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
     @@ builtin/submodule--helper.c: static int update_submodule(struct upd=
ate_data *update_data)
      {
      	ensure_core_worktree(update_data->sm_path);
q
