From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send.c: set CURLOPT_USE_SSL to CURLUSESSL_TRY
Date: Tue, 06 Jan 2015 12:19:12 -0800
Message-ID: <xmqqiogjoe67.fsf@gitster.dls.corp.google.com>
References: <31f38398d53bcfb1d659cd248db522e@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bernhard Reiter <ockham@raz.or.at>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 21:19:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8abA-0005Dg-AQ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 21:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844AbbAFUTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 15:19:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751338AbbAFUTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 15:19:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C86D2C598;
	Tue,  6 Jan 2015 15:19:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xfnb5HkCIcAYFHcKwxQ2XAl8o+Q=; b=UfzlV/
	AfF4c7HwuMwFoQ2w9zkkn+1uPfhdLWk+51VVbA1cMQQV8Tg+U0yDDkExQ1H74pBq
	fFsPKsWxppGQYuwu/smFZBH8ZR+aEHliWFNjrLIgZYh9DnjqNGG8o6O3xFrjIx3l
	JVxQ9zAS4YaPs5PfwQkAzLsqaSkuUFz2OS6fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ouL9f+js7WEUa7Eb7R9y5mFqvfRRWCS7
	BntskyDbtacidobkAdGnSWR4VAgRXpsY2chyQVtMYugiMbq162B6N9Ycpg+hYFwM
	GPoB059ccdUkuqfXCSU1y4q05jdRTpeL0uoEByGJFlVCNNjwufywlBnj84wWnPnX
	iMzQOaA0J5Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 432F12C594;
	Tue,  6 Jan 2015 15:19:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9FB12C58C;
	Tue,  6 Jan 2015 15:19:13 -0500 (EST)
In-Reply-To: <31f38398d53bcfb1d659cd248db522e@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Tue, 6 Jan 2015 03:20:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4818B4CE-95E1-11E4-A604-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262100>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> According to the cURL documentation for the CURLOPT_USE_SSL option,
> it is only used with plain text protocols that get upgraded to SSL
> using the STARTTLS command.
>
> The server.use_ssl variable is only set when we are using a protocol
> that is already SSL/TLS (i.e. imaps), so setting CURLOPT_USE_SSL
> when the server.use_ssl variable is set has no effect whatsoever.
>
> Instead, set CURLOPT_USE_SSL to CURLUSESSL_TRY when the server.use_ssl
> variable is NOT set so that cURL will attempt to upgrade the plain
> text connection to SSL/TLS using STARTTLS in that case.
>
> This much more closely matches the behavior of the non-cURL code path.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---

It sounds sensible from the description of the approach but I'd
prefer independent opinion to sanity-check me.  Will queue while
waiting for others to speak up.

Thanks.

>
> *** PATCH IS AGAINST NEXT ***
>
> In particular, this patch requires br/imap-send-via-libcurl
>
>
>  imap-send.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 4dfe4c25..5251b750 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1421,8 +1421,8 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>  		strbuf_release(&auth);
>  	}
>  
> -	if (server.use_ssl)
> -		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_ALL);
> +	if (!server.use_ssl)
> +		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_TRY);
>  
>  	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, server.ssl_verify);
>  	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, server.ssl_verify);
