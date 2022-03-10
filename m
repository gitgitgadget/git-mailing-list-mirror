Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11865C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiCJApd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiCJApb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:45:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1072C6E56B
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 16:44:31 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11462so28246287b3.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 16:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=iDYeU6D/RvuPb+ebpU3P8Tn6CFvVS+Y88/VESm/+cUY=;
        b=nNaqmUnzwc6rcSQBbjK2rkUi/L086DTkfaKWm9DmU8tgb4lyW++P6wAfz+eGNlF/Hj
         KPy/V2WEzVSDWX5ikQJcwqZdIeTWLpG+a5AvaILpYECeR5ckf4bOCX3EIwrl3I9Gn+ML
         SKF7VO+P2ddhovtBjtDtkqkOYODVO/O/hmPKydraxvFr9k1LgyQZfR1i78xu/PShzRkb
         0iCC4Qy+4KIlnOvF8FSn9uxnnVhVmHXZ83IPidwcrNxh2R/RTq8HJfIXAGe9lS1yZcai
         TR0Cdi/vBCXVsEe9g4+Ek/x36gezgDMmNsfX3jS+Y1BSCkgt/wh8pbNR8ccGu5fWaKjk
         y/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=iDYeU6D/RvuPb+ebpU3P8Tn6CFvVS+Y88/VESm/+cUY=;
        b=0XnTor29NWKiPSUXq5G+CvIPKngYkJdBRYQoobX+43EduZDlI+mbzp8goUIebkQ7ap
         VLv6FA6K9DT7Qu32ANa12F5BMpRl+8lc0F6Shxj9q1ziS1O0N2wZnxXMp5wzRb6x1aFb
         wGzuavEAHvFCZ8qL5jTI4tnGbsfFFZ512dHJ6H8wPs4X7uw+A+075C5wI3owQ3UYBVyK
         3Rp/9EcBQQAJOgKfjIDvbdvCyEdzc0M1GbU0jGtu0tqId/zWn/cooTpS1b1JA+XxzuaO
         hTWfkoQvYWmWQoPxdCSlfYJVkhk2u7zdC3+iC5GsOHdlsgnpYs2Xb+c3IsIPWC1g7+tD
         RRPA==
X-Gm-Message-State: AOAM531tl+FUpS6qZzgjLr4QE7UNxf0mm6vqQi2iwTQLWkYeEZkwj/vi
        YS2Hqcy7G3bE6PpG+WHigOB27KrbTc5m1XdCy99KKhx0KKVEjDpW81Lh5+7FGCeY/hh4DaHTEvj
        FII4T2g2hwDokDt77tpKlidQTV8/Cc1Y2zu2p5eE55grrC6YJbQDA8fGKspTj/P83z+jNaZmURQ
        ==
X-Google-Smtp-Source: ABdhPJzDkXqBCKOFIMV4MpV2bCEpMG8WbZZsbmTN/9XfflwIIRx0P6PScqDpA48duvMuM0OzTgcyZZEkvIQF2LCTxUU=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:e0ed:468:c28b:9b23])
 (user=emilyshaffer job=sendgmr) by 2002:a81:c24b:0:b0:2dc:7d67:a57a with SMTP
 id t11-20020a81c24b000000b002dc7d67a57amr2200811ywg.272.1646873070150; Wed,
 09 Mar 2022 16:44:30 -0800 (PST)
Date:   Wed,  9 Mar 2022 16:44:20 -0800
In-Reply-To: <20220301002613.1459916-1-emilyshaffer@google.com>
Message-Id: <20220310004423.2627181-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v9 0/3] teach submodules to know they're submodules
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
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the original cover letter, see
https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer%40google.=
com.

CI run: https://github.com/nasamuffin/git/actions/runs/1954710601

Since v8:

Only a couple of minor fixes.

Junio pointed out that I could write the tests better using --type=3Dbool
and 'test_cmp_config', and that we could be a little more careful about
when to give up on 'git rev-parse --show-superproject-working-dir'.

Glen mentioned that builtin/submodule--helper.c:run_update_procedure() is c=
alled
unconditionally earlier in the same function where I had added the
config in git-submodule.sh. So, I moved the config set into
submodule--helper.c to reduce possible edge cases where the config might
not be set.

Otherwise, this series is pretty much unchanged.

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
 builtin/submodule--helper.c        | 11 +++++++
 submodule.c                        | 30 ++++++++++++++++++
 t/t1500-rev-parse.sh               | 10 +++++-
 t/t7400-submodule-basic.sh         | 42 ++++++++++++-------------
 t/t7406-submodule-update.sh        |  8 +++++
 t/t7412-submodule-absorbgitdirs.sh | 50 ++++++++++++++++++++++++++++--
 7 files changed, 131 insertions(+), 26 deletions(-)

