From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Wed, 22 Aug 2012 10:18:49 -0700
Message-ID: <7v8vd6alqe.fsf@alter.siamese.dyndns.org>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:19:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Ea7-0005eV-Re
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928Ab2HVRSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:18:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47522 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964848Ab2HVRSw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:18:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAF779048;
	Wed, 22 Aug 2012 13:18:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gVw2cza+O15IxzsqFrpZTJDKW5o=; b=W82KPP
	J1Cc3YqWMNleEo/LetZ4L3y7kxHeBDub5YHH8dA1Jh2MYucvoBHvILTP2pxrEzdK
	zIZKBFLOeFvhm/+HFDTv2HQYzsu2FZAvB5Oh5Bpyd/XFtjcYqkOipBzSXppZoZKu
	qhpCvcJ8jnDHRMkEMRD0oB8Sq0EObZAVzAuJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MqqCzGzL87WmrlWcM8aoUVAdTavbdzqC
	1XWHTj3yMkfOjKYJfmo7zPxTTzUsQwahytvZsAP0LLu/7nJEy9mZOGvC2GhOLUHq
	2xLUxjIan/Fa9QAVOwPMlEbz1Ww3TPzJxeRj4KvbmoALy3s0JM6hPzDmGycOaTed
	JoZbz4nMTKo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D90599047;
	Wed, 22 Aug 2012 13:18:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C5739046; Wed, 22 Aug 2012
 13:18:51 -0400 (EDT)
In-Reply-To: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 17:44:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 713A54EE-EC7D-11E1-9D14-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204036>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>

At the very least, please mention that this reverts be22d92 (http:
avoid empty error messages for some curl errors, 2011-09-05) on
platforms with older versions of libcURL.

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
>                                 ret = HTTP_REAUTH;
>                         }
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
