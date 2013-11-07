From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] ewah_bitmap.c: Fix printf format warnings on MinGW
Date: Thu, 07 Nov 2013 15:01:17 -0800
Message-ID: <xmqq7gcjq0jm.fsf@gitster.dls.corp.google.com>
References: <527C1069.1080000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 08 00:01:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeYZx-0000lm-4w
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 00:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077Ab3KGXB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 18:01:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65030 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018Ab3KGXBW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 18:01:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 350415189B;
	Thu,  7 Nov 2013 18:01:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3z5oK1xvp3a8bwDIt59k7AmE3IU=; b=YpLPbO
	lwVY1g9xsH38tO4dS1d0/C71XCqKW6YQes5UowkeK3nXflC+lbS0N1eHyRNhHK5N
	7vKMA4As1GuNeiQObZVFRJbbMFxaadpDLGCMw5s1ekFWannsn6cCWMvTiaqkF3FQ
	oORJhEVbNW3y1zjUrJK9nYJqYIMLkXoG3UAI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gcZmjsx62lA0mdufReRSZCUbwAKnvo+6
	FRJZk6tnSxh7uXYkCmvpuB0AOKd0g/3fU+nJW1akeKnF1eiZQ3Cs1AX0P7i55fFe
	kM0WxrLkxIV+GX0BUj24fRTiAMnd9du99unXTwh8MB/lcD+pPRTzLejGnX1PAC+S
	TtspnlQxtTQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 280F25189A;
	Thu,  7 Nov 2013 18:01:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69FF951899;
	Thu,  7 Nov 2013 18:01:21 -0500 (EST)
In-Reply-To: <527C1069.1080000@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 07 Nov 2013 22:12:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 84AE14EA-4800-11E3-81DF-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237444>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On MinGW, gcc complains as follows:
>
>         CC ewah/ewah_bitmap.o
>     ewah/ewah_bitmap.c: In function 'ewah_dump':
>     ewah/ewah_bitmap.c:389: warning: unknown conversion type \
>         character 'z' in format
>     ewah/ewah_bitmap.c:389: warning: unknown conversion type \
>         character 'z' in format
>     ewah/ewah_bitmap.c:389: warning: too many arguments for format
>     ewah/ewah_bitmap.c:392: warning: unknown conversion type \
>         character 'l' in format
>     ewah/ewah_bitmap.c:392: warning: too many arguments for format
>
> In order to suppress the warnings, use the PRIuMAX and PRIx64 macros
> from the <inttypes.h> header file.

Good; it is in line with 28bd70d8 (unbreak and eliminate
NO_C99_FORMAT, 2011-03-16) and 3efb1f34 (Check for PRIuMAX rather
than NO_C99_FORMAT in fast-import.c., 2007-02-20).

Thanks.


> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  ewah/ewah_bitmap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index 625f5a6..1e363b9 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -22,6 +22,7 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <stdio.h>
> +#include <inttypes.h>
>  
>  #include "ewok.h"
>  #include "ewok_rlw.h"
> @@ -386,10 +387,11 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
>  void ewah_dump(struct ewah_bitmap *self)
>  {
>  	size_t i;
> -	fprintf(stderr, "%zu bits | %zu words | ", self->bit_size, self->buffer_size);
> +	fprintf(stderr, "%"PRIuMAX" bits | %"PRIuMAX" words | ",
> +		(uintmax_t)self->bit_size, (uintmax_t)self->buffer_size);
>  
>  	for (i = 0; i < self->buffer_size; ++i)
> -		fprintf(stderr, "%016llx ", (unsigned long long)self->buffer[i]);
> +		fprintf(stderr, "%016"PRIx64" ", (unsigned long long)self->buffer[i]);
>  
>  	fprintf(stderr, "\n");
>  }
