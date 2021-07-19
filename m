Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E563C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1E8610D0
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384148AbhGSSXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 14:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357106AbhGSSF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 14:05:57 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20208C06178A
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:30:38 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so19168317otq.11
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=DisS7ZGnhaTZbBe/MnhNpBL5KmJ4wpWSS15MvLP8gjQ=;
        b=fPqvMoj+Xbf4owA74Euelo4UjDzUXpocMXXdvHr/29t+M+U6r6QFRDoobIWInxcr2M
         F9o1yYVUG15QLKkKbCc4yDp4kqGY0bbfUxJLN5+SIWylpOXdHCdNyQ2AXYBGkh/Odrhd
         VMK6RMyKjrOsJfGKXSWRLtUDcvOJ15hykNBYxzqpmT2fAeeY7P9MkgMo0PnS2Ho3Xd1T
         La25B3xrOlPcdU2p7qxtGQghGLuA9zvCHlyFQ1nlIte5+6O40V+ozj1cEMCoG3XcYwJ1
         aqxbG9iG7XKoSKHJnlSvo6IIok1HdjavgDzK/IAtTwXO5vMJtqx/ks2i21yrHydjUOma
         +5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=DisS7ZGnhaTZbBe/MnhNpBL5KmJ4wpWSS15MvLP8gjQ=;
        b=eNj+CkIHp0xWEmny9DT8vM/SOHNjEFKKMUcxNdx3C9Egz6atYRCev41wj9r/6hP0ru
         sstX7R2XuH1MjGwC2Mu9xY9SMFPIm9DZH/jSE+XlCOtyvVA47LrQodwBpCljPKjSzx9u
         xHRluqZEAnp2kBBcN88BroCYPgwXLDS6nqH2JJzrVTHGxUnCuboufGsbPnIhMeB4XiaY
         IVo4TRxDjX4aSZRp6A8I6+y4UfMj4+CyqcrHL683mXEBx1z7hREXsuXwbwFR5oUrNoNn
         PL2QAvOJZnUspcSHMOWdeQCgDVTDGtFbVbNhgLNlIz8EtZU2KrSNy+2QY25xsWRLtRQR
         nBiw==
X-Gm-Message-State: AOAM533bfKEVRswdJ3SkjCpY5Dh75VA5YU/GxAtVyBK6WFY7KdIGo5wW
        Vv8QVNBGbxFcjDhItN38l1M=
X-Google-Smtp-Source: ABdhPJxL+BypfpsflWnvU3TXYYaiYUP5UbqgGzuFLg+8yLke8hcknHPPRr4vSkez+UHflfeYmfLZgQ==
X-Received: by 2002:a9d:a17:: with SMTP id 23mr5488983otg.343.1626720186275;
        Mon, 19 Jul 2021 11:43:06 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id a7sm2540833oti.47.2021.07.19.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:43:05 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:43:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <60f5c7b867941_141e5c20886@natae.notmuch>
In-Reply-To: <87h7gsvybx.fsf@evledraar.gmail.com>
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com>
 <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
 <87h7gsvybx.fsf@evledraar.gmail.com>
Subject: Re: progress test failure on fedora34
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Wed, Jul 14 2021, Alex Henrie wrote:
> =

> > On Wed, Jul 14, 2021 at 9:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> > <avarab@gmail.com> wrote:
> >>
> >>
> >> On Wed, Jul 14 2021, Fabian Stelzer wrote:
> >>
> >> > Hi,
> >> > The test t0500-progress-display.sh in current master fails on late=
st
> >> > fedora34.
> >> > The break was introduced with:
> >> >
> >> > 83ae1edff7ee0b7674bd556955d2cf1706bddb21
> >> > ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
> >> >
> >> > Kind regards,
> >> > Fabian
> >>
> >> I have not been able to reproduce this, it seems the below E-Mail wa=
s
> >> word-wrapped by your mailer, which is especially bad here since gett=
ing
> >> to the bottom of this requires looking at the whitespace.
> >>
> >> Is there a way you could tar that up and send it (to me personally i=
s
> >> fine, or some pastebin or whatever).
> >>
> >> I am able to reproduce something that looks like this if I
> >> s/COLUMNS=3D80/COLUMNS=3D79/g in the test-lib, but given that we set=
 it to
> >> 80, and that the progress.c code just ends up with an
> >> atoi(getenv("COLUMNS")), and we do our own wrapping (with no other f=
ancy
> >> logic) in progress.c, I'm not seeing right now how this could happen=
...
> >
> > This test also fails for me when using QTerminal or Konsole, but it
> > passes on XTerm and LXTerminal.
> =

> I tried this on Debian 11 with QTerminal 0.16.1 and can't reproduce it,=

> resized the window etc., always get COLUMNS=3D80 if I add some printf
> debugging.
> =

> Do you mind testing with an ad-hoc patch like this on top? It will fail=

> right away, but should say COLUMNS =3D 80 in the output.
> =

> The only thing I can think of right now is that some terminals are doin=
g
> some evil trickery to LD_PRELOAD or whatever and intercept getenv() for=

> COLUMNS and the like, but that's an entirely unfounded hunch.

I'm able to reproduce this. The test fails when running directly with
bash, but not with prove.

And it seems to be a bug in bash:

  export COLUMNS=3D80

  echo "COLUMNS: $COLUMNS"
  cat > /tmp/expect <<EOF
  foobar
  EOF
  echo "COLUMNS: $COLUMNS"

I get:

  COLUMNS: 80
  COLUMNS: 115

Even directly in the console.

-- =

Felipe Contreras=
