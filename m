From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 26/27] struct ref_update: Add type field
Date: Tue, 01 Apr 2014 13:03:27 -0700
Message-ID: <xmqq8urozuk0.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-27-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:03:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4uE-0002zo-Kl
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbaDAUDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:03:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62754 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbaDAUDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 16:03:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA17D79617;
	Tue,  1 Apr 2014 16:03:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TCJIDFz2umGnSCVDxEy4kYmOCnU=; b=eLdmlH
	cyc23iJicOquK/mfW7qZJ8IYoApaubv0Zz0EhvlJSLwsf66lpPmqa1YKOE5mLaq6
	eR+RWQ5FTVYlsK5sSOxiEL4BqIR70iKqxpks3kjYR1nAz7S7YuJUvM2l3043A0/A
	OTwLCoTms1Svg0SNZFEGuVQ2jYk5kJw6GQKrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DScbUpS99x7JK/3IA9JZLBZnTUBOqC1X
	V4AoIDwqgJ/RcMsYuGtiFdwNsI/FnaTsYj3q+XYnWlxK4X5z8MIqvzrP212wvlKr
	fdgMp9NUaX74SMvETPxreSyNQPAekvRt5QHaLlhFk5HstqUcOG5zxdXckqR/nvah
	AZf3Hah0G7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B438B79616;
	Tue,  1 Apr 2014 16:03:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6EF879614;
	Tue,  1 Apr 2014 16:03:28 -0400 (EDT)
In-Reply-To: <1395683820-17304-27-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1345D4A-B9D8-11E3-80DB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245649>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is temporary space for ref_transaction_commit().
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

I was about to complain to "*Add* type" that does not say what it is
used for at all, with "Please do not add something for unknown purpose
only to utilise it in a later patch".

But that was before I noticed that these are already used and
realized that the change is about "moving what is recorded in the
type array, which is used to receive the existing reftype discovered
by calling resolve_ref_unsafe() in ref_transaction_commit() and not
used anywhere else, to a field of individual ref_update structure".

So it was somewhat of a "Huh?", but perhaps it is OK.

I wonder if ref-transaction-commit can shrink its parameter list by
accepting a single pointer to one ref_update?

>  refs.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index d1edd57..07f900a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3279,6 +3279,7 @@ struct ref_update {
>  	int flags; /* REF_NODEREF? */
>  	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
>  	struct ref_lock *lock;
> +	int type;
>  	const char refname[FLEX_ARRAY];
>  };
>  
> @@ -3410,7 +3411,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  {
>  	int ret = 0, delnum = 0, i;
>  	struct ref_update **updates;
> -	int *types;
>  	const char **delnames;
>  	int n = transaction->nr;
>  
> @@ -3419,7 +3419,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  
>  	/* Allocate work space */
>  	updates = xmalloc(sizeof(*updates) * n);
> -	types = xmalloc(sizeof(*types) * n);
>  	delnames = xmalloc(sizeof(*delnames) * n);
>  
>  	/* Copy, sort, and reject duplicate refs */
> @@ -3437,7 +3436,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  					       (update->have_old ?
>  						update->old_sha1 : NULL),
>  					       update->flags,
> -					       &types[i], onerr);
> +					       &update->type, onerr);
>  		if (!update->lock) {
>  			ret = 1;
>  			goto cleanup;
> @@ -3465,7 +3464,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  
>  		if (update->lock) {
>  			delnames[delnum++] = update->lock->ref_name;
> -			ret |= delete_ref_loose(update->lock, types[i]);
> +			ret |= delete_ref_loose(update->lock, update->type);
>  		}
>  	}
>  
> @@ -3479,7 +3478,6 @@ cleanup:
>  		if (updates[i]->lock)
>  			unlock_ref(updates[i]->lock);
>  	free(updates);
> -	free(types);
>  	free(delnames);
>  	ref_transaction_free(transaction);
>  	return ret;
