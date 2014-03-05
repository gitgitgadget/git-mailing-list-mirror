From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/11] trailer: process trailers from stdin and arguments
Date: Wed, 05 Mar 2014 14:52:47 -0800
Message-ID: <xmqqiors1cn4.fsf@gitster.dls.corp.google.com>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
	<20140304194810.14249.7378.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:53:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLKgR-0006Ag-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 23:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbaCEWwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 17:52:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbaCEWwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 17:52:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B610E71E7E;
	Wed,  5 Mar 2014 17:52:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=2tsuengJ8x5QktsydQoJqzTQ2dk=; b=VRHb4nl4sk82m8nSu3WM
	x6Opw2oUCg9tSqv6l3IvbccaQqcma2+HkUxHHjmEu/qJNPWlLxQz3pzcZ9LqXDSp
	IPCXBhWYBtuvnmMXOuwvF+jf/BUmW0FlixW1QSKiJRqKK7XQLMmzIRglQQX85T8h
	op6znVGCu/ynyfBtBbuk/0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oz/ptZsdltRBzif5J62V85cLGO+7E0/VjFLMwgTOSdAQq2
	vq8VECUIZZfZGI7YCeeo3WkTwxcXpRs2YNheeD7MJpajEGFRrRQXDbzDaPyTCyUw
	oVQSpgZHpuKOhidGJRyfLkeTaY/rdAU9X0UdGpoFtt/gKMce3ynjHiDBDkCUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DEB571E7B;
	Wed,  5 Mar 2014 17:52:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8931471E76;
	Wed,  5 Mar 2014 17:52:48 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DFC5E08C-A4B8-11E3-90B5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243489>

Christian Couder <chriscool@tuxfamily.org> writes:

> Implement the logic to process trailers from stdin and arguments.
>
> At the beginning trailers from stdin are in their own in_tok
> doubly linked list, and trailers from arguments are in their own
> arg_tok doubly linked list.
>
> The lists are traversed and when an arg_tok should be "applied",
> it is removed from its list and inserted into the in_tok list.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

Thanks.

This round is marked as the sixth, but I still see quite a many
style issues, which I expect not to see from long timers without
being told.  Somewhat disappointing...

>  trailer.c | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
>
> diff --git a/trailer.c b/trailer.c
> index db93a63..a0124f2 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -47,3 +47,200 @@ static size_t alnum_len(const char *buf, size_t len)
> ...
> +			if ((where == WHERE_AFTER ? in_tok->next : in_tok->previous) == arg_tok)

Overlong line that does not have to be.

			if ((where == WHERE_AFTER
                             ? in_tok->next : in_tok->previous) == arg_tok)

or something?

> +static void update_last(struct trailer_item **last)
> +{
> +	if (*last)
> +		while((*last)->next != NULL)

Style.  SP between control keyword and the expression.

> +			*last = (*last)->next;
> +}
> +
> +static void update_first(struct trailer_item **first)
> +{
> +	if (*first)
> +		while((*first)->previous != NULL)

Ditto.

> +static void process_trailers_lists(struct trailer_item **in_tok_first,
> ...
> +	/* Process input from end to start */
> +	for (in_tok = *in_tok_last; in_tok; in_tok = in_tok->previous) {
> +		process_input_token(in_tok, arg_tok_first, WHERE_AFTER);
> +	}

Needless brace pair.

> +	/* Process input from start to end */
> +	for (in_tok = *in_tok_first; in_tok; in_tok = in_tok->next) {
> +		process_input_token(in_tok, arg_tok_first, WHERE_BEFORE);
> +	}

Ditto.
