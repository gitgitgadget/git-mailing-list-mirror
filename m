From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Wed, 22 Aug 2012 10:41:08 -0700
Message-ID: <7vk3wq964r.fsf@alter.siamese.dyndns.org>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de>
 <7v8vd6alqe.fsf@alter.siamese.dyndns.org>
 <003001cd808b$9d505730$d7f10590$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:41:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Evf-0007DY-JC
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab2HVRlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:41:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58300 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab2HVRlM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:41:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFFA49635;
	Wed, 22 Aug 2012 13:41:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IgzaypVstS7GyLl/wVB4zG/J1fU=; b=IdPfNw
	uJTEZkO/QtlJGBaLQH901YGWz9ewFIxCzf8lueV6iMtRxr9J4sfU0eSFsUyNIp76
	xNZTEVPvfw8ijAEOSBEjc6HV8J6WFDQcuXBt7FA2eDUp+/BSHbuK1VE30g3Y7nyi
	D02tVKrE7chBRiO2cDLA5emNTlkCYoNhui5S4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RZNGGAuvoeT2kRqAdh5zqW/e7RDUPsEG
	GrDNnlK8b8uMS1TvD6WF2t4lALcbaTGdJQqrLXrx1SBvpG1GaNHCSoMOpL9S0XrC
	Bz45pCHdB/h1dbndP592Ga/hXhe3RWUgR9GhEJGYf4+wZZ6GqQzH760LOQ7hCixI
	eUd4uOhMxew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB7B9634;
	Wed, 22 Aug 2012 13:41:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38F7B9632; Wed, 22 Aug 2012
 13:41:10 -0400 (EDT)
In-Reply-To: <003001cd808b$9d505730$d7f10590$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 19:28:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F535504-EC80-11E1-8A61-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204044>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Like this:
> ----
>
> This reverts be22d92 (http: avoid empty error messages for some curl errors,
> 2011-09-05) on platforms with older versions of libcURL.
>
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---

Perfect ;-)

>  http.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/http.c b/http.c
> index b61ac85..18bc6bf 100644
> --- a/http.c
> +++ b/http.c
> @@ -806,10 +806,12 @@ static int http_request(const char *url, void *result,
> int target, int options)
>                                 ret = HTTP_REAUTH;
>                         }

Now we need to see where these whitespace breakages are coming from
and fix it, and I think it should be done earlier than later, as I
expect we will be seeing more patches from you in the coming weeks.

>                 } else {
> +#if LIBCURL_VERSION_NUM >= 0x070c00
>                         if (!curl_errorstr[0])
>                                 strlcpy(curl_errorstr,
>  
> curl_easy_strerror(results.curl_result),
>                                         sizeof(curl_errorstr));
> +#endif
>                         ret = HTTP_ERROR;
>                 }
>         } else {
> --
> 1.7.12
>
> Bye, Jojo
