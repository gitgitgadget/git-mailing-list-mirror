Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13281C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 14:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EE7206F0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 14:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QUssvEbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD2O61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:58:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:37033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2O60 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 10:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588172286;
        bh=A3HqA9Jd/UZ8Ka3Clh384Nq2SPSLnks3RcJEibtRRGc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QUssvEbthv2G0a73q35ZsBHcIwBG08QO2atj/aKdeWVmBkNc7Rvg65oorzI6qllQF
         WeKsfr42j+Cp3us56vRvrkxF+VBZhiHxFK65K5crAi8fEnggatMBMVXJKwYLtHGfmq
         YIRaM/hsWUxnMVnbW70ZSycZssiADRGw/Q0oAAQ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.118]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M72sJ-1jXN3Z2p1b-008ebB; Wed, 29 Apr 2020 16:58:06 +0200
Date:   Wed, 29 Apr 2020 16:58:05 +0200 (CEST)
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
In-Reply-To: <xmqqr1w7yzjc.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004291657220.18039@tvgsbejvaqbjf.bet>
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>        <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>        <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com>        <xmqq4kt8bk5r.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004250027550.18039@tvgsbejvaqbjf.bet> <xmqqr1w7yzjc.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:czS/5DLFO9Rmxh3j6SEjjP80TVX01i2NO+YNo+tanGoMtEvvnMg
 KNjlDDxD1gJiZyDmxNPEL/9u0wrJIZmKETRstx5vvxUa/97mtAGJo8Za40XGUOHLz4q6kpe
 V7pKnz8kJH5iZuj1hAXYeeCcei7RU9n8rhKgEY+Qwv4pTqmKH0SX0yldngYtkF62x8wm5R9
 o6LjJkzIM7GjIv87+fM0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MhVcg4fjav0=:dSOGnryu0oAzcZIQo9uzw7
 DLU++kcif1IAP72Rg7GnYuFdRYB8PVTS/KzNaoaLoJ3tnejs91JtIZYNCtCGHcgzeUHR1cWmt
 +vIYSM20rTeX3RNuZ3HH4ljsadR6Brf7dH0TTaFHkhn0lmCO37FJXwheRWIXiSPMZzJZCuCMr
 pOKWSP+MPwr8+URVtnBhcvOnVF36IEML+6WG7KdTUOOHtqO/wtSM+iYI0WSS2NHoAlVy8morA
 Hrv4cNKxl01+xbdu5yE6p2sIQOMPRB8VLKxM3qojXAoPPJ0yEZZcOXk/sbv1YiRALapt9y/sa
 BZqJI4Gi817ygOs3LXAbcfNpiuzybT8uUbu2BGmJfZJ9SeKygQdXQwsPVloWDWJRg+fKjIR/j
 oYNJmZiOZenOQOLVG9jzVYepDrPNJdwOFUwXOP7uIhfVSFU96pOyLE9YHXfxoLVHwgrPAKTz/
 d2S0ehn0iafDRsdhwwwFriPdZwkHaQ4vzxItKsI+/Nhwd6swdfdo6HFEU1oRfaxlcuMjj4h6p
 xWT2MeZXUBv6qQ2MGKrIx1MnjL+aciH+bJ3SYMTX6cQgvSLolb6pewPsCUpDOrN8NShRY6TI3
 PEhbBJsggW9yuEOr8FHDxevbjdfTtvNCzPhKbF1SpxliEXPcScrF4T89IvTucDOqRsZkCJwV1
 pdnI7wBUu6xGMkiVRu886A5w7cRZR5c6N8QRUYpuIi5P0yyqID+o25E78hlLgoRkrw5nf9FMB
 xzcgeX4X6r+++MlI069v3ZYZyI6R24k0U57m4JgrkRqM0TEXD2AQBP8oLxwRiYch/cBpoZ6sU
 xqg7kWGK+ONHK/99Sz/KZibmLtBoqrvuX5oeE2ejuzVI+q0d0Ji6ZblXJQg2h+0v5n6DGWFYT
 eHgSXj5EE1/JhSih48sZjiOOJ5fLXhWNQCT0w2UagQ7lZ5KZt5Wo2sL9MtTqaQ51S6JSNI7Ot
 Qxp+D8f6D/oi1JrQHVZdfARFo3YebOR62+au2uZXlj8sIfFLR9TKPpHYtYg09z5BL4sJWFP+H
 Khb2SIN9Jj94lfdXBq7dYY4/3UzjLOtD6vKoQzaEKmlU0TD+zxKKLwY6s3FxmBnNKNIPu08TA
 +tziY2UEHd6XIo/TKbfABVcH18uCuuc0ogc7ghR2i2P7a2ehvhLm1pQ4RlD3KXl6vKSz+s0NH
 BlarZPWvgxW3ssRwJXOsYQJVkUVKSL0wlqYJ7vuuaHZSBS4DwaWG/j2qA4d5u9BcGW96YPlwU
 SWHI6kmmBkbF2OXYc
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 28 Apr 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Junio,
> >
> > On Fri, 24 Apr 2020, Junio C Hamano wrote:
> >
> >> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> >> writes:
> >>
> >> > @@ -53,7 +57,13 @@ static int credential_config_callback(const char=
 *var, const char *value,
> >> >  		char *url =3D xmemdupz(key, dot - key);
> >> >  		int matched;
> >> >
> >> > -		credential_from_url(&want, url);
> >> > +		if (credential_from_potentially_partial_url(&want, url) < 0) {
> >> > +			warning(_("skipping credential lookup for key: %s"),
> >> > +				var);
> >> > +			credential_clear(&want);
> >> > +			free(url);
> >> > +			return 0;
> >> > +		}
> >> >  		matched =3D credential_match(&want, c);
> >>
> >> Unfortunately, the whole section of this code that is being patched
> >> here goes away with 46fd7b39 (credential: allow wildcard patterns
> >> when matching config, 2020-02-20), that delegates large part of the
> >> logic to urlmatch.
> >>
> >> Dscho and Brian, how do we want to proceed?  As the conflicting
> >> change has already been in 'next' for more than a month and a half,
> >> we'd need this "partial URL" logic build to work well with it.
> >
> > I prepared a PR: https://github.com/gitgitgadget/git/pull/620. I do no=
t
> > necessarily feel 100% comfortable with that approach yet, but at least=
 it
> > lets the new test case of t0300 pass.
>
> The -2.17 patch series (your [v3 3/3]) ends t0300 like so
>
>     +	done &&
>     +
>     +	git -c credential.$partial.helper=3Dyep \
>     +		-c credential.with%0anewline.username=3Duh-oh \
>     +		credential fill <stdin >stdout 2>stderr &&
>     +	test_i18ngrep "skipping credential lookup for key" stderr
>     +
>     +'
>     +
>      test_done
>
> while the other branch lacks the extra blank line just before the
> single quote is closed.  I queued 850ef627 (SQUASH??? lose excess
> blank line to match the other side of the eventual merge,
> 2020-04-24) on top so that the "-s ours" merge would be without
> unnecessary evil-merge noise.  You probably would want to squash it
> in.

Thank you for pointing that out. I already did that:
https://github.com/gitgitgadget/git/compare/0535908dd7ea4487b342c0f8618257=
9279c57b34..d59738ecf741a5fddd70f133eaaf69768e245bcc

Do you want me to send another iteration, for completeness' sake?

Ciao,
Dscho
