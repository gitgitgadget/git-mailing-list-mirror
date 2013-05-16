From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/2] cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
Date: Wed, 15 May 2013 17:36:20 -0700
Message-ID: <7vbo8bahh7.fsf@alter.siamese.dyndns.org>
References: <1368663120-47102-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 02:36:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcmBT-0007bO-Ge
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 02:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab3EPAgY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 May 2013 20:36:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753084Ab3EPAgX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 May 2013 20:36:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD79FF85D;
	Thu, 16 May 2013 00:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QA9JW0mG36nq
	2BckAH1HE0WGBpE=; b=GdtmZRAgxNjMjdR1xBxnoIEFnapVEs3V5JeI8lfdYZrg
	RJS6KgnZa5BvmjFo8yvwx9k6aX5YTxqxicSGA2hRGdtKDfn6hrKuFSOAC7fiU3uy
	kAvLkQRSBikSskfSmWWWJJR5SVvCHVUlSrPwzC8/Z9DcmxrhayBd8C069LIkIBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bJZX38
	o3hX1wwms584OFRM+nUhYrYZttRN/KP5DMU5yymqTSYg77Q/U3u2mt8DOYJ7IFhk
	o4e1lGEW6VBmnTRWeaK3J2OslSiHrmfCZeE4q2ZbTfnmDuRDZdpEYpxhUFSfWRT/
	rTbcddoldBjjXqvScPk/QoHY7E4JjRo3TC4bY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0C37F85B;
	Thu, 16 May 2013 00:36:22 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5EB6F858;
	Thu, 16 May 2013 00:36:21 +0000 (UTC)
In-Reply-To: <1368663120-47102-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 15 May 2013 17:11:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1CA7700-BDC0-11E2-88D3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224463>

David Aguilar <davvid@gmail.com> writes:

> Mac OS X 10.8 Mountain Lion prints warnings when building git:
>
> 	warning: 'SHA1_Init' is deprecated
> 	(declared at /usr/include/openssl/sha.h:121)
>
> Silence the warnings by using the CommonCrytpo SHA-1
> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>
> Add a NO_COMMON_DIGEST_FOR_OPENSSL option to the Makefile to allow
> users to opt out of using this library.  When defined, Git will
> use OpenSSL instead.
>
> COMMON_DIGEST_FOR_OPENSSL is defined to enable the OpenSSL
> compatibility macros in CommonDigest.h.

This symbol will also cover not just SHA but also HMAC, would it
make more sense to call it COMMON_CRYPTO_FOR_OPENSSL?  After all,
that is what Apple calls this library, no?


>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Changes since last time:
>
> Name the Makefile variable after the #define for consistency.
>
>  Makefile | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index f698c1a..b0eb949 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -137,6 +137,10 @@ all::
>  # specify your own (or DarwinPort's) include directories and
>  # library directories by defining CFLAGS and LDFLAGS appropriately.
>  #
> +# Define NO_COMMON_DIGEST_FOR_OPENSSL if you are building on Darwin/=
Mac OS X
> +# and do not want to use Apple's CommonCrypto library.  This allows =
you to
> +# provide your own OpenSSL library, for example from MacPorts.
> +#
>  # Define BLK_SHA1 environment variable to make use of the bundled
>  # optimized C SHA1 routine.
>  #
> @@ -1054,6 +1058,9 @@ ifeq ($(uname_S),Darwin)
>  			BASIC_LDFLAGS +=3D -L/opt/local/lib
>  		endif
>  	endif
> +	ifndef NO_COMMON_DIGEST_FOR_OPENSSL
> +		COMMON_DIGEST_FOR_OPENSSL =3D YesPlease
> +	endif
>  	NO_REGEX =3D YesPlease
>  	PTHREAD_LIBS =3D
>  endif
> @@ -1389,10 +1396,16 @@ ifdef PPC_SHA1
>  	LIB_OBJS +=3D ppc/sha1.o ppc/sha1ppc.o
>  	LIB_H +=3D ppc/sha1.h
>  else
> +ifdef COMMON_DIGEST_FOR_OPENSSL
> +	BASIC_CFLAGS +=3D -DCOMMON_DIGEST_FOR_OPENSSL
> +	SHA1_HEADER =3D <CommonCrypto/CommonDigest.h>
> +else
>  	SHA1_HEADER =3D <openssl/sha.h>
>  	EXTLIBS +=3D $(LIB_4_CRYPTO)
>  endif
>  endif
> +endif
> +
>  ifdef NO_PERL_MAKEMAKER
>  	export NO_PERL_MAKEMAKER
>  endif
