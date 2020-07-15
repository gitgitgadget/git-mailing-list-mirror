Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F243C433DF
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7874D20657
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 13:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bult77FL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgGONFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgGONFl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 09:05:41 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FECEC061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 06:05:41 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id h17so829104qvr.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Zlt6qQkhM2QI3zA1uy+oNbfmWLksJB/JYCu+vlaQkhU=;
        b=Bult77FLaS8rhlvFREV8XCDvz+9/Goyr/xF/keN5tDe0jsHLHekJv4QKhQmdP8Bsit
         Va2PUn+VuSlobZ/hXshuoWJTOjkkQp5/+WK5YiZsAXqprHUfa//syN2mVnI8vPedcqCH
         4DjkZltevhFC89QibfBWod5q4N22sEOU8iz+HjEvIn0ah7iR4b2a5z/ai16jgsYrrcg8
         KfTT9Heh1ghLQ2xPtN9TY2YD2URY6kca51u6qWTTkUNiXmCZqdIc9+cyx2ukdpr2qweu
         bnPd9xRHMssxXt2mEDP7WIeKeh9dNjccveLAoSyYT8LkuzROx6uzYJZx7F4rhjC0Eiux
         iF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Zlt6qQkhM2QI3zA1uy+oNbfmWLksJB/JYCu+vlaQkhU=;
        b=oHpPn4MREbabgGv4LR/KepO7GByLXhZHFWIcl/72KX3xDJarzmjt4xttaoLyVlgwKC
         YOaCbvLgSC7C85aUToXmoa++0LC9Wf3P8UZjl2eST+O/kcF/+mzIIq5ndCLIAvOqTudH
         zDgJs6qmaFb35TSrQeNvFvbuP2nZwKuXGnG/iTdd2CsuTKpMY/VPehpwE19aRPq2g5KL
         bvwIrzaLT5iEEpAngCZyYrgy0D4/hTSrqsZuMJY49n+4tIqV+YjAb92QNdUCbTpxIskP
         q4xJuZNhNiak/adoAwqV9ToGK4jkF1hOdncFZQpa+uhyubrtw57G4ojbcNeWQWljOy8Z
         +8yQ==
X-Gm-Message-State: AOAM531Den7hoKM/NiKN9e1uhPkGogY1eznolQkGamINc6gBfL62r9Cj
        hCDhh1y3juIqa8h6W956kmDG/bmn
X-Google-Smtp-Source: ABdhPJy8x/AVRxxvuI5FvzQ9KN7zpmcJQ9xHWo1yrpM/LXzVEUXO4pIUH3PtNg14p5vaTtsD1DRexA==
X-Received: by 2002:ad4:4105:: with SMTP id i5mr9408501qvp.170.1594818340487;
        Wed, 15 Jul 2020 06:05:40 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id r7sm2814032qtm.66.2020.07.15.06.05.39
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 15 Jul 2020 06:05:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG?] Fetching a single tag to a local tag requires `--no-tags`
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200715072726.GA3249056@coredump.intra.peff.net>
Date:   Wed, 15 Jul 2020 09:05:37 -0400
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FB8592A-61FA-450C-B689-9E2DF879A292@gmail.com>
References: <12F0A2A4-CC71-4452-B8B8-F540339F8519@gmail.com> <20200715072726.GA3249056@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

> Le 15 juil. 2020 =C3=A0 03:27, Jeff King <peff@peff.net> a =C3=A9crit =
:
>=20
> On Tue, Jul 14, 2020 at 10:17:59PM -0400, Philippe Blain wrote:
>=20
>> If I want to fetch a single tag from a remote repository to a local =
tag,
>> it seems I have to use `--no-tags`, or else all tags on the remote =
are fetched:
>>=20
>> git remote add ggg https://github.com/gitgitgadget/git
>> # this command fetches all tags on Gitgitgadget
>> git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v2
>> # this command fetches only the tag listed on the command line
>> git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v2 =
--no-tags
>=20
> Hmm, that's not what I see:
>=20
>  $ git clone -q https://github.com/git/git tmp
>  $ cd tmp
>  $ git remote add ggg https://github.com/gitgitgadget/git
>  $ git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v2
>  remote: Enumerating objects: 11, done.
>  remote: Counting objects: 100% (11/11), done.
>  remote: Total 18 (delta 10), reused 10 (delta 10), pack-reused 7
>  Receiving objects: 100% (18/18), 7.16 KiB | 1.79 MiB/s, done.
>  Resolving deltas: 100% (12/12), completed with 3 local objects.
>  =46rom https://github.com/gitgitgadget/git
>   * [new tag]               =
pr-590/phil-blain/doc-log-multiple-ranges-v2 -> =
pr-590/phil-blain/doc-log-multiple-ranges-v2

Oups, I should have tried in a fresh clone...

>=20
>> Am I reading the documentation correctly ?
>>=20
>> tag <tag> syntax [1]:
>> "tag <tag> means the same as refs/tags/<tag>:refs/tags/<tag>;=20
>> it requests fetching everything up to the given tag."
>>=20
>> --no-tags [2] :
>> "By default, tags that point at objects that are downloaded
>> from the remote repository are fetched and stored locally.
>> This option disables this automatic tag following."=20
>=20
> I think this last one may be an oversimplification. I'm pretty sure =
that
> we'd download a tag that points to any object we already have, even if
> it wasn't just fetched.
>=20
>  [after this, we'll have the object still, but not the tag]
>  $ git tag -d pr-590/phil-blain/doc-log-multiple-ranges-v2
>  Deleted tag 'pr-590/phil-blain/doc-log-multiple-ranges-v2' (was =
3221c3f76f)
>=20
>  $ git fetch ggg tag pr-590/phil-blain/doc-log-multiple-ranges-v1
>  remote: Enumerating objects: 16, done.
>  remote: Counting objects: 100% (16/16), done.
>  remote: Total 25 (delta 15), reused 15 (delta 15), pack-reused 9
>  Receiving objects: 100% (25/25), 8.67 KiB | 2.89 MiB/s, done.
>  Resolving deltas: 100% (17/17), completed with 8 local objects.
>  =46rom https://github.com/gitgitgadget/git
>   * [new tag]               =
pr-590/phil-blain/doc-log-multiple-ranges-v1 -> =
pr-590/phil-blain/doc-log-multiple-ranges-v1
>   * [new tag]               =
pr-590/phil-blain/doc-log-multiple-ranges-v2 -> =
pr-590/phil-blain/doc-log-multiple-ranges-v2
>=20
> So in the second fetch, we got v1 and v2, because we already had the
> history for v2 sitting around. In the example at the beginning of my
> email, our git.git clone was pristine. But presumably you ran into =
this
> in a repository where you'd been doing work on that or other =
ggg-tracked
> topics.

Yes I think that what happened is I first tried=20
git fetch --tags pr-590/phil-blain/doc-log-multiple-ranges-v1,
which fetched all tags, then I deleted the tags but the object stayed,
as above, so my next fetch re-created all the tags.

Anyway, sorry for the noise and thanks for you answer!

Philippe.=
