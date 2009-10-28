From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send.c: fix pointer to be const
Date: Wed, 28 Oct 2009 00:25:19 -0700
Message-ID: <7vljiwq8tc.fsf@alter.siamese.dyndns.org>
References: <1256714677-3659-1-git-send-email-vietor@vxwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Vietor Liu <vietor@vxwo.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:25:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32uS-00023M-JK
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbZJ1HZX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 03:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbZJ1HZW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:25:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbZJ1HZW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 03:25:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B0D288277;
	Wed, 28 Oct 2009 03:25:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cqcTVBcvGnED
	TOe4YHs7iZE1mA0=; b=v6o1a7pQUZl8dVSS45F1XOxxtAGIuP5B3Cle7iFRYEr2
	KlXL0kZYI1b9VPvbYyHtcxy9sDbM21wx4/w6/VP7XSYqoIo4nei+kgMK+hqFuhtW
	sp0ljYFuaDaxAa8XsVUQ/7BKyIhZV6ks0UN/0R+mqUw6vPD9mG5k4/Z2cRynA7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f57UzS
	feAIatkvzKqnXI/QEiyLLuvcUU31U6a/PKJrNCVEK4rwlvxMerQu9UwNOS7ibxJ5
	byZxkzKYWGMmaJtOKoRsuEqHSrO4ehJOqbMzUroEOhQjTg2g34zdIL/xDhe0Z/V9
	xFgxkvXX0vb9GhuGHSPI5ZCNzF60LnKk07duc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C05888274;
	Wed, 28 Oct 2009 03:25:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A96C088272; Wed, 28 Oct 2009
 03:25:20 -0400 (EDT)
In-Reply-To: <1256714677-3659-1-git-send-email-vietor@vxwo.org> (Vietor Liu's
 message of "Wed\, 28 Oct 2009 15\:24\:37 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F2F65DE-C393-11DE-A984-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131431>

Vietor Liu <vietor@vxwo.org> writes:

> Fixes some compiler warnings:
> imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
> warning: assignment discards qualifiers from pointer target type
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> OpenSSL Changes between 0.9.8k and 1.0:
>
> *) Let the TLSv1_method() etc. functions return a 'const' SSL_METHOD
>      pointer and make the SSL_METHOD parameter in SSL_CTX_new,
>      SSL_CTX_set_ssl_version and SSL_set_ssl_method 'const'.
>
> Signed-off-by: Vietor Liu <vietor@vxwo.org>

This is much easier to understand.

Thanks.

> ---
>  imap-send.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 3847fd1..10dd025 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -273,7 +273,7 @@ static int ssl_socket_connect(struct imap_socket =
*sock, int use_tls_only, int ve
>  	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
>  	return -1;
>  #else
> -	SSL_METHOD *meth;
> +	const SSL_METHOD *meth;
>  	SSL_CTX *ctx;
>  	int ret;
> =20
> --=20
> 1.6.5.2
