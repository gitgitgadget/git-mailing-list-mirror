From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0200: "locale" may not exist
Date: Wed, 19 Dec 2012 07:28:24 -0800
Message-ID: <7vd2y6awo7.fsf@alter.siamese.dyndns.org>
References: <7vlicubkt4.fsf@alter.siamese.dyndns.org>
 <20121219131822.GB7134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 16:28:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlLZd-00064i-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 16:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab2LSP22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 10:28:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62384 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab2LSP21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 10:28:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 807D4AA20;
	Wed, 19 Dec 2012 10:28:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1FA4p9YW5vo9m8a528TynfzI1mY=; b=idlKmU
	CqbyXkRvqx9Pk9YO8XCu3VDdrqR3UsbKgvTG6xe6uQ79Yc2asoJ97pINZpW+uoB/
	mvOAjxXYGR6CBa4/hlkLAS2z4aCJuY0ig+uLeH+KQdhGcd7xIKYi8KzpoBDDf1eV
	to7yK4W3F9oaT8VituD3AhY40/hTz5HQHtsZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ISE8XYpP1yVHrU14exGSSYwO8+buIclH
	88RbrbQZDCv4hkuMf2DeVX5QvxE/77B7h41VplO5eYsi8R0c5oyHoADjELgzFYfl
	pONtOKKPZQ1QHV2zgkmJOEbMRyJFjXYqDIQZXhEmO2dle2GiYM+nBVcU68bJUIIw
	a3jLqw/xcIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DCA1AA1F;
	Wed, 19 Dec 2012 10:28:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C63C5AA1D; Wed, 19 Dec 2012
 10:28:25 -0500 (EST)
Importance: high
In-Reply-To: <20121219131822.GB7134@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Dec 2012 08:18:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB519EF4-49F0-11E2-9310-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211826>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 18, 2012 at 10:47:03PM -0800, Junio C Hamano wrote:
>
>> On systems without "locale" installed, t0200-gettext-basic.sh leaked
>> error messages when checking if some test locales are available.
>> Hide them, as they are not very useful.
>
> Obviously correct, though there is another way:
>
>> diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
>> index 0f76f6c..ae8883a 100644
>> --- a/t/lib-gettext.sh
>> +++ b/t/lib-gettext.sh
>> @@ -14,12 +14,14 @@ export GIT_TEXTDOMAINDIR GIT_PO_PATH
>>  if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
>
> If we turn this line into:
>
>   test_expect_success GETTEXT,!GETTEXT_POISON 'setup locale' '
>
> then people can see the error output of the setup step in verbose mode.

Ok, so it was not obviously "correct" after all ;-)

> +test_expect_success GETTEXT,!GETTEXT_POISON 'setup locale' '
>  	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
> -	is_IS_locale=$(locale -a | sed -n '/^is_IS\.[uU][tT][fF]-*8$/{
> +	is_IS_locale=$(locale -a | sed -n "/^is_IS\.[uU][tT][fF]-*8\$/{

Do we need to do this \$?

>  		p
>  		q
> -	}')
> +	}")
>  	# is_IS.ISO8859-1 on Solaris and FreeBSD, is_IS.iso88591 on Debian
> -	is_IS_iso_locale=$(locale -a | sed -n '/^is_IS\.[iI][sS][oO]8859-*1$/{
> +	is_IS_iso_locale=$(locale -a | sed -n "/^is_IS\.[iI][sS][oO]8859-*1\$/{
>  		p
>  		q
> -	}')
> +	}")
>  
>  	# Export them as an environment variable so the t0202/test.pl Perl
>  	# test can use it too
> @@ -37,7 +36,7 @@ then
>  		# Exporting for t0202/test.pl
>  		GETTEXT_LOCALE=1
>  		export GETTEXT_LOCALE
> -		say "# lib-gettext: Found '$is_IS_locale' as an is_IS UTF-8 locale"
> +		say "# lib-gettext: Found \"$is_IS_locale\" as an is_IS UTF-8 locale"

'\''?