Range-diff against v8:
-:  ---------- > 1:  251510c687 t7400-submodule-basic: modernize inspect() =
helper
1:  34cbfd81ee ! 2:  da01dc7c10 introduce submodule.hasSuperproject record
    @@ builtin/submodule--helper.c: static int clone_submodule(struct modul=
e_clone_data
      	free(sm_alternate);
      	free(error_strategy);
     =20
    -
    - ## git-submodule.sh ##
    -@@ git-submodule.sh: cmd_update()
    - 			;;
    - 		esac
    +@@ builtin/submodule--helper.c: static int run_update_procedure(int ar=
gc, const char **argv, const char *prefix)
    +=20
    + 	free(prefixed_path);
     =20
    -+		# Note that the submodule is a submodule.
    -+		git -C "$sm_path" config submodule.hasSuperproject "true"
    ++	/*
    ++	 * This entry point is always called from a submodule, so this is a
    ++	 * good place to set a hint that this repo is a submodule.
    ++	 */
    ++	git_config_set("submodule.hasSuperproject", "true");
     +
    - 		if test -n "$recursive"
    - 		then
    - 			(
    + 	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.for=
ce)
    + 		return do_run_update_procedure(&update_data);
    +=20
    =20
      ## submodule.c ##
     @@ submodule.c: static void relocate_single_git_dir_into_superproject(=
const char *path)
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(c=
onst char *p
     =20
      	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
     =20
    -+	/*
    -+	 * Note location of superproject's gitdir. Because the submodule alr=
eady
    -+	 * has a gitdir and local config, we can store this pointer from
    -+	 * worktree config to worktree config, if the submodule has
    -+	 * extensions.worktreeConfig set.
    -+	 */
     +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
     +	git_configset_init(&sub_cs);
     +	git_configset_add_file(&sub_cs, config_path.buf);
    @@ t/t7400-submodule-basic.sh: inspect() {
      	git -C "$sub_dir" diff-files --exit-code &&
     +
     +	# Ensure that submodule.hasSuperproject is set.
    -+	git -C "$sub_dir" config "submodule.hasSuperproject"
    ++	test_cmp_config -C "$sub_dir" true --type=3Dbool "submodule.hasSuper=
project"
     +
      	git -C "$sub_dir" clean -n -d -x >untracked
      }
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-quiet passe
     =20
     +test_expect_success 'submodule update adds submodule.hasSuperproject =
to older repos' '
     +	(cd super &&
    -+	 git -C submodule config --unset submodule.hasSuperproject &&
    ++	 test_unconfig submodule.hasSuperproject &&
     +	 git submodule update &&
    -+	 git -C submodule config submodule.hasSuperproject
    ++	 test_cmp_config -C submodule true --type=3Dbool submodule.hasSuperp=
roject
     +	)
     +'
     +
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the =
git dir' '
     -	test_cmp expect.2 actual.2
     +	test_cmp expect.2 actual.2 &&
     +
    -+	git -C sub1 config submodule.hasSuperproject
    ++	test_cmp_config -C sub1 true --type=3Dbool submodule.hasSuperproject
      '
     =20
      test_expect_success 'absorbing does not fail for deinitialized submod=
ules' '
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the =
git dir in a
     -	test_cmp expect.2 actual.2
     +	test_cmp expect.2 actual.2 &&
     +
    -+	git -C sub1/nested config submodule.hasSuperproject
    ++	test_cmp_config -C sub1/nested true --type=3Dbool submodule.hasSuper=
project
      '
     =20
      test_expect_success 're-setup nested submodule' '
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorbing f=
ails for a s
     +	git submodule absorbgitdirs sub4 &&
     +
     +	# make sure the submodule noted the superproject
    -+	git -C sub4 config submodule.hasSuperproject
    ++	test_cmp_config -C sub4 true --type=3Dbool submodule.hasSuperproject
     +	)
     +'
     +
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorbing f=
ails for a s
     +	git submodule absorbgitdirs sub5 &&
     +
     +	# make sure the submodule noted the superproject
    -+	git -C sub5 config submodule.hasSuperproject
    ++	test_cmp_config -C sub5 true --type=3Dbool submodule.hasSuperproject
     +	)
     +'
     +
2:  c14ee8760f < -:  ---------- rev-parse: short-circuit superproject workt=
ree when config unset
-:  ---------- > 3:  1893a84fdc rev-parse: short-circuit superproject workt=
ree when config unset
--=20
2.35.1.616.g0bdcbb4464-goog

