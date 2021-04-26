Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDDAC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A52F600D1
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhDZRml (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhDZRmk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:42:40 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5EC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:41:57 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id o21so5545130uaw.8
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HnkxTbu9AfVl5B9ciEKhHJopmMYDxU0HW8Ui1aqAtvU=;
        b=cRHV+lCRL2dCjNhwXK3n5qQTeQx72gApz+LttZJ0shObTxa7/1eT9Ubt32Jyjks71E
         Lv6C6bQkSyctn/EkxdSecRP31xH9EZeZDq5Ptw/Iem2zmvW2mUMjO3aq2eIhT8e1HIOQ
         GLvqZbwbFZW9FoIGZHl2p4ny/bZZzpxHDTQKxEc0Sv6mEKpn/lydH7S55uQZSdTXIXU9
         ymXvtbby96J5x554Fjfe6roD0bmiABgjbcJEbZ6x8atIv/ZF5Xq73FZRQzYQ25DIaMHd
         KRnb9ILpCLb0gumGIciyLdh4FPzdWPVaAsM7QSEytr1lp0Olj207pMAi92a/wzuzHjP1
         LpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HnkxTbu9AfVl5B9ciEKhHJopmMYDxU0HW8Ui1aqAtvU=;
        b=dwX+wchIEFLVItU66BBydRu49E8H2U9C+RONR/Pn4mcoiH07eKYqSPmRbGmmsI+TAy
         7osiVyUKtU4poKKqG0G7SHr7gZtMn7rAPljk21BCcXf/Su146XWo/xZnqI6s3o9gM/On
         VwUXazeT/tMwjpfmx3BfsMxR+UQUAl7bMYJ12VZNghmZ4hr9eSc9E7Hnsc0t8XQ4V0yD
         cEZ2h24w5ac26uDJThgkHk03armlGNVdoRNx4bnMjfdMbGgZF3rC3Ar/72lGX5bTQ1FC
         Ss+nAkKyjtuIvu5cq1GEahA5Ucg3F8Mtxbi6BNa0r0Nsmp+ESW0UI+Bmbw7O3F9cwEJL
         cxTw==
X-Gm-Message-State: AOAM5304J+3noEr2r/VPeg11tKx3eWLKctuUnbu1aIukvXQYLARr6WM7
        xXzwyOBLXSXauvgzkfZ38b4GaZEonWkwacZ06LOwDfX3svY=
X-Google-Smtp-Source: ABdhPJy/fsMDy1mDH1QTdTlUueYWyplc7iPxalaBafYAxd2A0ok7QBvKI7ES7LPprxmVPef7+Tmbxfj5RotAmuylPtg=
X-Received: by 2002:ab0:6030:: with SMTP id n16mr13598411ual.87.1619458916385;
 Mon, 26 Apr 2021 10:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <0665edb1308b8cd4536d6922fd36315e1abdd9d1.1618829584.git.gitgitgadget@gmail.com>
 <87bla83y7i.fsf@evledraar.gmail.com>
In-Reply-To: <87bla83y7i.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 26 Apr 2021 19:41:45 +0200
Message-ID: <CAFQ2z_NU3z=dxiqvYDtM7UGwMCdBA1pHq5UjPMERwa6F5xOW-A@mail.gmail.com>
Subject: Re: [PATCH 18/18] t1415: set REFFILES for test specific to storage format
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 9:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Apr 19 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  t/t1415-worktree-refs.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
> > index 7ab91241ab7c..a8083a0af3af 100755
> > --- a/t/t1415-worktree-refs.sh
> > +++ b/t/t1415-worktree-refs.sh
> > @@ -16,7 +16,7 @@ test_expect_success 'setup' '
> >       git -C wt2 update-ref refs/worktree/foo HEAD
> >  '
> >
> > -test_expect_success 'refs/worktree must not be packed' '
> > +test_expect_success REFFILES 'refs/worktree must not be packed' '
> >       git pack-refs --all &&
> >       test_path_is_missing .git/refs/tags/wt1 &&
> >       test_path_is_file .git/refs/worktree/foo &&
>
> So a na=C3=AFve:
>
>     diff --git a/refs/files-backend.c b/refs/files-backend.c
>     index 3f29f8c143..01e2dc8bc3 100644
>     --- a/refs/files-backend.c
>     +++ b/refs/files-backend.c
>     @@ -212,7 +212,7 @@ static void files_ref_path(struct files_ref_store=
 *refs,
>       */
>      static void add_per_worktree_entries_to_dir(struct ref_dir *dir, con=
st char *dirname)
>      {
>     -       const char *prefixes[] =3D { "refs/bisect/", "refs/worktree/"=
, "refs/rewritten/" };
>     +       const char *prefixes[] =3D { "refs/bisect/", "refs/rewritten/=
" };
>             int ip;
>
>             if (strcmp(dirname, "refs/"))
>
> Will fail the test under non-reftable, i.e. we somehow conflate "is
> packed" with correctly discovering these refs?

AFAICT, what happens is that the packed-refs file is shared across all
worktrees, so refs that are per worktree should not be stored there. I
think that is what the test is trying to assert.

> A discussion of how
> 8aff1a9ca5 (Add a place for (not) sharing stuff between worktrees,
> 2018-09-29) relates to reftable would be valuable here.

reftable handles this slightly differently. I added a comment to
reftable-backend.c about this.

> But on the tip of "seen" currently this test fails entirely with
> GIT_TEST_REFTABLE=3Dtrue, so I'm not sure if it got rid of the need for
> this abstraction in the files backend or what...

Before splitting the series into two (git support and test fixups),
all of these changes reduced the number of test breakages.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
