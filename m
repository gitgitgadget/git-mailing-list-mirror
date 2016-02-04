From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] ident.c: cleanup wrt ident's source
Date: Thu, 04 Feb 2016 14:42:55 -0800
Message-ID: <xmqqvb64f66o.fsf@gitster.mtv.corp.google.com>
References: <1454577160-24484-1-git-send-email-alonid@gmail.com>
	<1454577160-24484-4-git-send-email-alonid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 23:43:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRScB-0007y9-FQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbcBDWm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:42:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754173AbcBDWm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:42:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C4B4412A0;
	Thu,  4 Feb 2016 17:42:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kdEVgaYvrNgBg+rcRj5Fd22kBBE=; b=YhJKZA
	+bk0uWwfk6moHeAYF+e5ngjuVDk2VG/ojw9R21zemenQ7JJusrnK+2IFv17qFr9s
	9SDLML/5csfpVrzpFYhOo/hBbJd7YPWAT3qmPeflmz+RME7VYESMb2DZ1/pGGbFP
	En2QeUQjSY75V3Cn42kqT4TuBWPK286vjJLeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E/7llp2QvptBB0OL7NdWPg/dDDUsUzZ0
	gbxMHLzLZ5YA7baTCQRO0q/95w5evMAQ9CCCMtkTAltvJtig4oBxxG1irZjXEkFF
	SbXp7WjeVbK2NzRaDsuJPzGvr6PEZ/IVpxpoABcpA8mEDhN+23Ld8ad9C/RDcCHT
	WkrP5ZxOYvc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FEE64129F;
	Thu,  4 Feb 2016 17:42:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 159644129E;
	Thu,  4 Feb 2016 17:42:57 -0500 (EST)
In-Reply-To: <1454577160-24484-4-git-send-email-alonid@gmail.com> (Dan Aloni's
	message of "Thu, 4 Feb 2016 11:12:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2C1C024-CB90-11E5-8C28-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285512>

Dan Aloni <alonid@gmail.com> writes:

> +static int ident_source_is_sufficient(enum ident_source source)
> +{
> +	switch (source) {
> +	case IDENT_SOURCE_CONFIG:
> +	case IDENT_SOURCE_ENVIRONMENT:
> +		return 1;

Without adding these two lines here:

	default:
        	break;

I get this build failure:

ident.c: In function 'ident_source_is_sufficient':
ident.c:444:2: error: enumeration value 'IDENT_SOURCE_UNKNOWN' not handled in switch [-Werror=switch]
  switch (source) {
  ^
ident.c:444:2: error: enumeration value 'IDENT_SOURCE_GUESSED' not handled in switch [-Werror=switch]
ident.c:444:2: error: enumeration value 'IDENT_SOURCE_GUESSED_BOGUS' not handled in switch [-Werror=switch]

> +static int ident_is_sufficient(enum ident_person person)
>  {
> +	const char *str_name, *str_email;
> +	int name, email;
> +
> +	switch (person) {
> +	case IDENT_PERSON_COMMITTER:
> +		str_name = getenv("GIT_COMMITTER_NAME");
> +		str_email = getenv("GIT_COMMITTER_EMAIL");
> +		break;
> +	case IDENT_PERSON_AUTHOR:
> +		str_name = getenv("GIT_AUTHOR_NAME");
> +		str_email = getenv("GIT_AUTHOR_EMAIL");
> +		break;
> +	default:
> +		die("invalid parameter to ident_is_sufficient()");
> +	}
> +
> +	name = !!str_name || ident_source_is_sufficient(source_of_default_name);
> +	email = !!str_email || ident_source_is_sufficient(source_of_default_email);
> +
>  #ifndef WINDOWS
> -	return (user_ident_explicitly_given & IDENT_MAIL_GIVEN);
> +	return email;
>  #else
> -	return (user_ident_explicitly_given == IDENT_ALL_GIVEN);
> +	return name && email;
>  #endif
>  }

It appears that str_name and name are unconditionally computed even
though it does not affect the outcome of the whole thing.  When
building for !WINDOWS, I get

ident.c: In function 'ident_is_sufficient':
ident.c:456:6: error: variable 'name' set but not used [-Werror=unused-but-set-variable]
  int name, email;
      ^
cc1: all warnings being treated as errors
make: *** [ident.o] Error 1

as the result of this.
