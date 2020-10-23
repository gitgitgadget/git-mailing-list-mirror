Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF44C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 12:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF33521D43
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 12:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EvaPSS2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464041AbgJWMrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 08:47:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:44063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S464010AbgJWMrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603457254;
        bh=OtP9N08bksFwBKWxNMptIC6yCH2L9Y8l7DKKhNS8O78=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EvaPSS2FuRJRlDQ3v/240gTm9cftwJOQIxaIqVV0/QIij69Dxc/qOrNrgF++4zJcN
         6Q55OXqvt2lnZyjCkICK0TlnJsGI7Bz3GBJ2YiIxXKf1LQFR90Bei5aqTYB3p8SeOc
         qpEMhgE4dciG40Q0xFNfukTWi/nWuT9oIR7nRurs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.213.182]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1jwKoQ4Atf-00aEY8; Fri, 23
 Oct 2020 14:47:34 +0200
Date:   Fri, 23 Oct 2020 07:36:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/3] sideband: add defense against packets missing a
 band designator
In-Reply-To: <20201023084827.GE4012156@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2010230732250.56@tvgsbejvaqbjf.bet>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com> <pull.753.v2.git.1603136142.gitgitgadget@gmail.com> <c61e560451c4d7f101a23acec69117ddac563330.1603136143.git.gitgitgadget@gmail.com> <20201023084827.GE4012156@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rpSa20mq/yaO0p3dDeQgVpB37TJZ6iv6t+fEPNvnOKn/gGd9mNl
 hNrbPR8zuvtDdcMYG9aNjRsBcOFj0LRYlrPEtl8mlcs0Ce0NZx9wi/NpXiaD5llNA1XReTV
 YoQ5qxiJQE5+/0ltvc606kptZxbHsiHUnbCTWQXoDNRDeVKx+8nIdRe56OKOyEjj+4Lejne
 PH+BU4ukF/r2Dh29u9d2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OSRS2xcJeBo=:7wTBw6rxPZSeo/jyKW0xpi
 1hEeozPI6ZHaqujj2YkEspcOQVP3TiLorkV1ERzDlvAqPiAZ6MZGTez+qdL5crsrDrzY/ybgl
 dqceg0eVcruY3/Wr9FBorXSqHr3vYsu5L9SaFYmUURpQMS5/Hh42E4Tu5ly8Oo2MPsQJVpA2a
 +9vxM2Y4i71d4OiATgot9OiQ7PnbCXsZ6t4vmh41+en6Yv/GKHwNGl3Ecv/vn5z88NzjasEgp
 7yX73u7iJip8BvtuO//oNKAma58ySydcGGvO5CDGcpTZTd76EIoYL+A/NWIXQMJMq5GQnDDDz
 71FKdA4mUo2YHGq7LrmOacrOlZGT29mP915UKUjqwLZ0GQw7IkW6B/qazHv4UUfQUzIQEePvy
 0L0F/uUAPUGEYYISw3ENsjoXTxBNwXkrMhqNYIsmDxbNFOjUAhA/VndmRVzyPGlM7IoPk2Xi6
 mFK9vaU41RjXOX3KISzgwJTUHcfDSilWzYDTGTepGlxTSu6MXCvWFeS1QgW/ZEmESnLq44Lt9
 CgQOnXVNay4mOjpelwrdSHRAI0jiOTv0LlK27fFfQ8uYGcgOpwJ2QLR7o/EGL1N1K9InD9C4x
 USzKuudCo1iEMpzfhQppY66pulR98j8IMry834tlhrpHmrHrJMuTW5m8e7XXayfWm+xmnv/y+
 lYGimRGzxaTnSPbpfQ210x0gISriNmrXpbDxBzALSVWPQD/TrBsSivNqJLPrUTv1aEGN0I2sW
 VQmASt82TwxSnVub8J2+yjUKGdoB4TAA3fwMGgWPjb5T80lYFrQFejwNHXUr5tm2IxjpbPzw1
 Z+3SnqjVwkoQgViM/xRI8Nfm2cvWN/6F2+M9pRRwa5rKxJOywyHx3mmGRjPiDf+kLpRHVOqDs
 IKC4qa5RbpD6UcgcN0fBAeOsa4buIzXuxvHGYo1jk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 23 Oct 2020, Jeff King wrote:

