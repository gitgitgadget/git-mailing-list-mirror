From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 21:47:22 -0800
Message-ID: <7vvdf33onp.fsf@alter.siamese.dyndns.org>
References: <op.u6g8jnixg402ra@nb-04> <20100113154310.GA7348@Knoppix>
 <op.u6haiiiog402ra@nb-04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: "Rudolf Polzer" <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 06:49:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVf3y-0002pL-EB
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 06:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088Ab0AOFre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 00:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073Ab0AOFre
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 00:47:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab0AOFrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 00:47:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9913900C1;
	Fri, 15 Jan 2010 00:47:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9t5vhzWynKnUgAEA7/RZCeIpVYQ=; b=qaohmV
	2OZnigiK2kfkkaxDKi7QocUblo7iCuyHue+44nxM8r4LBOlKIbblDNF8lyOTJVwD
	m4uzfDFUlgJQBlx4ot7VujmuV0WBbLc3D/2+uALuj+pqsG7S/6lnBJkFzScALpzO
	gHZM8FEoWEB0H+vXZCqFGPiByfLB06eRa3ezc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ii9bqkXgI2gPoOvDuXmQcYGnqQ7nBqy1
	RHmG6PnTQcwpIUBvbgUQc5oAbq2/ZzD5yNE29ISF3HbP6FyKpGs85WnrlVouHi17
	uEJDKWeAnBC4m40oozQGIKtozwWa2mYyw6/5agfMQYWcaDshRJhHlOLHxE/2jRoY
	QXDgrA7KMlg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70AD6900BC;
	Fri, 15 Jan 2010 00:47:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D6ED900B3; Fri, 15 Jan
 2010 00:47:24 -0500 (EST)
In-Reply-To: <op.u6haiiiog402ra@nb-04> (Rudolf Polzer's message of "Wed\, 13
 Jan 2010 16\:55\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 771BA588-0199-11DF-B066-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137050>

"Rudolf Polzer" <divVerent@alientrap.org> writes:

> On Wed, 13 Jan 2010 16:43:10 +0100, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
>
>> - Some lines look way too long (~160 chars, should be max 80 unles
>> it would linebreak error message).
>
> Yes, also I got told that I used the wrong braces style... well, fixed
> that.

You didn't, although you tried to "hide" one level, which is even worse.

If you see overlong lines in patch text, it often is that the added
codepath is too deeply nested, and it often becomes much easier to
understand if you split it into a separate smaller helper function.

For example, if you have

	if (A) {
        	if (B) {
                	do something #1
                        if (C) {
                        	do something #2
                                while (D) {
                                	if (E) {
                                        	do something #3
					}
				}
			}
		}
	}

it often is much easier to read if you did:

	if (A)
		helper(...)

and wrote a helper that is

	helper()
        {
        	if (!B)
                	return
		do something #1
                if (!C)
                	return
		do something #2
		while (D) {
                	if (!E)
                        	continue
			do something #3
		}
	}

>> - Should the tracking be set up even if only part of ref update suceeded
>> (for those that succeeded), not requiring all to succeed?

I think giving configuration to the ones that succeeded, while not doing
so for the ones that failed, would be the best.

>> - Is --track the best name for this?

Most probably not.  "git branch --track" was already a mistake, whose
damage can be seen in the first message in this thread.  I originally read
"this converts a local branch to a tracking branch", and went "Huh??? ---
Is this patch running 'mv refs/heads/frotz refs/remotes/origin/frotz'?
What's fun about it???"

> @@ -115,6 +116,36 @@ static int push_with_options(struct transport
> *transport, int flags)
>  		fprintf(stderr, "Pushing to %s\n", transport->url);
>  	err = transport_push(transport, refspec_nr, refspec, flags,
>  			     &nonfastforward);
> +	if (err == 0 && flags & TRANSPORT_PUSH_TRACK) {

Style:

 - Have SP between syntactic keyword and open parenthesis.

 - Never place an opening brace, except the one that begins a function
   body, on its own line;

Also the overlong line is merely a symptom that you are putting too much
stuff in this function.  The whole addition should probably be a helper
function.

> @@ -115,6 +116,33 @@ static int push_with_options(struct transport *transport, int flags)
>  		fprintf(stderr, "Pushing to %s\n", transport->url);
>  	err = transport_push(transport, refspec_nr, refspec, flags,
>  			     &nonfastforward);
> +	if (err == 0 && flags & TRANSPORT_PUSH_TRACK)
> +	{
> +		struct ref *remote_refs =
> +			transport->get_refs_list(transport, 1);

You have already pushed by calling transport_push() before you got "err"
back.  Do you need to make a second, separate call to ls-remote here and
if so why?

I have a feeling that it is more appropriate to have the additional code
in transport_push(), which gets ls-remote information, runs match_refs()
and finally calls transport->push_refs().  I think the extra branch
configuration would fit better inside the if block immediately after all
that happens, i.e.

	if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
		struct ref *ref;
		for (ref = remote_refs; ref; ref = ref->next)
			update_tracking_ref(transport->remote, ref, verbose);
+		if (flags & TRANSPORT_PUSH_RECONFIGURE_FORK)
+			configure_forked_branch(...);
	}

in transport.c

> +		if(!(flags & TRANSPORT_PUSH_DRY_RUN))
> +		if(!match_refs(local_refs, &remote_refs, refspec_nr, refspec, match_flags))

Yuck; hiding the fact that you have an over-nested logic is not a way to
fix it.
