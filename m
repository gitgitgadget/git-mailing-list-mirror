Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3C9C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 11:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjHALfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjHALfM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 07:35:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066261BB
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 04:35:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe3c7f16bbso2553761e87.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690889709; x=1691494509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0tCgGOn/1WU/h1kEdgcP85dR+wSSqw14jJOMhROA08=;
        b=pp2BVjYkJwK6dQozs+vO/SnmjYrHl76611DYDBhTMtmbdpaqLwWaU6HTJFBIvQtni2
         5zFQgkVYAlQtDO8rN2jBZNnIJ5p+nHTB+3Xsnj6q/S/sxyBZH+NW9rHm/XYiUQgHxMVm
         QTLq0YlxGsIZ5pouUVy+DyGJorm/roSEAA9T/z9gZDHLm/pfW33BcBUzbyM5ZBcY/+cR
         RdtsbH3WB0Wf+yXqNBX0Rl+yarjXfql+dCVrwhNZS/LK5Qf8GsJvahWu4GNWL7Dyjf7g
         HS401LLAKytezFf8Swdr2WmAkWVM465zKR+CKcy7Jehbivlrihgf/fgRgNlU2eG2mKFJ
         Ay5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889709; x=1691494509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0tCgGOn/1WU/h1kEdgcP85dR+wSSqw14jJOMhROA08=;
        b=B8BrvDAsewPMl03Hldm5SBD0s76KpNka2iQSNtApAlSMNgLTIBGqqcYLyDyyLPNzHr
         hq3U5T5pY2h55HYMj6UqGidLLGiBHc13a9iRArkUez2PLGEYZgYa2Q5RpFii8xWxnaij
         UZZ9kMFhY7ghqAyFkP4AmhcUwY9UTQZs2Y+4MgiR4bSgNB09C8CJpla5VJWlYszar4cn
         o0h5tqE1oFtfb/e+cSE/XBoYNEG/WJ+pRNM4+Js5lL8oYil8yo7yMFYUp1jQDdlNJe9C
         bn6tSKQUbLhJxjOJwEvT+0iQAmCoC32RooahLORf8Nrg2iFyO/22zAeWntwfb7rI1PqS
         JDfA==
X-Gm-Message-State: ABy/qLYbF4WAdbcoiAQoNy3nN/nnapWirsj2+JPe/HbQ3INkeII9rvrd
        WrZ7K6Kzdjglxx0kjusYTWiMMscinkfL+3RVwmE=
X-Google-Smtp-Source: APBJJlH/2t04xyMMX5DK4z3eJKRgfmRL1Os6Tn8fynb/Dt7tGAM8+id5NMuQFl8cEhg/oOI51A/XlDbyvI0mS427Q4M=
X-Received: by 2002:ac2:5bce:0:b0:4fd:c844:6a43 with SMTP id
 u14-20020ac25bce000000b004fdc8446a43mr1939798lfn.43.1690889708998; Tue, 01
 Aug 2023 04:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <858rfnb770.fsf@gmail.com> <ZBy18EBE7WM/E4KF@nand.local>
 <851qlfazzp.fsf@gmail.com> <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
 <85tty8afvy.fsf@gmail.com> <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
 <ZMgXBc5idN+sR3o1@nand.local> <CAFQ2z_MzWauauzq_fKdcKTXahutLtADb7uHTh7ysinGNOx75nQ@mail.gmail.com>
In-Reply-To: <CAFQ2z_MzWauauzq_fKdcKTXahutLtADb7uHTh7ysinGNOx75nQ@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Tue, 1 Aug 2023 13:34:32 +0200
Message-ID: <CANQwDwe8Po-2KxNjWQ+RW+hYGLF=4sYTjQJxcVSAOtbtpfVRhQ@mail.gmail.com>
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

On Tue, 1 Aug 2023 at 13:26, Han-Wen Nienhuys <hanwen@google.com> wrote:
> On Mon, Jul 31, 2023 at 10:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wr=
ote:
> >
> > I haven't proved conclusively one way or the other where Roaring+Run is
> > significantly faster than EWAH or vice-versa. There are some cases wher=
e
> > the former is a clear winner, and other cases where it's the latter.
> >
> > In any event, my extremely WIP patches to make this mostly work are
> > available here:
> >
> >   https://github.com/ttaylorr/git/compare/tb/roaring-bitmaps
> >
>
> thanks. For anyone reading along, the changes to JGit are here
>
> https://git.eclipse.org/r/c/jgit/jgit/+/203448
>
> I was looking into this because I was hoping that roaring might
> decrease peak memory usage.
>
> I don't have firm evidence that it's better or worse, but I did
> observe that runtime and memory usage during GC (which is heavy on
> bitmap operations due to delta/xor encoding) was unchanged. That makes
> me pessimistic that there are significant gains to be had.

The major advantage Roaring bitmaps have over EWAH and other
simple Run Length Encoding based compression algorithms is that
bitmap operations can be done on compressed bitmaps: there is no
need to uncompress bitmap to do (want1 OR want2 AND NOT have).

If I remember correctly, Git (the C implementation) basically un-compresses
bitmaps to make use of them when using them during fetch.

Some operations can be done on EWAH without decompression, but
non-symmetric full-bitmap operation line AND NOT is not one of them.

Best,
--=20
Jakub Nar=C4=99bski
