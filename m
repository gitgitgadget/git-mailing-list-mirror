Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC3C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiCAA1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiCAA1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:27:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A544DF61
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:26:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d11b6259adso114087217b3.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=46WOAGYag0lc+vngQ5PHLicGI9rB3wZWBg6/1jquNaU=;
        b=ak2wgjgjq3tHNmY8RngNzAsbuTTrYDlDyiqyTKPIpz7gUzw6MUsAQUgnTSYL1Xk1oQ
         K5ntfnfXW60wTWSZLmrmq7+neO0sFWymTL7Hl/0mUKsPiwYsq/AdiE4sOBbLsqoR5I2C
         ZjupQBjfIFpp6taueAJFXiE2uPAqk9Grpgefze7DxGiZs8EA6lKeTlkwPpCRzCXl9vJg
         L+mR1MzwmUs+JVmd+Z3MYiK83WUDOby/YntOh+6qoExtIo8jsDo3aYop2sQ1oQPhob5a
         OsB5+EmtKtuzkgVz4tJsdqRXexTXxCAzWb2P9y0gdNNWve0FOUk342Xu1t4NFWgS7I9d
         jZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=46WOAGYag0lc+vngQ5PHLicGI9rB3wZWBg6/1jquNaU=;
        b=chf5jAL6a3CAZ9AjnO+FkyWJf85PIm6yoImsZU6o9IR9lDklP6OQo9+ZRp5JjcERSF
         aq0JN2Qcw77B6HyZQeWzDjEfA0rz5ozC5DLOIIppJHmW7jal+dD3VHev8aqtnYlZW2H1
         UgFIOe4aaN1z8nXSdu75vWSX2dIgxZXb4HNQYQ072BPKxIjeHhDs2WYgLE4+dT7z9fcn
         CWbWI2HwEAuukUSz/ORocw4bnc8K55gzagyzJcOmBDSdGbk6hon+bM3SRZx4dtNnu0Qj
         fKI5kOezRL2Cy4JSrxpHhNpiMjdahCMOahEttUYZgktn4xygDQFF0e7NHHM4q17U76sV
         sGOg==
X-Gm-Message-State: AOAM531HdRYRN/8KaHjNGAhLwU3FnVr5Gk5CG4MOxSE4z3zsQkNhRV0G
        NdoJbU5yyWAM0pgT7yxbsyYPr/fChVyCTOiO+iYAndoJcahHSaLPaaUhnPmP/vHYxQc6xCXJYcS
        0aQfdso0m3MAw6FniX0LEGFfn+LpyfujhKPQzFiWxn+do9qTpEt6bKsR/w5zHqZm1WcBNsOnMtw
        ==
X-Google-Smtp-Source: ABdhPJyB7CNSoTMqjR1IwlivEE7KPqLbq/Vl+v3BZQCy/CI0ehJfeB/+Dmm/v1Ssh8RmKUKei+ZJ0mGaBEhb0zGelV4=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:3f0e:8f7:9f8d:6e8c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:bec7:0:b0:623:c838:2f4 with SMTP
 id k7-20020a25bec7000000b00623c83802f4mr20867558ybm.99.1646094380215; Mon, 28
 Feb 2022 16:26:20 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:26:10 -0800
In-Reply-To: <20220203215914.683922-1-emilyshaffer@google.com>
Message-Id: <20220301002613.1459916-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v8 0/3] teach submodules to know they're submodules
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the original cover letter, see
https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer%40google.=
com.

CI run: https://github.com/nasamuffin/git/actions/runs/1866957146

Since v7:

Actually a fairly large rework. Rather than keeping the path from gitdir
to gitdir, just keep a boolean under 'submodule.hasSuperproject'. The
idea is that from this boolean, we can decide whether to traverse the
filesystem looking for a superproject.

Because this simplifies the implementation, I compressed the three
middle commits into one. As proof-of-concept, I added a patch at the end
to check for this boolean when running `git rev-parse
--show-superproject-working-tree`.

