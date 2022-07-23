Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37853C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiGWB43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGWB42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:56:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993787AB02
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:56:27 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x8so2849664qvo.13
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tb8jo1w/8EVtoutucUGk5E9zlpNnQgpBdyrPlip2WuQ=;
        b=EFZcUKhbg21HBF+AugjVeWUuT4lqPjKKfsK7SnGomInKHQhNcyhF5lnwVhqQEahL3J
         3WzsEWx302YwqdzgRvBfajvCce/1vKkdu5jdpaTw0xQnmlWs5DNSb8/dE1/kxfRk7jP/
         wv2vQdfEIEDl9iLrr3htaO7UGSIAxyA310C+Z5mTz304QlWyNtPLu7IiCYfV22RHNvPB
         MPv2ABVKD3jF4y+BVmPntdZS8i18VPISKNKdjW5HT3YG5TYcH2ZCw3iZjkuVaA8hfQ7H
         wx+orr5beXYyvOlo2p0qCenvmAExAUSsCDNb/FKKVcrfFDTgzO01ioD825pq3D9BDQnl
         ne8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tb8jo1w/8EVtoutucUGk5E9zlpNnQgpBdyrPlip2WuQ=;
        b=dvjsVPrfrZK3qPnbiOBwoRFTJx5b4ZztUF+FDbSOcdxJAZb77woXWa1BLKiFuTthTc
         wMlZ6NBB7xy0m8pPrQQhGksNFJvwUJtlWyIDeg43iTWWrpDQ4CxnvA56QI6yvZkmx+3U
         0oHpnDzM8/wLaX2RCW9hly5mUn4hquXhZoc03r1kYF0GURTL/xH/36W/QVNkcvJ+E9Wr
         9y28f0CwTKJectFjGKnILTIRxrwdLllexnR1dIcDXAglq4L3HX++O652k4StSvFRkqq0
         3PwspL0DF4zsfiseQgsDYfTByKTnytguOKVKwsKayYgy/26+PPBjhkAgrRl32HgyuaqO
         yx4Q==
X-Gm-Message-State: AJIora/P3OrpTvpUZ3WlTF2bo36l4OFY0kQT6pcWohhJVGwjVQBhDiZV
        dpDcHHwTpKMVhrErJnoLMrTg4dxlPLbSJC+v/JeGDWmRfmU=
X-Google-Smtp-Source: AGRyM1vZVDQGB0Dpl+VyPk3Xn0Wj1uDwIu6h+2fpmf9A6oYNA8ktAtTmmfmcfmL6VMjT7qEq5p8PVau27RDw2Ps2dZI=
X-Received: by 2002:a0c:8b89:0:b0:474:2a12:f422 with SMTP id
 r9-20020a0c8b89000000b004742a12f422mr1323314qva.115.1658541386678; Fri, 22
 Jul 2022 18:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com> <f401bd5ad0dd7564412e72d19a4193ad3f64e638.1658466942.git.gitgitgadget@gmail.com>
 <220722.86k085s9g3.gmgdl@evledraar.gmail.com>
In-Reply-To: <220722.86k085s9g3.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 Jul 2022 18:56:15 -0700
Message-ID: <CABPp-BGTqkqi5PKgbTSXOVC=TG25VhDRK_=b7SzJ2TZWzvVBWQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] merge: make restore_state() restore staged state too
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 3:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jul 22 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > There are multiple issues at play here:
> >
> >   1) If `git merge` is invoked with staged changes, it should abort
> >      without doing any merging, and the user's working tree and index
> >      should be the same as before merge was invoked.
> >   2) Merge strategies are responsible for enforcing the index =3D=3D HE=
AD
> >      requirement. (See 9822175d2b ("Ensure index matches head before
> >      invoking merge machinery, round N", 2019-08-17) for some history
> >      around this.)
> >   3) Merge strategies can bail saying they are not an appropriate
> >      handler for the merge in question (possibly allowing other
> >      strategies to be used instead).
> >   4) Merge strategies can make changes to the index and working tree,
> >      and have no expectation to clean up after themselves, *even* if
> >      they bail out and say they are not an appropriate handler for
> >      the merge in question.  (The `octopus` merge strategy does this,
> >      for example.)
> >   5) Because of (3) and (4), builtin/merge.c stashes state before
> >      trying merge strategies and restores it afterward.
> >
> > Unfortunately, if users had staged changes before calling `git merge`,
> > builtin/merge.c could do the following:
> >
> >    * stash the changes, in order to clean up after the strategies
> >    * try all the merge strategies in turn, each of which report they
> >      cannot function due to the index not matching HEAD
> >    * restore the changes via "git stash apply"
> >
> > But that last step would have the net effect of unstaging the user's
> > changes.  Fix this by adding the "--index" option to "git stash apply".
> > While at it, also squelch the stash apply output; we already report
> > "Rewinding the tree to pristine..." and don't need a detailed `git
> > status` report afterwards.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/merge.c                          | 5 +++--
> >  t/t6424-merge-unrelated-index-changes.sh | 7 ++++++-
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 4170c30317e..f807bf335bd 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -383,14 +383,15 @@ static void reset_hard(const struct object_id *oi=
d, int verbose)
> >  static void restore_state(const struct object_id *head,
> >                         const struct object_id *stash)
> >  {
> > -     const char *args[] =3D { "stash", "apply", NULL, NULL };
> > +     const char *args[] =3D { "stash", "apply", "--index", "--quiet",
> > +                            NULL, NULL };
> >
> >       if (is_null_oid(stash))
> >               return;
> >
> >       reset_hard(head, 1);
> >
> > -     args[2] =3D oid_to_hex(stash);
> > +     args[4] =3D oid_to_hex(stash);
> >
> >       /*
> >        * It is OK to ignore error here, for example when there was
>
> Just a nit/side comment: This is one of these older-style arg
> constructions that we've replaced with strvec in most other places.
>
> Let's leave this alone for now (especially in a v4), but FWIW I wouldn't
> mind if these sort of changes were strvec converted while at it:
>
>         diff --git a/builtin/merge.c b/builtin/merge.c
>         index 64def49734a..c3a3a1fde50 100644
>         --- a/builtin/merge.c
>         +++ b/builtin/merge.c
>         @@ -383,21 +383,23 @@ static void reset_hard(const struct object_=
id *oid, int verbose)
>          static void restore_state(const struct object_id *head,
>                                   const struct object_id *stash)
>          {
>         -       const char *args[] =3D { "stash", "apply", "--index", "--=
quiet",
>         -                              NULL, NULL };
>         +       struct strvec args =3D STRVEC_INIT;
>         +
>         +       strvec_pushl(&args, "stash", "apply", "--index", "--quiet=
", NULL);
>
>                 reset_hard(head, 1);
>
>                 if (is_null_oid(stash))
>                         goto refresh_cache;
>
>         -       args[4] =3D oid_to_hex(stash);
>         +       strvec_push(&args, oid_to_hex(stash));
>
>                 /*
>                  * It is OK to ignore error here, for example when there =
was
>                  * nothing to restore.
>                  */
>         -       run_command_v_opt(args, RUN_GIT_CMD);
>         +       run_command_v_opt(args.v, RUN_GIT_CMD);
>         +       strvec_clear(&args);
>
>          refresh_cache:
>                 if (discard_cache() < 0 || read_cache() < 0)
>
> I.e. it takes about as much mental energy to review that as counting the
> args elements and seeing that 2 to 4 is correct :)

I like this change and included it in my reroll.  Thanks!
