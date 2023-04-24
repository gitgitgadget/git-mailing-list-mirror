Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA6AC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjDXUAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjDXUAu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 16:00:50 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D8AA
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:00:48 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6a5e2289965so4047217a34.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682366448; x=1684958448;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkAeizIy30FfBFbkzRHWdr39S6w2Ptb/rkpyvx4pzMA=;
        b=qm7uSQIQr3jjZ/WZ77UJZ+ETn3ydiqww2Hq+ktEideCrIHkXUOom+e+aZo7jWahdrA
         lGqYKitNl5fTQlXz0fh3pe1Bpt1CBdbPoe1o4/9G4S1zRSMmeJZ58uGg9KavrwRcTe63
         6FaKIToICQ+59Xb/YRVpaDYoV304Kv6NMgAo3jIgtl9dlR998YdvNr3UizqcnTDfR1i3
         jx4klD6qzdLvRIFm98dIx5pF+9CYkPCvzIJWMMgY/RDSO95q3NZYoMr9sNyEaDAjiQYt
         lK3D+4EpTLCcFjbXorGH9aDjAJPpXhu9dDib3tetbnbJ3cXAXPkVm1JtJDAon5tZS4BC
         y/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682366448; x=1684958448;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DkAeizIy30FfBFbkzRHWdr39S6w2Ptb/rkpyvx4pzMA=;
        b=BWLseqQmlawURLY95ObX8EbWFxKGjrUU6o24iBP1SEmKx3wOpnLcwtC5bcWoc59D8L
         PjgnuO3Ey8cmto1CVpNXgnIN4u/Iah/pFEpdNnT25LE0VIwTWHAJPJxQQkDFfB2SeMhA
         +Wz2TEOxWJJh08gUBXZKxjF0IRpZsOho3n9WZ2UHcpISE7LPIyisRfj2sJDw+hNy702R
         Yh/vGLTmhZgb7WECk6/Hd2MIWJNLFoLaqwWuoR989sCXzBq/OfMzPSOMAgYgVLZ5yawt
         9duw+D1caB8EXR6LsrkAfIup18Bc+Cqt22jG643MLK0/qL0hkBgBNdnZje9UrG35iWoU
         afyw==
X-Gm-Message-State: AAQBX9cLb1Vaf7AZssjY9MwXC0dyc7UY2XFUy478o+o69VMyKq2tUXkQ
        T+MAFgkxaDbTMW+GUVI0+S8=
X-Google-Smtp-Source: AKy350b+e84YC1dcf4LP0/Gbovt0k+eYHq/C1/mgoKeodxyCLESd4jr9Ib/QUcE6wMElDWlGIHzmww==
X-Received: by 2002:a05:6830:18e2:b0:6a4:3c53:413a with SMTP id d2-20020a05683018e200b006a43c53413amr8777211otf.17.1682366447942;
        Mon, 24 Apr 2023 13:00:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bt8-20020a05683039c800b0069f951899e1sm5016366otb.24.2023.04.24.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:00:47 -0700 (PDT)
Date:   Mon, 24 Apr 2023 14:00:31 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Jeremy Morton <admin@game-point.net>
Cc:     Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Message-ID: <6446dfdfdd6c_cd6129446@chronos.notmuch>
In-Reply-To: <26c4306d-f0f1-a2a6-55a5-6bb10c77cc0f@intel.com>
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <CAPx1Gvdc6bqzt2PpqD1Z4e5w+b=8gZhUSyfUQC1n8QazdBacEw@mail.gmail.com>
 <74a361fd-4ee6-f362-8d49-92417f0e2dac@game-point.net>
 <CA+JQ7M-1YvZFzE_CtBQa5_eEXa1sPqK4xsTxdwpAQo_YcmW+-A@mail.gmail.com>
 <91dab444-5f65-31ae-c0c6-0b84313bcd94@game-point.net>
 <CA+JQ7M_Lv1acopOpPoHxp7mPwWMFj-7wwwDPpV7KUbwFsjpoxA@mail.gmail.com>
 <6446d78fbbe82_cd61294e5@chronos.notmuch>
 <26c4306d-f0f1-a2a6-55a5-6bb10c77cc0f@intel.com>
Subject: Re: Proposal: tell git a file has been renamed
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller wrote:
> On 4/24/2023 12:25 PM, Felipe Contreras wrote:
> > Erik Cervin Edin wrote:
> >> On Mon, Apr 24, 2023 at 1:17=E2=80=AFPM Jeremy Morton <admin@game-po=
int.net> wrote:
> >>>
> >>> There's no getting away from the fact that this adds a lot of (IMHO=

> >>> unnecessary) work if you've already done a rename that git can't
> >>> detect and have both that and a bunch of other changes sitting in t=
he
> >>> index.  What feels like it would be a natural resolution in these
> >>> cases, though, is a "no, this remove/add is actually a rename" comm=
and.
> >>
> >> It can definitely be both arduous and non-obvious how to deal with t=
his.
> >>
> >> The problem is that such a command cannot exist atm. because renames=

> >> don't exist, they are only interpreted. So the only way to achieve
> >> this is to revert enough of the contents staged to the index such th=
at
> >> the rename is detected. The only way to do that in a foolproof manne=
r
> >> is reverting all the staged changes except the path so that the move=
d
> >> file in the index is identical to the old file in HEAD.
> > =

> > I agree recording renames explicitely might be a good addition to git=
, but the
> > real question is how are they going to be stored in the object storag=
e.
> > =

> > My guess is that it can be added in the commit object after "committe=
r", just
> > add a "renames" field with all the renames, or one "rename" field per=
 rename.
> > It would be backwards compatible because any field can be added this =
way.
> > =

> > How to generate these fields is a separate issue: first things first.=

> =

> The other end of the solution space is to try to find ways to make the
> rename detection logic more accurate. We wouldn't need to store such a
> rename if the detection gave the correct answer in the first place.

We can make it more accurate, but it will never be 100%. Sometimes being
explicit is the only way.

Cheers.

-- =

Felipe Contreras=
