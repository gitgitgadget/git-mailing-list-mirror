Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1868C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 10:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiFFKqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiFFKqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 06:46:34 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21861CBD7F
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 03:46:30 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f83983782fso138747607b3.6
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ODLrLZLBph5Z7rDvot8jkGCzuwfgHGx1kinHoraoDbw=;
        b=Cpxq0fsXNnAYpOIt3FtSe8o+a+yVGZhQxMJgGhu4PuqWKkOzRMKIA7IwdSWuRqX4Pe
         WGV4233AmvFsb87+w/Ie2livujhh4o7Wm9OWdJ/WV1Me6Od4s088dzjztelmq4vSOzu5
         mV4IK6fC9xI043jc5uwXAErCyg9rgD027Z0C94H7tta9jhax3S8OB4uoWmqN5qCzNpaD
         PPL/nNN9qlcnYdLPUhEeY8+MvjwL9Pb6pwtbMCVg01R5QSRTHNQu/t+no08XiAYfEhJJ
         N0yT8pYMsZSUBYF0jZp5qAP6go/UCQSbxElQ8083JNK+flAeKrBw0rwth7dDq8IZxPr3
         Dptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ODLrLZLBph5Z7rDvot8jkGCzuwfgHGx1kinHoraoDbw=;
        b=p3i8xwU4gJV/1XM5ihQmXHv63wP1EcSnMMtUYUgmvHiDAHgj67Y2AuPi3YwwyPd+Id
         2FZa3hFqzA5ZVmLPU4ncEFAnXd7PstwZJq7lxGW9OY5+y0DUoIR9Rz/278BYmVr09wjb
         gs5cRk3vTpqih98p3/aUYilKO1+/+g1cbKgOsdKsjwOkpn8+z+mPaWx6W1WrogaZ9yiU
         l/U4din6rW8QKIewUgEgMliAGjNQ9HuBfc9+RKr8xS/oahEMEDkQlKkFoV0RqjT1xNrt
         oSZDXSz1advuAnJqbLntxl19QukJnTWZRhDoSgRV67icfzUCctvaFqeOBmmwq+2LpVJr
         uUMg==
X-Gm-Message-State: AOAM532xULyLU+SXIs1S0ma7mp5t2eIDGwtY58ztCKFdpnpcIfumWdlP
        7Dgy/T9E9eSxqVFi/zB2uhUb+6QDkJbBGw3iwY0qLMZq
X-Google-Smtp-Source: ABdhPJwTr0+/w8tWLImNXbWWeEvWGszIif7nC1QOuQlPDh9l8Dwz3osc8mULUGe5T1Ur3U24hnYN8aeHEDrq3ACQMfY=
X-Received: by 2002:a0d:dd96:0:b0:30c:4f94:956a with SMTP id
 g144-20020a0ddd96000000b0030c4f94956amr24787364ywe.466.1654512389340; Mon, 06
 Jun 2022 03:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8jHOhn+tNn2cR7X_fPyyLF-ADiScD2gymKY9H2ZFb+UdkJSw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2206021525430.349@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2206021525430.349@tvgsbejvaqbjf.bet>
From:   Benedek Kozma <cyberbeni@gmail.com>
Date:   Mon, 6 Jun 2022 12:46:13 +0200
Message-ID: <CAN8jHOiQZPxfPy2g5XfEOeayUqt345-Cosc3T_sT039KdgawRQ@mail.gmail.com>
Subject: Re: Bug: fsmonitor--daemon doesn't pick up submodule changes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tested the patch and it fixes the bug.

Johannes Schindelin <Johannes.Schindelin@gmx.de> ezt =C3=ADrta (id=C5=91pon=
t:
2022. j=C3=BAn. 2., Cs, 15:28):
>
> Hi Benedek,
>
> On Tue, 31 May 2022, Benedek Kozma wrote:
>
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > git status
> > cd submodule
> > git checkout origin/HEAD
> > cd ..
> > git status
> >
> > What did you expect to happen? (Expected behavior)
> > the second git status showing that a submodule changed
> >
> > What happened instead? (Actual behavior)
> > second git status also shows up to date
>
> I believe that this should be fixed by one of the active FSMonitor patche=
s
> that are lined up for getting merged into Git:
> https://lore.kernel.org/git/d0c8fecd1a0d622b1a6cce0aa79fdcdc2771db1d.1653=
601644.git.gitgitgadget@gmail.com/
>
> Do you have a setup where you could apply this patch and build Git so tha=
t
> you can verify whether this fixes the bug you reported?
>
> Thanks,
> Johannes
