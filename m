Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E64C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6FF2087E
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PhDDe/1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgDWWvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:51:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:57389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDWWvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 18:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587682248;
        bh=I5EamZSZi9cVmVU+LWXhuv2sNEnt3p3351EzDd/sv/g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PhDDe/1iKelz59SCgqQfzdk2syAa1r/ur4NzDcwSLLe5Kg5WJIvOEw28ODFtQAjR/
         0BB/vd2eXntTwQ4SFag2B5aUUV+Q6bBXDKynuj3QG/WP9ep/1D566zBEZg/6N/4uY4
         LSrzmLq62YO/7pZ+6CyLhVCpr9HpHhgg6pPnWpts=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.237]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MCKFu-1jIR1W0f22-009PS7; Fri, 24 Apr 2020 00:50:48 +0200
Date:   Fri, 24 Apr 2020 00:50:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a non-strict
 mode
In-Reply-To: <20200422233854.GE140314@google.com>
Message-ID: <nycvar.QRO.7.76.6.2004240032520.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com> <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com> <20200422233854.GE140314@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cy65JR+brB0ZdrjBGjjVw7wuHZ3Jzxel3a/VlUGgAQ6gN5md/lZ
 yWwzagahoT+90mUPSx4GTcFNjNS6vuUEbvUiBk1Hqhlw/CEWlBq+AFOgzaINY4/+XhUmU+D
 sAfbNrWQ7yTkuv4KEBoXOeJNBo8MqVuLxy3HmuN2Dm/J5viR9X7KbA0/j+nq88w3YSSxdnz
 esJzZBS5qZowIjx4oq0iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+N6CBCQ9wYY=:nwev1F2WheEjkA3UjI/iNT
 HPqfTidrCdD4DBzwCBwOCDIPgxrhBbc+wWTKpSKxTZw6EDVJ4ymgK5UIu4rwmQ5e8AvombOi3
 JSibvzrDTdg4rEvp+u7f6UnnWsZP5k4EDWVglemMltxH0cq3Px95P9N/Pc52ZDPLi3zbCmsr+
 DxH2JtcoFDr381NjnqSLblA1jjkkow8CdUJ1/XH4dyJlI7+LJDhK1hE/YjaL7Bk6zmaYa7eAj
 edBVH2IxAInKeTUGV34WmQpcVEvwVBsBy/3aemqDEggCFEyI4ZV6V0tVWBAwC+WrFxy12Z8A4
 AkWgH1XKGP4ZWISCZFz78tTGEx0R5CTMU0D7bz2NImfEjNQ0VtS8Lpy4NkO4ePY/elLugCm8B
 1fyBM9b4r2iPM129z1B834+tjF/1XelSzJf9+6+X0pqRryM/xeunUPuxxaYkq6wLAkPBFCDsP
 dQYbWYBQI1raVNeNQ9BSvCe1X/NecUvyL3MtVVUq0BmeWApMT8eghUmB70XckVXmcppYR9h3U
 VaZHFgvXJqvoLqyidTsk+H+WTQMk1LovJz6x55j76qDYnZAzN72PJaeGK9r3F0JytRskpvrti
 AVhsByeSoWwCCXANDTSGPkgPGwnZM5jUQb1dL6gnsXmolPlaWJkR4efVRrJRzwIgfznMH2RQV
 og5kumMHD12BCwH13tWIFn8HuUIklmdAcjVYV4q3fkOr+72udQbCwmpmc1CVH0IYeWRGJnZEb
 oz6NP/wF091hAxDtLW4FEvgS3EjbfLmxYDTKtPVDent8j3SCJURvpRUtjND9+Neznl3t1QmLS
 wTcqX3PPcU8+47tMS5iD0vij623CuCPQDHs+9V1HGZMqp/KPeXLB87s6eDiA8D/FExzpQoW//
 yqHVUvGmjXVa13lqpKNk61eVi9rgt0dJOAl6ImfGkMFnaydBHMyElEghbOJtMndUgjAQUqsVE
 YREjqydbn90f8nv1pbT/kgYUM6tbA/4PCZTxt4N8ouirlT2oRuH1LPOwiYlJOVcF7FLiUQ/M4
 zwZ0blLkKikmYx/sWuzMNfXyPSsru0XfB6Fsz/hoGv+Oorkvrhrinss6wUhw7zR6cSSejA+Xd
 ZHS+/p43GuYsxd33p6aBRAETa2WFaX9MsNTu47Dr2Ouo5cEh2NUiNBix12F1JMjOKpL2KIDhF
 JF47q48Yh19eJLl3uQGXOdT1SPPd1hNA2UoyljlYqVnYCnsk47QdJbHq3QbCoPQy/OUTp0xXC
 KBHQ1QalDUlyRHt3o
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 22 Apr 2020, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
>
> > There was one call site, though, that really needed that leniency: whe=
n
> > parsing config settings a la `credential.dev.azure.com.useHTTPPath`.
>
> Thanks for tackling this.
>
> Can the commit message say a little more about the semantics and when
> someone would use this?
>
> Is it a shortcut for
>
> 	[credential "http://dev.azure.com"]
> 		useHttpPath =3D true
>
> 	[credential "https://dev.azure.com"]
> 		useHttpPath =3D true
>
> ?

I don't really want to be too verbose about this in _this_ commit message.
But I do see your point. This is my current version of the commit message:

    credential: optionally allow partial URLs in credential_from_url_gentl=
y()

    Prior to the fixes for CVE-2020-11008, we were _very_ lenient in what =
