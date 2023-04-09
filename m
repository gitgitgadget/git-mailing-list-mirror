Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F34C761A6
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 06:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDIGvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Apr 2023 02:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIGva (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2023 02:51:30 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9E94ED5
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 23:51:29 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54e40113cf3so88914117b3.12
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 23:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681023088; x=1683615088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYIitX3oMOWo5LH0hKkSi1fZdkCwuH7QhNqdrpdv488=;
        b=JjZLbC2qAklkLtdFbmMvkc13DYYhsgIGLUqldCDwqXIDhMN0vzrCN+N/HAkLmzBJeU
         vd3uDh0vgN8GJVhHVR1sltjF6IyDD+YmCHp1ONgw7FW634PgxLzGJO31yAvUy8m0KtI9
         aV4Bp1F4CoIuNQ3MN7nOvNaHGKEjsk/68RA8CeD6d50+gyf9gScGz2k1yJgc5jOsWnec
         rXuOlXCpRt1G/Y7s3oOf/T2TER49sVvpP/jeeN1bfAogZvijsPKgru9HGYGWb5H8Mj6a
         D7AfM2kJa44aKQlmIZZXSUlO/Uz6wtbGVwpz5lR2w9b5LHxCMiGP6u31FphO2kJndeF0
         zR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681023088; x=1683615088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYIitX3oMOWo5LH0hKkSi1fZdkCwuH7QhNqdrpdv488=;
        b=MPgBHkPIRKHXDzXwJDraGTGVKi/dDBQKshV/7EP9XgYx/QsIoWEQNHdWrLwf6V7njY
         7pQifImz9fYTUuNZK7Qeua9zx/nbxk932ukAotpF39jbHUP/D9ZNzpooHXGgTsdBZt8D
         ckm1O8lsl/pHbzMi6N2D6tyzkfLnqbItob+3eKpPmXSaDawkyp3/P4Shg8exZEtgGo7r
         RrJZRtftlbXUB7NKfExgRquShGvFTWzX2jP0VqXfKs3fyRJ01TR8EOBTjiyiXFCZ0yVj
         gsfRTwE6pBBR7HWVeIxvC0dpkHbWtWLilbX25ZUGuTEbuHLWfZq5V1MTtCwMGwVzUk1h
         3sLQ==
X-Gm-Message-State: AAQBX9fCpKtnofO8s2KXkD7SvNX5qT2kMHI6a2Q4ghfZZLoHC2CCiOQM
        hb5wvnHcQF51Y0izuMo3At359uxTvRY9sUNfGIU=
X-Google-Smtp-Source: AKy350ZGkWyjdEEPj+StV069Oz5qTvLi/Qs9PPg5H5n/rXDKj1R9OMXhlwguAGEq/2HRlzSpBUpx23tofnJxSO4hdlU=
X-Received: by 2002:a81:af5d:0:b0:52e:e095:d840 with SMTP id
 x29-20020a81af5d000000b0052ee095d840mr4042200ywj.0.1681023088121; Sat, 08 Apr
 2023 23:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g> <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local> <ZDIgyKDQ2rJT2YEI@nand.local> <ZDIiO1HMjej+rnMk@nand.local>
In-Reply-To: <ZDIiO1HMjej+rnMk@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 9 Apr 2023 14:51:34 +0800
Message-ID: <CAOLTT8TFiXG1hABFVLp_TOEZ4__s2k4+nvcG3Ax867=LJxOi_g@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=889=E6=97=A5=E5=
=91=A8=E6=97=A5 10:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Apr 08, 2023 at 10:19:52PM -0400, Taylor Blau wrote:
> > On Sat, Apr 08, 2023 at 09:28:28PM -0400, Taylor Blau wrote:
> > > > I don't think so. While `git rev-list` traverses objects and perfor=
ms
> > > > filtering within a revision, `git cat-file --batch-all-objects` tra=
verses
> > > > all loose and packed objects. It might be difficult to perfectly
> > > > extract the filtering from `git rev-list` and apply it to `git cat-=
file`.
> > >
> > > `rev-list`'s `--all` option does exactly the former: it looks at all
> > > loose and packed objects instead of doing a traditional object walk.
> >
> > Sorry, this isn't right: --all pretends as if you passed all references
> > to it over argv, not to just look at the individual loose and packed
> > objects.
>
> The right thing to do here if you wanted to get a listing of all blobs
> in your repository regardless of their reachability or whether they are
> loose or packed is:
>
>     git cat-file --batch-check=3D'%(objectname)' --batch-all-objects |
>     git rev-list --objects --stdin --no-walk --filter=3D'object:type=3Dbl=
ob'
>

This looks like a mistake. Try passing a tree oid to git rev-list:

git rev-list --objects --stdin --no-walk --filter=3D'object:type=3Dblob'
<<< HEAD^{tree}
27f9fa75c6d8cdae7834f38006b631522c6a5ac3
4860bebd32f8d3f34c2382f097ac50c0b972d3a0 .cirrus.yml
c592dda681fecfaa6bf64fb3f539eafaf4123ed8 .clang-format
f9d819623d832113014dd5d5366e8ee44ac9666a .editorconfig
b0044cf272fec9b987e99c600d6a95bc357261c3 .gitattributes
...

> Or, if your filter is as straightforward as "is this object a blob or
> not", you could write something like:
>
>     git cat-file --batch-check --batch-all-objects | awk '
>       if ($2 =3D=3D "blob") { print $0 }'
>
> Or you could tighten up the AWK expression by doing something like:
>
>     git cat-file --batch-check=3D'%(objecttype) %(objectname)' \
>       --batch-all-objects | awk '/^blob / { print $2 }'
>
> Sorry for the brain fart.
>
> Thanks,
> Taylor
