Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11FEC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93294208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="T5WkDMuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgDWN2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:28:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:36337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgDWN2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 09:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587648493;
        bh=SEcM4tgPwnulPBJMeD8v84reP7cF2SHr5jnRyGN6bSA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T5WkDMuw86dJJzVjh+jnCK+kF12IjJaLNL0IGKvX74US/DCJZ+jZhDJUaJ6nhlaKg
         bpnKCDftXxAdzmJMwe12AnCBdlyqo83oE6LR2R9L3EDAHMsp2Bnj9djKBQ5KxRnKTt
         03ea4KxqSzRHp3KoU6qGuflOYxp878mcpcnCO2Ss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.237]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N7QxB-1j8aTA2Cmz-017oYn; Thu, 23 Apr 2020 15:28:13 +0200
Date:   Thu, 23 Apr 2020 15:28:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a non-strict
 mode
In-Reply-To: <CAPUEspgJvN6f6Wjo-yjYj-x+bYtC3vdSvwUtrF=MbJDjwYUTdA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004231433060.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com> <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com> <20200422233854.GE140314@google.com> <CAPUEspgJvN6f6Wjo-yjYj-x+bYtC3vdSvwUtrF=MbJDjwYUTdA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cn6rX9pWAboVXhrccu+DbPRAReGquKQt5ZSowhDic3i9uhY+kqG
 cLYmoGVXG1DquxrP8QkTj9644bNc98+yZY+EDS3Tf+Fx6n87K8FATFswKCh3kMd01UHaGt/
 XuqYWp9WQZayKoV2oF15QFqO3NtQoU0+1f6t+5pVvqZuOP0P3dg7xej37QTQlDEuTBOi1O+
 SfwH/UKIloqmNVG8K3dSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CPtBiucSZSE=:duVSMsXw2qWbNYK5CWihi2
 DHBu/lz3fVV6atdgCev0N8o6hDEcOnIuq64/kEqMk/YCEMFbDMETlZkYCX7yB5hZbZlAk2RGX
 P0k9DPFLtaipVjd5gcjWeMZpsc9TgNSJfd/N+u8nM5EYBgGDVoJlDwW7pvvAQNszDPcPiPp3b
 YK1YbpjQKVttx5+8YgjiOe4hsNYVyat1EsWUFk/9KO4f245odtzAyVFdbLTZ8nvUiNU8cSc0O
 ZGy02ZIR7ZIdqKi+55otn2yJp5wjyu/4/iLOA0is46pbHXQcawl0MRF7HF9o8HzIa/2kn+1s2
 1Zpib/79L/6SBKNxdfDtv+Xcvdi2z1zDXqFOvUKoTf5oKqVECvRymyaNjVXoWtLBx20bst2SD
 Z3ELhZ+b4dA4LveXGJtQnvEri3LTh7NDjS+81i4AFixmwpu1u946pnlVbpnXV+8FiW7/TVDpX
 utIUtNNmJJIw7sdVO8/WAC0WSjL2hUv91MCkGswe+W3gaektVLAZOGLwKftaLpR+INSNk5LPd
 OFHbEB6lRLTnFByPSvC6R1P2yyBa6T2dEEzS3JVWoBPl0pqo+JVAW912Wb1G+E0dXPM0ol7Xa
 t8HUBS/3MzY1rf1IStiodfPPrLOAEG6X7pTRyXq6SDN4WYWAL17ylgazxxr0l2JcvwDoEwIRO
 0G3ufiJmjBmcrB9101bqZv37S/foeQaN6IvM4ytyq3PFuFNs6Fbxnrh5mQg8EyxtawwUbpXg/
 TeXSEXoPmZ+GUFK3RWXI+DdSZjOrQMuyrNPOq2mgh9J54+E6c1N/MP2dt7klSbMQTGlRqxJyC
 pWYV3YlS7fwydqahVigx8IcGY3zlRv2xCb+wv0BGIvnKB/Cgin3ZtjOHAfHjT2tsh8LxyJeGX
 R90NIvJXtbO8saiJHgyDHIAiryyuqeCO7M0P/xSnOK0L0N1baU289fmi0JGCuPZh6cFYI7/+f
 NRliVcitz/a3lgHl3Hw6cFTyWKqb7+Tt8T64zQDVJFm3n7/Qj9MAddZxn0FF+e/T1CdP8mpJk
 /sckEX2oRdV1bombOKTEMG7kDmXVSeq7uFNNQfr2o2AZJV47tC/YYUh3cm5sJgbc0shMVSi9k
 6NQuz5juFZ2d8YMxFBgzjiOBAiPGbbLbONNjqayErJI0VoELtmK1K5E8IkQJKf4V6lWiJPJeH
 OdQ1K7zPb42U89TJDk82mjhxxRg4a/m7cF/Vrik02TR8XAXsSP4ak7vxBGHdrtf09vJK/HZPV
 mka6PPuou2PrKVVrz
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Wed, 22 Apr 2020, Carlo Arenas wrote:

> On Wed, Apr 22, 2020 at 4:41 PM Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> > Johannes Schindelin wrote:
> > > @@ -382,8 +382,10 @@ int credential_from_url_gently(struct credentia=
l *c, const char *url,
> > >               host =3D at + 1;
> > >       }
> > >
> > > -     c->protocol =3D xmemdupz(url, proto_end - url);
> > > -     c->host =3D url_decode_mem(host, slash - host);
> > > +     if (proto_end && proto_end - url > 0)
> > > +             c->protocol =3D xmemdupz(url, proto_end - url);
> >
> > What should happen when the protocol isn't present?  Does this mean
> > callers will need to be audited to make sure they handle NULL?
>
> the previous code was ensuring protocol was always at least "" (albeit i=
t
> might had been easier to understand with a comment)

If you mean v2.17.5 by "the previous code", then yes.

However, what I wanted to reinstate was the behavior of v2.17.4, at least
the behavior that was obviously intended by this code:

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

What speaks loudly to me is that _any_ of these can be `NULL` in `want`.
Any of them. Even protocol.

Remember, the call that I modified here to be more lenient populates that
`want`, not that `have`. The `have` still uses the strict mode, and that
is very much by design.

I also saw reports where users try to set `useHTTPPath` for hosts, not for
URLs, and it kind of makes sense. So I wanted to make that work, too.

Except that I uncovered the bug during my investigation that v2.17.4
handled `credential.<hostname>.useHTTPPath` as if no `<hostname>` was
provided at all!

So I wanted to fix that bug as well.

What I do _not_ want is to enforce `protocol` to be set (falling back to
an empty string if not specified). See below as to why.

> removing the proto_end - url check would have the same effect, but then
> we will need to also add a explicit xmemdupz("") for the nonstrict part
> or audit (and with certainty add) checks to prevent a NULL protocol to
> introduce regressions

I fear that my patches did not make it clear that the lenient mode is
_only_ used in the config parsing, in which case we very much do not want
to have the unspecified parts be interpreted as empty strings.

For example, if I specify

	[credential "http://"]
		helper =3D prevent

to catch _all_ http:// URLs, I definitely do not want that to be used only
for URLs with an empty host name!

Likewise, if I specify

	[credential "dev.azure.com"]
		useHTTPPath =3D true

I positively want to use the path part of the URL to specify what
credential to use _when accessing http://dev.azure.com/... _or_
https://dev.azure.com/... URLs, I do not expect that setting to be used
only for URLs with an empty protocol (which are now forbidden, anyway,
IIUC)!

So no, that `xmemdupz("")` would introduce very much undesirable behavior,
I believe.

Ciao,
Dscho
