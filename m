Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85015C00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 17:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHARoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjHARoV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 13:44:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF961BF5
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 10:44:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so5195531a12.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690911853; x=1691516653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTzRTySEub4hqHboByR/I53MSNDzWxMl7B12TKjQh9Q=;
        b=DsGsm/5Ur6zgmUSsqCiYyYc7CGvhS/4pSlXwvGLkG9hOdVvN7EffpZEztKgGy1E963
         DTyS1Yz6YNpKPgcLQyLnXGDdQ3HfScgRHyXm92Tcuve1yIFFIIxzFwVqDODG+fvr+Fl/
         dh36AkeiRwMebTo01I3Xq81Hoc/Om8h0iGBNashujAwHRAp7arLp8W6UeS6EnppfvGPC
         Vu5PWQRPEugUYhDKx2b2Rv0szxJD4UakHruLDMaK7IgZ+THtBE1HCSFiljcV5jHsnyG0
         vB0RQvo9qPYZgBHWlfufzlV5aKXYSpHHNXRUnXtZVUBcDrYwVrac4Ugkt3xf+WXV4zeB
         lE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911853; x=1691516653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTzRTySEub4hqHboByR/I53MSNDzWxMl7B12TKjQh9Q=;
        b=h2ZXABPaH7g7C4/FYW1z5GpzClMKAx2wsQsi4nOuJz/S9buewyXfVB94QZbRnyKBKP
         nMfN093nZ53N1upesxGK5TH6Sx4+knbw5k2dPHPRZBBlln1ZGCeon0l9VcEeKLf697kM
         Mr1vhH0n/HSs/yXcxuotTzUdg2aG6Q1vlWyDmOXn/b8ielPWaCNQgnz5RyMrEYouEwuz
         OU+s8giF26hFTQRt0nJV89TYOm2vDvhRB4nJYOHPAkcK/PO+ISOAYaYv+Nrn8FW3dGy+
         cFVsfDd/8bX3kILCHmxTCmHMEPC/9RNvfbAhNdPxSwaovFUwLVGJsdxIn7z+gjk8juoI
         Wdyw==
X-Gm-Message-State: ABy/qLair+1xfFkTs745X3v3VJ0LEfvAZRkNqXLsXG1LaVBj9Tk6BS+e
        AQq2Eo42ZU0uDzPZQoUhKbkjjOJeM/v2ltQg14U=
X-Google-Smtp-Source: APBJJlE6O/bF3EeXCMKqwY5V0PHcDBZLnuTKfwjl6phwlbXBdI4f/pczjTFUDpec+rXfx74KzFgRZIdB6kytUmmySKA=
X-Received: by 2002:aa7:c401:0:b0:522:3053:e64 with SMTP id
 j1-20020aa7c401000000b0052230530e64mr2846082edq.13.1690911853326; Tue, 01 Aug
 2023 10:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <858rfnb770.fsf@gmail.com> <ZBy18EBE7WM/E4KF@nand.local>
 <851qlfazzp.fsf@gmail.com> <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
 <85tty8afvy.fsf@gmail.com> <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
 <ZMgXBc5idN+sR3o1@nand.local> <CAFQ2z_MzWauauzq_fKdcKTXahutLtADb7uHTh7ysinGNOx75nQ@mail.gmail.com>
 <CANQwDwe8Po-2KxNjWQ+RW+hYGLF=4sYTjQJxcVSAOtbtpfVRhQ@mail.gmail.com> <ZMlCB/Pkzlb7Wvq5@nand.local>
In-Reply-To: <ZMlCB/Pkzlb7Wvq5@nand.local>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Tue, 1 Aug 2023 19:43:36 +0200
Message-ID: <CANQwDwdXoO4BeSzCCedC9VnPoJV-eHSr18YJeAeG2Gvj9-__zQ@mail.gmail.com>
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring bitmaps?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

On Tue, 1 Aug 2023 at 19:34, Taylor Blau <me@ttaylorr.com> wrote:
> On Tue, Aug 01, 2023 at 01:34:32PM +0200, Jakub Nar=C4=99bski wrote:
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
> Yeah, this is definitely where the majority of CPU savings seems to
> remain. The existing implementation in my branch is much too eager to
> uncompress bitmaps when we need to perform a logical/binary operation on
> them.

As I understand it, the current code in Git (in C implementation) uses
uncompressed bitmap to store the result of OR-ing, but it uses compressed
EWAH to perform <uncompressed result> OR <EWAH-compressed bitmap>.

> I think with some more surgery we could leave bitmaps in a compressed
> state for longer. I am not sure whether or not we should ever uncompress
> the bitmaps, though it's possible that doing so is beneficial since
> uncompressed bitmaps have better query performance (albeit more costly
> memory usage).

I'm not sure if it would be worth the complexity, but supposedly you can
perform L bitwise OR operations in O(log(L)) instead of O(L). Current C cod=
e
computes OR operation sequentially, see above, and also
  https://github.com/git/git/blob/master/pack-bitmap.c#L103\0

There might be thousands of "wants" and of "haves", but is it common?

Best,
--=20
Jakub Nar=C4=99bski
