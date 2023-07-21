Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B57C0015E
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 04:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGUElT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 00:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGUEky (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 00:40:54 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E694B2735
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 21:40:45 -0700 (PDT)
Date:   Fri, 21 Jul 2023 04:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689914444; x=1690173644;
        bh=ttsdUgiBuMb8wY+Jhz3M7JxI7pVPmW7pUCXD4KH35CY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=wk/rh3NKVH1RUUPlX/rhKckw2KdXWdFCMfbAGSscmmwPoGzvGBphyJ8EQ93cc9vZX
         BFQXpxdIJPKIrdIH9gBeZkPAv4PBAOyqgEJLlhsJ+k6sllIuTJ5U2sfpE7BGhApp1p
         QoC+jJlwOuLrtHewb1qkaiIfhbRSic6Uds3rdWDxxzSNfcQPguHtcgC94UCulXIWj5
         Wrq7wtUgNuYPRQrcCsHnjKTUYObVQsVry0lbMeJ0JtjUyYGrc5mkS0m4jQsEx7/CK4
         QYf/uD7VbCwIVdblNdbHbM3BoMVD6JbDtuOnahfRboRVa9Ev/dqvR3LAX6Yd4kvBx8
         WPmLIZCEwV8xw==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 0/3] t2400: Fix test failures when using grep 2.5
Message-ID: <20230721044012.24360-1-jacobabel@nullpo.dev>
In-Reply-To: <20230716033743.18200-1-jacobabel@nullpo.dev>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <20230716033743.18200-1-jacobabel@nullpo.dev>
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

Note: I jumped the gun on v2 a bit as discussions for v1 were still in
progress so these are all changes suggested off v1.

Changes from v2:
  * Split `--sq` change out into separate patch (from 3/3 to 1/3).
  * Convert tab in advice to space to match coding convention and to
    allow regex to be further simplified [4].
  * Simplified regex [4].
  * Reworded commit message for patch 3/3 to better document reason for
    change [4].

1. https://github.com/gitgitgadget/git/pull/1550/checks?check_run_id=3D1494=
9695859
2. https://lore.kernel.org/git/CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-=
9zbqXMA@mail.gmail.com/
3. https://stackoverflow.com/questions/4233159/grep-regex-whitespace-behavi=
or
4. https://lore.kernel.org/git/3f3a3f5b-70fd-ec3f-acbb-d585b5eb6cbc@gmail.c=
om/

Jacob Abel (3):
  t2400: drop no-op `--sq` from rev-parse call
  builtin/worktree.c: convert tab in advice to space
  t2400: rewrite regex to avoid unintentional PCRE

 builtin/worktree.c      |  4 ++--
 t/t2400-worktree-add.sh | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  96c21c5bee t2400: drop no-op `--sq` from rev-parse cal=
l
-:  ---------- > 2:  ebfba2d602 builtin/worktree.c: convert tab in advice t=
o space
1:  ef4ebd7350 ! 3:  dee0c8f350 t2400: Fix test failures when using grep 2.=
5
    @@ Metadata
     Author: Jacob Abel <jacobabel@nullpo.dev>
    =20
      ## Commit message ##
    -    t2400: Fix test failures when using grep 2.5
    +    t2400: rewrite regex to avoid unintentional PCRE
    =20
    -    Replace all cases of `\s` with `[[:blank:]]` or ` ` as older versi=
ons
    -    of GNU grep (and from what it seems most versions of BSD grep) do =
not
    -    handle `\s`.
    +    Replace all cases of `\s` with ` ` as it is not part of POSIX BRE =
or ERE
    +    and therefore not all versions of grep handle it without PCRE supp=
ort.
    =20
         For the same reason all cases of `\S` are replaced with `[^ ]`. It=
's not
    -    an exact replacement (as it does not match tabs) but it is close e=
nough
    -    for this use case.
    -
    -    Replacing `\S` also needs to occur as `\S` is technically PCRE and=
 not
    -    part of ERE even though most modern versions of grep accept it as =
ERE.
    -
    -    This commit also drops `--sq` from a rev-parse call as it appears =
to be
    -    a no-op.
    +    an exact replacement but it is close enough for this use case.
    =20
         Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
    =20
    @@ t/t2400-worktree-add.sh: test_wt_add_orphan_hint () {
      =09=09if [ $use_branch -eq 1 ]
      =09=09then
     -=09=09=09grep -E "^hint:\s+git worktree add --orphan -b \S+ \S+\s*$" =
actual
    -+=09=09=09grep -E "^hint:[[:blank:]]+git worktree add --orphan -b [^ ]=
+ [^ ]+$" actual
    ++=09=09=09grep -E "^hint:[ ]+git worktree add --orphan -b [^ ]+ [^ ]+$=
" actual
      =09=09else
     -=09=09=09grep -E "^hint:\s+git worktree add --orphan \S+\s*$" actual
    -+=09=09=09grep -E "^hint:[[:blank:]]+git worktree add --orphan [^ ]+$"=
 actual
    ++=09=09=09grep -E "^hint:[ ]+git worktree add --orphan [^ ]+$" actual
      =09=09fi
     =20
      =09'
    @@ t/t2400-worktree-add.sh: test_dwim_orphan () {
     =20
      =09local git_ns=3D"repo" &&
     @@ t/t2400-worktree-add.sh: test_dwim_orphan () {
    - =09=09=09=09=09grep "$invalid_ref_regex" actual &&
    - =09=09=09=09=09! grep "$orphan_hint" actual
    - =09=09=09=09else
    --=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-for=
mat=3Dabsolute --git-path HEAD) &&
    -+=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --path-format=
=3Dabsolute --git-path HEAD) &&
    + =09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --path-format=
=3Dabsolute --git-path HEAD) &&
      =09=09=09=09=09headcontents=3D$(cat "$headpath") &&
      =09=09=09=09=09grep "HEAD points to an invalid (or orphaned) referenc=
e" actual &&
     -=09=09=09=09=09grep "HEAD path:\s*.$headpath." actual &&
--=20
2.39.3


