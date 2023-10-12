Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D93CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 13:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347209AbjJLNYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 09:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378662AbjJLNX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 09:23:57 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A485FBB
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 06:23:54 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so650337a34.0
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697117034; x=1697721834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE1VjGz3ZJWVWf/MH+ex/XRSv1dPmWWpfRI0iiUJyKY=;
        b=aKUEXFXJpbmvusMOkXX48EqVAcjX8pDKJWJPULUaEmUAuKK5Ol8xAiDnEw0ausKnJn
         NCr/rIJCyu9BxUQWqn1Fta5cuwttJ503lXBdALWV2AJOJqe984kAKFnzZ8FK9INNhEbF
         wrRefh7sqHU9/yMKrlT9LT7OKhvtoD7WsKIIFGOe/c8idvhMQ+i5YlwUOFHil+ub//Qo
         QQQ3yeqfGQ3/pcy9FtJXYRu08NV25xCtOsuvxYN4YFnNdzECsLDj3labKhgEWa4ezpB3
         GrA7SsWIgYu+8b14191b1vEEU7enq+1yoHqxZwcDtMu/tkZr/NPrzLVKvpF06Y87ifeA
         sVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697117034; x=1697721834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uE1VjGz3ZJWVWf/MH+ex/XRSv1dPmWWpfRI0iiUJyKY=;
        b=YfqDYIzLFkSItN+yLZi20Y92y6CbYLg6hyzTjzIZiwFpL1nfCnXx/EeHq510YWTPpj
         qKdOZe4UWmP/jfUZl0UbG/xVhbfnS6Rivka8rIkfkp0DkWmYX0ElbYSoALRiGLv8p0a8
         fKnBvkWAwhjZEaFDMJvAMJUSVDqw/S+Vzpa3qq6/R4WRdpv+ct6VTQKvlpOsphDw1ign
         rvrfBw4IMJXxN1qgm1pmJBkraIpvbjqjUjdDX7QvQOtJUiNo19vJHpWxbiBRI6SUnLgu
         VVlKckZjhkV6orutA34UjUIKa1eFLWaftQlPr2V6FqcQPWJK9HQqLU0PZHxAItgRtM7R
         ldvQ==
X-Gm-Message-State: AOJu0YwOiACP98ytODeLO1JJxkK0KM2vtLl1XNt0oMseApSxyoGwvqYt
        g3/f1OcLTey2Nw8gSXU+ybMbTw+IJ1WjrpbjiEk=
X-Google-Smtp-Source: AGHT+IEqXruNbxYAq5y1EyNgLAwdbwgbmGpAbm4kW8XUabEgr3phc7RGCuodFvsVT41itaYjYCgp2eUMmTg2CSzIcf8=
X-Received: by 2002:a05:6870:1ecd:b0:1e9:934d:514c with SMTP id
 pc13-20020a0568701ecd00b001e9934d514cmr5769879oab.50.1697117033904; Thu, 12
 Oct 2023 06:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231009105528.17777-1-karthik.188@gmail.com> <ZSTs3BUVtaI9QIoA@tanuki>
 <xmqqil7etndo.fsf@gitster.g> <CAOLa=ZSbd_E+DAkhuGrUpfHkxaje3jrH9-fEDyctAPFExKnj9A@mail.gmail.com>
 <xmqqbkd5nlq0.fsf@gitster.g> <CAOLa=ZQxNX4oGtqrgLyKenC_D8M=9q0sFJVmo4fyjSPtgw315Q@mail.gmail.com>
 <ZSfSt4tXx8sE68Bn@tanuki>
