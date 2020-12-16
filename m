Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D5C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 09:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C805230FF
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 09:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgLPJWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 04:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgLPJWi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 04:22:38 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F159C0613D6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 01:21:58 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id k78so21734493ybf.12
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 01:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L95SFVP4BBIk53NXdAI52GtGtPJINg9BFynH/BNw4vs=;
        b=My156c9YqddK7LgT9IhKKOIumklDe8ISflnabOh75WYk3j+oV7pGA+3AnkLN0VxvAi
         pZimfbdiwIm6Kr/fY6qK5nk8PfQs+QYGOYY9BqwDPEEs8exs9pr9KAcDb/7UnosPVul/
         HCFYg8s4bmKy90nN1QqMky4tLP9gZNAx97JVj+LAf5UVW4RjGoL7YqXfi0ylEdCGkA+l
         cm1st1eHipsmZGKx3QZl7lvAAXvwpU/GlY0zjV3mpw7/juC/9s9B9bg4512qoheR0Ich
         4cfNuKstj/7E7lk/VnyvvdrILUoZtMKae16Gjy7UxVu5becNl9OubSnVemNaVmeM/3ys
         DM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L95SFVP4BBIk53NXdAI52GtGtPJINg9BFynH/BNw4vs=;
        b=b6V0DN9g3Lix7AW8AZmXQItqZ2yC9bub5yh3MdOpgLelpq7Q51M/J8kms8aeRyugr0
         rCfT+SUGnu33wGAtt1nQ+rxnmKr3onSg1pSnmMTqBA80ULwO3epnvqF6hrWRjw6jXd4j
         zN9EIZZsxDceUzG/nf1/cjI47NZikTuBzc2Q5cq1Prl+jMT86N+V/wPHvhpLHrBrMKwx
         6ZHrYD6UTx3mpZxgu7Na9CmzAUXaRDVbx6dZkUMa32oLFxepqNoH+0bC5E3ZvIt6PiXu
         ymaZUNGKqTgf7y2LWuiL4r8h+PSboklCeJ0+7WNcy7dKjp/9PQTdJTH7UpNjY8CKifWp
         iwzA==
X-Gm-Message-State: AOAM530EKXI9TiqyE4QXVZ4n3iiIlFUkV1j9I3AG8y484lVs4r1MR0r1
        DG+uQ7uIKjh+a79SL8cb4WaCam/w7jWJ9dkc+Is=
X-Google-Smtp-Source: ABdhPJxEKpK0ozoDte2wlbtX+4SprdrSnTZU4nwdbKlTV52G4sv9OqAFkfc0stElerHJHQ57l0XZN3OjHjAvpi9ZYy4=
X-Received: by 2002:a25:b814:: with SMTP id v20mr48791971ybj.323.1608110517630;
 Wed, 16 Dec 2020 01:21:57 -0800 (PST)
MIME-Version: 1.0
References: <dc410ef1-fc05-162e-ed4e-c843e0bc285d@web.de> <X9j+nuzjiYyw/vQx@coredump.intra.peff.net>
In-Reply-To: <X9j+nuzjiYyw/vQx@coredump.intra.peff.net>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 16 Dec 2020 17:21:46 +0800
Message-ID: <CANYiYbHOczhRoJkOofFNQ6VA3BiyOF=QjffFBDvLn43Ts8B67w@mail.gmail.com>
Subject: Re: bug report: "git pack-redundant --all" crash in minimize()
To:     Jeff King <peff@peff.net>
Cc:     "Daniel C. Klauer" <daniel.c.klauer@web.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2020=E5=B9=B412=E6=9C=8816=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 15, 2020 at 06:34:53PM +0100, Daniel C. Klauer wrote:
>
> > I'm getting the following crash from "git pack-redundant --all" (output
> > from valgrind):
> >
> > =3D=3D14070=3D=3D Invalid read of size 8
> > =3D=3D14070=3D=3D    at 0x18F165: minimize (pack-redundant.c:399)
> > =3D=3D14070=3D=3D    by 0x18F165: cmd_pack_redundant (pack-redundant.c:=
622)
> > =3D=3D14070=3D=3D    by 0x1242D3: run_builtin (git.c:444)
> > =3D=3D14070=3D=3D    by 0x1242D3: handle_builtin (git.c:674)
> > =3D=3D14070=3D=3D    by 0x125393: run_argv (git.c:741)
> > =3D=3D14070=3D=3D    by 0x125393: cmd_main (git.c:872)
> > =3D=3D14070=3D=3D    by 0x123E7D: main (common-main.c:52)
> > =3D=3D14070=3D=3D  Address 0x10 is not stack'd, malloc'd or (recently) =
free'd
> >
> > Commands to reproduce:
> >
> > mkdir new
> > cd new
> > git init
> > touch foo.txt
> > git add foo.txt
> > git commit -m "first commit"
> > git gc
> > git pack-redundant --all
>
> Thanks for an easy reproduction. This bisects to 3011177640
> (pack-redundant: delay creation of unique_objects, 2019-02-02).
>
> I suspect the fix is just:
>
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 3e70f2a4c1..68afcfeb7b 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -396,7 +396,7 @@ static void minimize(struct pack_list **min)
>
>         pl =3D local_packs;
>         while (pl) {
> -               if (pl->unique_objects->size)
> +               if (pl->unique_objects && pl->unique_objects->size)
>                         pack_list_insert(&unique, pl);
>                 else
>                         pack_list_insert(&non_unique, pl);
>
> but I didn't look closely (author cc'd).
>

Will fix like this:

    pack-redundant: fix crash when one packfile in repo

    Command `git pack-redundant --all` will crash if there is only one
    packfile in the repository.  This is because, if there is only one
    packfile in local_packs, `cmp_local_packs` will do nothing and will
    leave `pl->unique_objects` as uninitialized.

    ... ...

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 178e3409b7..9b0646a5e2 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -473,6 +473,12 @@ static void cmp_local_packs(void)
 {
        struct pack_list *subset, *pl =3D local_packs;

+       /* only one packfile */
+       if (!pl->next && !pl->unique_objects) {
+               llist_init(&pl->unique_objects);
+               return;
+       }
+
        while ((subset =3D pl)) {
                while ((subset =3D subset->next))
                        cmp_two_packs(pl, subset);
