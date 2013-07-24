From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/4] tests: add new test for the url_normalize function
Date: Wed, 24 Jul 2013 10:14:59 -0700
Message-ID: <7vy58v6fsc.fsf@alter.siamese.dyndns.org>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
	<60d85be89d27515d913ae15e10c332f@f74d39fa044aa309eaea14b9f57fe79>
	<20130724065933.GC30074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 24 19:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V22ee-0000kw-KY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 19:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab3GXRPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 13:15:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab3GXRPE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 13:15:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 880812C5AA;
	Wed, 24 Jul 2013 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BNDR5/57AVPXAQQwcH0FAY11x60=; b=gp91EP
	6txoBq+VTnhVsQtNP3MrmCqoz6bP19di7PWFs8vAE/F9HqmZQJXvYr/z7I9cmzGl
	T4hamK9YIAtGb/jexhj17N66HNPlXRAfP+guUyyJ41rgP+DvQ6yNoUOEn3ic4CqI
	uw81CMMUBUFiBHV3OorMGURBRL/RhFiJe50ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uUNmkdp5Nd7N0j/t+MW3tAzorn3G6cl2
	dRLiTeyCHil00fvU4gtyYrHa1OUr/O+559ZnMIBSk21yKlmYUXBslUxS7aPZG/xp
	edYo187vr8sN993wsES1rmorpP+rxtmT5+kFUQSUoyOjaQAndBZRe/Rn7mBUU+uS
	XLM8GxlJNkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BDAE2C5A8;
	Wed, 24 Jul 2013 17:15:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 650E62C5A2;
	Wed, 24 Jul 2013 17:15:01 +0000 (UTC)
In-Reply-To: <20130724065933.GC30074@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 24 Jul 2013 02:59:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93152D9A-F484-11E2-B0CA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231107>

Jeff King <peff@peff.net> writes:

> That is, would a shell script ever want to say "what is the value of
> this config variable for url $X"? Certainly our test scripts want to,
> and having a test-* program covers that, but might user scripts want to
> do the same? Or even to introduce its own URL-matched config options?
>
> How hard would it be to convert the "-c" option of test-url-normalize
> into something like:
>
>   git config --file=foo --url http noepsv $URL
>
> which would look for http.$URL.noepsv matches.

Lovely.

>> +#if LIBCURL_VERSION_NUM >= 0x070903
>> +	else if (!strcmp("sslkey", opt_lc.buf))
>> +		printf("%s\n", ssl_key);
>> +#endif
>> +#if LIBCURL_VERSION_NUM >= 0x070908
>> +	else if (!strcmp("sslcapath", opt_lc.buf))
>> +		printf("%s\n", ssl_capath);
>> +#endif
>> [...]
>
> Do we need to have the complete list of options here, including curl
> version limitations? It seems like this will eventually get out of date
> with the list of options. Would it be sufficient to test just one (or
> even just handle a fake "http.$URL.foo" variable)?

Yeah, and that will be in line with "git config --url" direction.

Another thing we may want to consider is to see if we can
restructure the http_options interface a bit, so that the caller can
be agonistic to the actual meaning of the key.  For example,

  "git config --url http notknownyet $URL" 

may want to be able to show the value for http.<pattern>.notknownyet
for the most matching <pattern> for a given $URL, without knowing
what the variable means, just like any other configuration that is
queried via the "git config" program.  The caller may want to pass
further type information like --bool, --int and --path as needed.

>> +#define url_normalize(u) http_options_url_normalize(u)
>
> Does this macro do anything besides shorten the name? Is the extra
> level of indirection to the reader worth it?

Probably not.

Thanks.
