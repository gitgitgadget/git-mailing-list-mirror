Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0897C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 07:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbhLBHgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 02:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhLBHgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 02:36:38 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75FEC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 23:33:16 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v15so53196595ljc.0
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 23:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mgyY+lalJN9IpC6nVNNfeCoevGzH5+RIrjRuwOPC8nE=;
        b=oP8HHVe7yL9ZQ4fH2qg7tWmfi7IwGD8up0sBR6UrkOiW5fJTAuzPl+YJ1ws9Qihhdh
         0v5dvckht+PQNPRJsoOO1ozLkOgTT8IhzdbI5T9CpIKJ4TYWVSknohZhNvtVCvbk6M2Z
         FZ5bFVPqc7zHpTVH16d4UCeA8/jNyiAEUDkw1SpiaokK1gPY7e1GBVFFDinnHdPrtTOG
         D0wKqmKuJgTkuX4/VmHdGjTteyocyf76mzXEWQwUHCCjUz9PxmVXsTYyg+IgP8GlK15u
         PHiFgUlERwjuhMsxniKkvGTVVVPetcIQbCYgzLiwxeO0r94GZj+pqMjI9KeGj8Jc0mvZ
         LH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mgyY+lalJN9IpC6nVNNfeCoevGzH5+RIrjRuwOPC8nE=;
        b=8Mh+8rqv51vz4gS9/6Lj1GCgTPe9KcXU9j7+uDI1vQkQnKXVeK+zjw2Ax7qYUxFdpH
         0AH8Y9Qii4+4KYXaw4o5CWY5xAw41xp6vrvQqt97eOGvWnYDm1YFdbMsaBeWXIaNfUYI
         Mc51R05sZUpbRL4H+XHipKyNwa0b+tu0o4NoERpg5RWy2yicHH1e/7HNPBT1n2MgZ1wx
         BSW9RZwr0zx9e/CfsOt8qTcZDLRUzjRYD5/nmjtIE3OnR45ZmXG8MpKc9J9nxHefKi7x
         B/G6hvIRzY4dL0j9ccBFkdhh4IwzBRD3jnaXgiQ0y3ul4UikaqWmLHUr+LqZz2uvHoND
         ToIQ==
X-Gm-Message-State: AOAM5319uytcAHEbZCBzAcPPiq9Gwfh67qoiT0seUNZnCk3D4hjV5Dl8
        fyXceAXDilUB9zVgUBbz5ELIDOADMZFF0rUeDYw=
X-Google-Smtp-Source: ABdhPJxuMQLWND9spiBFuKHBSuCaXo9gadnjzoWvj/QGdaLgZBwJG0FUMXaRVug7s21Odej3xaqjLO/DfVEFS96FPxo=
X-Received: by 2002:a05:651c:1687:: with SMTP id bd7mr10573422ljb.305.1638430394993;
 Wed, 01 Dec 2021 23:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20211009082058.41138-1-chiyutianyi@gmail.com> <20211122033220.32883-6-chiyutianyi@gmail.com>
 <8ff89e50-1b80-7932-f0e2-af401ee04bb1@gmail.com> <CAO0brD0oPHMwGNQXpC2XVhU=fY7XrrtBeu-x8GmJndeVptJaBg@mail.gmail.com>
 <446c3677-140f-3033-138f-1ef9b1f546a5@gmail.com>
