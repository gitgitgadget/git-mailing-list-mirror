Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA7C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6A561152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJNUgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhJNUgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:36:38 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039BBC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:33 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id x16-20020a0cfe10000000b003834102a98cso6538479qvr.9
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EHPXI9zDsiAIZcUmoggXLM7T55QJPxWr3RQ8HIGdlDw=;
        b=ADnLvRyvetUZQnMlQeV9B3iVp/GsWMU6yZSvj7PilTd9lorL27MfL5piQ5KJAOzudf
         M38mCELcK87IIuAUNE88SzIyggxNtFwxD8E9cC/GI+tBPs35Ix+L7+kTFw4iluUFxWhJ
         bLRYomDHLNYtvpuZSz4qwvQSJsl94m+6Su/0Cc5gxKv8Zfit16CoLoM+qhIwroHYv6mv
         S3lbKmSvQQbGUrFicrQ4mKdDq7I6XtrSRcGGxq3ut4Bx+PEfNKeCpyldIHKjmqYUZXyZ
         llvf/gu5SsJZjcxNkD0/3FpbZSLZSIiXxYU3AeCo0rH9WdjVxxIysQy0UYwQxyPxSlEU
         HkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EHPXI9zDsiAIZcUmoggXLM7T55QJPxWr3RQ8HIGdlDw=;
        b=IWmio5TfNqgCFH72FxBDRoREsHF5ZPeliUYnLHAjakTysqRABZYyjcCB9YjkUWwaY/
         xJ+KC1wuWmqV95xlTXnbubhWzA6amdRnn+sDcBXCcgbIKFZJyymRu1ziRF7tF73eIL+W
         El0g3zCKqz507Bde+gJldVbeMBZcxYR2EwqRw7tCtcXi6ucH3QdeHrB3Fsx1m31ORjar
         SKEK7FkpVMibN+yfXP7t/g4GH8735w5Wf84ffcPe9k1cbdRNGWap/D2v2IVcORdaB6AI
         Zmr/NDjQN570+XdMQ6vyBtmjA0Nej4YeQMTtyGjxptMSb1YdzKLNddcLl+O2XRM/N8WT
         iViA==
X-Gm-Message-State: AOAM530j94vdypvySUBkZlvtBMjpImwzRlcvVVtmSksByLbM7s5N5EQV
        By8fzGSi/ldvc6QasWkmdsVEFpJM+aBNsUhbH9x7fmpkojfMkIhW8r0OCW3n/JxSGRJdQIpepNT
        6AMN8eX2FPutZqtme7oDjwyVJhReON3nmhZ3+Efgp6jD2DgWaN4J5keOs2KbaJHQHteYHo83GNw
        ==
X-Google-Smtp-Source: ABdhPJwt8E3xTgl9MT0EecUtbx+lpcsp016JEbBE7V/tSLzWf6ixwtJ9s49S/r/ILE/gwsMc+TnIRShkWeygmExhrd4=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:e9ae:673a:ec5:a064])
 (user=emilyshaffer job=sendgmr) by 2002:ac8:5e14:: with SMTP id
 h20mr8962237qtx.364.1634243672023; Thu, 14 Oct 2021 13:34:32 -0700 (PDT)
Date:   Thu, 14 Oct 2021 13:34:12 -0700
Message-Id: <20211014203416.2802639-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 0/4] cache parent project's gitdir in submodules
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
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the original cover letter, see
https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer%40google.com.

The CI run is here:
https://github.com/nasamuffin/git/runs/3899227896

It shows some broken Windows tests, but those are broken in the
fork-point too:
https://github.com/nasamuffin/git/actions/runs/1343120990

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

 - Emily

Emily Shaffer (4):
  t7400-submodule-basic: modernize inspect() helper
  introduce submodule.superprojectGitDir record
  submodule: record superproject gitdir during absorbgitdirs
  submodule: record superproject gitdir during 'update'

 Documentation/config/submodule.txt | 12 +++++++
 builtin/submodule--helper.c        |  4 +++
 git-submodule.sh                   | 14 ++++++++
 submodule.c                        | 10 ++++++
 t/t7400-submodule-basic.sh         | 54 ++++++++++++++++--------------
 t/t7406-submodule-update.sh        | 12 +++++++
 t/t7412-submodule-absorbgitdirs.sh | 23 +++++++++++--
 7 files changed, 102 insertions(+), 27 deletions(-)

