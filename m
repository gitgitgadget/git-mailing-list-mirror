Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F665C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257E32071C
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HzEI8ZhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDVWvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:51:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:34997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgDVWu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 18:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587595840;
        bh=OWDrqXFHAeYDiFx8GpH9YaB/GKAFaLcwhygmBvmDIkk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HzEI8ZhVkpofqCKJXdH59QHTkUrxvKUMgCZK9Tnk9o2CAEWZdN9RgHf7stK/3x80V
         6vnGn9xg8HCjxBMNgU86RoJHLyjIPpWy4phitGx2V3n29aHwcM+g53x+GHGxEaooEo
         AQao6EyAuazsd80oR2XsUdCs/P7ryyUuSrZiNNNE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.165]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MtOGU-1jDQcD3ANi-00us8g; Thu, 23 Apr 2020 00:50:39 +0200
Date:   Thu, 23 Apr 2020 00:50:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a non-strict
 mode
In-Reply-To: <xmqqh7xbi28f.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004230042370.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>        <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com> <xmqqh7xbi28f.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+2ki2doGEry6lNxZlJOROtN0DJPTiYhZcs8dbC49g1+lG450TLl
 77tXKt1/jvSmvrN4coqas0ygLF/hPLcmGuzuhRUmWwnORQQtreE1D4j0L/57L4HWqbwbLp3
 Wr/kvl49nB+Dff9bZTNqDn6OvLhUqvdjNnIUn3jqJShueCPbLMoRzQQAaR6ZlC09it6+uVg
 EF0EnmMp59S5gn8+xdSqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OKeEYMSjxus=:320THGywk8cJ0z3PLTSebC
 Sene4HlFhobbXNye0C+R/cQB/Y6HbFyoNq2TLgEw/8+bLdxDzTAlQ94C5/clWN8hTTB8fJNnf
 FbfZjrUo04GDg2PJQckgAVbOaOeEvi+NK0yQdT/s6sjwWL/ziKxou6PhQkD7EGX9xY2/S5spu
 PIOHPcWOCoAEN7aVDpxXt82xnKymJlz6m31vggvwMQzvvXQjdFJrRwhW61rIVYes0tm9h/okx
 HOFXV7aByO8IA+WPWINh+HEEowQztObkf/MUJUEfR1EhZnTKSiOgOkQ6oLDs++XG3EPzAdRD2
 9ON9enmFYJPHgF/LtNuqylRNPcx/bIdCnHyoP2E4GpScGioD7HrQfeMr9fDXoYUUUvkZjzyus
 I4whszydORQg295THY1+v7+ruWdzy4U7zL5QLIOv/0VUAWFpgdIbkEI+cWeVVsZzL9+xd8zfd
 bEufyLuTEeUAz1avQ5amG9C4cJAZFR8Sj+eOFXn6K10XtN7XPNbMxjqgg8Nb+ToJff0R5aY6X
 VIFb51EkGKJeNP38itgUbI+vHGeLExAnqn1ndMT0czQfB3AX2T9IDhx07RFa1DM1VDXFY53Bo
 LknN64qOvjRk1u1oJCuJPqGL27QqulhgDm21Ny4IbwT8g5ndHVF0ukwraFjHkCN1HKXZtFqKe
 Zi/SRd3LncxsqO/TfxFJAJNJMbE9HHn7FHCsOk3sZNRlUNjGzFSaK1fcqSpMe/+kX2zj2mAnP
 wYg2gmWc4YFTfJ2M5n90EL9/7DNJORljMojdVhFs23Rd9+QT8EdFbdGJR6M9kziWEzdEcjDat
 3f2jyUz7R+t+NT5lFuCBRxfodcfdgJcHxv+j0VTD8NRBVaJ6aVrF1WZlVXHvY5kaD5wESyIub
 /HGpQg8mJm8crt3Jpen8u8ghr+tc9vD/OXzr3fiAz0FGZyyOvNYXiG4vfADktjTPGNuBJWGuT
 sxXtPLFqzybF8HuZSkhD+HOl7Z0slaX9nqab95jsU5APRPe5jtXIjX+sAKqPfkSzOU4qomHb/
 VvAYuEyhF5xAZKWixYvB2jeKWFftuIxSvAk8dxNSj5YtPtlitEAi1WlNKq3roF+SDApY4hopj
 Kp9KNSqvZCW0EG9wtwF9lLY+DG1dIfuK93vxSskWqbyFtA+AgyJDzptdt5CTv17hPixVPG89Q
 aO4Jea6rLtk11+Z7UuFOcX8aBW70h7rZGyT2TuyMdAubNRQYBtWiIf96ul9k4iKEJ2dOhUf+B
 BzRVxH72PWwmP99w/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Apr 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > -	if (!proto_end || proto_end =3D=3D url) {
> > +	if (strict && (!proto_end || proto_end =3D=3D url)) {
> >  		if (!quiet)
> >  			warning(_("url has no scheme: %s"), url);
> >  		return -1;
> >  	}
> > -	cp =3D proto_end + 3;
> > +	cp =3D proto_end ? proto_end + 3 : url;
> >  	at =3D strchr(cp, '@');
> >  	colon =3D strchr(cp, ':');
> >  	slash =3D strchrnul(cp, '/');
> > @@ -382,8 +382,10 @@ int credential_from_url_gently(struct credential =
*c, const char *url,
> >  		host =3D at + 1;
> >  	}
> >
> > -	c->protocol =3D xmemdupz(url, proto_end - url);
> > -	c->host =3D url_decode_mem(host, slash - host);
> > +	if (proto_end && proto_end - url > 0)
> > +		c->protocol =3D xmemdupz(url, proto_end - url);
>
> Missing "proto://" under non-strict mode would leave c->protocol
> NULL (not "") here, as described in [0/3].

Right. I debated whether to set it to `NULL` explicitly, or whether to
leave it alone. At the end, I settled with the version in v2.17.4.

> Here, slash would be pointing at one of "/?#" at the end of the host
> and url would be pointing at...?  E.g. for "http:///path", URL
> points at 'h' at the beginning, proto_end points at ':', cp points
> at the last '/' before "path" and slash is the same as cp.  host
> points at cp as there is no '@' at sign.

It is not obvious from the diff: `url` is never changed. It would still
point at the first `h`, as you said.

> > +	if (slash - url > 0)
> > +		c->host =3D url_decode_mem(host, slash - host);
>
> This wants to make c->host NULL when host is missing, as described
> in [0/3].

I did not describe well enough in 0/3, my apologies.

Again, I tried to go with the version from v2.17.4 here, i.e. to set
`c->host` if we get a value, but not set it to `NULL` otherwise (instead
leave as-is).

> Shouldn't the condition based on "slash - host", though?

That would have been my preferred solution, too. But there is some
subtlety at work: for a `url` like `/this/is/my/path`, we want to leave
`c->host` as-is, but for `cert:///...` we want to set it to "" (t0300.23
and t7416.12 test for this explicitly).

I guess a better condition would be `if (proto_end || slash - host > 0)`.
What do you think?

> Other than that, it looks sensible.

Thanks,
Dscho
