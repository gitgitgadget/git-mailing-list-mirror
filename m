From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] replace_object: use struct members instead of an array
Date: Fri, 21 Feb 2014 10:23:40 -0800
Message-ID: <xmqqeh2w495f.fsf@gitster.dls.corp.google.com>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
	<1393000327-11402-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 21 19:23:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGulO-0007ao-Vo
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 19:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbaBUSXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 13:23:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754494AbaBUSXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 13:23:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5548E6C8EE;
	Fri, 21 Feb 2014 13:23:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QhAHdtgqdZMHaVruRtVixYjOuNc=; b=uk8HFF
	ynbQSIN2Fib+WTWWYeEDlczo5XRay7p261eTD/TXaPr0d/RGFv16DWFSFaSbS26i
	JvexAY8tIQjOPohiE03X3hWVDM3B4Nare8VwsG2ilgBfCpqdqWaAIhExhmBcPLfq
	3FdAWEKY4IFw/vYWdcSTNia8LzryY3ZD5i2wU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cUdCIWCTxfLLEMtPS4UTVrD45FlibO7v
	YKFSia5+5w+WlYTfzQ4oJELLD5bmJ8Mj4mn101rbOtNvAk5sVtZr43jDMwBYQHum
	T8+LFRa1UGRJ6Xmf5nhIaov+Og0HVuxmdglxIZsHS64WqxFflyKX/UuzI40mYnPS
	maSBjCVgnnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9106C8ED;
	Fri, 21 Feb 2014 13:23:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DED36C8EA;
	Fri, 21 Feb 2014 13:23:42 -0500 (EST)
In-Reply-To: <1393000327-11402-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 21 Feb 2014 17:32:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4AE675AE-9B25-11E3-8F52-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242486>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Give the poor humans some names to help them make sense of things.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Good.

Reviewed-by: me.

>  replace_object.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/replace_object.c b/replace_object.c
> index cdcaf8c..6fc3ff4 100644
> --- a/replace_object.c
> +++ b/replace_object.c
> @@ -3,8 +3,13 @@
>  #include "refs.h"
>  #include "commit.h"
>  
> +/*
> + * An array of replacements.  The array is kept sorted by the original
> + * sha1.
> + */
>  static struct replace_object {
> -	unsigned char sha1[2][20];
> +	unsigned char original[20];
> +	unsigned char replacement[20];
>  } **replace_object;
>  
>  static int replace_object_alloc, replace_object_nr;
> @@ -12,7 +17,7 @@ static int replace_object_alloc, replace_object_nr;
>  static const unsigned char *replace_sha1_access(size_t index, void *table)
>  {
>  	struct replace_object **replace = table;
> -	return replace[index]->sha1[0];
> +	return replace[index]->original;
>  }
>  
>  static int replace_object_pos(const unsigned char *sha1)
> @@ -24,7 +29,7 @@ static int replace_object_pos(const unsigned char *sha1)
>  static int register_replace_object(struct replace_object *replace,
>  				   int ignore_dups)
>  {
> -	int pos = replace_object_pos(replace->sha1[0]);
> +	int pos = replace_object_pos(replace->original);
>  
>  	if (0 <= pos) {
>  		if (ignore_dups)
> @@ -60,14 +65,14 @@ static int register_replace_ref(const char *refname,
>  	const char *hash = slash ? slash + 1 : refname;
>  	struct replace_object *repl_obj = xmalloc(sizeof(*repl_obj));
>  
> -	if (strlen(hash) != 40 || get_sha1_hex(hash, repl_obj->sha1[0])) {
> +	if (strlen(hash) != 40 || get_sha1_hex(hash, repl_obj->original)) {
>  		free(repl_obj);
>  		warning("bad replace ref name: %s", refname);
>  		return 0;
>  	}
>  
>  	/* Copy sha1 from the read ref */
> -	hashcpy(repl_obj->sha1[1], sha1);
> +	hashcpy(repl_obj->replacement, sha1);
>  
>  	/* Register new object */
>  	if (register_replace_object(repl_obj, 1))
> @@ -107,7 +112,7 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
>  
>  		pos = replace_object_pos(cur);
>  		if (0 <= pos)
> -			cur = replace_object[pos]->sha1[1];
> +			cur = replace_object[pos]->replacement;
>  	} while (0 <= pos);
>  
>  	return cur;