Range-diff against v3:
1:  f1236dc9d7 ! 1:  2ff151aaa2 t7400-submodule-basic: modernize inspect() helper
    @@ t/t7400-submodule-basic.sh: test_expect_success 'setup - repository to add submo
     -}
     -
      inspect() {
    - 	dir=$1 &&
    +-	dir=$1 &&
     -	dotdot="${2:-..}" &&
    - 
    +-
     -	(
     -		cd "$dir" &&
     -		listbranches >"$dotdot/heads" &&
    @@ t/t7400-submodule-basic.sh: test_expect_success 'setup - repository to add submo
     -		git diff-files --exit-code &&
     -		git clean -n -d -x >"$dotdot/untracked"
     -	)
    -+	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
    -+	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
    -+	git -C "$dir" rev-parse HEAD >head-sha1 &&
    -+	git -C "$dir" update-index --refresh &&
    -+	git -C "$dir" diff-files --exit-code &&
    -+	git -C "$dir" clean -n -d -x >untracked
    ++	sub_dir=$1 &&
    ++
    ++	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
    ++	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
    ++	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
    ++	git -C "$sub_dir" update-index --refresh &&
    ++	git -C "$sub_dir" diff-files --exit-code &&
    ++	git -C "$sub_dir" clean -n -d -x >untracked
      }
      
      test_expect_success 'submodule add' '
2:  2caf9eb8ee ! 2:  ed5479ad5d introduce submodule.superprojectGitDir record
    @@ Commit message
     
         By using a relative path instead of an absolute path, we can move the
         superproject directory around on the filesystem without breaking the
    -    submodule's cache.
    +    submodule's cache. And by using the path from gitdir to gitdir, we can
    +    move the submodule within the superproject's tree structure without
    +    breaking the submodule's cache, too.
     
         Since this hint value is only introduced during new submodule creation
         via `git submodule add`, though, there is more work to do to allow the
    @@ Documentation/config/submodule.txt: submodule.alternateErrorStrategy::
      	clone proceeds as if no alternate was specified.
     +
     +submodule.superprojectGitDir::
    -+	The relative path from the submodule's worktree to its superproject's
    ++	The relative path from the submodule's gitdir to its superproject's
     +	gitdir. When Git is run in a repository, it usually makes no difference
     +	whether this repository is standalone or a submodule, but if this
     +	configuration variable is present, additional behavior may be possible,
    @@ Documentation/config/submodule.txt: submodule.alternateErrorStrategy::
     +	to be present in every submodule, so only optional value-added behavior
     +	should be linked to it. It is set automatically during
     +	submodule creation.
    -++
    -+	Because of this configuration variable, it is forbidden to use the
    -+	same submodule worktree shared by multiple superprojects.
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
    +@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
      		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
    - 					   error_strategy);
    + 				       error_strategy);
      
     +	git_config_set_in_file(p, "submodule.superprojectGitdir",
     +			       relative_path(absolute_path(get_git_dir()),
    -+					     path, &sb));
    ++					     sm_gitdir, &sb));
     +
      	free(sm_alternate);
      	free(error_strategy);
      
     
      ## t/t7400-submodule-basic.sh ##
    -@@ t/t7400-submodule-basic.sh: test_expect_success 'setup - repository to add submodules to' '
    - submodurl=$(pwd -P)
    +@@ t/t7400-submodule-basic.sh: submodurl=$(pwd -P)
      
      inspect() {
    --	dir=$1 &&
    --
    --	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
    --	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
    --	git -C "$dir" rev-parse HEAD >head-sha1 &&
    --	git -C "$dir" update-index --refresh &&
    --	git -C "$dir" diff-files --exit-code &&
    --	git -C "$dir" clean -n -d -x >untracked
    -+	sub_dir=$1 &&
    + 	sub_dir=$1 &&
     +	super_dir=$2 &&
    + 
    + 	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
    + 	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
    + 	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
    + 	git -C "$sub_dir" update-index --refresh &&
    + 	git -C "$sub_dir" diff-files --exit-code &&
    ++
    ++	# Ensure that submodule.superprojectGitDir contains the path from the
    ++	# submodule's gitdir to the superproject's gitdir.
    ++
    ++	super_abs_gitdir=$(git -C "$super_dir" rev-parse --absolute-git-dir) &&
    ++	sub_abs_gitdir=$(git -C "$sub_dir" rev-parse --absolute-git-dir) &&
    ++
    ++	[ "$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" = \
    ++	  "$(test-tool path-utils relative_path "$super_abs_gitdir" \
    ++						"$sub_abs_gitdir")" ] &&
     +
    -+	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
    -+	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
    -+	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
    -+	git -C "$sub_dir" update-index --refresh &&
    -+	git -C "$sub_dir" diff-files --exit-code &&
    -+	cached_super_dir="$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" &&
    -+	[ "$(git -C "$super_dir" rev-parse --absolute-git-dir)" \
    -+		-ef "$sub_dir/$cached_super_dir" ] &&
    -+	git -C "$sub_dir" clean -n -d -x >untracked
    + 	git -C "$sub_dir" clean -n -d -x >untracked
      }
      
    - test_expect_success 'submodule add' '
     @@ t/t7400-submodule-basic.sh: test_expect_success 'submodule add' '
      	) &&
      
