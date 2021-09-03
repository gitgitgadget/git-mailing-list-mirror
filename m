Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDAAC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FED610FA
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhICPYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:24:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:33389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234053AbhICPYR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 11:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630682590;
        bh=uS8wkJMc7BG27sGHQ2NhJmEjbpmxkJpxOdQOjEOrwrI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kka9STmL8fj1Xd1tI80eq4ng4TuZvYbs2KKOae+gOlyOmr2Z9T1gk8H+bzXES+nbJ
         yF7py58ezcZ1bVnMaWORVkpVkS7MpbHL5ceesQVWAvIZ70FWKYkvMbk/us6XO6o5kb
         4URuTZtO/jh0qVWeEBSSS9rMQVylXc4qPwk40Sik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVDW-1mg2GU0JSq-00Jts3; Fri, 03
 Sep 2021 17:23:10 +0200
Date:   Fri, 3 Sep 2021 17:23:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 12/15] scalar: teach 'reconfigure' to optionally handle
 all registered enlistments
In-Reply-To: <CAPig+cTG2+A0auFYdu-PHBVa1w2A5neS+6JQ5m+ADaOBq8vzUA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109031722460.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <732a28c22fcecafa308cd9444efe9158800b94e5.1630359290.git.gitgitgadget@gmail.com> <CAPig+cTG2+A0auFYdu-PHBVa1w2A5neS+6JQ5m+ADaOBq8vzUA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:A9/ZshzXe3bDZTcfpoNKz39Y1JQ/9Mji5V4hBJYC1a1OWC4R2L9
 LsG+qHnZF2WOqgoDLXcb8AQwFQI31zq0tXABLMyvJCcjkVmsPEIgk7DkqQucDS+Esc4F0Ph
 5RrKvznK5fLCUykeFB5zerL75IUUzN2pKKhdJOX3qHhk+2+pK2M+4je24nTcASTk+Myps7l
 3m93rmDeWd98wxm4HszQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AAI5SwCImOY=:HVkQJW/iaXn3OBG+/7KChU
 3GkqJ/kT8t0Dla7hptn93dqTcvKXBI3GKPWS7R3RzIfTKGEBwcZmoVZw1+mWxxa17JevebUnH
 lOkoWD3KFWnAHCr8n1SBxSDAmO3u01Si44Sh1lbxjrxPvP4ABptSTHkZzK6Uc1nkjyM4vbNOs
 uL7XjYVPE6Ht7J1cMIxYs1/PcWsrsvFjoIzUPIcWvBRnQJO/2DAc3P/1bNhDoeG2cGPgVx8im
 C/bPeel1AB40Hi6bgEkpFeIAhOcnc0JxXGZGV23SQ9roH1WrVt20SKtpaVoyOsIxxtV1DTg9w
 ycA1wX1lUqSq+R7EZcQUuOuefNbaBRXj0MtRyZmvSgXHQWi22Z4HsVtm2mggQJIrCi+p4p9tr
 V3TsOktzOvZK/EcW+wjPh0SE7FurYSqzM4rMfIQvQsN56hEkSJFKNg+aG8Hab/h27HPbLrhpm
 OcL+E2geAkB8tI/+nGhw/gCGYuyOsC6lEGJHCJATu6eFco+im8boNzSxk1zuHVh7JhzyNUmAi
 gL+EGOwa0a31s9e7YN/+fg+uvQo7GmjuXcd+6M3V1WmD+qEaQkcQxKqcv0VXFPSlxXqBfDHml
 uJlgeXlDigjWiCe3+P+wMIv0QfAHxPDr31XsuTYcgL7oHvtGZlfqXoOA7SqXPj+3fEqFyMsjT
 joMAnnCCeJixsyEp36nL6AhS7w6K5zutw0Df0/pVm6hfNQ0ejbzcQgvhn47cH5qqgGkWPQSIA
 695csxwg5ETNOdr/80z4hEjEH7te6UHoIBxrvt0B+z+He0J5OiawxYl6Dywk8JjHdbcmfZSmE
 Eg4aACVi/z+YyjwreuCvlLxTz4IN850MndZDyXOxBPHEqV/E1xFSqigrYRktunNsBy5ik6vYk
 y0U9UvpKKDowucG6TskrbNP/bahzbAJ5PASl/NpmWyreasuBW+5/Ku9967MkxKuKLOET/alS6
 cDk0lGBWofX9eViOY+Ep25KbV9yvW06HFjtNTmrIA/wUDnfuN6XGNSY9q/d1Z90v8kojJqaxu
 DoUArSJqi7tdXFrvgnyYWdPNQld630SM3eVs9bKLxew9/CXGCKWwE1w/Aql1RjXZGJ+on9Tpn
 3dq4hLp2nU4mPOju+s6bc/JkwKOXsybipWIrx9C7kBo9j5vciCySzViZQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 31 Aug 2021, Eric Sunshine wrote:

> On Mon, Aug 30, 2021 at 5:35 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > After a Scalar upgrade, it can come in really handy if there is an eas=
y
> > way to reconfigure all Scalar enlistments. This new option offers this
> > functionality.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
> > @@ -121,6 +121,10 @@ After a Scalar upgrade, or when the configuration=
 of a Scalar enlistment
> > +With the `--all` option, all enlistments currently registered with Sc=
alar
> > +will be reconfigured. This option is meant to to be run every time Sc=
alar
> > +was upgraded.
>
> s/was/is/

I wanted to convey a temporal order, so I changed it to "every time after
Scalar is upgraded". Okay?

Ciao,
Dscho
