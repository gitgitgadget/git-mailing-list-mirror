From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] date: recognize bogus FreeBSD gmtime output
Date: Tue, 01 Apr 2014 19:42:30 +0200
Message-ID: <533AFA86.2090905@web.de>
References: <20140401073848.GA22023@sigill.intra.peff.net> <20140401074251.GA22550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 19:43:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV2iQ-0000vu-Su
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 19:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbaDARnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Apr 2014 13:43:09 -0400
Received: from mout.web.de ([212.227.17.11]:49318 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbaDARnG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 13:43:06 -0400
Received: from [192.168.178.27] ([79.253.130.66]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MZliY-1Wkutp1oZK-00LSpR; Tue, 01 Apr 2014 19:42:51
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140401074251.GA22550@sigill.intra.peff.net>
X-Provags-ID: V03:K0:Afh7n1CH8M2DkpMBNIVCsir+GczkWjO4fJV6iwNOgOIbeDbSUTk
 S2dvSRX9NRqaoTFG6tnJ3fgBPzH/BNrQpyA21Wnl2f3RWRPCFI3k/5mBwYUue4U59JF/HWo
 xOzgR4u9thtJvMOSI0gH/XK2rXXfNYXBiNX6anWrYPgTjyiPgUvw0TBqpwDCVQX8aRviGaT
 qr3HEyXgqfRrjWAwrgPMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245618>

Am 01.04.2014 09:42, schrieb Jeff King:
> diff --git a/compat/gmtime.c b/compat/gmtime.c
> new file mode 100644
> index 0000000..ffcabf4
> --- /dev/null
> +++ b/compat/gmtime.c
> @@ -0,0 +1,26 @@
> +#include "../git-compat-util.h"
> +#undef gmtime
> +#undef gmtime_r
> +
> +struct tm *git_gmtime(const time_t *timep)
> +{
> +	static struct tm result;
> +	return git_gmtime_r(timep, &result);
> +}
> +
> +struct tm *git_gmtime_r(const time_t *timep, struct tm *result)
> +{
> +	struct tm *ret;
> +
> +	ret =3D gmtime_r(timep, result);
> +
> +	/*
> +	 * Rather than NULL, FreeBSD gmtime will return a "struct tm" with =
all
> +	 * fields zeroed. Since "mday" cannot otherwise be zero, we can tes=
t
> +	 * this very quickly.
> +	 */
> +	if (ret && !ret->tm_mday)
> +		ret =3D NULL;
> +
> +	return ret;
> +}

http://pubs.opengroup.org/onlinepubs/009695399/functions/gmtime.html=20
says that errno shall be set on error and only mentions EOVERFLOW as a=20
possible error code.

Ren=C3=A9
