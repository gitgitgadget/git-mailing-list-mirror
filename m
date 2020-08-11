Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A5C433E1
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 04:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08D820772
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 04:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEjeH39M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgHKE2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 00:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgHKE2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 00:28:46 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F126DC06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 21:28:45 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id i20so2354283vkk.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 21:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qZKOF8RShuTHiEaSrGS29vdyPyrBh2dgr2TqCv3ydao=;
        b=OEjeH39MVeKCBHNc5h7/2S30Kp1tsBRah86vHpR9cUHp87L1CNke1fMAkCwOLpHqXf
         HqMPIYaKc+AGSIjf+8HFmFalYWBl+BIlcD2LnKR7OcEv7iOSjMl0ZKsuO6To9zxWyfOg
         Vx/wxn3VwuRCU7wCVywE4oWrKhgAOc7SrjiMIfBoB+x188xTu1HtafTiAjOC/ljUXGHE
         SKg93Ypxxt1+2SNahWAT81SmXGIeZt3CsLNxWKbasOlThjTOyWF4xJ4CscPvkPOzgsif
         pnVroqHnYXYxnuXTOe+n5QRtamf+nfl5o6nPPknt32ucmZCtgIvYXZgdtYB5FOGkxnoD
         hnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qZKOF8RShuTHiEaSrGS29vdyPyrBh2dgr2TqCv3ydao=;
        b=Kegm5WJ72p4ORSb8ElXiHxaqTXh47L6Of2FejiIqb5Q26wdlfRBKTqSBRiF4zXSUcs
         n6yqx0fJz0XGFJVvOQ754J5PIvgj7OS0x8H+rDlFcCkwa2RNfGHXvOAyOZ3cBFcYCoU7
         i3b0GHZX3CyNdvw7lsfyMrr9oE+z4x9nMW4ikeqQ965KSSN+ea3MZ06SIRMw15rv9F/h
         btXSXRGHbJ53aNdSG64CTTHv+j+R2LHMOIk5KDy77grlIcjebb4bnUFjZ4+YKppfASZR
         skbpJTZpyogaJgFapNhS4luQQ1Ff5MZaoqs9jCYqC6MDrhRs34rsgKri10Vxxa1Qi1dk
         N0eg==
X-Gm-Message-State: AOAM532e5f0ip+bId4qlD4q/yGnakjzakhFvyLW2tTUvPpn96rAWlw+G
        cKnsm5Xizv506NvM4tK7mdoNu1AAsoK/UYD+fMk=
X-Google-Smtp-Source: ABdhPJz3x7OyH3DwpIwgonYYW6KiwVXiZG2oxGgzuJvLKX3cGcQvCSD00V4lDV+19TbgptfJr3mzP0ZYR2G5sQmjedQ=
X-Received: by 2002:a1f:93c1:: with SMTP id v184mr22675150vkd.62.1597120123230;
 Mon, 10 Aug 2020 21:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200810194748.1483784-1-martin.agren@gmail.com> <CAPig+cTsxAW=s1iXcK_-Kn+xiSNCm_u_o_Q2xm-0+a_v4qc5_w@mail.gmail.com>
In-Reply-To: <CAPig+cTsxAW=s1iXcK_-Kn+xiSNCm_u_o_Q2xm-0+a_v4qc5_w@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 11 Aug 2020 06:28:30 +0200
Message-ID: <CAN0heSotdXH50ssd01b7fFuqEuOs+X0f1Zpj+nhxuO=TRNStUg@mail.gmail.com>
Subject: Re: [PATCH] progress: don't dereference before checking for NULL
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 10 Aug 2020 at 23:27, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Mon, Aug 10, 2020 at 3:48 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> >  void stop_progress(struct progress **p_progress)
> >  {
> > +       if (!p_progress)
> > +               BUG("don't provide NULL to stop_progress");
> > +
> >         finish_if_sparse(*p_progress);
>
> I'm wondering what this really buys us over simply crashing due to the
> NULL dereference (aside from the slightly more informative diagnostic
> message). Either way, it's going to crash, as it should because
> passing NULL is indeed a programmer error for these two functions. I'm
> pretty sure that it is more common in this project simply to allow a
> programmer error like this simply to crash on its own rather than
> adding code to make it crash explicitly.

I'm not a big fan of undefined behavior. In general, I don't buy the
"but in practice it will do what we want" argumentation.

Before 98a1364740 ("trace2: log progress time and throughput",
2020-05-12), we didn't check for NULL in this function. Then that commit
tried to do so. It would feel wrong for me to say "that commit didn't
get it quite right -- rip out the check". Then, to be honest, I'd much
rather just leave it in place. At least that way, someone else might
spot it a year from now.

I could add an early return (instead of an early BUG). That would
gracefully handle NULL. Grepping around suggests there are other `if (!p)
BUG();`. Even Documentation/CodingGuidelines BUGs on a NULL-pointer,
although in the context of checking for NULL (as opposed to "how to
BUG").

> > -       if (p_progress && *p_progress) {
> > +       if (*p_progress) {
>
> In other words, I think the entire patch can be reduced to just this
> change here (and a simplified commit message).

I started with this, but then I felt terrible for just sweeping the
whole thing under the rug.

Martin
