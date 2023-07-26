Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2FC0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 21:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGZVmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGZVmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 17:42:32 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA426AC
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 14:42:27 -0700 (PDT)
Date:   Wed, 26 Jul 2023 21:42:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1690407743; x=1690666943;
        bh=4e1cPK6GbSAkwKJsbUURiIfvej3Wc8w/QbUxaL3mibM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=W2jlCO6ip5C7WpmYUuh4RBbH5NoRT5bWiIsQipHnmz/ZOnhUCiaPRYbrEr0MhJhh0
         foLHvhD2Dk5VJTT+riaSrNtEQRony6L2YnPvcOXmWR71CWt20Lb4PyXm9iQzKPYjKe
         nYjBUj/KW/LAZ1yMOm+mWoAcZTfxYVrpDiWDzQZ74i/pUEIO1bBNc9xN3/qImlP+do
         BOSuvcMTAZ5CFUFs4/ROoqC3qdEHp5d5bbCkgoPQFTYAGYOmmY5lu7E5tyagrp0pb1
         PyEf7dIlJbfpo/utbICUycuDWBMI3UpPk4WH6xxXeVNViPkD6/ztNKttOXeywPIv+2
         2XHHZBPxT3umQ==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 0/3] t2400: Fix test failures when using grep 2.5
Message-ID: <20230726214202.15775-1-jacobabel@nullpo.dev>
In-Reply-To: <20230721044012.24360-1-jacobabel@nullpo.dev>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <20230716033743.18200-1-jacobabel@nullpo.dev> <20230721044012.24360-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset is in response to build failures on GGG's Cirrus CI=20
freebsd_12 build jobs[1] and was prompted by a discussion thread [2].
These failures seem to be caused by the behavior outlined in [3].=20

Changes from v3:
  * Replace `[ ]` with ` ` in regex for `test_wt_add_orphan_hint()` [4][5].
  * Drop trailing `.*` from `invalid_ref_regex` [4][5].
  * Change `[a-z-]` to `[-a-z]` in `bad_combo_regex` to better portray
    intent [4][5].
  * Replace `\+` with `*` in `bad_combo_regex` as `\+` is not POSIX
    BRE and is a GNU extension [4][5].
  * Drop "without PCRE support" from commit message [4].
  * Reword commit message to reflect changes.

1. https://github.com/gitgitgadget/git/pull/1550/checks?check_run_id=3D1494=
9695859
2. https://lore.kernel.org/git/CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-=
9zbqXMA@mail.gmail.com/
3. https://stackoverflow.com/questions/4233159/grep-regex-whitespace-behavi=
or
4. https://lore.kernel.org/git/axnxvnmo6ekhhccppinji73ivlandwuqs44epmq4pdef=
m7ukiv@ejz7bee5xjli/
5. https://lore.kernel.org/git/xmqqiladw9h7.fsf@gitster.g/

Jacob Abel (3):
  t2400: drop no-op `--sq` from rev-parse call
  builtin/worktree.c: convert tab in advice to space
  t2400: rewrite regex to avoid unintentional PCRE

 builtin/worktree.c      |  4 ++--
 t/t2400-worktree-add.sh | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

Range-diff against v3:
1:  96c21c5bee =3D 1:  96c21c5bee t2400: drop no-op `--sq` from rev-parse c=
all
2:  ebfba2d602 =3D 2:  ebfba2d602 builtin/worktree.c: convert tab in advice=
 to space
3:  dee0c8f350 ! 3:  13f61cd15a t2400: rewrite regex to avoid unintentional=
 PCRE
    @@ Commit message
         t2400: rewrite regex to avoid unintentional PCRE
    =20
         Replace all cases of `\s` with ` ` as it is not part of POSIX BRE =
or ERE
    -    and therefore not all versions of grep handle it without PCRE supp=
ort.
    +    and therefore not all versions of grep handle it.
    =20
    -    For the same reason all cases of `\S` are replaced with `[^ ]`. It=
's not
    -    an exact replacement but it is close enough for this use case.
    +    For the same reason all cases of `\S` are replaced with `[^ ]`. It=
 is
    +    not an exact replacement but it is close enough for this use case.
    +
    +    Also, do not write `\+` in BRE and expect it to mean 1 or more;
    +    it is a GNU extension that may not work everywhere.
    +
    +    Remove `.*` from the end of a pattern that is not right-anchored.
    =20
         Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## t/t2400-worktree-add.sh ##
     @@ t/t2400-worktree-add.sh: test_wt_add_orphan_hint () {
    @@ t/t2400-worktree-add.sh: test_wt_add_orphan_hint () {
      =09=09if [ $use_branch -eq 1 ]
      =09=09then
     -=09=09=09grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" =
actual
    -+=09=09=09grep -E "^hint:[ ]+git worktree add --orphan -b [^ ]+ [^ ]+$=
" actual
    ++=09=09=09grep -E "^hint: +git worktree add --orphan -b [^ ]+ [^ ]+$" =
actual
      =09=09else
     -=09=09=09grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
    -+=09=09=09grep -E "^hint:[ ]+git worktree add --orphan [^ ]+$" actual
    ++=09=09=09grep -E "^hint: +git worktree add --orphan [^ ]+$" actual
      =09=09fi
     =20
      =09'
    @@ t/t2400-worktree-add.sh: test_dwim_orphan () {
      =09local fetch_error_text=3D"fatal: No local or remote refs exist des=
pite at least one remote" &&
      =09local orphan_hint=3D"hint: If you meant to create a worktree conta=
ining a new orphan branch" &&
     -=09local invalid_ref_regex=3D"^fatal: invalid reference:\s\+.*" &&
    -+=09local invalid_ref_regex=3D"^fatal: invalid reference: .*" &&
    - =09local bad_combo_regex=3D"^fatal: '[a-z-]\+' and '[a-z-]\+' cannot =
be used together" &&
    +-=09local bad_combo_regex=3D"^fatal: '[a-z-]\+' and '[a-z-]\+' cannot =
be used together" &&
    ++=09local invalid_ref_regex=3D"^fatal: invalid reference: " &&
    ++=09local bad_combo_regex=3D"^fatal: '[-a-z]*' and '[-a-z]*' cannot be=
 used together" &&
     =20
      =09local git_ns=3D"repo" &&
    + =09local dashc_args=3D"-C $git_ns" &&
     @@ t/t2400-worktree-add.sh: test_dwim_orphan () {
      =09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --path-format=
=3Dabsolute --git-path HEAD) &&
      =09=09=09=09=09headcontents=3D$(cat "$headpath") &&
--=20
2.41.0


