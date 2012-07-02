From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7] git on Mac OS and precomposed unicode
Date: Mon, 02 Jul 2012 15:21:39 -0700
Message-ID: <7vr4styfbg.fsf@alter.siamese.dyndns.org>
References: <201207022232.51737.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 00:22:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slp0j-0006Pj-Q8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025Ab2GBWVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jul 2012 18:21:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34260 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab2GBWVn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2012 18:21:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71ED38DB1;
	Mon,  2 Jul 2012 18:21:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Y4/h8As9TF2m
	gEGrLrF8w5OGvHA=; b=XaGOcChctOlk4QQXH/4YWyxOjqyq3ENmcmI0c/KxUweg
	liix9fSaQmTW9KhWA5sD6MUxih0pZoBakGAekH51MnWtLBJ1Oc0rD06yKJqWhHvx
	oDi/GqmzWyhTggkyZC+qyhvSB4dgLuqNepAFtoF4ay8Ql/FJXtXJ0ADg9lEqZno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qJxXB1
	YHjauXfYEB/B4+8SZqLSqV6E3ipva9y6uhs2qojXGziDr7CXmtk8LsoIJQJDwlBC
	bJkToaWQwuTqzpHJNVjYg7pkl1Kt7uy0u3AcAytvD4QP8yB8q/ba02+qkYnYSEe8
	xh57AAlguTWqFJGiP6kTjUdd49Xp1mdyGWG74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 690488DB0;
	Mon,  2 Jul 2012 18:21:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C8668DA8; Mon,  2 Jul 2012
 18:21:41 -0400 (EDT)
In-Reply-To: <201207022232.51737.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Mon, 2 Jul 2012 22:32:50
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C8FE2A0-C494-11E1-8417-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200867>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> +core.precomposedunicode::
> +	...
> +	When false, file names are handled fully transparent by git, which =
means
> +	that file names are stored as decomposed unicode in the repository.

I do not think it means any such thing.

We just take whatever the platform throws at us and shove that in
the repository.  On MacOS X with HFS+, it may be decomposed UTF-8,
but we do not even try to ensure everything (like the path added by
somebody else on a BSD system in a commit that you fetched) is in a
particular encoding.

> diff --git a/Makefile b/Makefile
> index f62ca2a..55ceb10 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -607,6 +607,7 @@ LIB_H +=3D compat/bswap.h
>  LIB_H +=3D compat/cygwin.h
>  LIB_H +=3D compat/mingw.h
>  LIB_H +=3D compat/obstack.h
> +LIB_H +=3D compat/precomposed_utf8.h

Micronit.  Shouldn't these all be called "precompose_utf8"
throughout the patch?

We are asking Git "please normalize by precompose any UTF-8
pathnames" when we give the -DPRECOMPOSE_UNICODE C-preprocessor
macro, and compat/precompose_utf8.[ch] are to implement the
machinery to do so.

> diff --git a/compat/precomposed_utf8.c b/compat/precomposed_utf8.c
> new file mode 100644
> index 0000000..14bb0ce
> --- /dev/null
> +++ b/compat/precomposed_utf8.c
> @@ -0,0 +1,189 @@
> +/* Converts filenames from decomposed unicode into precomposed unico=
de.
> +   Used on MacOS X.
> +*/

Micronit.

	/*
         * Multi-line comments begin by slash asterisk newline.
         * and ends with a run of SP to align asterisk, asterisk
         * and then newline, like this.
         */
> +#define __PRECOMPOSED_UNICODE_C__
> +
> +#include "cache.h"
> +#include "utf8.h"
> +#include "precomposed_utf8.h"


> +#include "stdio.h"

You shouldn't need "stdio.h" as you are including "git-compat-util.h"
via "cache.h".

> diff --git a/compat/precomposed_utf8.h b/compat/precomposed_utf8.h
> new file mode 100644
> index 0000000..708a1c6
> --- /dev/null
> +++ b/compat/precomposed_utf8.h
> ...
> +#ifndef __PRECOMPOSED_UNICODE_C__
> +#define dirent dirent_prec_psx
> +#define opendir(n) precomposed_utf8_opendir(n)
> +#define readdir(d) precomposed_utf8_readdir(d)
> +#define closedir(d) precomposed_utf8_closedir(d)
> +#define DIR PREC_DIR
> +#endif /* __PRECOMPOSED_UNICODE_C__ */

Hrm, this is not wrong per-se, but looks somewhat unwieldy.

> +#define  __PRECOMPOSED_UNICODE_H__
> +#endif /* __PRECOMPOSED_UNICODE_H__ */

> diff --git a/utf8.c b/utf8.c
> index 8acbc66..a544f15 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -433,19 +433,12 @@ int is_encoding_utf8(const char *name)
> ...
> @@ -478,6 +470,20 @@ char *reencode_string(const char *in, const char=
 *out_encoding, const char *in_e
>  			break;
>  		}
>  	}
> +	return out;
> +}
> +
> +char *reencode_string(const char *in, const char *out_encoding, cons=
t char *in_encoding)
> +{
> +	iconv_t conv;
> +	char *out;
> +
> +	if (!in_encoding)
> +		return NULL;
> +	conv =3D iconv_open(out_encoding, in_encoding);
> +	if (conv =3D=3D (iconv_t) -1)
> +		return NULL;
> +	out =3D reencode_string_iconv(in, strlen(in), conv);
>  	iconv_close(conv);
>  	return out;
>  }

Much nicer ;-).
