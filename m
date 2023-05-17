Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9EAC77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 19:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjEQTZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 15:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEQTZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 15:25:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D73D2F0
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:24:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f500dee3f6so12247261cf.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684351489; x=1686943489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDrudoGOkGGMGQlzdxuHCjW82JRaUcAJAtJem6BTn7A=;
        b=gBPkOlPRhmalN/WcF1/XkjAUzNjKp4y4Z93P8XqGlmtyeqYkyhEaVesm1jfwgy00OK
         cS0XF75rb6i0vJir2CUDjpBedY9jaWY4+6m+G9Tja0/wXZxJC+2X5ko8koX0REKh0LlH
         dFkzsr4a5szhdPp0SfpD7MrHEIrpPUHK3PlN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351489; x=1686943489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDrudoGOkGGMGQlzdxuHCjW82JRaUcAJAtJem6BTn7A=;
        b=DAm1co7lV65wRn8cRN6YcfgM3m9ibbTCGEZowfnsiOpv2V9VvLLnq/6auVkJIjG+I1
         sK4XVbIvmymD5g21czg43Wx81feBYAVBxDm4LJj/E4zRsjnuFOpv0U9OrxEN3ZXKQ3LY
         FV/F46RHxRJHB2n4MCi8u2biTlC9oZfMHrqXPbRZPNn+OKvxU6dw8z1Bi4VeyFoA1S2Y
         MradXoo6yQqN2RIaz42QfTDZ4tpHMT5WZScK61cq7fNiajRnRrsXhhuz/UpoJooE9Afo
         HeJMLr5i+qwwvv6yv/G7FIoJaiamrHsDIhmmNW2LJY12bZbCNBU7ZtPDBYDwY+B1zWAD
         uDuQ==
X-Gm-Message-State: AC+VfDzSqkyJRWsDPp2U2CpfimJTxHPtrFLBe8vaM/v4FdbFzGXc+bD1
        C5PKGdDpemlkrqu4IklOa6INyTytOSLzgMCeVHM=
X-Google-Smtp-Source: ACHHUZ4fxcEFdO0SK3/LvqddrcN7JUJkAd7rVdX3OhwfKf/jv39teCew8ZAkSPeZ5LG1E2IY7LVLqg==
X-Received: by 2002:a05:622a:1391:b0:3f5:aa3:ace7 with SMTP id o17-20020a05622a139100b003f50aa3ace7mr1242885qtk.61.1684351489676;
        Wed, 17 May 2023 12:24:49 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a15cf00b0075784a8f13csm831301qkm.96.2023.05.17.12.24.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:24:48 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-3f38824a025so40571cf.0
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:24:48 -0700 (PDT)
X-Received: by 2002:ac8:594f:0:b0:3f0:af20:1a37 with SMTP id
 15-20020ac8594f000000b003f0af201a37mr30285qtz.15.1684351488079; Wed, 17 May
 2023 12:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
 <xmqqo7mipyt0.fsf@gitster.g>
In-Reply-To: <xmqqo7mipyt0.fsf@gitster.g>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 May 2023 12:24:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnzFrczC1dvsHYgNabZMhC7-K1uG8=MH20qNE25o0CEA@mail.gmail.com>
Message-ID: <CAD=FV=XnzFrczC1dvsHYgNabZMhC7-K1uG8=MH20qNE25o0CEA@mail.gmail.com>
Subject: Re: bug report: cover letter is inheriting last patch's message ID
 with send-email
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>, michael.strawbridge@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, May 17, 2023 at 12:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Emily Shaffer <nasamuffin@google.com> writes:
>
> > Following is a report from inside of Google:
> >
> > **What did you do before the bug happened? (Steps to reproduce your iss=
ue)**
> >
> > ```
> > # With the attached patches, where all of the patches have a
> > # Message-Id but the cover letter doesn't.
> > git send-email *.patch
> > ```
> >
> > Specifically, you can see me doing it:
> >
> > ```
> > $ git send-email *.patch
> > 0000-cover-letter.patch
> > 0001-dt-bindings-interrupt-controller-arm-gic-v3-Add-quir.patch
> > ...
> > 0006-arm64-dts-mediatek-mt8195-Add-mediatek-gicr-save-qui.patch
> > To whom should the emails be sent (if anyone)?
> > Message-ID to be used as In-Reply-To for the first email (if any)?
> > (mbox) Adding cc: Douglas Anderson <dianders@chromium.org> from line
> > 'From: Douglas Anderson <dianders@chromium.org>'
> >
> > From: Douglas Anderson <dianders@chromium.org>
> > To:
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Subject: [PATCH 0/6] irqchip/gic-v3: Disable pseudo NMIs on Mediatek
> > Chromebooks w/ bad FW
> > Date: Thu, 11 May 2023 15:25:55 -0700
> > Message-ID: <20230511151719.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718=
@changeid>
> > ```
> >
> > If you look at `0000-cover-letter.patch` you can see that it has no
> > Message-ID, but the above clearly shows that the cover letter is being
> > sent with a Message-ID (and the one from the last patch).
>
> It is correct that Message-ID needs to be assigned by send-email if
> the outgoing message lacks one.  I am not sure what is meant by
> "from the last patch".  Do you mean that Message-ID exists in
> 0006-*.patch but not in 0000-cover-letter.patch [*]?

Yes. It exists in all of the patches except 0000-cover-letter.patch.
...but when the mail gets actually sent the cover letter and last
patch (0006 in the case I reported) end up sharing the same Change ID.
With older versions of git send-email the cover letter would get an
auto-generated Message-Id.


> I suspect that
> is the root cause of the problem; if 000[1-6]-*.patch already has
> their own Message-ID: because --thread is used when running
> git-format-patch, they would also have In-Reply-To: and References:,
> but there is no way for them to reference 0000-cover-letter.patch
> (because format-patch did not get a chance to generate Message-ID to
> it), is there?

The patches were generated with git-format-patch but the Message-ID
was added by patman [1]. The Message-ID encodes the local Change-Id
which can make it easier to associate one version of the same patch
with another (same reason gerrit uses Change-Id) [2]. There is no
Change-Id associated with the cover letter so patman doesn't bother
adding one there and has always just let it be auto-generated. We
could certainly change patman to make up a Message-Id for the cover
letter, but there is no real need.

[1] https://source.denx.de/u-boot/u-boot/-/blob/master/tools/patman/patman.=
rst
[2] https://source.denx.de/u-boot/u-boot/-/commit/833e4192cd791733ddc010699=
6a4f86f9269ceba
