Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45066CA5520
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 09:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbjIMJcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbjIMJco (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 05:32:44 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ACC10DF
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 02:32:40 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5734f54dc44so4076606eaf.2
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694597560; x=1695202360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fv8oMIcohr/MrFd21H4qnUf4YqSNvh2GRsMtDD9WCnQ=;
        b=N476kXalybgCgo/99C3HuckInVoFJHpPBUpEM3pi2jnlcL8BTkhEaJBhmKcd4y+4hK
         J8nL2QK8xvJRShqZHKzYaLXZ3ByzlDD0ZaMhGqKkIGicr7K5hCChJHhKjpyMkinzBDGZ
         bVuzGS7D48v+NDPynxZAVLmZSZZDb2Nf6Lq4D1g8y3Mr7ZjhO5XwsRYEJfOkPNefu+tU
         mlnByQDPxLZUJ9etXj/iMMTpndSKPiW3EG33gJ0ef15bq4h5ZCdrYMdH2+PKVN3t/TLG
         6W+wQIKjCMv6G4lW7yA7xSDFEJsTpxcuBgvfZynsIaRolTIM4ECYm74vXVxxICKY9Aew
         uIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597560; x=1695202360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fv8oMIcohr/MrFd21H4qnUf4YqSNvh2GRsMtDD9WCnQ=;
        b=PBwddbdG1qwGrnl/7N/mzTbb/nCA1GkP81I03lkuc2OiEs4jFBY5ZDhbLGAFdssbqL
         J9wP+K2gl6Hv3n0F41577OwV0ggRMAtjWnFwPkJnPP+locqlkGjUL0FRdxs6trbOWoiD
         dBDOGPVITjTXHebQ5Rz0O9byJiMTIiQeCUjAbmvxQNqR0MmE68pOXtVEFzC/sJGrqNou
         C/5ZwiMT4RT/Igcoum1/Z3CQX6hdeOphb1K9P3SHFb1Cwpez014Dngv5ZENH1n7sqFcN
         90CMRiZ2igcLCSgdCjkX9bDGB0Y8VSTEna6fuPHMBYHXlMTV/kNVnmcArBARpl7jJlkv
         oKAA==
X-Gm-Message-State: AOJu0YwS+W0GIAjFAmh7uuqdojrehB7xmwCUwRijVW3zwtjRG13XA9wd
        UHrHPj3nXl/0xppGfh3z+TQNPt2kA+Tf+X8NIpNRVC4gTD+Riw==
X-Google-Smtp-Source: AGHT+IESsdu9L/rfJxJKVL+wNsKl/1AlqM5n8aFXYSS5ORuZmm9TT9JohIahsNJTqB1huNXCg8qy46GhERG7TWtn7jI=
X-Received: by 2002:a05:6871:9b:b0:1bb:89b1:77b7 with SMTP id
 u27-20020a056871009b00b001bb89b177b7mr2494400oaa.16.1694597559732; Wed, 13
 Sep 2023 02:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230908174208.249184-1-karthik.188@gmail.com>
 <20230912155820.136111-1-karthik.188@gmail.com> <ZQCa3GHT3D7aibJ1@nand.local>
In-Reply-To: <ZQCa3GHT3D7aibJ1@nand.local>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 13 Sep 2023 11:32:13 +0200
Message-ID: <CAOLa=ZSVobP9Be9W3f1BWoZjLUYwOqOpCQMCXVH34=iGKfXnmw@mail.gmail.com>
Subject: Re: [PATCH v2] revision: add `--ignore-missing-links` user option
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2023 at 7:07=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
> > +# We create 5 commits and move them to the alt directory and
> > +# create 5 more commits which will stay in the main odb.
> > +test_expect_success 'create repository and alternate directory' '
> > +     git init main &&
>
> We don't necessarily have to initialize a repository, as the test suite
> already does so for us. So we may want to write this instead as:
>
>     test_commit_bulk 5 &&
>     git clone --reference=3D. --shared . alt &&
>     test_commit_bulk -C alt --start=3D6 5
>

I was trying to use the env variable `GIT_ALTERNATE_OBJECT_DIRECTORIES` and
get hence ended up creating a new repository. But I really like the
convenience functions
that you've suggested below. With that, this seems like the way to go.

> > +# when the alternate odb is provided, all commits are listed along wit=
h the boundary
> > +# commit.
> > +test_expect_success 'rev-list passes with alternate object directory' =
'
> > +     GIT_ALTERNATE_OBJECT_DIRECTORIES=3D$PWD/alt git -C main rev-list =
HEAD >actual &&
> > +     test_stdout_line_count =3D 10 cat actual &&
> > +     grep $BOUNDARY_COMMIT actual
> > +'
>
> Here, I think we'd want to make sure that we have not just 10 lines of
> output, but that they are the 10 that we expect, like so:
>
>     git -C alt rev-list --all --objects --no-object-names >actual.raw &&
>     {
>       git rev-list --all --objects --no-object-names &&
>       git -C alt rev-list --all --objects --no-object-names --not \
>         --alternate-refs
>     } >expect.raw &&
>     sort actual.raw >actual &&
>     sort expect.raw >expect &&
>     test_cmp expect actual
>
> When reviewing this and tweaking some of the tests locally, I found it
> useful to have some convenience functions like "hide_alternates" and
> "show_alternates" to control whether or not "alt" could see its
> alternate or not.
>
> From my review locally, the resulting changes (which can be applied
> directly on top of your patch here look like):
>

This is much better. I didn't know about `test_oid_to_path` and
`test_when_finished`, and overall
your patch looks much nicer and is more thorough in the testing. I'll
add it to the next version.
Will wait a day or two for more feedback before I submit v3.

Thanks again for your review and the patch :)
