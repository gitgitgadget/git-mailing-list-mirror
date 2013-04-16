From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 10:18:16 -0700
Message-ID: <7va9oyo0mf.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <20130415232532.GA7134@sigill.intra.peff.net>
 <20130416003038.GA5336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 19:18:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US9WT-0002xm-69
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 19:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935999Ab3DPRSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 13:18:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935825Ab3DPRSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 13:18:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51DCF17C32;
	Tue, 16 Apr 2013 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NzUo37h1RyWpRcoVn0spsS1nEsU=; b=lqA9Gr
	dF9IOrXqYCUsTYLrC9mWKFR5EZlucvk4v2QXTUF4C72Bxl9LTr2KY7fTs2aDhcZA
	oaOJ7BLZBEA3rPnx2ILeybzIorNZfsnhlqZjVIb91mCTIIDJz0DQ2KY0kmjBpscO
	0Xp361hkZVENmKxPbNkxfLS0dS92V65uXZU9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JhqAMNRB1l6PWUo3s+Wtk9yl+zLOVi0A
	Hf5UeuYdSjhEqH5tQZdBBddto+lhnL409UJE5WuSfX5SgYmcc6qm4ORXhWwku9xD
	EsNUIN0QoL0Pq7g7MOQCX8pOLqiIWywyHsB+p0noP+Bn1h7mR7vqZ7ASU1Jas3GO
	h751J3f85CY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44E6217C31;
	Tue, 16 Apr 2013 17:18:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 969F817C2D; Tue, 16 Apr
 2013 17:18:18 +0000 (UTC)
In-Reply-To: <20130416003038.GA5336@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 15 Apr 2013 20:30:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1AE7C1C-A6B9-11E2-89EE-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221430>

Jeff King <peff@peff.net> writes:

> The solution is simple: now that FAILONERROR is a
> per-request setting, we move it to get_active_slot to make
> sure it is reset for each request.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Hmph. I have no idea how this ever passed the tests, so I can only
> assume that I screwed up in running them. I even recall considering this
> issue while writing the patches, but I mixed up which of get_curl_handle
> and get_active_slot it needed to be in when I did so.

Thanks.

>  http.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index 58c063c..48d4ff6 100644
> --- a/http.c
> +++ b/http.c
> @@ -282,7 +282,6 @@ static CURL *get_curl_handle(void)
>  #endif
>  	if (ssl_cainfo != NULL)
>  		curl_easy_setopt(result, CURLOPT_CAINFO, ssl_cainfo);
> -	curl_easy_setopt(result, CURLOPT_FAILONERROR, 1);
>  
>  	if (curl_low_speed_limit > 0 && curl_low_speed_time > 0) {
>  		curl_easy_setopt(result, CURLOPT_LOW_SPEED_LIMIT,
> @@ -506,6 +505,7 @@ struct active_request_slot *get_active_slot(void)
>  	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
>  	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
> +	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
>  	if (http_auth.password)
>  		init_curl_http_auth(slot->curl);
Thanks
