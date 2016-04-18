From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/6] remote-curl.c: fix variable shadowing
Date: Mon, 18 Apr 2016 11:35:10 -0700
Message-ID: <xmqqega26a01.fsf@gitster.mtv.corp.google.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 20:35:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asE12-0003Yw-Qr
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 20:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbcDRSfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 14:35:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751671AbcDRSfN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 14:35:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE546139FB;
	Mon, 18 Apr 2016 14:35:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TpbiudBD8H633/AkXlJwSZG050g=; b=SlNEAD
	+7af+ZkRL3y8bXdz/aCSmPy0KUbsBZx3Hk/60yVfQYkHEH4mOLUK08h/GIKBf3Ej
	+7Lpst4Y3QbrVZyMhMk/bR5zvizXZ0H8rYaw1cOdkOgRFZrkGwlV0Ec95DjCcVQz
	2AXYP0p4uad7Gu0mj382XRGdGqc+w4E30xr1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpgSKAjeNS048abkntYB7LiKluO5jwJ3
	oOgw87TW8NWRI5nLQYW/E4dqQZRn0HGpjpkhZUIh92yMoKBaEQywV+b3Qds3TSY/
	tmcnKbj5HGmGtevQV+5nYIkSRG10Z0MDjDh6v23lRSX9yDB58AD6Qhi64mgb9FXY
	vhUqT1qE/js=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C7BA6139FA;
	Mon, 18 Apr 2016 14:35:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44488139F8;
	Mon, 18 Apr 2016 14:35:11 -0400 (EDT)
In-Reply-To: <1460747949-3514-3-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 15 Apr 2016 15:19:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 489CE392-0594-11E6-9DC4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291818>

David Turner <dturner@twopensource.com> writes:

> The local variable 'options' was shadowing a global of the same name.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

OK.  In general, giving a longer and more descriptive name to the
global would be a direction to lead to more readable code, though.

>  remote-curl.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 15e48e2..b9b6a90 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -254,7 +254,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  	struct strbuf effective_url = STRBUF_INIT;
>  	struct discovery *last = last_discovery;
>  	int http_ret, maybe_smart = 0;
> -	struct http_get_options options;
> +	struct http_get_options get_options;
>  
>  	if (last && !strcmp(service, last->service))
>  		return last;
> @@ -271,15 +271,15 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  		strbuf_addf(&refs_url, "service=%s", service);
>  	}
>  
> -	memset(&options, 0, sizeof(options));
> -	options.content_type = &type;
> -	options.charset = &charset;
> -	options.effective_url = &effective_url;
> -	options.base_url = &url;
> -	options.no_cache = 1;
> -	options.keep_error = 1;
> +	memset(&get_options, 0, sizeof(get_options));
> +	get_options.content_type = &type;
> +	get_options.charset = &charset;
> +	get_options.effective_url = &effective_url;
> +	get_options.base_url = &url;
> +	get_options.no_cache = 1;
> +	get_options.keep_error = 1;
>  
> -	http_ret = http_get_strbuf(refs_url.buf, &buffer, &options);
> +	http_ret = http_get_strbuf(refs_url.buf, &buffer, &get_options);
>  	switch (http_ret) {
>  	case HTTP_OK:
>  		break;