we
    required from a URL in order to parse it into a `struct credential`.
    That led to serious vulnerabilities.

    There was one call site, though, that really needed that leniency: whe=
n
    parsing config settings a la `credential.dev.azure.com.useHTTPPath`.
    Settings like this might be desired when users want to use, say, a giv=
en
    user name on a given host, regardless of the protocol to be used.

    In preparation for fixing that bug, let's add a parameter called
    `allow_partial_url` to the `credential_from_url_gently()` function and
    convert the existing callers to set that parameter to 0, i.e. do not
    change the existing behavior, just add the option to be more lenient.

    Please note that this patch does more than just reinstating a way to
    imitate the behavior before those CVE-2020-11008 fixes: Before that, w=
e
    would simply ignore URLs without a protocol. In other words,
    misleadingly, the following setting would be applied to _all_ URLs:

            [credential "example.com"]
                    username =3D that-me

    The obvious intention is to match the host name only. With this patch,
    we allow precisely that: when parsing the URL with non-zero
    `allow_partial_url`, we do not simply return success if there was no
    protocol, but we simply leave the protocol unset and continue parsing
    the URL.

As you see, I added substantially more information there.

> > In preparation for fixing that regression, let's add a parameter
> > called `strict` to the `credential_from_url()` function and convert
> > the existing callers to enforce that strict mode.
>
> I suspect this would be easier to read squashed with patch 3.  That
> would also mean that the functionality and test coverage come at the
> same time.

On the contrary, I _really_ want them to be separate, so that it is easier
to review. I know that _I_ had an easier time looking over the patch that
introduces the non-strict mode, to make sure that it does not change a
thing in strict mode (and yes, v1 made that harder than necessary by _not_
using `strict ||` in the condition that guards the `c->host` assignment).

In short: it is my intention to keep the two patches separate, with the
main goal to make sure that I don't introduce any of those regressions
Peff is worried about.

> [...]
> > diff --git a/credential.c b/credential.c
> > index 64a841eddca..c73260ac40f 100644
> > --- a/credential.c
> > +++ b/credential.c
> > @@ -344,7 +344,7 @@ static int check_url_component(const char *url, in=
t quiet,
> >  }
> >
> >  int credential_from_url_gently(struct credential *c, const char *url,
> > -			       int quiet)
> > +			       int strict, int quiet)
>
> The collection of flags makes me wonder whether it's time to use a
> single "flags" parameter with flags that are |ed together.  That way,
> call sites are easier to read without requiring cross-reference
> assistance to see which option each boolean parameter represents.

I resisted the temptation because I don't want this to be a big patch
series, but a fast one. The reports keep coming in, and the current plan
seems to be for GitHub Desktop to release another version on Monday, for
which I need to release a MinGit backport probably tomorrow, otherwise it
won't work timewise.

Meaning: I don't really want to do "nice to have" work like this flag.

> Alternatively, could the non-strict form be a separate public function
> that uses the same static helper that takes two boolean args?  That is,
> something like
>
> 	int credential_from_url_gently(struct credential *c, const char *url,
> 				       int quiet)
> 	{
> 		return parse_credential_url(c, url, 1, quiet);
> 	}
>
> 	int credential_from_url_nonstrict(struct credential *c, const char *url=
,
> 					  int quiet)
> 	{
> 		return parse_credential_url(c, url, 0, quiet);
> 	}

Looks good, but there are only three callers (and I don't expect more).
And the only caller interested in the lenient mode (read: the only
now-complicated call) lives in the very same file as the called function.
So it strikes me as quite a bit of an overkill to introduce two new
functions.

> [...]
> > @@ -357,12 +357,12 @@ int credential_from_url_gently(struct credential=
 *c, const char *url,
> >  	 *   (3) proto://<user>:<pass>@<host>/...
> >  	 */
> >  	proto_end =3D strstr(url, "://");
> > -	if (!proto_end || proto_end =3D=3D url) {
> > +	if (strict && (!proto_end || proto_end =3D=3D url)) {
> >  		if (!quiet)
> >  			warning(_("url has no scheme: %s"), url);
> >  		return -1;
> >  	}
>
> When !strict, this means we are not requiring a protocol.  No other
> difference appears to be intended.

Almost. My intention was to handle missing host names, too: `/repo.git`
should also match `https://example.com/repo.git`.

The user name is optional already, anyway.

BTW I realized (while working on these patches) that it would probably be
a good idea to warn about passwords in these `credential.<URL>.<key>`
settings: the password will be ignored as far as `credential_match()` is
concerned, and they should probably not live in the config.

But for aforementioned reasons, I decided against including a patch that
makes that happen.

> [...]
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
> What should happen when the protocol isn't present?  Does this mean
> callers will need to be audited to make sure they handle NULL?

Again, the sole caller of this lenient mode is the config parser which
then wants to match the (partial) URL against the actual URL, using this
function:

	int credential_match(const struct credential *want,
			     const struct credential *have)
	{
	#define CHECK(x) (!want->x || (have->x && !strcmp(want->x, have->x)))
		return CHECK(protocol) &&
		       CHECK(host) &&
		       CHECK(path) &&
		       CHECK(username);
	#undef CHECK
	}

The lenient parser is supposed to populate the `want` of this function. In
other words, the code _expects_ `protocol` (or for that matter, _any_
attribute of `want`) to be optional.

> > +	if (slash - url > 0)
> > +		c->host =3D url_decode_mem(host, slash - host);
>
> What should happen the URL starts with a slash?

Oh... I thought it was obvious that a partial URL starting with a slash
would refer to the path part only... Does that not make sense?

Ciao,
Dscho