In-Reply-To: <ZSfSt4tXx8sE68Bn@tanuki>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 12 Oct 2023 15:23:27 +0200
Message-ID: <CAOLa=ZTYqpzyynO=Ks0OkYxveoz9ouwjwj_jcGmr-gfi5_4fhA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rev-list: add support for commits in `--missing`
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2023 at 1:04=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Wouldn't this have the potential to significantly regress performance
> for all those preexisting users of the `--missing` option? The commit
> graph is quite an important optimization nowadays, and especially in
> commands where we potentially walk a lot of commits (like we may do
> here) it can result in queries that are orders of magnitudes faster.
>
> If we were introducing a new option then I think this would be an
> acceptable tradeoff as we could still fix the performance issue in
> another iteration. But we don't and instead aim to change the meaning of
> `--missing` which may already have users out there. Seen in that light
> it does not seem sensible to me to just disable the graph for them.
>

Agreed, that there is a rather huge performance drop doing this. So either:
1. Add commit support for `--missing` and disable commit-graph. There is hu=
ge
performance drop here for commits.
2. Add commit support for `--missing` but disabling commit-graph is provide=
d via
an additional `--disable-commit-graph` option. This expects the user to man=
ually
disable commit-graph for `--missing` to work correctly with commits.

I was also thinking about this, but people who are using `--missing`
till date, also use
it with `--objects`. Using `--objects` is already slow and doesn't
benefit from the
commit-graph. So I don't know if there is much of a performance hit.

Some benchmarks on the Git repo:

With commit graphs:

$ hyperfine --warmup 2 "git rev-list --objects --missing=3Dprint HEAD > /de=
v/null"
Benchmark 1: git rev-list --objects --missing=3Dprint HEAD > /dev/null
  Time (mean =C2=B1 =CF=83):      1.336 s =C2=B1  0.013 s    [User: 1.278 s=
, System: 0.054 s]
  Range (min =E2=80=A6 max):    1.323 s =E2=80=A6  1.365 s    10 runs

$ hyperfine --warmup 2 "git rev-list --missing=3Dprint HEAD > /dev/null"
Benchmark 1: git rev-list --missing=3Dprint HEAD > /dev/null
  Time (mean =C2=B1 =CF=83):      29.6 ms =C2=B1   1.5 ms    [User: 20.2 ms=
, System: 9.1 ms]
  Range (min =E2=80=A6 max):    27.5 ms =E2=80=A6  35.1 ms    92 runs

Without commit graphs:

$ hyperfine --warmup 2 "git rev-list --objects --missing=3Dprint HEAD > /de=
v/null"
Benchmark 1: git rev-list --objects --missing=3Dprint HEAD > /dev/null
  Time (mean =C2=B1 =CF=83):      1.735 s =C2=B1  0.022 s    [User: 1.672 s=
, System: 0.057 s]
  Range (min =E2=80=A6 max):    1.703 s =E2=80=A6  1.765 s    10 runs

$ hyperfine --warmup 2 "git rev-list --missing=3Dprint HEAD > /dev/null"
Benchmark 1: git rev-list --missing=3Dprint HEAD > /dev/null
  Time (mean =C2=B1 =CF=83):     426.6 ms =C2=B1  10.2 ms    [User: 410.1 m=
s, System: 15.1 ms]
  Range (min =E2=80=A6 max):   414.9 ms =E2=80=A6 441.3 ms    10 runs

This shows that while there is definitely a performance loss when
disabling commit-graphs.
This loss is much lesser when used alongside the `--objects` flag.

Overall, I lean towards the option "1", but okay with either.

> Did you figure out what exactly the root cause of this functional
> regression is? If so, can we address that root cause instead?

Are you referring to `--missing` not working with commits? Looking at
the history
of `--missing` shows:

- caf3827e2f: This commits introduces the `--missing` option, it
basically states that
for the upcoming partial clone mechanism, we want to add support for identi=
fying
missing objects.
- 7c0fe330d5: This commit adds support for trees in `--missing`. It
also goes on to
state that `--missing` assumed only blobs could be missing.

Both of these show that `--missing` started off support for only blobs
and eventually
added support to trees (similar to how we're adding support for
commits here). So
I guess the intention was to never work with commits. But the documentation=
 and
the option seem generic enough. Considering that trees was an extension, co=
mmits
should be treated the same way.
