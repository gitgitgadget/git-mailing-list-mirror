Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ADEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 10:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjFUK4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjFUK4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 06:56:40 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E861992
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:56:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b46773e427so63873121fa.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687344998; x=1689936998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8etw+DZph8VFdivgbFppAzwgS4szWOHe0mdRkwu+yOc=;
        b=MzUD9C/SWbFEDp4oshjRImjezrBcZ4Q5035+4odGh2L9bGosiuWHgio6HI1Sv75sSp
         y/b+P4L8j6V5VCj9mJwIJYANz3UhGF3NjzuCNn4tSqshUWTzKj9eNbnojedGEkxypxpq
         qZQ7m2BGsexF7Jutules50NEgBwFTQb1M21Hw9iN5pQ3Q9HgFcPFvSJ+gaH0QpDPfkfa
         mvokN8AcL28QiA25mhkmvsOw+AjQqo16RIQgqyF9E44tCVL52FWawIVrid/7hl+it1DG
         KrIxbJfYMDoZZm83ZkC2u0UyDujoN3JtTIMFEgmhxVwZ1yWQa1ZMXmXDPDmR4JMwIKXi
         880w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344998; x=1689936998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8etw+DZph8VFdivgbFppAzwgS4szWOHe0mdRkwu+yOc=;
        b=dDwp8HRoKRijysG8BcpcYtPHGZtAKPJuogKXnzXq9SkSFmjfhesYW94vxQ7V5v6xtD
         KZ4+liBEogSMedzv1uQbztH5Lk6aAhahSJ8L62P/Qtschw/zt4KJWhpAwseyMjT1tj7h
         g24OFcfH5ZzQX36vr7l+6TtS6Aj9ua5+QtN58M1xJ0Iw4/a4Go9Spcd2e7dOScgDqk8H
         TE/pPr+99pvYZT0LfB5Ah7srgiqB92ZsooY1s774uSTiw4w7rop0ezDvaQbFKrj0IVVZ
         yDm48NFynE1FiEILoYH7xoA1QoiqEpcPNXrvmkXWLETgdp6GM9UqP6tZwc+hRkHiJ6jl
         EZHw==
X-Gm-Message-State: AC+VfDwMq1B3khZubk7Jo4UbtsnrVwlYTt3BuxNhJ5tT2V6GOY15KcSZ
        NHdqIVswvd+uIxVzz9ZJdKUbym6rxjzoXDgs2WapxeJkSfs=
X-Google-Smtp-Source: ACHHUZ604osDYQR77nd0HA0cJ/hI/vmMuHGJJAsEs+utjWgi49bkQzO7BX7bnmC35MYEwSjrt385Ta1L5pWoz4Xt8+s=
X-Received: by 2002:a2e:8057:0:b0:2b5:7a97:d517 with SMTP id
 p23-20020a2e8057000000b002b57a97d517mr3132975ljg.46.1687344997617; Wed, 21
 Jun 2023 03:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-5-christian.couder@gmail.com> <xmqqttv8thjw.fsf@gitster.g>
In-Reply-To: <xmqqttv8thjw.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Jun 2023 12:56:25 +0200
Message-ID: <CAP8UFD1MGX8yZsNuKmax2J1ZmwfxmzfbgJ_pNrbar6X2Dar8+g@mail.gmail.com>
Subject: Re: [PATCH 4/9] repack: refactor piping an oid to a command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 1:46=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Create a new write_oid_hex_cmd() function to send an oid to the standar=
d
> > input of a running command. This new function will be used in a
> > following commit.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  builtin/repack.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 0541c3ce15..e591c295cf 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -182,6 +182,17 @@ static void prepare_pack_objects(struct child_proc=
ess *cmd,
> >       cmd->out =3D -1;
> >  }
> >
> > +static void write_oid_hex_cmd(const char *oid_hex,
> > +                           struct child_process *cmd,
> > +                           const char *err_msg)
> > +{
> > +     if (cmd->in =3D=3D -1 && start_command(cmd))
> > +             die("%s", err_msg);
>
> I am not sure why we would want to conflate the "if we haven't
> started the command, auto-start it upon our first attempt to write"
> in these low-level "I am designed to do one thing, which is to feed
> the object name to the process, and do it well" function.
>
> The caller in the original shares the same issue, so we could say
> that this patch is not creating a new problem, but this somehow
> feels it is mak ng the existing problem even worse.

Ok. I think I will rework this patch from version 2 of this series to
remove that code. It will perhaps look like there is a bit of
duplicated code, but I don't think it will be too bad.

> And I think the error handling here shows why the API feels wrong.
> When auto-start fails, we have a message, but when write fails,
> there is no custom message---it makes as if write_oid_hex_cmd() is
> primarily about starting, which is so important relative to its
> other functionalities and deserves a custom error message, but that
> is not the message you want to be conveying.

Right.

> > +     xwrite(cmd->in, oid_hex, the_hash_algo->hexsz);
> > +     xwrite(cmd->in, "\n", 1);
>
> I would have expected that the "refactor" at least would reduce the
> number of system calls by combining these two writes into one using
> an on-stack local variable char buf[GIT_MAX_HEZSZ+1] or something.

Ok, I will change it to reduce the number of system calls.
