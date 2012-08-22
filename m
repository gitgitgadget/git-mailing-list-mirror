From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Wed, 22 Aug 2012 11:17:22 -0700
Message-ID: <7v7gsq94gd.fsf@alter.siamese.dyndns.org>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de>
 <7v8vd6alqe.fsf@alter.siamese.dyndns.org>
 <003001cd808b$9d505730$d7f10590$@schmitz-digital.de>
 <7vk3wq964r.fsf@alter.siamese.dyndns.org>
 <003c01cd808f$f24e2a60$d6ea7f20$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:17:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4FUp-00085F-52
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933218Ab2HVSR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:17:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933208Ab2HVSRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:17:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B5329EE2;
	Wed, 22 Aug 2012 14:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SvqevrFP2nnNkdcbEmz4plNuamM=; b=O/J3xm
	fES4q8GUNanlVkpCW1lF2IiMnlAA/2arrtrnmsNpHzDRb4ZKauDOS7W+1TIB8gan
	9z9v2eyJv60PpORx4WozFPrs+EjfybTyHo+CEI9ZbxJIdDSyj/NAYFoiiq1+spbr
	jvjg822TnnAblWuOzT/AgTZ2S0AnMC/Zne+xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BwsPy/Xr/bF9iXHGjhK/Hxz6zEQ7zsq7
	m+OwBiMU1XRDM47xlY0DVETlQ77+A+5tGnWMazZa/dkbUrjxWrsniwNaIjQcgH+e
	zSS69K0TEeI5CrHxCV7dB8eYgu323XFsuH6UEgH9X8RPp8QKqpb3GC3kQp/2Rz2N
	I9N/13Ktomk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 790A39EE1;
	Wed, 22 Aug 2012 14:17:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2EAB9EE0; Wed, 22 Aug 2012
 14:17:23 -0400 (EDT)
In-Reply-To: <003c01cd808f$f24e2a60$d6ea7f20$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 19:59:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EE93178-EC85-11E1-83E4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204058>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>
> This reverts be22d92 (http: avoid empty error messages for some curl errors,
> 2011-09-05) on platforms with older versions of libcURL.
>
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
>  http.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/http.c b/http.c
> index b61ac85..18bc6bf 100644
> --- a/http.c
> +++ b/http.c
> @@ -806,10 +806,12 @@ static int http_request(const char *url, void *result,
> int target, int options)

Likewrapped X-<

>  				ret = HTTP_REAUTH;
>  			}
>  		} else {
> +#if LIBCURL_VERSION_NUM >= 0x070c00
>  			if (!curl_errorstr[0])
>  				strlcpy(curl_errorstr,
>  
> curl_easy_strerror(results.curl_result),
>  					sizeof(curl_errorstr));
> +#endif
>  			ret = HTTP_ERROR;
>  		}
>  	} else {
