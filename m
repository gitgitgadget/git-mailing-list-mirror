From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Fri, 16 Dec 2011 14:01:50 -0800
Message-ID: <7viplggoq9.fsf@alter.siamese.dyndns.org>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk>
 <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
 <20111125170219.GD10417@beez.lab.cmartin.tk>
 <7vy5v2wleb.fsf@alter.siamese.dyndns.org>
 <20111128104812.GA2386@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@roxen.com>,
	Git Mailing list <git@vger.kernel.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:01:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbfqo-0004m3-RK
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760844Ab1LPWBz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 17:01:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760834Ab1LPWBx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 17:01:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B09724A;
	Fri, 16 Dec 2011 17:01:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jmLsdBD+OC5H
	YptUtwlnjpcwT+k=; b=s3LWkgIbylMqA1Gbf/pBbFcq+P7+Fgfj8hy8REnot0Cf
	B6I5H6LIrHGCefGdsOivO32cj/2A45C7BIadtPXfxmwyta+FxakdHoTGcg3P8+So
	lMPrx6lj/UH2rp8Npfa5bWxwixSFDPabuciuFB0rPN7Uo0E92Nuw18ahMqXsgZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i37NYU
	ecBDRx0QY6UxbZdamKKbnbrF5AEXM5NEnFR6CtNL6foDgEULdehstZPslM5z8z41
	pW6oVn34ib7GF0Vj1tSS/FPRVHfpAFMT43H+dLo9Z1dL98DDPlOKjmGP9vVwYpUF
	bfFMO1Xo039K99LqNgN8L9rkRGo8ezRnHlvTw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 683007249;
	Fri, 16 Dec 2011 17:01:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D69537248; Fri, 16 Dec 2011
 17:01:51 -0500 (EST)
In-Reply-To: <20111128104812.GA2386@beez.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 28 Nov 2011 11:48:12
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F347EB8-2831-11E1-BC72-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187322>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Subject: [PATCHv2] convert: track state in LF-to-CRLF filter
>
> There may not be enough space to store CRLF in the output. If we don'=
t
> fill the buffer, then the filter will keep getting called with the sa=
me
> short buffer and will loop forever.
>
> Instead, always store the CR and record whether there's a missing LF
> if so we store it in the output buffer the next time the function get=
s
> called.
>
> Reported-by: Henrik Grubbstr=C3=B6m <grubba@roxen.com>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>  convert.c |   50 +++++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 86e9c29..1c91409 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -876,24 +876,39 @@ int is_null_stream_filter(struct stream_filter =
*filter)
>  /*
>   * LF-to-CRLF filter
>   */
> +
> +struct lf_to_crlf_filter {
> +	struct stream_filter filter;
> +	int want_lf;
> +};
> +
>  static int lf_to_crlf_filter_fn(struct stream_filter *filter,
>  				const char *input, size_t *isize_p,
>  				char *output, size_t *osize_p)
>  {
> -	size_t count;
> +	size_t count, o =3D 0;
> +	struct lf_to_crlf_filter *lfcrlf =3D (struct lf_to_crlf_filter *) f=
ilter;
> +
> +	/* Output a pending LF if we need to */
> +	if (lfcrlf->want_lf) {
> +		output[o++] =3D '\n';
> +		lfcrlf->want_lf =3D 0;
> +	}
> =20
>  	if (!input)
> -		return 0; /* we do not keep any states */
> +		return 0; /* We've already dealt with the state */
> +

Shouldn't we be decrementing *osize_p by 'o' to signal that we used tha=
t
many bytes in the output buffer here before returning to the caller?

>  	count =3D *isize_p;
>  	if (count) {
> -		size_t i, o;
> -		for (i =3D o =3D 0; o < *osize_p && i < count; i++) {
> +		size_t i;
> +		for (i =3D 0; o < *osize_p && i < count; i++) {
>  			char ch =3D input[i];
>  			if (ch =3D=3D '\n') {
> -				if (o + 1 < *osize_p)
> -					output[o++] =3D '\r';
> -				else
> -					break;
> +				output[o++] =3D '\r';
> +				if (o >=3D *osize_p) {
> +					lfcrlf->want_lf =3D 1;
> +					continue; /* We need to increase i */
> +				}
>  			}
>  			output[o++] =3D ch;
>  		}