3:  d278568a8e ! 3:  60e6cf77c5 submodule: record superproject gitdir during absorbgitdirs
    @@ Commit message
      ## submodule.c ##
     @@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *path)
      	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
    - 	char *new_git_dir;
    + 	struct strbuf new_gitdir = STRBUF_INIT;
      	const struct submodule *sub;
     +	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
      
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *p
     +	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
     +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
     +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
    -+			       relative_path(get_super_prefix_or_empty(),
    -+					     path, &sb));
    ++			       relative_path(absolute_path(get_git_dir()),
    ++					     real_new_git_dir, &sb));
     +
     +	strbuf_release(&config_path);
     +	strbuf_release(&sb);
    @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the git dir' '
     +	test_cmp expect.2 actual.2 &&
     +
     +	# make sure the submodule cached the superproject gitdir correctly
    -+	test-tool path-utils real_path . >expect &&
    -+	test-tool path-utils real_path \
    -+		"$(git -C sub1 config submodule.superprojectGitDir)" >actual &&
    ++	submodule_gitdir="$(git -C sub1 rev-parse --absolute-git-dir)" &&
    ++	superproject_gitdir="$(git rev-parse --absolute-git-dir)" &&
    ++
    ++	test-tool path-utils relative_path "$superproject_gitdir" \
    ++		"$submodule_gitdir" >expect &&
    ++	git -C sub1 config submodule.superprojectGitDir >actual &&
     +
     +	test_cmp expect actual
      '
      
      test_expect_success 'absorbing does not fail for deinitialized submodules' '
    +@@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the git dir in a nested submodule' '
    + 	git status >actual.1 &&
    + 	git -C sub1/nested rev-parse HEAD >actual.2 &&
    + 	test_cmp expect.1 actual.1 &&
    +-	test_cmp expect.2 actual.2
    ++	test_cmp expect.2 actual.2 &&
    ++
    ++	sub1_gitdir="$(git -C sub1 rev-parse --absolute-git-dir)" &&
    ++	sub1_nested_gitdir="$(git -C sub1/nested rev-parse --absolute-git-dir)" &&
    ++
    ++	test-tool path-utils relative_path "$sub1_gitdir" "$sub1_nested_gitdir" \
    ++		>expect &&
    ++	git -C sub1/nested config submodule.superprojectGitDir >actual &&
    ++
    ++	test_cmp expect actual
    + '
    + 
    + test_expect_success 're-setup nested submodule' '
4:  6866c36620 ! 4:  df9879ff93 submodule: record superproject gitdir during 'update'
    @@ Commit message
     
      ## git-submodule.sh ##
     @@ git-submodule.sh: cmd_update()
    - 			fi
    - 		fi
    + 			;;
    + 		esac
      
     +		# Cache a pointer to the superproject's gitdir. This may have
    -+		# changed, so rewrite it unconditionally. Writes it to worktree
    ++		# changed, unless it's a fresh clone. Writes it to worktree
     +		# if applicable, otherwise to local.
    -+		relative_gitdir="$(git rev-parse --path-format=relative \
    -+						 --prefix "${sm_path}" \
    -+						 --git-dir)"
    ++		if test -z "$just_cloned"
    ++		then
    ++			sm_gitdir="$(git -C "$sm_path" rev-parse --absolute-git-dir)"
    ++			relative_gitdir="$(git rev-parse --path-format=relative \
    ++							 --prefix "${sm_gitdir}" \
    ++							 --git-dir)"
     +
    -+		git -C "$sm_path" config --worktree \
    -+			submodule.superprojectgitdir "$relative_gitdir"
    ++			git -C "$sm_path" config --worktree \
    ++				submodule.superprojectgitdir "$relative_gitdir"
    ++		fi
     +
      		if test -n "$recursive"
      		then
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --quiet passe
     +	(cd super &&
     +	 git -C submodule config --unset submodule.superprojectGitdir &&
     +	 git submodule update &&
    -+	 echo "../.git" >expect &&
    ++	 test-tool path-utils relative_path \
    ++		"$(git rev-parse --absolute-git-dir)" \
    ++		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
     +	 git -C submodule config submodule.superprojectGitdir >actual &&
     +	 test_cmp expect actual
     +	)
-- 
2.33.0.1079.g6e70778dc9-goog

