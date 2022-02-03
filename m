Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69109C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355602AbiBCV7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiBCV7V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:59:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E2C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:59:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso8635771ybp.23
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=u7NJmDHT3cowz08gjRGpr6UTXYTzr34sQKSJ5vbvdew=;
        b=SiOlT+MmJ89eo44ze0hcwVEWm5y7eQwifAGJl9wml/mHc3qlYj6QgoYeaJ2q/2otag
         SLkvGa/1uppSCRuz8x4Pr+TU59hzpCIt1iDS2lcEAJpizPIM5mUlAq+wqlqg6va37s2g
         Zj5uGX4ekOViRAU3hfS/C8Fcdkzk50YGBwSc16Ek/+9v/8HY37QzZJ9MgX1/mno50cGI
         ag14ZL1C4mF0GBrE+YNxoMpQ6mTav1M5wKsw8Ln3vBqC2BboiRvmuxBnxxl+ADyu8Tv3
         HAMf7BCR7ZH09R9KFjQ3mfidX6SgoMWFZULGWMf0TDsTKJyQQEtBIeWl8jZid4p+10DX
         0zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=u7NJmDHT3cowz08gjRGpr6UTXYTzr34sQKSJ5vbvdew=;
        b=uPDpYBzBJqMbMtMWJjX1oeG8BOVx2xZrmq+gGSQ+NJTyGXDCIg/Gde/X5YXfcQZ6bS
         cEjieQ0ATvSAnjU9k94ZlsC6jpPA6g+WqYjc1OVOg0n4hAbQIIIFf2X4aTmRbaL+N+wb
         qEKHEi3utqEBsRowlQUm5JEfRdWNVjl7zPVjwdyMHr+4ndI+7k8bMWx4McG8t1WsiZ2B
         SPKWOY0iysOAfftTLcty6GOZwma9AQ8VZG+kseLhAdhDZjTXfWtziFUUkbIR9MgRKgdI
         fW2SiNiGkn0FPa4kP2W6B/BsRC+jpuj3w8AZNbio/t18lVDSMCXYWV2nEAb78LDPCNxh
         yAsw==
X-Gm-Message-State: AOAM5316qoMaoW+dt8mx5Y/T1WVOKVxJQCR58Eda5e1wLMqNiThayZiV
        DIkwYu39larEPtR7axBm1aefqtA4hH/7mmJgz+O3q7peEBawlyUgrg5AsRPQUDS1x2Am9zcbzNC
        I6LU++IHwW/ciVhs8cKkT4ATIXg8CXKGBxeT/Q2hAgdP1rPOuFuhGR6Lyjkft54P4fEiJCxuVjQ
        ==
X-Google-Smtp-Source: ABdhPJwYmAATu3d12EfPpd/roF20PJS5+wUrxEenHwQQ8QepSSmJ4pLGUJ/nwrGDnhFM7dlcugoHu5tIrNOQDfYQz1s=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:662:cd2f:9dc:846b])
 (user=emilyshaffer job=sendgmr) by 2002:a81:778a:: with SMTP id
 s132mr108057ywc.518.1643925560402; Thu, 03 Feb 2022 13:59:20 -0800 (PST)
Date:   Thu,  3 Feb 2022 13:59:10 -0800
In-Reply-To: <20211117005701.371808-1-emilyshaffer@google.com>
Message-Id: <20220203215914.683922-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 0/5] teach submodules to know they're submodules
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

CI run: https://github.com/nasamuffin/git/actions/runs/1780282431

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


Emily Shaffer (4):
  t7400-submodule-basic: modernize inspect() helper
  introduce submodule.superprojectGitDir record
  submodule: record superproject gitdir during absorbgitdirs
  submodule: record superproject gitdir during 'update'

 Documentation/config/submodule.txt |  9 ++++
 builtin/submodule--helper.c        | 11 ++++
 git-submodule.sh                   | 15 ++++++
 submodule.c                        | 23 +++++++++
 t/t7400-submodule-basic.sh         | 54 +++++++++++---------
 t/t7406-submodule-update.sh        | 27 ++++++++++
 t/t7412-submodule-absorbgitdirs.sh | 82 +++++++++++++++++++++++++++++-
 7 files changed, 194 insertions(+), 27 deletions(-)

Range-diff against v6:
1:  f1b08a7057 =3D 1:  251510c687 t7400-submodule-basic: modernize inspect(=
) helper
2:  d46c8439ab ! 2:  1a85deb1c5 introduce submodule.superprojectGitDir reco=
rd
    @@ Metadata
      ## Commit message ##
         introduce submodule.superprojectGitDir record
    =20
    -    Teach submodules a reference to their superproject's gitdir. This =
allows
    -    us to A) know that we're running from a submodule, and B) have a
    -    shortcut to the superproject's vitals, for example, configs.
    +    Teach submodules a config variable referencing to their superproje=
