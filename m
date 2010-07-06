From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t0006: test timezone parsing
Date: Tue, 06 Jul 2010 00:01:35 -0700
Message-ID: <7vpqz13xgw.fsf@alter.siamese.dyndns.org>
References: <20100704104834.GA23070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 06 09:01:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW2A8-0001Bl-I2
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 09:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab0GFHBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 03:01:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab0GFHBm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 03:01:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB316C05CD;
	Tue,  6 Jul 2010 03:01:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GptSGQpvEBIRLIEPDN1FaXEE8Wo=; b=ok2BxZ
	Ysr4qo8kU5AGIHrr6+fkaky7xQ4LQeUKQwR1Gz+V4oJ59by8NzFd9o3p9xoLfrTP
	WLlKvPfN6cKJ347Yqti00xI/oiGGur25i+6pm0rXZYr9AW5KkTedxrwkcOc4/Q22
	2K3jXxyKCQtgAcFQok4mCSP3jVmnZ+O3hkFoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nIcnIk+4zXNvApRLD9HcGbgwFH24OUk2
	T3QoZ20SDdyvcVuXvoAMgU9nSOhBWwbRqQysqlLnygb18tLbl/uRvYsAcsdo540b
	NZWoOpuTvr+APNTfcS2p/JQICL10v6DZaUoAdzXsZXFX6Q4SQgmPphhEP2kSvGNm
	HcfPJrNSovs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 865C9C05CC;
	Tue,  6 Jul 2010 03:01:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5EB8C05CB; Tue,  6 Jul
 2010 03:01:36 -0400 (EDT)
In-Reply-To: <20100704104834.GA23070@sigill.intra.peff.net> (Jeff King's
 message of "Sun\, 4 Jul 2010 06\:48\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5336D6BE-88CC-11DF-94EE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150330>

Jeff King <peff@peff.net> writes:

> diff --git a/test-date.c b/test-date.c
> index a9e705f..ac6854a 100644
> --- a/test-date.c
> +++ b/test-date.c
> @@ -21,12 +21,15 @@ static void parse_dates(char **argv, struct timeval *now)
>  	for (; *argv; argv++) {
>  		char result[100];
>  		time_t t;
> +		int tz;
>  
>  		result[0] = 0;
>  		parse_date(*argv, result, sizeof(result));
> -		t = strtoul(result, NULL, 0);
> -		printf("%s -> %s\n", *argv,
> -			t ? show_date(t, 0, DATE_ISO8601) : "bad");
> +		if (sscanf(result, "%ld %d", &t, &tz) == 2)

Gah...

On FreeBSD 8.0, we now see this.

   cc1: warnings being treated as errors
   test-date.c: In function 'parse_dates':
   test-date.c:28: warning: format '%ld' expects type 'long int *', but argument 3 has type 'time_t *'
