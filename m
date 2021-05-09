Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F45C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 23:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC9A61152
	for <git@archiver.kernel.org>; Sun,  9 May 2021 23:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEIXIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 19:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhEIXIG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 19:08:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F9C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 16:07:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m11so4156133lfg.3
        for <git@vger.kernel.org>; Sun, 09 May 2021 16:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XcoWEBRH+X4ydY5kpuPPd6EYYHLTYZ4O8mEat/8cXI0=;
        b=kSk7J0pHrmxvu+hXkJcdR5YYLux1JToYNLvEA0qKiwXXcYs/WTJvvvsxjkFaB9AJqb
         FPxUsqFCd9ViyVa2ymhyWMKKTyiJx5BpgEMFA0X9PO+1lNDZ7dVPt7MJUan/uX+Nt20a
         SvmMrwctub55Vj1c3UTQPeVfrXdnyd7CT5NAWaJhdRzSk0IVSIIRam3l8j8WVznChSUk
         QTSBsT4ydINfEuFmav9H3+/nn3M3RtffmNyx+Q7PTfRoj6YsZTTSdqYU3Ig1UlVxuINO
         h6mHQJfiYWlD1wjXvgE3uBxlQoq8KttGvgkgNE2duDrCuKxytVCfhSpUrh+en36O26eJ
         9vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XcoWEBRH+X4ydY5kpuPPd6EYYHLTYZ4O8mEat/8cXI0=;
        b=hT6iZLLrbexqglVJ4bOZMPKEEzKCrYu79up7k3aBLVwA14sRo2nTBmk0BvesnfNMBN
         LnKvGB1q4qCJnXrJ3HzALp1o1Z4fmNTvCOdQYC++Pgec7gKyxmsxNBwtLxt5W5yscDNO
         5Wxv11tCtWWslIMmggU/AfbnVxIn5Nzm1ER+k9mpAseQBChM+rDOD2SNmM2Z3tTZG48f
         TFFC4JoQrH3yS8MQaeRBYDmTIpnr+gfTWJqUSDiWSzBy309qpnBAc+WJZ59o+w673kBZ
         s/0I83WSTRMuoZWzSCdCjXyyyvgdif1++BlSFOr4TWxBKhr2e1NaT3W9dZI8gYOuQZXn
         sJmQ==
X-Gm-Message-State: AOAM530FrcjbCNhNltphDhkDoVHjDmqWCkG8MoZI218jc+A9Ocf8C94h
        aFexGF2BzCEAOTYiFnEpc2NvLK62ojh7D7JM0hk=
X-Google-Smtp-Source: ABdhPJyMdVRq+fQKCGhZRN+wEX3mJwhN7Vag7OBdRXLRJaCeBxM5i4Bt7ToIWM+RK6r3PSR/NPj+GHyTsXODFccRo18=
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr14832953lfn.148.1620601620538;
 Sun, 09 May 2021 16:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210509212220.29557-1-alexhenrie24@gmail.com> <CAPig+cTm7rW7V2DasW2XTArHAY_91rxxm5QaF31U8rB1ZLXOvQ@mail.gmail.com>
In-Reply-To: <CAPig+cTm7rW7V2DasW2XTArHAY_91rxxm5QaF31U8rB1ZLXOvQ@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 9 May 2021 17:06:49 -0600
Message-ID: <CAMMLpeRFjHNCUqzRhJZDuUA_CxsNvR-gn4-Mb6kmNQSZ4L8y6g@mail.gmail.com>
Subject: Re: [PATCH] graph: improve grammar of "invalid color" error message
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 4:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, May 9, 2021 at 5:23 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> > Without the "d", it sounds like a command, not an error, and is liable
> > to be translated incorrectly.
> >
> > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> > ---
> > diff --git a/graph.c b/graph.c
> > @@ -95,7 +95,7 @@ static void parse_graph_colors_config(struct strvec *colors, const char *string)
> > -                       warning(_("ignore invalid color '%.*s' in log.graphColors"),
> > +                       warning(_("ignored invalid color '%.*s' in log.graphColors"),
>
> Another possibility: "ignoring invalid color ... in ..."
>
> Even better: "invalid color ... in ..."

Any of those would be fine. I don't have a strong opinion.

-Alex
