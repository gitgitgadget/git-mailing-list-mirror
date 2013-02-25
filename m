From: Jeff King <peff@peff.net>
Subject: Re: [PATCH ] t4210-log-i18n: spell encoding name "UTF-8" correctly
Date: Mon, 25 Feb 2013 15:36:52 -0500
Message-ID: <20130225203652.GB15932@sigill.intra.peff.net>
References: <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
 <20130211205958.GA32740@sigill.intra.peff.net>
 <512B22DE.9070603@viscovery.net>
 <512BB377.2010403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Haller <thom311@gmail.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:37:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA4nX-00008R-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 21:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981Ab3BYUgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 15:36:55 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60217 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab3BYUgz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 15:36:55 -0500
Received: (qmail 27018 invoked by uid 107); 25 Feb 2013 20:38:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 15:38:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 15:36:52 -0500
Content-Disposition: inline
In-Reply-To: <512BB377.2010403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217105>

On Mon, Feb 25, 2013 at 07:54:47PM +0100, Torsten B=C3=B6gershausen wro=
te:

> (beside that I couldn't find t4210 somewhere),

It's newly added in 04deccd.

> diff --git a/utf8.c b/utf8.c
> index a4ee665..e9850d0 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -487,6 +487,10 @@ char *reencode_string(const char *in, const char=
 *out_encoding, const char *in_e
>  	if (!in_encoding)
>  		return NULL;
>  	conv =3D iconv_open(out_encoding, in_encoding);
> +	if (conv =3D=3D (iconv_t) -1 && errno =3D=3D EINVAL) {
> +		conv =3D iconv_open(is_encoding_utf8(out_encoding) ? "UTF-8" : out=
_encoding,
> +											is_encoding_utf8(in_encoding) ? "UTF-8" : in_encoding);
> +	}

Yeah, I think this is pretty close to the patch I just sent. You do the
fallback, which I think is sane to prevent any possible regression (for
"type 3" systems, as I called them in my commit). I don't know if it is
worth checking errno; we should get the same failure either way, and I'=
d
worry slightly about some odd iconv implementation does not use EINVAL.

And of course, I like my indentation and commit message better. :)

-Peff
