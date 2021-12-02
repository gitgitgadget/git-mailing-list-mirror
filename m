Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3FEC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 14:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358778AbhLBOwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 09:52:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:33039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358789AbhLBOwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 09:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638456525;
        bh=4L0ww1wycu0CgWAYiwXRtIqLxLyG1RaSNK0wZHkoVIU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bnKhO92TmIbj1cCU2GrQCoO2C9Ju3Tf3l7MV6ugSSulUiKPkVG4lPl9uzMtPsuCK2
         J/Y8cVZ4IBsAAmnlyBeMlk5PBHl0v3c1xbelxpCRXuLqQK/YVg4zLSpdq6wFpBruVb
         F6i40j10j91wIR/nY6pGqbVA70ldMQIYvEibWNc4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1mJSZR0N4i-00ZQW4; Thu, 02
 Dec 2021 15:48:45 +0100
Date:   Thu, 2 Dec 2021 15:48:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Chris Torek <chris.torek@gmail.com>
cc:     phillip.wood@dunelm.org.uk, Carlo Arenas <carenas@gmail.com>,
        Git List <git@vger.kernel.org>, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using
 a tty
In-Reply-To: <CAPx1GvcML9TvmP1BSLN0vKWD++8LBj-68Xwmz-KrZM32Q=0_Ug@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112021542390.63@tvgsbejvaqbjf.bet>
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com> <20211122222850.674-1-carenas@gmail.com> <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com> <CAPUEsphP2GRaHJa0Qnvf22WUnNB+GnnfG8TgHqwJvSGdYfUQGA@mail.gmail.com> <7138fa14-02b2-b123-4d8d-df73763f8431@gmail.com>
 <CAPx1GvcML9TvmP1BSLN0vKWD++8LBj-68Xwmz-KrZM32Q=0_Ug@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rRgujVSM1ostdFX3nLXikvjg1Pu0uTsVeMs8CwcjtNiwYjbbvpH
 DZ4B4QfpU5xXgFYr7AghEzwhFqPc6Nz8ySSnTXjIeORoF22c9gHlS2QxgN/rdizTmyA4s9u
 IlAZozWK8NGG2MDswETVxNb+t0nI7Gjc7Rhwf4jhoAcqvAakCBRleun/9Z5PM/Hq/MCTk5y
 +m1pe26wth4BWB394lwUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UpESyul54IU=:o8gQZtXpfPjQT5RJK/rc6k
 TVIso1IK/x3zoMxFMpR1rQnnccNkpyXeg/tLbeGk8LA8PzP0Rk1wnlDGGgI3elXW0c/ssssPC
 4c/ZZ8cqHJT43T/yIrHnc96gqwxw0FjAQhm75r6HV/E1bMausAlXnfb6rXe9swIgFwuiwy8hh
 Jl+E4OuIspVZ44B4OtmQkRrG6MO21og39FQ5LQJ6yC/lqh4W9J6C8wAvzbl2iY394JMOCGr6V
 b1JY/pCpLcuCnGnMV/6IxKzgG82nefpGzOvqlfaRTQowBdT1c00cZcDIG6hrQ9qgZtmS3TBDL
 oCECtTGnepso/ZdpIIl7dU1VKd4x4/9NjSdW/dQJe4ySrUpOl/daB5EoJrKBabErDkVkBxkcl
 z7CbSEMqh0S5xGgwtxKxKcBx86pNNILnmvqx/q6SurHgwfZ9MtYem4r0owAZlGRlPL6gZa140
 LVZQM8YAPNt5hR16GAIr8E6mhO5j6chnZc/f9YR9LPwonxw4YWUaebsiBs2tIn4EFwJy0Cy4S
 G1/bOKy9YQXSyQ4c8hsA567MDclWRY2d23FXqSYWBKTvGNvE2pe1J7XFv1hc+QwG4Nt4W1fPQ
 MB7vd1aIUGvOewAb4Y1quVe2bOaUse0dib7yqhqOCngBItY8eYTOqy8/KBTAaEi72EIYVq0f5
 V5W7WtdGRVbdn/faVA1gI7qK52F3ALLNOoc3VklbDk4Tc7bfuWvT+6doitMf0ufrN+hC78/KH
 OsfV3SrbzyFLDWvw9cALbyJ3fAQXxo+YU5WwPdPrQP78mbaDqw+V6YgWrjOCb0dmdniIUdfz/
 nyU2ND2HPEZSW3CvaqpHFYEwwTvkYKZ4QcQWVobH7Iu8EpB1uu47LxWPQQzjceT7niG7lg0gu
 gBWkQ4MQb0eM7t7eKbJHJlm2VmR3eYsqi3uHMQyFs27gAC9D7xKg7gn8GCJfnovMCFBPSuMG2
 6NVa0IIsvE2tLKSzPLe+WgQAYHpfO1kAzIUVPyCuUBp/EnteDLDIRrQoCOBMjszWpWEykPpdF
 Jz4YI+5Ot0AaQ5KeyBrLbtBJYKjrKklYZ6zOPFHq1Ag1dlOODHlQDHlqJ+dRZzwaI42GOS9Ql
 mDhCjYLIX5VULU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Tue, 30 Nov 2021, Chris Torek wrote:

> On Tue, Nov 30, 2021 at 2:41 PM Phillip Wood <phillip.wood123@gmail.com>=
 wrote:
> > On 23/11/2021 17:31, Carlo Arenas wrote:
> > > Restricting this feature further, maybe through a configuration
> > > property or even special casing the EDITOR is also IMHO a good idea.
> >
> > I think just doing this when we run the editor may be the way to go as=
 I
> > think it is only that case that can mess up the terminal.
>
> If it only happens with certain versions of vi / vim, perhaps Git could =
come
> with a front end program that saves the tty state, runs vim, and restore=
s the
> tty state. (Or set this up so that the program can run any editor.)  The=
n add
> a FAQ entry if needed: "if your editor goofs up the terminal, insert thi=
s front
> end program".

Putting myself into an end-user's shoes, I would much prefer not to be
asked to do extra work and I imagine that the millions of other users who
go with Git's default editor have the very same preference.

Just like we default to `LESS=3DFRX` for Git's default pager, and just lik=
e
we special-case `less` and `vi` in `git grep -O<program>`, it makes sense
to special-case `vi` when saving/restoring the terminal because we know it
helps users.

And by "special-case", I want to say that Git should provide a paved path
to success, not a workaround that users still have to configure manually.

Ciao,
Dscho
