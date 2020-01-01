Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0565CC2D0DE
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC202072C
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 22:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bWV2B7zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgAAWB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:01:26 -0500
Received: from mout.gmx.net ([212.227.17.21]:37599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgAAWB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 17:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577916078;
        bh=8yKWJ4sbPj7UwR/5CDlT0MXk3y8BArsuv7j+rpNCwgM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bWV2B7zbnZLjrq6iDjgFqwT6dZKK4akVlM0z+TSKnzW/UvFL25XUxO1tZvqT2PoJ1
         tqBil3WktKP1uE7d5D6OEObZ3c5D7ooKXqKJjWciI7X4bR08goPnMyNUk1BulJvUk0
         Sp0ufsFfpkCFcv8LOG/gxA9aj8bf49V28rA25Ztw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1j4RSg2stc-00Hgq2; Wed, 01
 Jan 2020 23:01:18 +0100
Date:   Wed, 1 Jan 2020 23:01:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, plroskin@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] rebase: fix saving of --signoff state for am-based
 rebases
In-Reply-To: <xmqqsgle94o3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001012300430.46@tvgsbejvaqbjf.bet>
References: <pull.680.git.git.1576868036.gitgitgadget@gmail.com> <c64984e146e509a743c9adc7b61bf7b274103cf9.1576868036.git.gitgitgadget@gmail.com> <xmqqsgle94o3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sri7JwAj1HU0ykcRAC5lMlcxU1JyEoMuu/UaZqXHcIGKDlJjhOM
 36etu2HLhicwZOPK6ILQpe4i/bWNqWSblHUnBcY69yUmauEBIkBl4YIX/sxekh+atktqpIM
 CuxFMk7MzGlcDVlbNu6RfmQDsuHWv/jElyPOEwnMehw/VuxCix+3yHkG47NjMVWJVry78gE
 L5j7wsTVjVCdp4MpekuEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qdYUz9PLwic=:PgJN71XzSRmx74ntklTK23
 Pt3lfq5PshjIQC4/hyackoHugcUeQNNMex91wKkYt+/mh+hWnNPJLPrHM3vcw4xBUuheFSFvK
 dg1/oWhhb4idGFSaL0s9CE0qDmRnBoMUJ6DNYOX63g3Sz/ATsddhpB9AmnjRbuBGgsbRBzvAt
 GoyC/AzXJU02DQVu+JYmtwwV12rRtIMVBUeErUwRX36m8AWp5RXMTj/QDcNbTAM8wkVrjG2wz
 P8xyZua++n+Va597qwDnNa+zkfK/65rkdvajST4SN+u2xeI9lJpUg2gdx0Q0L8eUfkde1rjQz
 WJmh8QjaLuZwAlINGGI5KChoOJ9QJtkp/zg+HRqPXqM8ET0vmux0lbPms47V+tEFt69ax7gKT
 DBQUj1baHEGACrllt+FrSPXFy+OgM2ww1s9nAc2xsU73oC3s73VwUu3C1RbobZRm5VAABVjSK
 /XR6pD1PMnel46997sQRfWppJAIESpgJMQIBSWr6wQZJlShlikKBhd7btgjAKGLaI5O1KfoE4
 6vGZMGJSQrm8Y1IdD3pqr/YU/hzdfbhFgEDx3gX2k1EJsCO+qMj/xo0dI+4kYbjL8c5a/MMdY
 4e8AEemFE55Bg3yFN6+5DDhH5Mi8K3VjwOPB0PBYB09B/7iLFHTaJkMANCtTtCA/8L2IUFQ7Q
 D9LC9HN3tumKupun/a7i6VG0tlGFAww5BpujdMuEQRXYfdaDzaw5gCcVpR5B0kFK41KuLNCzU
 AWlu5mTKBwoNQsb/iDIXf2FyE170sf1g99Ersq1fJHKidakZz86v1BcVn1KaLSOfjgq22mgF5
 WB1SXk7f+fweDkGmmPWwVarPvL4Z4iTc2+6fokJnu2i4i+M+uIlnKo/zj72TfTVb/gkXtpKtF
 p8hg6ThrofrXLaBbiFpOSJklbegHsYOPbNMKqcGsAYVdhemY2bbAQ7GenuqzREbD+BoSUvnyB
 jLU6EF7pHv0bjlM7Bx9XwljsQOXXsMaDepfP8mkV4PERtUONFhkkJSdCS0vKzLo7DZ7dFTN8e
 gP3GfZ608D1RsnWjuXf1mKee2pbd8JON8xDFyd5JtkwslOihRLIIZ/Hwv/QtnLgYRMewhQWOb
 fSK8GihOnrxiofTFMDkpjGobqfUaht32SDHqNTWk7jZ5SUrlniKDdAjiTK3tMMh8bRIkh4a4g
 ZHk+SsWBj4Um7qiAIC9Sb1eRomldMb24X3OHED3vetbfNyhoyi6r7dAmRaxsffJEfRmAaLH0H
 IlYURsHr9un1SlpD+XrM2Ep09LX71izfQ6PUy3v8c5il6fZdEaU2z6nqAGDA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 20 Dec 2019, Junio C Hamano wrote:

> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > This was an error introduced in the conversion from shell in commit
> > 21853626eac5 ("built-in rebase: call `git am` directly", 2019-01-18),
> > which was noticed by a random browsing of the code.
>
> Wow, thanks.

Oy. Thanks for fixing my bug,
Dscho

>
> This probably indicates that nobody uses "rebase --signoff" in real
> life (i.e. where correct signed-off-by line matters).  But still the
> bug is worth fixing.
>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/rebase.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index ddf33bc9d4..e354ec84bb 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -706,7 +706,7 @@ static int rebase_write_basic_state(struct rebase_=
options *opts)
> >  		write_file(state_dir_path("gpg_sign_opt", opts), "%s",
> >  			   opts->gpg_sign_opt);
> >  	if (opts->signoff)
> > -		write_file(state_dir_path("strategy", opts), "--signoff");
> > +		write_file(state_dir_path("signoff", opts), "--signoff");
> >
> >  	return 0;
> >  }
>
