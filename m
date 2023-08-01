Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F56C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 13:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjHANSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjHANRt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 09:17:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2244E1718
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 06:17:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so9153770e87.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690895866; x=1691500666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kflj8W0VOfCmX9TVaUG2CbPd557k4KXGWw7vjjNVGoU=;
        b=X9eBW0IZ6LnsJDFIbuH6ri7Ob4MbJ07G4FoDtokyustsxlL0yzYE64lam4rkV1AK/v
         bYN6xV5c4UfYUA4Nv1+nSM9uwmWIysHokdLK/Ph0NWUT56aYhrXgSggG8QM4UxIR7jBa
         NM9HkrALNcDX2e65RnsH3ofm9EBQKRlPI7UplVjzzi5cJyxalbiYtEG5iQxkrFyx6yzK
         d+UOLkZxrr4TAFogOLSel8qH464m3nejdSLMqd8lXbMYA/UEc1FfrM15bAK02Nv1kr6o
         A4/WXwjYOb8+g6ATT5vvcCTZxVm5u0ODc4w0UFsGQs0PIIz/DXr1KwlWjGJdZlvADypn
         ljeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895866; x=1691500666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kflj8W0VOfCmX9TVaUG2CbPd557k4KXGWw7vjjNVGoU=;
        b=d0LYiZs6ponkD3huw8mglB4kGbiSi4YCTYpDdXsh/cHC9y/x7+L833Cx2T+isGyilg
         Y4pmVONDEdj3o43bVA/7AJy4yb1PiVtYTSOVktmrimLokt1+iyf7n/xQAOgEXXd63jxm
         bppNGWNjH5SApXy5QCAYY56R75gA382LU3pVzy8xGsOK2POJvHARs2V5FoguFX1jE13P
         ImmHoHMaDp0D3+0gp10N/Bnw7ykL5Bgmq5AOrVrMwfgWbhPfscJUT+qNmLwhJxjKgXI9
         5uc/7DOh/7ZxnDGbLwRrfn1a1iqwyGTsoos9V0zQSJbuQ/rXphXfkyCOvKoAKGBn+Cmi
         YcJA==
X-Gm-Message-State: ABy/qLaTwNTCoAbRRvuTbHmPaDY8CAnI8sAT5vbWzpw97u2rlUQS+K1L
        1B2IADwe5iEJxE0wINZeeRKSlK9TR69O5cGm/YU=
X-Google-Smtp-Source: APBJJlH8aTUkow4CO2j0N/cLz4AqN5jL4QekFAWXfeIWWJl4P7JUK3ukFoji2o6Ss2lA7EK7z71rFo6TrIRyj3R3Fkc=
X-Received: by 2002:ac2:5478:0:b0:4fd:b7fb:c9fa with SMTP id
 e24-20020ac25478000000b004fdb7fbc9famr1907375lfn.42.1690895865780; Tue, 01
 Aug 2023 06:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <858rfnb770.fsf@gmail.com> <ZBy18EBE7WM/E4KF@nand.local>
 <851qlfazzp.fsf@gmail.com> <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
 <85tty8afvy.fsf@gmail.com> <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
 <ZMgXBc5idN+sR3o1@nand.local> <CAFQ2z_MzWauauzq_fKdcKTXahutLtADb7uHTh7ysinGNOx75nQ@mail.gmail.com>
 <CANQwDwe8Po-2KxNjWQ+RW+hYGLF=4sYTjQJxcVSAOtbtpfVRhQ@mail.gmail.com> <CAFQ2z_MmUDMTc7wyR1X8oxXdtz54_0HZmS2Q8iv9YMoqZmh0hQ@mail.gmail.com>
In-Reply-To: <CAFQ2z_MmUDMTc7wyR1X8oxXdtz54_0HZmS2Q8iv9YMoqZmh0hQ@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Tue, 1 Aug 2023 15:17:09 +0200
Message-ID: <CANQwDwf6x9yZgBLkSLun3pFaGpy4NC0RwYbid2L5wC6=Z9peww@mail.gmail.com>
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring bitmaps?
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Tue, 1 Aug 2023 at 13:54, Han-Wen Nienhuys <hanwen@google.com> wrote:
> On Tue, Aug 1, 2023 at 1:35=E2=80=AFPM Jakub Nar=C4=99bski <jnareb@gmail.=
com> wrote:
> > On Tue, 1 Aug 2023 at 13:26, Han-Wen Nienhuys <hanwen@google.com> wrote=
:
> > > On Mon, Jul 31, 2023 at 10:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com=
> wrote:
> > > >
> > > > I haven't proved conclusively one way or the other where Roaring+Ru=
n is
> > > > significantly faster than EWAH or vice-versa. There are some cases =
where
> > > > the former is a clear winner, and other cases where it's the latter=
.
> > > >
> > > > In any event, my extremely WIP patches to make this mostly work are
> > > > available here:
> > > >
> > > >   https://github.com/ttaylorr/git/compare/tb/roaring-bitmaps
> > > >
> > >
> > > thanks. For anyone reading along, the changes to JGit are here
> > >
> > > https://git.eclipse.org/r/c/jgit/jgit/+/203448
> > >
> > > I was looking into this because I was hoping that roaring might
> > > decrease peak memory usage.
> > >
> > > I don't have firm evidence that it's better or worse, but I did
> > > observe that runtime and memory usage during GC (which is heavy on
> > > bitmap operations due to delta/xor encoding) was unchanged. That make=
s
> > > me pessimistic that there are significant gains to be had.
> >
> > The major advantage Roaring bitmaps have over EWAH and other
> > simple Run Length Encoding based compression algorithms is that
> > bitmap operations can be done on compressed bitmaps: there is no
> > need to uncompress bitmap to do (want1 OR want2 AND NOT have).
>
> Are you sure? The source code for and and andNot look rather similar
> in that they seem to do operations on whole RLE sections at a time,
>
> https://sourcegraph.com/github.com/lemire/javaewah/-/blob/src/main/java/c=
om/googlecode/javaewah/EWAHCompressedBitmap.java?L498
>
> https://sourcegraph.com/github.com/lemire/javaewah/-/blob/src/main/java/c=
om/googlecode/javaewah/EWAHCompressedBitmap.java?L405
>
> Looking at the EWAH format as documented for git-bitmap-format, EWAH
> allows for RLE on both 1s and 0s. It should be possible to efficiently
> clear out a section of the target if the second operand of andNot has
> RLE encoded run of 1s.

You are right, I seem to have misremembered the statement from the
EWAH paper.

Lemma 2 in "Sorting improves word-aligned bitmap indexes" (arXiv:0901.3751v=
7)
states that the bitmap operation of L bitmaps is computable in
O(L*compressed size),
and for updatable L-ary operation like symmetric boolean operation
the bitmap operation is computable in O(log(L)*compressed size).

Now I am not sure if I understand the code of Git correctly, but it seems l=
ike
in pack-bitmap.c the `add_commit_to_bitmap()` function stores the result
of OR operation on bitmaps as an uncompressed bitmap:
https://github.com/git/git/blob/master/pack-bitmap.c#L1030

Best,
--=20
Jakub Nar=C4=99bski
