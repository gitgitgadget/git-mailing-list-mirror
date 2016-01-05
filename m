From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/15] ref-filter: convert variable 'width' to an unsigned int
Date: Tue, 05 Jan 2016 13:12:32 -0800
Message-ID: <xmqqmvsjivcv.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-12-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 22:12:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGYuP-0000nJ-W0
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 22:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbcAEVMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 16:12:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752245AbcAEVMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 16:12:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 411DA384D5;
	Tue,  5 Jan 2016 16:12:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oMRxF8EiZa5UJ0gynlx+WSBFFPU=; b=szqFsU
	jo3f6DXgxEITTYz1l/dzImn5jZ/GXf8H+VRWd0YS4HfzQy/bMOlRcWeFB4mXP0hU
	8T9b6zlaZfoQIEFYdgVdqgCLGEfuSoVC+McWHilD6V2INm2ezX1ivr3uc87MsXPC
	vXGDB1vSBv9VqUtLG6dp0Hv5KsQDsEkkYnYjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PBVqVOcVLM7/qod12FPDs8CG8/fhfCPs
	4hYbGFGvae4RYYjzC/gYefzYQSTmKcXMLW23EQKkHclm2V9CODa8iMqdoYJjbw2o
	q/7MyZzwYVpWEv9GbKkLLrEzQCkKZ9vmQyR858Jdw5Xs2hAirKdEqaQEOljNG0wx
	zCX9Vf4fAdQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38E9F384D4;
	Tue,  5 Jan 2016 16:12:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AB260384D3;
	Tue,  5 Jan 2016 16:12:33 -0500 (EST)
In-Reply-To: <1451980994-26865-12-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 5 Jan 2016 13:33:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09C69392-B3F1-11E5-9B41-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283402>

Karthik Nayak <karthik.188@gmail.com> writes:

> In align_atom_parser() the 'width' variable is an int, which requires
> an explicit type conversion when used in strtoul_ui(). Hence make it
> an unsigned int.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---

Shouldn't this be done in [09/15] from the beginning?  As it's not
like [09/15] was a pure code movement, this step looks like "Oops,
I screwed up earlier, and here is a fixup".

If we want to do this as a separate step, it would be easier to
follow if it is done _before_ 09/15 to the original of the code
movement, I think.

>  ref-filter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index ccad4c3..4f623a0 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -90,7 +90,7 @@ static void align_atom_parser(struct used_atom *atom)
>  	struct align *align = &atom->u.align;
>  	const char *buf = NULL;
>  	struct strbuf **s, **to_free;
> -	int width = -1;
> +	unsigned int width = ~0U;
>  
>  	if (!match_atom_name(atom->name, "align", &buf))
>  		die("BUG: parsing non-'align'");
> @@ -104,7 +104,7 @@ static void align_atom_parser(struct used_atom *atom)
>  		int position;
>  		buf = s[0]->buf;
>  
> -		if (!strtoul_ui(buf, 10, (unsigned int *)&width))
> +		if (!strtoul_ui(buf, 10, &width))
>  			;
>  		else if ((position = parse_align_position(buf)) >= 0)
>  			align->position = position;
> @@ -113,7 +113,7 @@ static void align_atom_parser(struct used_atom *atom)
>  		s++;
>  	}
>  
> -	if (width < 0)
> +	if (width == ~0U)
>  		die(_("positive width expected with the %%(align) atom"));
>  	align->width = width;
>  	strbuf_list_free(to_free);
