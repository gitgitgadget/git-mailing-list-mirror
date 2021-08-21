Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1586C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 02:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F1C611C4
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 02:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhHUChl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhHUChk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 22:37:40 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD8C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 19:37:01 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z2so11421363iln.0
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 19:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iHQM6gjlOzEu2KKYW9XUpFd4gIKAhQvwaj2EW+kO12s=;
        b=rThhjO2xXFJKEla0uI+aMprTRX7MYrjWte4YPRZshQLYokk+XB0gMDy4eEF34jKfok
         99fN8xAeH3Q7w3BYp/JBH7zB/mzwN7ZaFx9j337OMbWTn3gOekWolVtVq2Vz4KcVFpGs
         FG6iTy7ToVzQdKhhUOYRg05rTijsCs8NCybwUe3+N5BeCNdp1izGYHCeD007fP2u0h+7
         nF7JH8kk784UnDbD8LlS0ybFKiS4Xq8UOCb3OiPA7iX+Dkkze331DatMRM479VjWOOsl
         TU/SbB1TxWt/04IeRv0SHemwUPE5NwhvR979wGfq8qJEq8Zytk5h/OnDLdWVTHQg6VUW
         l7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iHQM6gjlOzEu2KKYW9XUpFd4gIKAhQvwaj2EW+kO12s=;
        b=fdCMltLOf8fKurN4gQjlccN0birERpZWMWDuS/cfWS8choU0UMMTUbXt9TlT3R4qrS
         WKrr3k51wNOpyWM58t6sb7Elg3JNaYSVN4EGWSHR1Hh00bxh5qr4T8KpC5m26ck0KAAX
         j7AOG7LWKO1Vk40ntRugkYrvoxTZeF1bzpzm1brawBXPyZdkGB7JTkFiE0OS3XRN7wBo
         vvs/M7+NZOmi4Deub1KbB2cjfiV0UfKMwvQqU+BrLo5xz5x/HzlEVxKeORcUhO/TsUWq
         L/hkQ3m4x2CvlQRNjCuxJ6x/CyLSf5c1UjvYF4QPpoApbEqiPBZUHR71M4oegR2Lyz1D
         dNkw==
X-Gm-Message-State: AOAM533v6q+iXdtk7pZ4gwXJ1Sy6ONV/DsXFOTzBpqrvoIwhV5i9tjg5
        litY/fPcI7NgJqs70kf0Hk/2c02lzG46vgKy5Ws=
X-Google-Smtp-Source: ABdhPJwuPVcOP0/LVFvUKa/RN//mN4YVuM2DiZxoufOwzNK+ANwzz9HayVvi52KmtWtjPZQD8HGhirj0IqPnRb6f/c4=
X-Received: by 2002:a92:440c:: with SMTP id r12mr15536794ila.174.1629513419939;
 Fri, 20 Aug 2021 19:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
 <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
 <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com>
 <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com>
 <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com>
 <CAOLTT8Qx3=C=MwRmKbrp=G5T_rQVcaLbZfzzO60m7P-_k1qh8A@mail.gmail.com> <CAP8UFD0WB7FYtp9aX4qz5BmLiNz1S5PA1U8-cB8b9zRqdZHOjw@mail.gmail.com>
In-Reply-To: <CAP8UFD0WB7FYtp9aX4qz5BmLiNz1S5PA1U8-cB8b9zRqdZHOjw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 21 Aug 2021 10:36:48 +0800
Message-ID: <CAOLTT8QtLzP5jfqav-UnJj21NczVW-XhRmfxGQ__qdNah_C1yQ@mail.gmail.com>
Subject: Re: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=
=8821=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:13=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi ZheNing,
>
> On Thu, Aug 19, 2021 at 3:39 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Hi, Christian and Hariom,
> >
> > I want to use this patch series as the temporary final version of GSOC =
project:
> >
> > https://github.com/adlternative/git/commits/cat-file-reuse-ref-filter-l=
ogic
>
> I am still not very happy with the last patch in the series,but it can
> be improved later.
>

To be free to tell me what's not good about it, I can try my best to
improve it. :-)