In-Reply-To: <446c3677-140f-3033-138f-1ef9b1f546a5@gmail.com>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Thu, 2 Dec 2021 15:33:04 +0800
Message-ID: <CAO0brD2bGXwAJVrPSybbVNeSmQ1S85a_ykmceVKrg=pE3MfsnA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] unpack-objects: unpack_non_delta_entry() read data
 in a stream
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 2:38 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> I used a pack-file from an internal repo. It happened to be using
> partial clone, so here is a repro with the git/git repository
> after cloning this way:
>
> $ git clone --no-checkout --filter=3Dblob:none https://github.com/git/git
>
> (copy the large .pack from git/.git/objects/pack/ to big.pack)
>
> $ hyperfine \
>         --prepare 'rm -rf dest.git && git init --bare dest.git' \
>         -n 'old' '~/_git/git-upstream/git -C dest.git unpack-objects <big=
.pack' \
>         -n 'new' '~/_git/git/git -C dest.git unpack-objects <big.pack' \
>         -n 'new (small threshold)' '~/_git/git/git -c core.bigfilethresho=
ld=3D64k -C dest.git unpack-objects <big.pack'
>
> Benchmark 1: old
>   Time (mean =C2=B1 =CF=83):     82.748 s =C2=B1  0.445 s    [User: 50.51=
2 s, System: 32.049 s]
>   Range (min =E2=80=A6 max):   82.042 s =E2=80=A6 83.587 s    10 runs
>
> Benchmark 2: new
>   Time (mean =C2=B1 =CF=83):     101.644 s =C2=B1  0.524 s    [User: 67.4=
70 s, System: 34.047 s]
>   Range (min =E2=80=A6 max):   100.866 s =E2=80=A6 102.633 s    10 runs
>
> Benchmark 3: new (small threshold)
>   Time (mean =C2=B1 =CF=83):     101.093 s =C2=B1  0.269 s    [User: 67.4=
04 s, System: 33.559 s]
>   Range (min =E2=80=A6 max):   100.639 s =E2=80=A6 101.375 s    10 runs
>
> Summary
>   'old' ran
>     1.22 =C2=B1 0.01 times faster than 'new (small threshold)'
>     1.23 =C2=B1 0.01 times faster than 'new'
>
> I'm also able to repro this with a smaller repo (microsoft/scalar)
> so the tests complete much faster:
>
> $ hyperfine \
>         --prepare 'rm -rf dest.git && git init --bare dest.git' \
>         -n 'old' '~/_git/git-upstream/git -C dest.git unpack-objects <sma=
ll.pack' \
>         -n 'new' '~/_git/git/git -C dest.git unpack-objects <small.pack' =
\
>         -n 'new (small threshold)' '~/_git/git/git -c core.bigfilethresho=
ld=3D64k -C dest.git unpack-objects <small.pack'
>
> Benchmark 1: old
>   Time (mean =C2=B1 =CF=83):      3.295 s =C2=B1  0.023 s    [User: 1.063=
 s, System: 2.228 s]
>   Range (min =E2=80=A6 max):    3.269 s =E2=80=A6  3.351 s    10 runs
>
> Benchmark 2: new
>   Time (mean =C2=B1 =CF=83):      3.592 s =C2=B1  0.105 s    [User: 1.261=
 s, System: 2.328 s]
>   Range (min =E2=80=A6 max):    3.378 s =E2=80=A6  3.679 s    10 runs
>
> Benchmark 3: new (small threshold)
>   Time (mean =C2=B1 =CF=83):      3.584 s =C2=B1  0.144 s    [User: 1.241=
 s, System: 2.339 s]
>   Range (min =E2=80=A6 max):    3.359 s =E2=80=A6  3.747 s    10 runs
>
> Summary
>   'old' ran
>     1.09 =C2=B1 0.04 times faster than 'new (small threshold)'
>     1.09 =C2=B1 0.03 times faster than 'new'
>
> It's not the same relative overhead, but still significant.
>
> These pack-files contain (mostly) small objects, no large blobs.
> I know that's not the target of your efforts, but it would be
> good to avoid a regression here.
>
> Thanks,
> -Stolee

With your help, I did catch this performance problem, which was
introduced in this patch:
https://lore.kernel.org/git/20211122033220.32883-4-chiyutianyi@gmail.com/

This patch changes the original data reading ino to stream reading, but
its problem is that even for the original reading of the whole object data,
it still generates an additional git_deflate() and subsequent transfer.

I will fix it in a follow-up patch.

Thanks,
-Han Xin
