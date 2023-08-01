Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1E3C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 11:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHALy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 07:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjHALyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 07:54:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425641718
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 04:54:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf91956cdso471326466b.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 04:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690890863; x=1691495663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgudRI0nS5w6mAPrPb1wQf83saJ7MaoT1wcJirj41Ak=;
        b=uYibxweBUhOznUvLf6IiEtPah0V6kD8Fboz+11pVjCEndMsvMSJofKTJBXQ26zkD5g
         EOs6m8ga3hovqQdgjxJid08HGW+QyJb3QMMbBYWaK4tmMw5qzDVWNvlMELbjWzcj7ptF
         3899S3Ux4202KTcbkX1EXM8vzL4TpOKar7P02Hg55DyFuGA94Awacdt4XFA/2mWLPtrq
         LGe4lEHmayzf9XI7PTGca5/5dyDPRwM84TK6EVT6VFD9+z/UAUorHxSrE47mlTOY+5xe
         Hyp9/UGphxjSvkFLe6e971uFKRo8WlUc+JqMp9XpNYPtoH82fq4nJaBZLYkw4mIXqd8/
         46iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690890863; x=1691495663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgudRI0nS5w6mAPrPb1wQf83saJ7MaoT1wcJirj41Ak=;
        b=bwqwDkLxeUcts95hy5lZEPB9y9gDWbDiEcrPEBNTDa7/lJUrmSAAyD6WXsu/s628l5
         wUdNQXlcUwuYvSffZHu34Xphq+BXnQtghc8a+4DAU2Ab9xWEK6J4XXzqwgdxO7Qs74Dt
         RDDqP3hrZVcw/hFjD6DGaqJbtxBWbWqY33CBtWJ68P0nrXC9OqhcxuIxbping0xfJIvG
         aSXjJs6l88mHHMx/Iehgq2aNU9t0PsV4mEb9B5KuTCodO1gpd9B8AZZrfN4u4k7wRi4c
         sgOx90yGQxJBkU1DTje9O11wtw+gU5mgzIoYwDdAaPhrKRa8vJyjyU1JIz1+xkrn2jDk
         0H1A==
X-Gm-Message-State: ABy/qLYcBcc//hR/aEHX9N9vY0q7850wio6dhgeyM0yp0GX9ibzXkGwb
        j5cWCYCXOQyAgeTpKJ9LkEfF9BXAk21QF5DWFBheZA==
X-Google-Smtp-Source: APBJJlF9DI6AfIhx/5KZCJhu3NJ1ifIOm+yICBsOwOtnKkxlQwy00AM5aSmbKVBYmhFsnuBIiW2UnUWwnvu5hiEPuz8=
X-Received: by 2002:a17:906:15d:b0:95e:d3f5:3d47 with SMTP id
 29-20020a170906015d00b0095ed3f53d47mr2396703ejh.48.1690890862600; Tue, 01 Aug
 2023 04:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <858rfnb770.fsf@gmail.com> <ZBy18EBE7WM/E4KF@nand.local>
 <851qlfazzp.fsf@gmail.com> <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
 <85tty8afvy.fsf@gmail.com> <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
 <ZMgXBc5idN+sR3o1@nand.local> <CAFQ2z_MzWauauzq_fKdcKTXahutLtADb7uHTh7ysinGNOx75nQ@mail.gmail.com>
 <CANQwDwe8Po-2KxNjWQ+RW+hYGLF=4sYTjQJxcVSAOtbtpfVRhQ@mail.gmail.com>
In-Reply-To: <CANQwDwe8Po-2KxNjWQ+RW+hYGLF=4sYTjQJxcVSAOtbtpfVRhQ@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 1 Aug 2023 13:54:11 +0200
Message-ID: <CAFQ2z_MmUDMTc7wyR1X8oxXdtz54_0HZmS2Q8iv9YMoqZmh0hQ@mail.gmail.com>
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring bitmaps?
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2023 at 1:35=E2=80=AFPM Jakub Nar=C4=99bski <jnareb@gmail.co=
m> wrote:
>
> Hello,
>
> On Tue, 1 Aug 2023 at 13:26, Han-Wen Nienhuys <hanwen@google.com> wrote:
> > On Mon, Jul 31, 2023 at 10:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> =
wrote:
> > >
> > > I haven't proved conclusively one way or the other where Roaring+Run =
is
> > > significantly faster than EWAH or vice-versa. There are some cases wh=
ere
> > > the former is a clear winner, and other cases where it's the latter.
> > >
> > > In any event, my extremely WIP patches to make this mostly work are
> > > available here:
> > >
> > >   https://github.com/ttaylorr/git/compare/tb/roaring-bitmaps
> > >
> >
> > thanks. For anyone reading along, the changes to JGit are here
> >
> > https://git.eclipse.org/r/c/jgit/jgit/+/203448
> >
> > I was looking into this because I was hoping that roaring might
> > decrease peak memory usage.
> >
> > I don't have firm evidence that it's better or worse, but I did
> > observe that runtime and memory usage during GC (which is heavy on
> > bitmap operations due to delta/xor encoding) was unchanged. That makes
> > me pessimistic that there are significant gains to be had.
>
> The major advantage Roaring bitmaps have over EWAH and other
> simple Run Length Encoding based compression algorithms is that
> bitmap operations can be done on compressed bitmaps: there is no
> need to uncompress bitmap to do (want1 OR want2 AND NOT have).

Are you sure? The source code for and and andNot look rather similar
in that they seem to do operations on whole RLE sections at a time,

https://sourcegraph.com/github.com/lemire/javaewah/-/blob/src/main/java/com=
/googlecode/javaewah/EWAHCompressedBitmap.java?L498

https://sourcegraph.com/github.com/lemire/javaewah/-/blob/src/main/java/com=
/googlecode/javaewah/EWAHCompressedBitmap.java?L405

Looking at the EWAH format as documented for git-bitmap-format, EWAH
allows for RLE on both 1s and 0s. It should be possible to efficiently
clear out a section of the target if the second operand of andNot has
RLE encoded run of 1s.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