One thing I'm not sure about: in the tests, I check whether the config
is set, but not what the boolean value of it is. Is there a better way
to do that? For example, I could imagine someone deciding to set
`submodule.hasSuperproject =3D false` and the tests would not function
correctly in that case. I think we don't really normalize the value on a
boolean config like that, so I didn't want to write a lot of comparison
to check if the value is 1 or true or True or TRUE or Yes or .... Am I
overthinking it?

The other thing I'm not sure about: since it's just a bool, we're not
restricted to setting this config only when we have both gitdir paths
available. That makes me want to set the config any time we are doing
something with submodules anyway, like any time 'git-submodule--helper'
is used. But that helper seems to be called in the context of the
superproject, not of the submodules, so adding this config for each
submodule we touch would be a second child process. Is there some other
common entry point for submodules that we can use?

 - Emily

Since v6:

I've dropped the fifth commit to use this new config for `git rev-parse
--show-superproject-working-tree`. I think it did more harm than good -
that tool uses an odd way to determine whether the superproject is
actually the superproject, anyways.

I poked a little bit at trying to find some benchmark to demonstrate
that "submodule.superprojectGitDir" is actually faster - but I didn't
end up able to write one without writing a ton of new code to traverse
the filesystem. To be honest, I'm not all that interested in performance
- I want the config added for correctness, instead.

So, the only real changes between v6 and v7 are some documentation
changes suggested by Jonathan Tan
(https://lore.kernel.org/git/20211117234300.2598132-1-jonathantanmy%40googl=
e.com).

Since v5:

A couple things. Firstly, a semantics change *back* to the semantics of
v3 - we map from gitdir to gitdir, *not* from common dir to common dir,
so that theoretically a submodule with multiple worktrees in multiple
superproject worktrees will be able to figure out which worktree of the
superproject it's in. (Realistically, that's not really possible right
now, but I'd like to change that soon.)

Secondly, a rewording of comments and commit messages to indicate that
this isn't a cache of some expensive operation, but rather intended to
be the source of truth for all submodules. I also added a fifth commit
rewriting `git rev-parse --show-superproject-working-tree` to
demonstrate what that means in practice - but from a practical
standpoint, I'm a little worried about that fifth patch. More details in
the patch 5 description.

I did discuss =C3=86var's idea of relying on in-process filesystem digging =
to
find the superproject's gitdir with the rest of the Google team, but in
the end decided that there are some worries about filesystem digging in
this way (namely, some ugly interactions with network drives that are
actually already an issue for Googler Linux machines). Plus, the allure
of being able to definitively know that we're a submodule is pretty
strong. ;) But overall, this is the direction I'd prefer to keep going
in, rather than trying to guess from the filesystem going forward.

Since v4:

The only real change here is a slight semantics change to map from
<submodule gitdir> to <superproject common git dir>. In every case
*except* for when the superproject has a worktree, this changes nothing.
For the case when the superproject has a worktree, this means that now
submodules will refer to the general superproject common dir (e.g. no
worktree-specific refs or configs or whatnot).

I *think* that because a submodule should exist in the context of the
common dir, not the worktree gitdir, that is ok. However, it does mean
it would be difficult to do something like sharing a config specific to
the worktree (the initial goal of this series).

$ROOT/.git
$ROOT/.git/config.superproject <- shared by $ROOT/.git/modules/sub
$ROOT/.git/modules/sub <- points to $ROOT/.git
$ROOT/.git/worktrees/wt
$ROOT/.git/worktrees/wt/config.superproject <- contains a certain config-ba=
sed pre-commit hook

If the submodule only knows about the common dir, that is tough, because
the submodule would basically have to guess which worktree it's in from
its own path. There would be no way for '$WT/sub' to inherit
'$ROOT/.git/worktrees/wt/config.superproject'.

That said... right now, we don't support submodules in worktrees very
well at all. A submodule in a worktree will get a brand new gitdir in
$ROOT/.git/worktrees/modules/ (and that brand new gitdir would point to
the super's common dir). So I think we can punt on this entire question
until we teach submodules and worktrees to play more gracefully together
(it's on my long list...), and at that time we can probably introduce a
pointer from $ROOT/.git/modules/sub/worktrees/wt/ to
$ROOT/.git/worktrees/wt/....

Or, to summarize the long ramble above: "this is still kind of weird
with worktrees, but let's fix it later when we fix worktrees more
thoroughly".

(More rambling about worktree weirdness here:
https://lore.kernel.org/git/YYRaII8YWVxlBqsF%40google.com )


Since v3, a pretty major change: the semantics of
submodule.superprojectGitDir has changed, to point from the submodule's
gitdir to the superproject's gitdir (in v3 and earlier, we kept a path
from the submodule's *worktree* to the superproject's gitdir instead).
This cleans up some of the confusions about the behavior when a
submodule worktree moves around in the superproject's tree, or in a
future when we support submodules having multiple worktrees.

I also tried to simplify the tests to use 'test-tool path-utils
relative_path' everywhere - I think that makes them much more clear for
a test reader, but if you're reviewing and it isn't obvious what we're
testing for, please speak up.

I think this is pretty mature and there was a lot of general agreement
that the gitdir->gitdir association was the way to go, so please be
brutal and look for nits, leaks, etc. this round ;)
[/v4 cover letter]

Emily Shaffer (3):
  t7400-submodule-basic: modernize inspect() helper
  introduce submodule.hasSuperproject record
  rev-parse: short-circuit superproject worktree when config unset

 Documentation/config/submodule.txt |  6 ++++
 builtin/submodule--helper.c        |  5 +++
 git-submodule.sh                   |  3 ++
 submodule.c                        | 30 ++++++++++++++++++
 t/t7400-submodule-basic.sh         | 42 ++++++++++++-------------
 t/t7406-submodule-update.sh        |  8 +++++
 t/t7412-submodule-absorbgitdirs.sh | 50 ++++++++++++++++++++++++++++--
 7 files changed, 119 insertions(+), 25 deletions(-)

Range-diff against v7:
1:  1a85deb1c5 < -:  ---------- introduce submodule.superprojectGitDir reco=
rd
-:  ---------- > 1:  251510c687 t7400-submodule-basic: modernize inspect() =
helper
2:  7a44b0edf9 ! 2:  34cbfd81ee submodule: record superproject gitdir durin=
g absorbgitdirs
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
    =20
      ## Commit message ##
    -    submodule: record superproject gitdir during absorbgitdirs
    +    introduce submodule.hasSuperproject record
    =20
    -    Already during 'git submodule add' we record a pointer to the
    -    superproject's gitdir. However, this doesn't help brand-new
    -    submodules created with 'git init' and later absorbed with 'git
    -    submodule absorbgitdirs'. Let's start adding that pointer during '=
git
    -    submodule absorbgitdirs' too.
    +    Teach submodules a config variable indicating the fact that they a=
re a
    +    submodule. If this config is set to false or unset, Git may assume=
 the
    +    current repo is not a submodule.
    +
    +    Git commands can use this variable to decide whether to traverse t=
he
    +    filesystem and look for a superproject at all. 'git rev-parse
    +    --show-superproject-working-tree' can learn to exit early if this =
config
    +    is unset or false. Other newly added or implicit behavior - like "=
git
    +    status" showing the submodule's status in relation to the superpro=
ject,
    +    or a config shared between the superproject and submodule - can us=
e this
    +    config to decide whether to search the parent directory to find a
    +    superproject.
    +
    +    Introduce this config everywhere we add a new submodule, or touch =
one
    +    that already exists, so that we can proliferate it in repos which =
are
    +    already out in the world using submodules.
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## Documentation/config/submodule.txt ##
    -@@ Documentation/config/submodule.txt: submodule.superprojectGitDir::
    - 	reference to determine whether the current repo is a submodule to
    - 	another repo; if this reference is absent, Git will treat the curren=
t
    - 	repo as though it is not a submodule (this does not make a differenc=
e to
    --	most Git commands). It is set automatically during submodule creatio=
n.
    -+	most Git commands). It is set automatically during submodule creatio=
n
    -+	and 'git submodule absorbgitdir'.
    +@@ Documentation/config/submodule.txt: submodule.alternateErrorStrateg=
y::
    + 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `igno=
