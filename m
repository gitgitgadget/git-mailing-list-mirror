Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA352C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 20:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEQUVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 16:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEQUVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 16:21:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014F31FEB
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:21:12 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6238200c584so5508516d6.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684354870; x=1686946870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9eufCQIzIxnk4sdz7+2778nyOaREe2A0dPohUbh/EI=;
        b=HtY93MLRnGfGADNZhJ2ernXSYy/DbBBDcvglYCGGV0AC03Cnx46BFxtxDU6fQm0+Pg
         76rJCQAcbR/hooRzmkQCHqlZVK/3mzpmuu90tt4pjWgRgKKCTlejovLM3MN91vlmvwR4
         0bqIeyuRQsaHS3dB1ArXzsgNCv3W/1pUAdBu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354870; x=1686946870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9eufCQIzIxnk4sdz7+2778nyOaREe2A0dPohUbh/EI=;
        b=KYoC91qpZOfY4+HGPsg1Ug7OufDinP7xaQ3x2hW5WS3ECy7us5UWvYLR8qi5goYQQ2
         egx5YvdkmBmHVb5T0fL5YcklAcFJPSeIor2KeKbAj4miu3Z86KBXvZMpkDfBZxPdCPav
         02+ua30ZE2a6MtyZAmHllw6xiA+qYRzlWAxJ0njJheUd3fLETVYVnhgLlan3U4Vxd0Q9
         rOI04/w6vsycNchtLhU610HUim3ee2gJY5xI5WAOEw5x+Y/b16B44QMvi1p+Co6XMAPo
         NBKWjnw7+Z22/lzyN7pMZT5vLriGM9KoBsNV3+3UHA1kmcSC8RIiXt3Rf7r15TeMb6Is
         JJhA==
X-Gm-Message-State: AC+VfDwa+OW0tMNNqi83howygF3QF3VteMcvqGvSPES9KTvhl8YFUxFy
        15p6suvHB1aR9jGOnBw3JWG7nWvc0FdMSudVuHw=
X-Google-Smtp-Source: ACHHUZ6bJFdqRfvXDwca6ZbrE0WLml7l5mCmxJoFjR2X7KD2a25+05IMs0ikN/r95n3qEz6gU+0D1w==
X-Received: by 2002:a05:6214:2622:b0:5ee:2789:160e with SMTP id gv2-20020a056214262200b005ee2789160emr1542451qvb.52.1684354869905;
        Wed, 17 May 2023 13:21:09 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b007593d311c02sm887285qkh.27.2023.05.17.13.21.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 13:21:09 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3f396606ab0so53841cf.0
        for <git@vger.kernel.org>; Wed, 17 May 2023 13:21:08 -0700 (PDT)
X-Received: by 2002:ac8:7f50:0:b0:3f3:9b0b:8750 with SMTP id
 g16-20020ac87f50000000b003f39b0b8750mr15723qtk.17.1684354867956; Wed, 17 May
 2023 13:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
 <xmqqo7mipyt0.fsf@gitster.g> <CAD=FV=XnzFrczC1dvsHYgNabZMhC7-K1uG8=MH20qNE25o0CEA@mail.gmail.com>
 <xmqqfs7upvvw.fsf@gitster.g>
In-Reply-To: <xmqqfs7upvvw.fsf@gitster.g>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 May 2023 13:20:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WxB8bqKZSkGQYuPxJ6BeA5fbNWcwfiTyhktn83bzCHfg@mail.gmail.com>
Message-ID: <CAD=FV=WxB8bqKZSkGQYuPxJ6BeA5fbNWcwfiTyhktn83bzCHfg@mail.gmail.com>
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

On Wed, May 17, 2023 at 1:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
>
> > Yes. It exists in all of the patches except 0000-cover-letter.patch.
> > ...but when the mail gets actually sent the cover letter and last
> > patch (0006 in the case I reported) end up sharing the same Change ID.
> > With older versions of git send-email the cover letter would get an
> > auto-generated Message-Id.
>
> Yeah, I think the patch I sent in the thread should help; I'd
> appreciate it if you folks can test and verify.

Yup, tested. It works!


> >> I suspect that
> >> is the root cause of the problem; if 000[1-6]-*.patch already has
> >> their own Message-ID: because --thread is used when running
> >> git-format-patch, they would also have In-Reply-To: and References:,
> >> but there is no way for them to reference 0000-cover-letter.patch
> >> (because format-patch did not get a chance to generate Message-ID to
> >> it), is there?
> >
> > The patches were generated with git-format-patch but the Message-ID
> > was added by patman [1]. The Message-ID encodes the local Change-Id
> > which can make it easier to associate one version of the same patch
> > with another (same reason gerrit uses Change-Id) [2]. There is no
> > Change-Id associated with the cover letter so patman doesn't bother
> > adding one there and has always just let it be auto-generated.
>
> > We
> > could certainly change patman to make up a Message-Id for the cover
> > letter, but there is no real need.
>
> This is a tangent, as I think the earlier patch should fix the
> regression, but wouldn't a recipient of such a series have a hard
> time to locate and group the patches in the same series with the
> cover letter, without having In-Reply-To: or References: that links
> the later message back to the initial message (i.e. cover letter)?
> Assigning a Message-ID to the cover, and referencing it from the
> patches via In-Reply-To:, is what is commonly done, I think, for
> that kind of threading.

It has always magically worked.

For instance, looking at a patch series I sent before the regression.
You can see the cover letter here with an automatically-assigned
Message-Id:

https://lore.kernel.org/linux-arm-kernel/20230504221349.1535669-1-dianders@=
chromium.org/

You can then look at patch #1, which had a Message-Id assigned to it
by patman (by simply adding a "Message-Id" line to the patch file
after git format-patch but before calling git send-email):

https://lore.kernel.org/linux-arm-kernel/20230504151100.v4.1.I8cbb2f4fa7405=
28fcfade4f5439b6cdcdd059251@changeid/

You can see that it properly references the cover letter. Specifically
in the raw message you can see:

In-Reply-To: <20230504221349.1535669-1-dianders@chromium.org>
References: <20230504221349.1535669-1-dianders@chromium.org>

-Doug