> > Due to the branch ref-filter-opt-code-logic or branch
> > ref-filter-opt-perf patch series
> > temporarily unable to reflect its optimization to git cat-file
> > --batch. Therefore, using
> > branch cat-file-reuse-ref-filter-logic is the most effective now.
> >
> > This is the final performance regression test result:
> > Test                                        upstream/master   this
> > tree
> > -----------------------------------------------------------------------=
-------------
> > 1006.2: cat-file --batch-check              0.06(0.06+0.00)
> > 0.08(0.07+0.00) +33.3%
> > 1006.3: cat-file --batch-check with atoms   0.06(0.04+0.01)
> > 0.06(0.06+0.00) +0.0%
> > 1006.4: cat-file --batch                    0.49(0.47+0.02)
> > 0.48(0.47+0.01) -2.0%
> > 1006.5: cat-file --batch with atoms         0.48(0.44+0.03)
> > 0.47(0.46+0.01) -2.1%
> >
> > git cat-file --batch has a performance improvement of about 2%.
> > git cat-file --batch-check still has a performance gap of 33.3%.
> >
> > The performance degradation of git cat-file --batch-check is actually
> > not very big.
> >
> > upstream/master (225bc32a98):
> >
> > $ hyperfine --warmup=3D10  "~/git/bin-wrappers/git cat-file
> > --batch-check --batch-all-objects"
> > Benchmark #1: ~/git/bin-wrappers/git cat-file --batch-check --batch-all=
-objects
> >  Time (mean =C2=B1 =CF=83):     596.2 ms =C2=B1   5.7 ms    [User: 563.=
0 ms, System: 32.5 ms]
> >  Range (min =E2=80=A6 max):   586.9 ms =E2=80=A6 607.9 ms    10 runs
> >
> > cat-file-reuse-ref-filter-logic (709a0c5c12):
> >
> > $ hyperfine --warmup=3D10  "~/git/bin-wrappers/git cat-file
> > --batch-check --batch-all-objects"
> > Benchmark #1: ~/git/bin-wrappers/git cat-file --batch-check --batch-all=
-objects
> >  Time (mean =C2=B1 =CF=83):     601.3 ms =C2=B1   5.8 ms    [User: 566.=
9 ms, System: 33.9 ms]
> >  Range (min =E2=80=A6 max):   596.7 ms =E2=80=A6 613.3 ms    10 runs
> >
> > The execution time of git cat-file --batch-check is only a few
> > milliseconds away.
>
> Yeah, it looks like less than 1% overhead.
>
> Great work!
>
> > But look at the execution time changes of git cat-file --batch:
> >
> > upstream/master (225bc32a98):
> >
> > $ time ~/git/bin-wrappers/git cat-file --batch --batch-all-objects
> > >/dev/null
> > /home/adl/git/bin-wrappers/git cat-file --batch --batch-all-objects >
> >  24.61s user 0.30s system 99% cpu 24.908 total
> >
> > cat-file-reuse-ref-filter-logic (709a0c5c12):
> >
> > $ time ~/git/bin-wrappers/git cat-file --batch --batch-all-objects >/de=
v/null
> > cat-file --batch --batch-all-objects > /dev/null  25.10s user 0.30s
> > system 99% cpu 25.417 total
> >
> > The execution time has been reduced by nearly 0.5 seconds.
>
> It looks like it has increased by 0.5s, not been reduced.
>

Unfortunately, you are right, it is not faster, but slower.
It seems that the 2% optimization measured by t/perf does not seem to be
so credible? I donno.

Test                                        upstream/master   this
tree
---------------------------------------------------------------------------=
---------
1006.2: cat-file --batch-check              0.07(0.06+0.01)
0.08(0.07+0.01) +14.3%
1006.3: cat-file --batch-check with atoms   0.06(0.05+0.01)
0.07(0.05+0.01) +16.7%
1006.4: cat-file --batch                    0.49(0.46+0.03)
0.48(0.47+0.01) -2.0%
1006.5: cat-file --batch with atoms         0.48(0.45+0.03)
0.47(0.46+0.01) -2.1%

Do we need to focus on the benchmark instead of the sum of the
benchmark plus the
variance? i.e. 1006.4, benchmark are 0.46 and 0.47, From this perspective, =
the
performance of git cat-file --batch will be worse.

> > Intuition
> > tells me that the performance improvement of git cat-file --batch will =
be
> > more important.
> >
> > In fact, git cat-file origin code directly adds the obtained object dat=
a
> > to the output buffer; But after using ref-filter logic, it needs to cop=
y
> > the object data to the intermediate data (atom_value), and finally
> > to the output buffer. At present, we cannot easily eliminate intermedia=
te
> > data, because git for-each-ref --sort has a lot of dependence on it,
> > but we can reduce the overhead of copying or allocating memory as
> > much as possible.
>
> Ok.
>
> > I had an idea that I didn't implement before: partial data delayed eval=
uation.
> > Or to be more specific, waiting until the data is about to be added to
> > the output
> > buffer, form specific output content, this may be a way to bypass the
> > intermediate
> > data.
>
> Yeah, that might be a good idea.

I will try to do it.

Thanks.
--
ZheNing Hu
