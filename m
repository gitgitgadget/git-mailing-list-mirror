Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F64C433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 13:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596F961019
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 13:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhIZNTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhIZNTl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 09:19:41 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2109EC061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 06:18:05 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id r8so10224552uap.0
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R+2CSx6hxdmvajsCXmehT0tvNWUN843BuGSXL2bD4l8=;
        b=ADDaZPxNjOhLG6blSB22obQXrfdKvFrbAJ0UeBymd1UdmovNIG9P/hJV+m/GF8B3QT
         mFQJn3wjrxOm4AlzLZa9ap0AXaIRIeDuL7kSnuNJJak+unD/BY7p9hK8kRIuwiZjEppu
         wES/RKpgZYR5GetaoSeDSKXZkN1AmWGoTeU07b3x3mRTL0JuO82HOrEbnbz6LphMSUSo
         BQPE5wFzp+U4B09C2W+S2vrgPozbZcAdOOK3kTvduN1SrIn1FCgSQTXhF1XhC7k/hbTa
         xdAbi7R2+J9zGk1SLlfi4kURdl1t4UETg9o/M2kdk8ezuntN1mgkLG+mTR6IvBPDpcBu
         MP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R+2CSx6hxdmvajsCXmehT0tvNWUN843BuGSXL2bD4l8=;
        b=4HBhkCkmtbT/4Ye53dLK9vn2tLywzoZi4hjTvLoppO13uyBBf4Axxxocyc4xVpLfZI
         VYAZWgksTYX7NmDusGKEy4sr7cT46lrYtFOb+mNCiIbd/8MyqWKUwjqdh/Dwc9Eu2HTN
         INtKazzGq6P/fkXEwA0hNLh0Njyr0Z6g39CSVwwA0MKAGEJuY6T1PaEY+ZtRTKC3B3C5
         xS+bXfnmu5YRQdM0cEqHY85wflTez1hV5ko1mfnn5X8CUmEq3zULi2DuTbu1S5ImDdNj
         cErduTbAjse6quRlfLiBCpdqWd2DFldip0QZo633Q1a8542ULvgzGKhX0BK7/GIpJeR0
         m99A==
X-Gm-Message-State: AOAM531A+gerK/stM4mXYaqaMU0cHmJQODFppDIEe0nnJ9/6X2NJVOMR
        hlTdua9CGvHHMfCrAPb3rRYfj6qb0sU3GPPDN2k=
X-Google-Smtp-Source: ABdhPJyxyyF4h9Vt8NHl57lfvxY5AuwU0xdSCtxY882DzvMhnq2yfhejM02n5qYAKSk2vaUvr7WUAsQNwyfEl36gBmc=
X-Received: by 2002:a9f:3852:: with SMTP id q18mr15189355uad.79.1632662283562;
 Sun, 26 Sep 2021 06:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAB5AetcMK6=yZh4OY-0A6x6vs7X+0_1APfp4cCP_MSK_TO46ow@mail.gmail.com>
In-Reply-To: <CAB5AetcMK6=yZh4OY-0A6x6vs7X+0_1APfp4cCP_MSK_TO46ow@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 26 Sep 2021 21:17:45 +0800
Message-ID: <CAOLTT8QqF-4rRiuWwntA3TfauCfc-MKingPQmyuKw3r5zf7O3A@mail.gmail.com>
Subject: Re: BUG: git log dies to SIGPIPE
To:     Joseph Jenne <joseph.jenne15@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joseph Jenne <joseph.jenne15@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:47=E5=86=99=E9=81=93=EF=BC=
=9A
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> used `git log`, exiting the viewer (`less`) before reading the entire
> commit history of the project
> What did you expect to happen? (Expected behavior)
> normal exit with status code 0
> What happened instead? (Actual behavior)
> git log dies to SIGPIPE after `less` exits
> What's different between what you expected and what actually happened?
> git does not exit normally as would be expected
> Anything else you want to add:
>
>
>
> [System Info]
> git version:
> git version 2.30.2
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.10.0-8-amd64 #1 SMP Debian 5.10.46-2 (2021-07-20) x86_64
> compiler info: gnuc: 10.2
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/zsh

I may be a little unresponsive, I also saw this bug today, and there
is no such bug
in a small repository, it only appears in a large repository.

I now know that it comes from outside git, this is really bad.

--
ZheNing Hu
