From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/6] send-pack: Rename ref_update_to_be_sent to check_to_send_update
Date: Wed, 17 Dec 2014 14:53:20 -0800
Message-ID: <xmqqioh999cv.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418841177-12152-1-git-send-email-sbeller@google.com>
	<1418841177-12152-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 23:53:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1NTE-0004oL-1z
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 23:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbaLQWxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 17:53:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750959AbaLQWxX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 17:53:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C169F280DD;
	Wed, 17 Dec 2014 17:53:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eu+JmWjE59hk28mRYFlhU6Qt700=; b=YGouCB
	pX7S9ftH3aEroQeZxUo1JLsZaopr+ytMusCJphCPKdSzYGQoDRbolaFFIF18Bdgd
	L+cyDGms8VNG+P8UGoh2MvpC7Kk4HzG0jFiX67fjnG6he+qKGsLeA++YIqxanThm
	3jWHugM00mTc1MHkZOOQMmeGaDoPmqFF+rj/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vlrqIpAzSEaqMPdH+f0db/xnihlonicV
	rWp5urQ3F72GQ9tWiGWet8U7lBXiOSyniXvPv4EoVxUaNjfl5qxjg0sFmNZADmth
	c9jCwTLMN4FKZWDB8+wkGp9ppBZRTJdHA4bmEAxphanKx9a7d7AyoRj0efpbwBDh
	qXOP85Z4CBE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4FE2280DC;
	Wed, 17 Dec 2014 17:53:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A7FE280DA;
	Wed, 17 Dec 2014 17:53:23 -0500 (EST)
In-Reply-To: <1418841177-12152-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 17 Dec 2014 10:32:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80FEBBDC-863F-11E4-B7D1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261503>

Stefan Beller <sbeller@google.com> writes:

> This renames ref_update_to_be_sent to check_to_send_update and inverts
> the meaning of the return value. Having the return value inverted we
> can have different values for the error codes. This is useful in a
> later patch when we want to know if we hit the CHECK_REF_STATUS_REJECTED
> case.

Makes sense; I would have defined these constants negative, but that
can be cleaned up if somebody cares deeply enough later.

Will queue.  Thanks.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     This was introduced with the [PATCHv2] series.
>     Changes v2 -> v3:
>     
>     * Rename to check_to_send_update
>     * Negative error values.
>     * errors values are #define'd and not raw numbers.
>
>  send-pack.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/send-pack.c b/send-pack.c
> index e2bdd89..77e4201 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -190,10 +190,13 @@ static void advertise_shallow_grafts_buf(struct strbuf *sb)
>  	for_each_commit_graft(advertise_shallow_grafts_cb, sb);
>  }
>  
> -static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_args *args)
> +#define CHECK_REF_NO_PUSH 1
> +#define CHECK_REF_STATUS_REJECTED 2
> +#define CHECK_REF_UPTODATE 3
> +static int check_to_send_update(const struct ref *ref, const struct send_pack_args *args)
>  {
>  	if (!ref->peer_ref && !args->send_mirror)
> -		return 0;
> +		return -CHECK_REF_NO_PUSH;
>  
>  	/* Check for statuses set by set_ref_status_for_push() */
>  	switch (ref->status) {
> @@ -203,10 +206,11 @@ static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_a
>  	case REF_STATUS_REJECT_NEEDS_FORCE:
>  	case REF_STATUS_REJECT_STALE:
>  	case REF_STATUS_REJECT_NODELETE:
> +		return -CHECK_REF_STATUS_REJECTED;
>  	case REF_STATUS_UPTODATE:
> -		return 0;
> +		return -CHECK_REF_UPTODATE;
>  	default:
> -		return 1;
> +		return 0;
>  	}
>  }
>  
> @@ -250,7 +254,7 @@ static int generate_push_cert(struct strbuf *req_buf,
>  	strbuf_addstr(&cert, "\n");
>  
>  	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (!ref_update_to_be_sent(ref, args))
> +		if (check_to_send_update(ref, args) < 0)
>  			continue;
>  		update_seen = 1;
>  		strbuf_addf(&cert, "%s %s %s\n",
> @@ -369,7 +373,7 @@ int send_pack(struct send_pack_args *args,
>  	 * the pack data.
>  	 */
>  	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (!ref_update_to_be_sent(ref, args))
> +		if (check_to_send_update(ref, args) < 0)
>  			continue;
>  
>  		if (!ref->deletion)
> @@ -390,7 +394,7 @@ int send_pack(struct send_pack_args *args,
>  		if (args->dry_run || args->push_cert)
>  			continue;
>  
> -		if (!ref_update_to_be_sent(ref, args))
> +		if (check_to_send_update(ref, args) < 0)
>  			continue;
>  
>  		old_hex = sha1_to_hex(ref->old_sha1);
