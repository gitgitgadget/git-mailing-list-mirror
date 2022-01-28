Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9F6C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 11:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiA1Lw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 06:52:58 -0500
Received: from mout.gmx.net ([212.227.15.15]:46901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348285AbiA1Lwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 06:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643370768;
        bh=5A7VOdlP6LBDX0lcbsrE24f+r9G+ZTZQMHijW+XYfzE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gD9vpM5ctbRbPk2ZLoP3lq7UBdS5XcWCDSnAiqupVy1OAILPwGZI0OmqHxNWZ+p5d
         ysOvZVEPZZvAoBd6t349WC2Waj8Rg2v9KsBdba8cLposT1O4bzkPB56XPJup8ox58R
         G3Ze8LWSg3cSyNrWwkzhaLd6A3TdUvNzk3L3WVuw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1mjOVB1G57-00WGWP; Fri, 28
 Jan 2022 12:52:48 +0100
Date:   Fri, 28 Jan 2022 12:52:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-filter: be more careful when looking for negative
 bits
In-Reply-To: <YfCGDY5qXPCFXpfp@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2201281249310.347@tvgsbejvaqbjf.bet>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com> <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com> <YfCGDY5qXPCFXpfp@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y0KxJPgdnDi0RGWBP/5WYb+r2HijXV7CT8fqzfiETTTkNB0+ClX
 JCOoyLTjfA84Xincitq7MN9eUbhAzHvyi4bu5DnrrFJKOkAIf2K8dw0CCv3jmxMYHxXl7SV
 e7/JmnWlQlX+Im1YqzxwlceqSLQ4x36TfA9hA5BtVQ1FgVRHY7iMK1YAAghZU3nA0M1uBzE
 tJhBtJRXRb+F8HW9tPRoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S5OcZvxaSC0=:tfX3ha9UrVli34Gva9lriq
 dmzYCqAINZxufdg8rPPmVWSXT5F3Y3qhDqN4U62W8Xw7pK53synpwI0f4j/47fdBTRUDc5uGr
 rshAFn4OibNG0dkegwL7BJw2THeJSV0vpbH86T67NoHEZ8id4uTnJZErljgCY1tWt9TJ2NGn4
 TWZ4o31qbAIn/9vy+FiNfBQcY5JgnAuPJpQmnyLJ22lTqbkeHXSEsfOe8CK/WyzHwcRKom9uF
 IPgks/O1O7neCS5fRKajgxLzWdXMsbeSRJXb6uenbYksQZ2BYCjgYEre5h9R835BRvzP5hG5o
 R80ggUZVa+NyLzDV1hh1pRDooIcMimzI68Q3iCL1/H+mNz+K1ahQwAIuSvUrsHTTolp+yaueA
 Tj+fCSz7h9oPl32DXn8GvISFh2HlpFgipTO344wWLxvrCtw7VyG43EP1O8woF57+SixGcrTfv
 r18dcSBw11jeI+mOG2FS6z8SAM2vMpYZr+zhJpiNlIhYNXu2Txbe4Umh7HxbQM0YubfsaUyC9
 U7xdTpL9k+IxXnlxl+yjcUP1jAqJZ1L9ApkxCSl6EPH8FzFjXjn37DRTzJ6fU825CkDSobO7S
 ygtZ3ixuMowlBOc2TsqHBfyOW/Q9U9Gmx4RTzAL3ZfJr2+pwyD0XQ2A2GBZdd4b35W3SeI8F+
 t8LonxfGkDgx1wjOLCr4dNDOgdFzyD7HSYWjD2ut0RksNQUASCvBUWQCWG5NsHFm5EoXeEfAy
 /3YcW3vW1ewT5kZ2cx9exhpwVvbVwxn0//0j7MnrJhIkAVi8xkuRJPckkA2JxEcdLuzDVy5tC
 rUnTfgfRWZiGaiFAqPy412LFBN39I1u+i+UbRRBhmAiCTXodn9lDrKoxaxOtBd4mKjo/QxvqG
 +RQ9Pn27ECSFOHBa6iFtzX6pl0QPjGhGZKBMNZV4SGD5vPAaitB840ORAD0wyTYzJvSrN2P+t
 4gSUVmpIQF8ZtLEDfjyqk+AFdYtC+NOjDG86GqosixchMk5Bx0ZB5TgXUlpEhzvSVHGBE+wEv
 MNyKcAryoakYlVPPTeDgsNm80da42pHoGfkqSLUtgKWaGX6U2pj2D1b2wrnoPiFlviy3gsOJm
 ONoc4s4hKqoWpw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Tue, 25 Jan 2022, Taylor Blau wrote:

> On Tue, Jan 25, 2022 at 10:29:19PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/diff.c b/diff.c
> > index c862771a589..fc1151b9c73 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -4821,17 +4821,15 @@ static int diff_opt_diff_filter(const struct o=
ption *option,
> >  	prepare_filter_bits();
> >
> >  	/*
> > -	 * If there is a negation e.g. 'd' in the input, and we haven't
> > +	 * If the input starts with a negation e.g. 'd', and we haven't
> >  	 * initialized the filter field with another --diff-filter, start
> >  	 * from full set of bits, except for AON.
> >  	 */
> >  	if (!opt->filter) {
> > -		for (i =3D 0; (optch =3D optarg[i]) !=3D '\0'; i++) {
> > -			if (optch < 'a' || 'z' < optch)
> > -				continue;
> > +		optch =3D optarg[0];
> > +		if (optch >=3D 'a' && 'z' >=3D optch) {
> >  			opt->filter =3D (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
> >  			opt->filter &=3D ~filter_bit[DIFF_STATUS_FILTER_AON];
> > -			break;
> >  		}
> >  	}
>
> Thinking through how this would have worked before with
> `--diff-filter=3DDr`, I think it goes something like:
>
>   1. We set all bits (except the all-or-none bit) on via the first loop.
>   2. Then we OR in the bit for deletions, which does not change the
>      overall filter (since it was already set by the previous step).
>   3. Then we unset the bit corresponding to renames.
>
> That leaves us with all bits on except two: DIFF_STATUS_RENAMED and
> DIFF_STATUS_FILTER_AON.

Correct. And since we asked only for "Deleted", we get way more than we
bargained for.

> As far as I can understand, the AON "filter" shows all files as long as
> at least one of them matches the filter, otherwise it shows nothing at
> all.

Right, so on its own, it is quite useless. It needs to be combined with
another diff filter to make sense.

> But that doesn't save us, since we have many more bits on than we should
> have, meaning that `--diff-filter=3DDr` doesn't work at all (assuming yo=
u
> expected it to show just deletions, like `--diff-filter=3DD` does).

Correct.

Ciao,
Dscho
