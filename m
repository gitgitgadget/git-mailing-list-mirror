Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF2C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 04:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKDERj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 00:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKDERh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 00:17:37 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D352322BE9
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 21:17:36 -0700 (PDT)
Date:   Fri, 04 Nov 2022 04:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail2; t=1667535454; x=1667794654;
        bh=nD/eoin2eZkKQnJzB72NEU5UJlEZU+6ZZIRqJElj1ZU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=rh/KcvXOLKcnnXM8gvP0WUwYl3K+hUQp1m1vMY2ATiYbR97DulPPosXBYgJoPWDRE
         35qUBFqd9DDqkrQqb7P7Z58QAaDpW+/HtHIhzjoQdu50ulM6fslxfklLYUzZYeZBSn
         tsQHJqnwgwKcveLbRZppCRYTW3wph6JeHU+cQcr0ON33llqc4yVdukaAFoVPj9N660
         xu34JQku1geh5sbjjgII9GruiTFik/ghO9QA35jzwAgf3TTPWLz0gvRy5jbTMl5LEV
         FwLkizBPduprDx8nP001hxd4sKTgTUCHrneRMDXtBxPP/2yUSN1R3RljBA4eUqBX2z
         Vx8a7uN43WnnA==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] worktree add: Add unit tests for --orphan
Message-ID: <20221104041719.f22ult3ilasnl5wy@phi>
In-Reply-To: <221104.86k04bzeaa.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104010242.11555-5-jacobabel@nullpo.dev> <221104.86k04bzeaa.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/04 02:37AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Fri, Nov 04 2022, Jacob Abel wrote:
>
> We usually add tests along with the feature, so this should be squashed
> into your 3/4.
>
> > Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> > ---
> >  t/t2400-worktree-add.sh | 54 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >
> > diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> > index d587e0b20d..064e1336e2 100755
> > --- a/t/t2400-worktree-add.sh
> > +++ b/t/t2400-worktree-add.sh
> > @@ -310,6 +310,26 @@ test_expect_success '"add" -B/--detach mutually ex=
clusive' '
> >  =09test_must_fail git worktree add -B poodle --detach bamboo main
> >  '
> >
> > +test_expect_success '"add" --orphan/-b mutually exclusive' '
> > +=09test_must_fail git worktree add --orphan poodle -b poodle bamboo ma=
in
> > +'
> > +
> > +test_expect_success '"add" --orphan/-B mutually exclusive' '
> > +=09test_must_fail git worktree add --orphan poodle -B poodle bamboo ma=
in
> > +'
> > +
> > +test_expect_success '"add" --orphan/--detach mutually exclusive' '
> > +=09test_must_fail git worktree add --orphan poodle --detach bamboo mai=
n
> > +'
> > +
> > +test_expect_success '"add" --orphan/--no-checkout mutually exclusive' =
'
> > +=09test_must_fail git worktree add --orphan poodle --no-checkout bambo=
o main
> > +'
> > +
> > +test_expect_success '"add" -B/--detach mutually exclusive' '
> > +=09test_must_fail git worktree add -B poodle --detach bamboo main
> > +'
> > +
> > [...]
> > +test_expect_success '"add --orphan"' '
> > +=09git worktree add --orphan neworphan orphandir main &&
> > +=09git -C orphandir symbolic-ref HEAD >actual &&
> > +=09echo refs/heads/neworphan >expected &&
> > +=09test_cmp expected actual &&
>
> nit: we usually do:
>
> =09echo ...
> =09git ...
> =09test_cmp
>
> So there's never doubt that the "expected" is before the command
> (i.e. not impacted by it).
>
> > +=09(
> > +=09=09cd orphandir &&
> > +=09=09git diff main
> > +=09)
>
> Here you can avoid the sub-shell, with:
>
> =09git -C orphandir diff main
>
> > +'
> > +
> > +test_expect_success '"add --orphan" fails if the branch already exists=
' '
> > +=09git worktree add -b existingbranch orphandir2 main &&
> > +=09test_must_fail git worktree add --orphan existingbranch orphandir3 =
main &&
> > +=09[ ! -d orphandir3 ]
>
> Don't use "[", use "test", but in this case use one of the "test -d",
> "test -f" etc. wrappers in test-lib-functions.sh.
>
> > +'
> > +
> > +test_expect_success '"add --orphan" fails if the commit-ish doesnt exi=
st' '
> > +=09test_must_fail git worktree add --orphan badcommitish orphandir4 ee=
e2222 &&
> > +=09[ ! -d orphandir4 ]
>
> ditto.

Noted. Will make the above requested changes in v2.

> > +'
> > +
> > +test_expect_success '"add --orphan" with empty repository' '
> > +=09(
> > +=09=09mkdir emptyorphanrepo &&
> > +=09=09cd emptyorphanrepo &&
> > +=09=09GIT_DIR=3D".git" git init --bare &&
> > +=09=09git worktree add --orphan newbranch worktreedir &&
> > +=09=09git -C worktreedir symbolic-ref HEAD >actual &&
> > +=09=09echo refs/heads/newbranch >expected &&
> > +=09=09test_cmp expected actual
> > +=09)
>
> Ditto we can avoid sub-shelling here, also when using sub-shells, make
> the "cd" the first command in it, if you keep it the "mkdir" should go
> outside of it.
>
> But isn't this (untested, maybe I'm missing a subtlety):
>
> =09test_when_finished "rm -rf repo" &&
> =09GIT_DIR=3D.git git init --bare repo &&
> =09git -C worktree ...
> =09git -C worktree/subdir ..
> =09echo refs ...
> =09test_cmp ...
>
> I.e. do we need to create the dir manually before "git init --bare"?

Yes, these should be essentially equivalent. I'll update the tests accordin=
gly.

