Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45331C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F97920728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="W2BjmCIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgDXWaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:30:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:55127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXWaP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 18:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587767393;
        bh=D0qApv8abD2Bn55bTqaGTtgLXMkARuhJZ7cCNqKr/6g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W2BjmCITMQb2S4TiJHMUrKpnGw2QPJ3UDq3dx5PX0bMRtH3ixFhkYNFzrCT0b/Bok
         gwXGxEu6NrkuFf9eC2DnVXoWMhROWf0ZxMxkv1s70R4uNKy/F8ZhQoHutfGAHvDChE
         JXnx0WFUkY77Q4yHtZ2l1oAMoExjFI7acUNsJ8M0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.1]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MFsYx-1jQAM22UO7-00HMRM; Sat, 25 Apr 2020 00:29:53 +0200
Date:   Sat, 25 Apr 2020 00:29:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH v3 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
In-Reply-To: <xmqq4kt8bk5r.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004250027550.18039@tvgsbejvaqbjf.bet>
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>        <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>        <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com> <xmqq4kt8bk5r.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lAzmYk1I9ma4gHjT5DNoiBPRuyvi3LMkBSP9VQ0UiMWpo/A+Rsa
 po1l/y6/dXG/000Mw48sqaIIhGFB8Y5+06HXtfJI7s+nkGZ/TtDLHYKg/2MFbr3HvOcW+Ek
 2G49YFQrMpIw+gReZh3us0jIQj4emzFubptnmJNwFgmmY8KPQXaWYaKQcvNUlpjtO55HvZr
 3Q4fJoamQVP6GHTWwrlzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sWz9w2DcPJo=:Lw55MRmIwGhkohKUvm6UDY
 q1Z3CiAfgdovlMi5rb6xdIVL5zV57y04ys8Rr1vI3Pva3SnzpMtsG/pBIFjQ69JBY4X7qzCIu
 OfPN0GjVnyruACajIbhpthcOXq5E36s/CFT4aIl5PjNmtRu7OwTytN1Ywb1V4JQWl7PFzneWc
 byQCxA00BOk++wOD8MnWTW5w6oCXs9KMgal0LLMQS30W6GsGmadDnxX/pfK7rB4At7UXNNJwI
 +soTdll3R8hW8Az0mRlAO7lWpNv4WJ88aBx12llyMlaDlgR+A0fhmbEjdCpLVmkV9MDEC8+eu
 cv0M2uWET/E1ZwaHSQ7G8m/gNG4E/MHfl6SnhBk4Z/Zbm+9We8TKOOWccEiaEKm391Za9gESt
 7hG+G/q/xm9DeYXIU0PH3UyvLKxuj5YMfZlV5kHSeFiXJ3LZ3KFMgPkq5aha8bW2M1jgDj+An
 /Yf8DlaL2Rrl4E1O+cOgvB3eXCqr9A2ePyZVKTqM1JFI/bywserXL+67iJFUJ7wLs99NILavB
 JjWYcf73nZZDw+zXbtXOKaY623avT4dG9vbtrH09Q98YRmcbaOpD0idxPisQvxUOwsos+b3FV
 kwjrP38E+gs74qA4alZN0KlYKB9AdbsapF6VUJunoPhCDRcSuSWNK3GlzVigp4+K/drXZBZz5
 5DinsLB2mkCewWukX0vhu4AeQRN7sg/VDE0xMh4XRh+qqhla5uH0EGTvR0C8GynGnfvlaaBBt
 71M8zEVy3Yf+zh/OHpeOLPFZ64JKVESDkh+g7jJrCJHQ4WE0CHM/gdQWuz3OvGz+hHBFvS322
 YEMAF8nPMhE9OI2pc/ETTRn8jkeitPxI4QXqt+Nc9RCM/94XIP8etKbPS6Wxm5gLNs0Zr5fRV
 09Zz8qa2oy80nHVJOWcMCB3kA2NW3QnGrvu0L0OZxlzSoNVjeTdM3SlTW/kFYQ9M1GT/JHz2b
 s93Plqo9JT3os5Ez25TeDl+amz+WpEWHG2K6DvMZR0qEp4nJSVh00pn45haOXbrEnLaP+dEGT
 c92d56yXCe9KL7IyrsHc0Kpj5IdDr1yBVzx/xgdGzmAPOZWx3mOl7dm/s/M4Y4YoU8X3xfYHG
 fE5tKITuJOaLCFLfYVH0lrPh385HVZRc/7AuXCBqCbaUCMMk71IVu5YX84HxU/E+lOJWlL9Go
 1M3TAZsYm7BclnTW3QtT9P1/BMQKD5nlid09DRLSS0eZH/O3bIGQcgSeivOKGQgLcP9bBJ0IP
 wjIjQXt0QSNuHTFTv
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 24 Apr 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > @@ -53,7 +57,13 @@ static int credential_config_callback(const char *v=
ar, const char *value,
> >  		char *url =3D xmemdupz(key, dot - key);
> >  		int matched;
> >
> > -		credential_from_url(&want, url);
> > +		if (credential_from_potentially_partial_url(&want, url) < 0) {
> > +			warning(_("skipping credential lookup for key: %s"),
> > +				var);
> > +			credential_clear(&want);
> > +			free(url);
> > +			return 0;
> > +		}
> >  		matched =3D credential_match(&want, c);
>
> Unfortunately, the whole section of this code that is being patched
> here goes away with 46fd7b39 (credential: allow wildcard patterns
> when matching config, 2020-02-20), that delegates large part of the
> logic to urlmatch.
>
> Dscho and Brian, how do we want to proceed?  As the conflicting
> change has already been in 'next' for more than a month and a half,
> we'd need this "partial URL" logic build to work well with it.

I prepared a PR: https://github.com/gitgitgadget/git/pull/620. I do not
necessarily feel 100% comfortable with that approach yet, but at least it
lets the new test case of t0300 pass.

Ciao,
Dscho


