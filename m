From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: ensure that URLs do not have a trailing
 slash
Date: Wed, 07 Apr 2010 08:12:30 -0700
Message-ID: <7viq83e1pd.fsf@alter.siamese.dyndns.org>
References: <1270651892-5712-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 17:12:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWvu-0005GW-3M
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 17:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931Ab0DGPMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 11:12:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0DGPMk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 11:12:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A83DA8313;
	Wed,  7 Apr 2010 11:12:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WiDvwXGy8SPAx3O7/sDLIAsqyFs=; b=PkT7ue
	zb8fV8EkMJc3DuYuhuE7M0oWcqjcU9qYmxLasWt646FTA6FcMzmGet1tOesdQYnX
	bUdWnC+t8V1sLqBS/qDP2mDHDmqSE5j7XwrYmtNwkZuXE9qClhtdML7epbWOd0CA
	AE0K+hwkAirDB9ll/8G/ILVnm91tS37oVEgOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W2PeLXfvPExD38DZb/VWZQXBuSE4PVd/
	DrKwqd5FPJMAxM49x/QTJSbd7IYdHPzVvNXs4/WcS79vPwLFK5uqXviiAcl2R4lg
	S4jy7hzwFMlu2U1KsyjKiiUpShIw6XZx6Z0uYhDd0aC0e4M8nnS7R9dV/TAibfQG
	JtFk+z446SY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68593A830F;
	Wed,  7 Apr 2010 11:12:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CA9DA8307; Wed,  7 Apr
 2010 11:12:31 -0400 (EDT)
In-Reply-To: <1270651892-5712-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Wed\,  7 Apr 2010 22\:51\:32 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FFAD62F2-4257-11DF-98B7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144236>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  remote-curl.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 0782756..0f21f8a 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -101,7 +101,8 @@ static struct discovery* discover_refs(const char *service)
>  		return last;
>  	free_discovery(last);
>  
> -	strbuf_addf(&buffer, "%s/info/refs", url);
> +	end_url_with_slash(&buffer, url);
> +	strbuf_addstr(&buffer, "info/refs");
>  	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
>  		is_http = 1;
>  		if (!strchr(url, '?'))
> @@ -120,7 +121,8 @@ static struct discovery* discover_refs(const char *service)
>  		strbuf_reset(&buffer);
>  
>  		proto_git_candidate = 0;
> -		strbuf_addf(&buffer, "%s/info/refs", url);
> +		end_url_with_slash(&buffer, url);
> +		strbuf_addstr(&buffer, "info/refs");
>  		refs_url = strbuf_detach(&buffer, NULL);
>  
>  		http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
> @@ -511,7 +513,8 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
>  	rpc->out = client.out;
>  	strbuf_init(&rpc->result, 0);
>  
> -	strbuf_addf(&buf, "%s/%s", url, svc);
> +	end_url_with_slash(&buf, url)
> +	strbuf_addf(&buf, "%s", svc);
>  	rpc->service_url = strbuf_detach(&buf, NULL);
>  
>  	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);

The code does not look like it is making sure things do not have a
trailing slash.  For example, if svc has trailing slash, either %s/%s or
strbuf_addf() would have the last character of svc in rpc->service_url.

You are fixing something else.

The new code avoids duplicated slashes in the middle if "url" can but does
not necessarily end with a slash.  Is that what you are trying to fix?  I
wonder if it makes more sense to make sure "url" always ends with a slash
at the calling sites where it is obtained from either the end user or from
the running environment...
