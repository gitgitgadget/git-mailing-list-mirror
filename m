Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10EAC32771
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 23:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIUXgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIUXgS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 19:36:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2499A1A72
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 16:36:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k10so11844565lfm.4
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=TAyWU9+NWSsXY2y1dqv4YRVDzLiahwV98CLCtnw8rt4=;
        b=EF6vFPvUhdw1GuEJKpFqHHcuYmuYQcGZzZTXijzoTGQVCxzqzFTcjpQf3XhpNiG4nL
         Jy3+qJowt/NmRiLmb+XKp/pONgC6fe6NtFj49iKvWClv1rIIC8AiVO5P8kJGVT0TPrwk
         xoEDgBMLqPhQSNmiPboosP7lAa2vRsf/2+tC0xA26c6GG/5SclGKaB+Y2EyPqsjbdEGH
         E/pTLq/nPj2ITUmCMm+8tCb0LEY6ToM98ojrbWHjoXMTIZCO1wPZ5vdMVaUloM+muFrh
         j9n0jSsDSzUIBFeyLCVwnumzXZMWWj7qHbO0knjWEnm8Mv1JgXJPsA8XgyWhrJvJdfAG
         RW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TAyWU9+NWSsXY2y1dqv4YRVDzLiahwV98CLCtnw8rt4=;
        b=m+Z4ZUi7diVZzZBNrxWR8YA4/Nw4nOCBv6+wqw+xkmiEgkn4qP2e14cAXRjfBsheau
         aB186nGc48kINdsvzTyM7tSiC8L/QviE6yAwll1ij5nCqm0ba2Y/Fui6mLtpQfcfsjyR
         baJ3N0EhukksaZsbalhyuBP94m3Ltx4twPDHvTZ4hLcHxyEN9m/4hZDPG3WrYtvEUurx
         kbEfv8IkjKUjCaNIl8xpIntbJlbj406bZQHEHMc/SKbrHJwNSc/rdjTURP28/8NJupyv
         fnZyw0afDxg4zRcLS/5Zt8AtdvBzTANPURFgdkrraF8BsZGOYXBo95SDYOsgKTwAqi9/
         laVw==
X-Gm-Message-State: ACrzQf0nPaShH1uIi+/qam+W9dtOwXrs4T63j2UU+8I5JopDLSHRrnWB
        YSfejhcZRirJEKl4Jaz0GKdSPqU1qwIaTPCEaUo=
X-Google-Smtp-Source: AMsMyM4HfnsaZdOFOOKqqt1xPIdDC6mSC/hFU7b23xv5uDWjALfOecTJxapJUDK5PkEPuHZDm6jJFl0jrjiZ2PS1Y54=
X-Received: by 2002:ac2:4c4b:0:b0:49e:939d:69dd with SMTP id
 o11-20020ac24c4b000000b0049e939d69ddmr211263lfk.516.1663803374979; Wed, 21
 Sep 2022 16:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
 <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com> <CAOLTT8TwdwfHCCv+x51++Aanf3tipMegfZiTKFbQtfh7b_EY0A@mail.gmail.com>
In-Reply-To: <CAOLTT8TwdwfHCCv+x51++Aanf3tipMegfZiTKFbQtfh7b_EY0A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Sep 2022 16:36:03 -0700
Message-ID: <CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5ncw54Di_g@mail.gmail.com>
Subject: Re: Question relate to collaboration on git monorepo
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2022 at 8:22 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Emily Shaffer <emilyshaffer@google.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=882=
1=E6=97=A5=E5=91=A8=E4=B8=89 02:53=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Sep 20, 2022 at 5:42 AM ZheNing Hu <adlternative@gmail.com> wro=
te:
> > >
> > > Hey, guys,
> > >
> > > If two users of git monorepo are working on different sub project
> > > /project1 and /project2 by partial-clone and sparse-checkout ,
> > > if user one push first, then user two want to push too, he must
> > > pull some blob which pushed by user one. I guess their repo size
> > > will gradually increase by other's project's objects, so is there any=
 way
> > > to delete unnecessary blobs out of working project (sparse-checkout
> > > filterspec), or just git pull don't really fetch these unnecessary bl=
obs?
> >
> > This is exactly what the combination of partial clone and sparse
> > checkout is for!
> >
> > Dev A is working on project1/, and excludes project2/ from her sparse
> > filter; she also cloned with `--filter=3Dblob:none`.
> > Dev B is working on project2/, and excludes project1/ from his sparse
> > filter, and similarly  is using blob:none partial clone filter.
> >
> > Assuming everybody is contributing by direct push, and not using a
> > code review tool or something else which handles the push for them...
> > Dev A finishes first, and pushes.
> > Dev B needs to pull, like you say - but during that pull he doesn't
> > need to fetch the objects in project1, because they're excluded by the
> > combination of his partial clone filter and his sparse checkout
> > pattern. The pull needs to happen because there is a new commit which
> > Dev B's commit needs to treat as a parent, and so Dev B's client needs
> > to know the ID of that commit.
> >
>
> I don't agree here, it indeed fetches the blobs during git pull. So I
> do a little
> change in the previous test:
>
> (
>   cd m2
>   git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
> blob_count1
> #  git push
> #  git -c pull.rebase=3Dfalse pull --no-edit #no conflict
>   git fetch origin main
>   git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
> blob_count2
>   git merge --no-edit origin/main
>   git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
> blob_count3
>   printf "blob_count1=3D%s\n" $(cat blob_count1)
>   printf "blob_count2=3D%s\n" $(cat blob_count2)
>   printf "blob_count3=3D%s\n" $(cat blob_count3)
> )
>
> warning: This repository uses promisor remotes. Some objects may not be l=
oaded.
> remote: Enumerating objects: 32, done.
> remote: Counting objects: 100% (32/32), done.
> remote: Compressing objects: 100% (20/20), done.
> remote: Total 30 (delta 0), reused 0 (delta 0), pack-reused 0
> Receiving objects: 100% (30/30), 2.61 KiB | 2.61 MiB/s, done.
> From /Users/adl/./mono-repo
>  * branch            main       -> FETCH_HEAD
>    a6a17f2..16a8585  main       -> origin/main
> warning: This repository uses promisor remotes. Some objects may not be l=
oaded.
> Merge made by the 'ort' strategy.

Note: The merge completed successfully, and we see no evidence of
additional blobs being downloaded before this point.

> remote: Enumerating objects: 1, done.
> remote: Counting objects: 100% (1/1), done.
> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> Receiving objects: 100% (1/1), 87 bytes | 87.00 KiB/s, done.

Here, we do have an object download, which occurred after the merge
completed, so there must be something happening after the merge which
needs the extra blob; if we keep reading...

>  project1/file1 | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Ah, the 'helpful' diffstat.  It downloads blobs from a promisor remote
just so we can see what has changed, including in the area of the
project we don't care about.

(This is yet another reason it'd be nice to have a --restrict mode for
grep/diff/log/etc. for sparse-checkout uses, and an ability to make it
the default in some repo, so you could get just the diffstat within
the region of the project that you care about.  We're discussing such
an idea, but it isn't implemented yet.)

> warning: This repository uses promisor remotes. Some objects may not be l=
oaded.
> blob_count1=3D11
> blob_count2=3D11
> blob_count3=3D12
>
> The result shows that blob count doesn't change in git fetch, but in git =
merge.

If you add --no-stat to your merge command (or set merge.stat to
false), the extra blob will not be downloaded.