re`
    + 	or `info`, and if there is an error with the computed alternate, the
    + 	clone proceeds as if no alternate was specified.
    ++
    ++submodule.hasSuperproject::
    ++	Indicates whether this repository is a submodule. If this config is =
set
    ++	to 'true', Git may traverse the filesystem above this submodule in o=
rder
    ++	to identify the superproject. It is set automatically during submodu=
le
    ++	creation, update, and 'git submodule absorbgitdir'.
    +
    + ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static int clone_submodule(struct modu=
le_clone_data *clone_data)
    + 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
    + 				       error_strategy);
    +=20
    ++	/*
    ++	 * Teach the submodule that it's a submodule.
    ++	 */
    ++	git_config_set_in_file(p, "submodule.hasSuperproject", "true");
    ++
    + 	free(sm_alternate);
    + 	free(error_strategy);
    +=20
    +
    + ## git-submodule.sh ##
    +@@ git-submodule.sh: cmd_update()
    + 			;;
    + 		esac
    +=20
    ++		# Note that the submodule is a submodule.
    ++		git -C "$sm_path" config submodule.hasSuperproject "true"
    ++
    + 		if test -n "$recursive"
    + 		then
    + 			(
    =20
      ## submodule.c ##
     @@ submodule.c: static void relocate_single_git_dir_into_superproject(=
const char *path)
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(c=
onst char *p
      	const struct submodule *sub;
     +	struct config_set sub_cs;
     +	struct strbuf config_path =3D STRBUF_INIT, sb =3D STRBUF_INIT;
    -+	int tmp;
     =20
      	if (submodule_uses_worktrees(path))
      		die(_("relocate_gitdir for submodule '%s' with "
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(c=
onst char *p
     +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
     +	git_configset_init(&sub_cs);
     +	git_configset_add_file(&sub_cs, config_path.buf);
    -+	/* return 0 indicates config was found - we have a worktree config *=
/
    -+	if (!git_configset_get_bool(&sub_cs, "extensions.worktreeConfig", &t=
mp))
    -+		strbuf_addstr(&config_path, ".worktree");
     +
    -+	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdi=
r",
    -+			       relative_path(absolute_path(get_git_dir()),
    -+					     real_new_git_dir, &sb));
    ++	git_config_set_in_file(config_path.buf, "submodule.hasSuperproject",
    ++			       "true");
     +
     +	git_configset_clear(&sub_cs);
     +	strbuf_release(&config_path);
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(c=
onst char *p
      	free(real_old_git_dir);
      	free(real_new_git_dir);
    =20
    + ## t/t7400-submodule-basic.sh ##
    +@@ t/t7400-submodule-basic.sh: inspect() {
    + 	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
    + 	git -C "$sub_dir" update-index --refresh &&
    + 	git -C "$sub_dir" diff-files --exit-code &&
    ++
    ++	# Ensure that submodule.hasSuperproject is set.
    ++	git -C "$sub_dir" config "submodule.hasSuperproject"
    ++
    + 	git -C "$sub_dir" clean -n -d -x >untracked
    + }
    +=20
    +
    + ## t/t7406-submodule-update.sh ##
    +@@ t/t7406-submodule-update.sh: test_expect_success 'submodule update =
--quiet passes quietness to fetch with a s
    + 	)
    + '
    +=20
    ++test_expect_success 'submodule update adds submodule.hasSuperproject =
to older repos' '
    ++	(cd super &&
    ++	 git -C submodule config --unset submodule.hasSuperproject &&
    ++	 git submodule update &&
    ++	 git -C submodule config submodule.hasSuperproject
    ++	)
    ++'
    ++
    + test_done
    +
      ## t/t7412-submodule-absorbgitdirs.sh ##
     @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the=
 git dir' '
      	git status >actual.1 &&
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the =
git dir' '
     -	test_cmp expect.2 actual.2
     +	test_cmp expect.2 actual.2 &&
     +
    -+	# make sure the submodule cached the superproject gitdir correctly
    -+	submodule_gitdir=3D"$(git -C sub1 rev-parse --path-format=3Dabsolute=
 --git-common-dir)" &&
    -+	superproject_gitdir=3D"$(git rev-parse --path-format=3Dabsolute --gi=
t-common-dir)" &&
    -+
    -+	test-tool path-utils relative_path "$superproject_gitdir" \
    -+		"$submodule_gitdir" >expect &&
    -+	git -C sub1 config submodule.superprojectGitDir >actual &&
    -+
    -+	test_cmp expect actual
    ++	git -C sub1 config submodule.hasSuperproject
      '
     =20
      test_expect_success 'absorbing does not fail for deinitialized submod=
ules' '
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the =
git dir in a
     -	test_cmp expect.2 actual.2
     +	test_cmp expect.2 actual.2 &&
     +
    -+	sub1_gitdir=3D"$(git -C sub1 rev-parse --path-format=3Dabsolute --gi=
t-common-dir)" &&
    -+	sub1_nested_gitdir=3D"$(git -C sub1/nested rev-parse --path-format=
=3Dabsolute --git-common-dir)" &&
    -+
    -+	test-tool path-utils relative_path "$sub1_gitdir" "$sub1_nested_gitd=
ir" \
    -+		>expect &&
    -+	git -C sub1/nested config submodule.superprojectGitDir >actual &&
    -+
    -+	test_cmp expect actual
    ++	git -C sub1/nested config submodule.hasSuperproject
      '
     =20
      test_expect_success 're-setup nested submodule' '
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorbing f=
ails for a s
     +	# absorb the git dir
     +	git submodule absorbgitdirs sub4 &&
     +
    -+	# make sure the submodule noted the superproject gitdir correctly
    -+	submodule_gitdir=3D"$(git -C sub4 rev-parse --absolute-git-dir)" &&
    -+	superproject_gitdir=3D"$(git rev-parse --absolute-git-dir)" &&
    -+
    -+	test-tool path-utils relative_path "$superproject_gitdir" \
    -+		"$submodule_gitdir" >expect &&
    -+	git -C sub4 config submodule.superprojectGitDir >actual &&
    -+
    -+	test_cmp expect actual
    ++	# make sure the submodule noted the superproject
    ++	git -C sub4 config submodule.hasSuperproject
     +	)
     +'
     +
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorbing f=
ails for a s
     +	# absorb the git dir
     +	git submodule absorbgitdirs sub5 &&
     +
    -+	# make sure the submodule noted the superproject gitdir correctly
    -+	submodule_gitdir=3D"$(git -C sub5 rev-parse --absolute-git-dir)" &&
    -+	superproject_gitdir=3D"$(git rev-parse --absolute-git-dir)" &&
    -+
    -+	test-tool path-utils relative_path "$superproject_gitdir" \
    -+		"$submodule_gitdir" >expect &&
    -+	git -C sub5 config submodule.superprojectGitDir >actual &&
    -+
    -+	test_cmp expect actual &&
    -+
    -+	# make sure the config went into the submodule config.worktree
    -+	test_file_not_empty "$submodule_gitdir/config.worktree"
    ++	# make sure the submodule noted the superproject
    ++	git -C sub5 config submodule.hasSuperproject
     +	)
     +'
     +
3:  63e736e69d < -:  ---------- submodule: record superproject gitdir durin=
g 'update'
-:  ---------- > 3:  c14ee8760f rev-parse: short-circuit superproject workt=
ree when config unset
--=20
2.35.1.574.g5d30c73bfb-goog

