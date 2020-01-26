Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3055C35240
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA4F2075D
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 09:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WRWhJSqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgAZJaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 04:30:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:60991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgAZJaT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 04:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580031015;
        bh=ri7q2Q+k3u7RukqxHcyFM6SdVv9vyFpkF9xrbBGb7AA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WRWhJSqI5Urq4cq8TVLUxfCVrQhf1gsNUMicAmwRilwgvMhxbXDl90NhpsSyUkv4A
         wCW+PAEF6E/f1w0uZSbC+8ZRByKtXp96cG/qCsmcEQ3+KH1V1VxO4TrnpAczX+HRK3
         3XyfPXhQOwV1sZs7xWbqIo7ScdTVptfKoG/7uGlE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1jbopY1Wxf-012or6; Sun, 26
 Jan 2020 10:30:15 +0100
Date:   Sun, 26 Jan 2020 10:30:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bert Wesarg <bert.wesarg@googlemail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/7] remote rename/remove: handle branch.<name>.pushRemote
 config values
In-Reply-To: <055e52dd-9349-697c-277f-abc9ac8ae85e@googlemail.com>
Message-ID: <nycvar.QRO.7.76.6.2001261028350.46@tvgsbejvaqbjf.bet>
References: <cover.1579857394.git.bert.wesarg@googlemail.com> <9c2110eda64ab7bf0cb780dafe1f13b28fee5ca0.1579857394.git.bert.wesarg@googlemail.com> <nycvar.QRO.7.76.6.2001250142560.46@tvgsbejvaqbjf.bet> <055e52dd-9349-697c-277f-abc9ac8ae85e@googlemail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FraTZOvX0XuLN36du/pkncUF8kbcIeKCuXWVHcblnrwjwBHdwow
 QVktg9ilSNuMWXUZDc1ASAaBxbx4DtAMnenxN4Z2LvzqzmqmYk4VXZa27QYMYWjvsYkGq7m
 lO4qEsHJDTpQtrxQ1JQvL5cIsZa7+PvGXJ3MB3tTAgMV40W6reXcK3WJlaG0KdOu0Pu+Fk5
 qyzKWjQIVpTv18JTwtnoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FXMEqyTESUM=:/hoLxuXm+egrellepHuQkE
 l1tqk8YeGVKt82lBEFb4SEXz1Fhs0HT1dmqx0mXM+nhoW/yTYW4rcYGww4RGDfPUKeq3ri5BK
 Ka1LvC0yZoWsbmfq6qDmw2sFcgwu8yCpXPXjmkLmbi5/th5ZOh1ujgTBAocez+9wYVwiuG01/
 q8XSnP+oWZxaxnPM1aVOa6pDnJOuRJEnAqIAVBBEUgB6i93qemG4lVqTFdM8VsHbF7jqm0rnP
 CWe/CP7u83GfrI35ZfsgwRW/dBDtN33q2ZL8vXN91kEHsKcz6T9DrwTTOTLKfDfT9tsjBIJs1
 tHU/srNOkEe1KcxtLhXaxjqWyI53gzG5xt06uSg07kM2hAIablwkbsj1p9J4tReq0NVwR2eay
 UObtti+1JNGXrc9X/8rb6IR+CYW/dB6ds4GPcRS2NzdC1lIWS6q08GBrGTvxRtW5GU55uYOj1
 z+ZnwJ/LTFOLp8NqjFgacivfXqvUa3VVOuckhtYlZsZJ2fg3WO3Z3F1F+p/zEt7iuj1qdNpCM
 qI2UssOf9xzZe98/5OUny9kgMZb+EufVQNkys4YYu9jhkSp0hBtcL8y7vMiJyPvr3RBMec9Iw
 bs3whcsAzri+gMn0KeeIdO2Qj0ajbV5LwITdXv+GmuDbq3sZ82Bt2BtDH/McxmuWK5epN/fCN
 PXqzBOXAXwTmLaiFbv66IIo4Lvxj4S1SzQ7+Pdktxd4ZJ7vOIsaohdD+xAbRcU6cS9+U2uIsa
 tOGuuIWfnpRTIl9dTB+rYt3un7+CsMAnW6m8NA26vv8XHHLuRHILnKOQzfY70bdhlu7cnvBQK
 blcl0IYvIWtVK5P2t6tBm+fNPGMXxk5U/nPHAD/tK9rfHKdQg4K6sfbjowE8WxbP9YAkyFB6w
 40+yhkTCnFD53u3z1vgfQLHmB5lJjDqrJoZAHfGOs0ii7QbcCW3jl8FbEuNKLixDFxlzw/eB5
 8ngq3wjUHL5w305D6Z+YMXrL95J2qWOkiy8JRgKPE+t72S5qxxCXG5Sz6vUsZ2s7e+yz4N1ml
 LHm3NQHckInOvbumV9wqYjjab7hQmg72BWIVOkmkhabrpyPMghJW+cEYKNER3yyXSdNatb7uO
 HCXWBM/pZWaSD//MOmgGdGoWVNrEBorvwY6Gqrssf6TIJXSfEXnw/8XQ4tvQ50H9lyR9e7V2f
 W/keY9ZaXrQf7CyuV8kJh3mY/Nzgm5GRa5tqXepG5omqfI2zasTneH0SbGVJ3L7TVQ2o+WcVE
 CyS8S/ml7NXp5/1WA
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,

On Sat, 25 Jan 2020, Bert Wesarg wrote:

> On 25.01.20 01:46, Johannes Schindelin wrote:
> > Hi Bert,
> >
> > On Fri, 24 Jan 2020, Bert Wesarg wrote:
> >
> > > When renaming or removing a remote with
> > >
> > >      git remote rename X Y
> > >      git remote remove X
> > >
> > > Git already renames/removes any config values from
> > >
> > >      branch.<name>.remote =3D X
> > >
> > > to
> > >
> > >      branch.<name>.remote =3D Y
> > >
> > > As branch.<name>.pushRemote also names a remote, it now also renames
> > > or removes these config values from
> > >
> > >      branch.<name>.pushRemote =3D X
> > >
> > > to
> > >
> > >      branch.<name>.pushRemote =3D Y
> > >
> > > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > >
> > > ---
> >
> > This commit seems to cause a failure in t5505:
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D27833&=
view=3Dms.vss-test-web.build-test-results-tab
> >
> > Here is the excerpt of the log:
> >
> > [...]
> >
> > Could you have a look to see whether the code or the test need to be
> > adjusted?
>
> please ensure that you have v4 of this patch. What you see was a bug in =
v3.

I was talking about the current state of what was merged into `pu`:
https://github.com/gitgitgadget/git/commit/6f032056fd7534b8efd712994c02531=
d83ada957
(note the red X indicating the build failure).

If you already fixed this, and Junio merely has to pick it up, all the
better.

Thanks,
Dscho
