Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2059C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4F823AC8
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgLHW2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbgLHW2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:28:21 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91DC061794
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:27:40 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id dk8so16383465edb.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ngBDcSkvVWC+3IGlGJ+Ny0DQ/VSqC8ZFxShcAqrX+XA=;
        b=TMFYSVuwnLaiqY3dauWKsrQo3n5Flp7pd63g9bceHafTbWG1mt3dkHqyH8/qsfqJVE
         lpb/5eyVjU83wTbrpKbzZP7nRo01+xNlyQqHrxhrLuxFKteOKoW6vwdHUr+oP7mpSlc+
         ioOsyq6Epn8Xtw8WRsxwtjNcddptYX1d2pqvwRwQGcxGDfrRN2MT3uBh3d+AfyEDLuh2
         OTodJrvbQ3BCq1SidJOTwnYQ/MbGV1Zv1o0JTl8BRgmb/u0FCkUv8q9m09kndOC3nf/8
         xpoi8U0yzuTmKKSroU3qP4VuUmmEmJEy4r+hu1dX7wLd+xlKHbua6bN9tXU/3LZbwUtg
         lXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ngBDcSkvVWC+3IGlGJ+Ny0DQ/VSqC8ZFxShcAqrX+XA=;
        b=Zq5LojcV8Er7bDaNRqGkBnh7ZnrfH2+m1h8PcrTR7GD/hw626+PUUCCUY1kotDRuGf
         w4IMRHg3VzT7r3JmNVYJCvzWvsi9yaTn/PHc5UqGoIA7YsB0JPfhzb6gcmT5ZMIYNvlt
         CILWDdnSBxbdw9XACCrbKFDQ32pUJz4byiyFOzesfmFgQnrFtwIWFcgbpeU8/APHTxE4
         UCV+PXyc1Z1DNUaHQ1jhqkShLHIUw5OM3GJQRHJYIiAeFjSg2F6e7YOx6fMEj8DfHOCJ
         0bRI4r/oQje+d6Gnda92+0a+U2mMOTSDtmPvVbRs736WCodQUKLiE9WqYd5GoSlUG+3a
         BXSw==
X-Gm-Message-State: AOAM530J7XvEK2Uti0wFflzLqyjmGIdpS4xFe0CJCkH56zxGvoiAh09m
        4qq+CcQ62ITX0XKd9FAiBZntxSjzFzjugnf8/ZROaI6aMu0=
X-Google-Smtp-Source: ABdhPJzGKBYhV1zqag4yvS5ikZQP6CrU8sxFpJfcqsaPuo0VW23LMgrMF6TIWxvRvgBe84RWhDG616g0oDGDs4VD4o0=
X-Received: by 2002:a05:6402:1155:: with SMTP id g21mr124429edw.53.1607466459142;
 Tue, 08 Dec 2020 14:27:39 -0800 (PST)
MIME-Version: 1.0
References: <63AC7AC2-5D32-479B-BF9E-0E5C31351A1B@gmail.com>
 <CAPig+cT=-nNcfrzjSmTXymhFkB22bPFE6QRKXqPtat2ipUdboQ@mail.gmail.com> <CAPig+cSEHR+S+y66zm5HFQCybtino0Ne=Z7qwB7tsc50pi1kpg@mail.gmail.com>
In-Reply-To: <CAPig+cSEHR+S+y66zm5HFQCybtino0Ne=Z7qwB7tsc50pi1kpg@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Date:   Tue, 8 Dec 2020 17:27:27 -0500
Message-ID: <CADtb9DwR4SQE7w9YmzpEgvvdt+wQYm5rQSC7nQ+mevzJOthj8A@mail.gmail.com>
Subject: Re: 'git worktree repair' can't repair when main and linked worktrees
 are moved
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Le mar. 8 d=C3=A9c. 2020, =C3=A0 12 h 42, Eric Sunshine
<sunshine@sunshineco.com> a =C3=A9crit :
>
> On Sat, Dec 5, 2020 at 4:22 AM Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> > On Fri, Dec 4, 2020 at 6:14 PM Philippe Blain
> > <levraiphilippeblain@gmail.com> wrote:
> > > I've had to move all my Git clones to a new filesystem.
> > > Several of them use secondary worktrees [...]
> > > I had hoped to use the new 'git worktree repair' command
> > > but it seems it does not work for this use case.
> >
> > This is a situation which `git worktree repair` can not yet handle.
>
> A patch[1] addressing this shortcoming has been posted.
>
> [1]: https://lore.kernel.org/git/20201208173705.5770-1-sunshine@sunshinec=
o.com/

Great! I'll try to take a look.

Thanks,
Philippe.