> On Mon, Oct 19, 2020 at 07:35:42PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > diff --git a/pkt-line.c b/pkt-line.c
> > index 657a702927..f72048f623 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -461,8 +461,10 @@ int recv_sideband(const char *me, int in_stream, =
int out)
> >  	enum sideband_type sideband_type;
> >
> >  	while (1) {
> > -		len =3D packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX,
> > -				  0);
> > +		int status =3D packet_read_with_status(in_stream, NULL, NULL, buf,
> > +						     LARGE_PACKET_MAX, &len, 0);
> > +		if (!len && status =3D=3D PACKET_READ_NORMAL)
> > +			BUG("missing band designator");
> >  		if (!demultiplex_sideband(me, buf, len, 0, &scratch,
> >  					  &sideband_type))
>
> I also wonder if this status-check should be pushed down into
> demultiplex_sideband() by passing "status",

I tried that, but as mentioned in the commit message, fbd76cd450
(sideband: reverse its dependency on pkt-line, 2019-01-16) went out of its
way to _stop_ the code inside `demultiplex_sideband()` from relying on
anything in `pkt-line.h`. And that `PACKET_READ_NORMAL` and
`PACKET_READ_EOF` _is_ from `pkt-line.h`.

Ciao,
Dscho

> for two reasons:
>
>   1. So we don't have to repeat it (though it isn't that big)
>
>   2. The other half of this weirdness is that if we get an early EOF,
>      we'll hit the "missing sideband designator" die() message. But
>      that's not really what happened; we probably got a network hangup.
>      And we could distinguish that case by checking for status =3D=3D
>      PACKET_READ_EOF and provide a better message.
>
> Something like this (completely untested):
>
> diff --git a/sideband.c b/sideband.c
> index 0a60662fa6..6ad15ed581 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -115,6 +115,7 @@ static void maybe_colorize_sideband(struct strbuf *d=
est, const char *src, int n)
>  #define DUMB_SUFFIX "        "
>
>  int demultiplex_sideband(const char *me, char *buf, int len,
> +			 enum packet_read_status status,
>  			 int die_on_error,
>  			 struct strbuf *scratch,
>  			 enum sideband_type *sideband_type)
> @@ -130,17 +131,29 @@ int demultiplex_sideband(const char *me, char *buf=
, int len,
>  			suffix =3D DUMB_SUFFIX;
>  	}
>
> -	if (len =3D=3D 0) {
> -		*sideband_type =3D SIDEBAND_FLUSH;
> -		goto cleanup;
> -	}
> -	if (len < 1) {
> +	if (status =3D=3D PACKET_READ_EOF) {
>  		strbuf_addf(scratch,
> -			    "%s%s: protocol error: no band designator",
> +			    "%s%s: protocol error: eof while reading packet",
>  			    scratch->len ? "\n" : "", me);
>  		*sideband_type =3D SIDEBAND_PROTOCOL_ERROR;
>  		goto cleanup;
>  	}
> +
> +	if (len < 0)
> +		BUG("negative length on non-eof packet read");
> +
> +	if (len =3D=3D 0) {
> +		if (status =3D=3D PACKET_READ_NORMAL) {
> +			strbuf_addf(scratch,
> +				    "%s%s protocol error: no band designator",
> +				    scratch->len ? "\n" : "", me);
> +			*sideband_type =3D SIDEBAND_PROTOCOL_ERROR;
> +		} else {
> +			*sideband_type =3D SIDEBAND_FLUSH;
> +		}
> +		goto cleanup;
> +	}
> +
>  	band =3D buf[0] & 0xff;
>  	buf[len] =3D '\0';
>  	len--;
>