ct's
    +    gitdir. Git commands can rely on this reference to determine wheth=
er the
    +    current repo is a submodule to another repo. If this reference is
    +    absent, Git may assume the current repo is not a submodule.
    +
    +    In practice, some commands which specifically reference the submod=
ule
    +    relationship, like 'git rev-parse --show-superproject-working-tree=
',
    +    will still search the parent directory. Other newly added or impli=
cit
    +    behavior, such as "git status" showing the submodule's status in
    +    relation to the superproject, or a config which is shared between =
the
    +    superproject and the submodule, should not search the parent direc=
tory
    +    and instead rely on this "submodule.superprojectGitDir" config.
    =20
         By using a relative path instead of an absolute path, we can move =
the
         superproject directory around on the filesystem without breaking t=
he
    @@ Commit message
         superproject's worktree gitdir (if it exists), we ensure that we c=
an
         tell which worktree contains our submodule.
    =20
    -    Since this hint value is only introduced during new submodule crea=
tion
    -    via `git submodule add`, though, there is more work to do to allow=
 the
    -    record to be created at other times.
    -
    -    Once this new config is reliably in place, we can use it to know
    -    definitively that we are working in a submodule, and to know which
    -    superproject we are a submodule of. This allows us to do some
    -    value-added behavior, like letting "git status" print additional i=
nfo
    -    about the submodule's status in relation to its superproject, or l=
ike
    -    letting the superproject and submodule share an additional config =
file
    -    separate from either one's local config.
    +    This commit teaches "git submodule add" to add the aformentioned c=
onfig
    +    variable. Subsequent commits will teach other commands to do so.
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Helped-by: Junio C Hamano <gitster@pobox.com>
    @@ Documentation/config/submodule.txt: submodule.alternateErrorStrategy=
::
      	clone proceeds as if no alternate was specified.
     +
     +submodule.superprojectGitDir::
    -+	The relative path from the submodule's gitdir to its superproject's
    -+	gitdir. When Git is run in a repository, it usually makes no
    -+	difference whether this repository is standalone or a submodule, but=
 if
    -+	this configuration variable is present, additional behavior may be
    -+	possible, such as "git status" printing additional information about
    -+	this submodule's status with respect to its superproject. This confi=
g
    -+	should only be present in projects which are submodules, but is not
    -+	guaranteed to be present in every submodule, so only optional
    -+	value-added behavior should be linked to it. It is set automatically
    -+	during submodule creation.
    ++	If this repository is a submodule, the relative path from this repo'=
s
    ++	gitdir to its superproject's gitdir. Git commands may rely on this
    ++	reference to determine whether the current repo is a submodule to
    ++	another repo; if this reference is absent, Git will treat the curren=
t
    ++	repo as though it is not a submodule (this does not make a differenc=
e to
    ++	most Git commands). It is set automatically during submodule creatio=
n.
    =20
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int clone_submodule(struct modu=
le_clone_data *clone_data)
3:  63ddaf5608 ! 3:  7a44b0edf9 submodule: record superproject gitdir durin=
g absorbgitdirs
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    + ## Documentation/config/submodule.txt ##
    +@@ Documentation/config/submodule.txt: submodule.superprojectGitDir::
    + 	reference to determine whether the current repo is a submodule to
    + 	another repo; if this reference is absent, Git will treat the curren=
t
    + 	repo as though it is not a submodule (this does not make a differenc=
e to
    +-	most Git commands). It is set automatically during submodule creatio=
n.
    ++	most Git commands). It is set automatically during submodule creatio=
n
    ++	and 'git submodule absorbgitdir'.
    +
      ## submodule.c ##
     @@ submodule.c: static void relocate_single_git_dir_into_superproject(=
const char *path)
      	char *old_git_dir =3D NULL, *real_old_git_dir =3D NULL, *real_new_gi=
t_dir =3D NULL;
4:  33a582ef13 ! 4:  63e736e69d submodule: record superproject gitdir durin=
g 'update'
    @@ Commit message
    =20
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    =20
    + ## Documentation/config/submodule.txt ##
    +@@ Documentation/config/submodule.txt: submodule.superprojectGitDir::
    + 	reference to determine whether the current repo is a submodule to
    + 	another repo; if this reference is absent, Git will treat the curren=
t
    + 	repo as though it is not a submodule (this does not make a differenc=
e to
    +-	most Git commands). It is set automatically during submodule creatio=
n
    +-	and 'git submodule absorbgitdir'.
    ++	most Git commands). It is set automatically during submodule creatio=
n,
    ++	update, and 'git submodule absorbgitdir'.
    +
      ## git-submodule.sh ##
     @@ git-submodule.sh: cmd_update()
      			;;
5:  a8b5d40a77 < -:  ---------- submodule: use config to find superproject =
worktree
--=20
2.35.0.263.gb82422642f-goog

