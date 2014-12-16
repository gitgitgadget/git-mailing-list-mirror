From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/6] send-pack: Invert the return value of ref_update_to_be_sent
Date: Tue, 16 Dec 2014 11:14:55 -0800
Message-ID: <xmqq7fxrbe4w.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:15:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xaJ-0004Qj-2d
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbaLPTO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:14:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64166 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751049AbaLPTO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:14:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4C9D2862E;
	Tue, 16 Dec 2014 14:14:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ovgHzMetrF/DIh9bq5mCYiyeX3k=; b=FYHAZw
	4ZEFpZ+OgSwOkhUzWh1bQOtoLJLoeabElx9IBz4GS3c3qfz8YjO9hnWEFyePh2EP
	XROfLVhexo8RhqNzz4XHzR2jenjYbpANRJzw5l+IHjHO2JfjZCqDC68Mc2Dmeem1
	efScid1z7FVb4Y/HRjCLDldaU1rmkGc4SidNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lDGUxEwu8WGw5ZPZabP9FXAwqp2QvZa9
	nsD4aopKA5MaDlr2lhYz0aZ4nLwpJMQsxJey2jenabmFPluS5ZoKRhPxJB4MQmuh
	x3EExUb2CNT2FXQmIOJkWcrPPWtOpFsKqm8gBopOi+ON6guRTGHvwNJD9jyVhfn9
	EUEgXYEu664=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B0632862D;
	Tue, 16 Dec 2014 14:14:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 244022862C;
	Tue, 16 Dec 2014 14:14:59 -0500 (EST)
In-Reply-To: <1418755747-22506-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 16 Dec 2014 10:49:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D3E4F764-8557-11E4-89CB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261454>

Stefan Beller <sbeller@google.com> writes:

> Having the return value inverted we can have different values for
> the error codes. This is useful in a later patch when we want to
> know if we hit the REF_STATUS_REJECT_* case.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     New in the series. For consistency with all the other patches
>     it also reads v2.

Sorry, but ECANNOTPARSE especially "it also read v2" part.

>  send-pack.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/send-pack.c b/send-pack.c
> index 2a513f4..1c4ac75 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -190,10 +190,10 @@ static void advertise_shallow_grafts_buf(struct strbuf *sb)
>  	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
>  }
>  
> -static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args)
> +static int no_ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args)
>  {
>  	if (!ref->peer_ref && !args->send_mirror)
> -		return 0;
> +		return 1;
>  
>  	/* Check for statuses set by set_ref_status_for_push() */
>  	switch (ref->status) {
> @@ -203,10 +203,11 @@ static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_a
>  	case REF_STATUS_REJECT_NEEDS_FORCE:
>  	case REF_STATUS_REJECT_STALE:
>  	case REF_STATUS_REJECT_NODELETE:
> +		return 2;
>  	case REF_STATUS_UPTODATE:
> -		return 0;
> +		return 3;
>  	default:
> -		return 1;
> +		return 0;

Hmmm.  It used to be "will we send this one?"  It is fine if the
function wants to differenciate various kinds of error, but

 (1) unexplained 1, 2 and 3 looks cryptic and unmaintainable;

 (2) no_ prefix in the function name is usually a bad idea, because
     it easily invites "if (!no_foo(...))" double negation; and

 (3) unless there is a good reason to do otherwise, a function that
     returns 0 on success should signal an error with a negative
     return.

"static int check_to_send_update()" or something, perhaps?

	if (check_to_send_update() < 0)
        	/* skip as this is an error */
                continue;

does not look too bad.

>  }
>  
> @@ -250,7 +251,7 @@ static int generate_push_cert(struct strbuf *req_buf,
>  	strbuf_addstr(&cert, "\n");
>  
>  	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (!ref_update_to_be_sent(ref, args))
> +		if (no_ref_update_to_be_sent(ref, args))
>  			continue;
>  		update_seen = 1;
>  		strbuf_addf(&cert, "%s %s %s\n",
> @@ -370,7 +371,7 @@ int send_pack(struct send_pack_args *args,
>  	 * the pack data.
>  	 */
>  	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (!ref_update_to_be_sent(ref, args))
> +		if (no_ref_update_to_be_sent(ref, args))
>  			continue;
>  
>  		if (!ref->deletion)
> @@ -391,7 +392,7 @@ int send_pack(struct send_pack_args *args,
>  		if (args->dry_run || args->push_cert)
>  			continue;
>  
> -		if (!ref_update_to_be_sent(ref, args))
> +		if (no_ref_update_to_be_sent(ref, args))
>  			continue;
>  
>  		old_hex = sha1_to_hex(ref->old_sha1);
