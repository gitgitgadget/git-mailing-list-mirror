From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/16] ref-filter: include reference to 'used_atom' within 'atom_value'
Date: Wed, 30 Mar 2016 15:12:26 -0700
Message-ID: <xmqq37r7sjhx.fsf@gitster.mtv.corp.google.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
	<1459330800-12525-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 00:12:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alOLw-00041n-H3
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 00:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbcC3WMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 18:12:33 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752465AbcC3WMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 18:12:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5ECE51718;
	Wed, 30 Mar 2016 18:12:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PDTabMbttd2VyT8kfY633ZtdlM0=; b=A2yfR4
	8fI6Qa3eb1QobZbf2QnpSVx1dZjz93NN3AsPofkze6PxOdJ2CaFJ8V0w/A11AZyS
	eTz5oN4SNohHpplp3HfQVYdzMe/1p0BULWqxXNm5Kp6Dlks0ToxBTxpjGTDKy7tw
	H3pFGLtEe5On4q7GpxV5aIeAihMSj+rchYcE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q00fbXzuB1CFqkSsSH+otRIhiuAHwn9N
	I5KekTV4eiuofOKLRjh+WcIFt1VU22EeU3YtN1Nd+das1c3z//D4uszUjRUeTqw8
	VubFYzO/Ezj3BnwkRUmO1wk4SKKuDZ3EWVPJRbBSqnc93egbg66pQr3QxKtC5Zst
	qjJZ4WuZMPU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBDC251717;
	Wed, 30 Mar 2016 18:12:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 213C451716;
	Wed, 30 Mar 2016 18:12:28 -0400 (EDT)
In-Reply-To: <1459330800-12525-3-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 30 Mar 2016 15:09:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D567C30-F6C4-11E5-82BF-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290351>

Karthik Nayak <karthik.188@gmail.com> writes:

> Ensure that each 'atom_value' has a reference to its corresponding
> 'used_atom'. This let's us use values within 'used_atom' in the
> 'handler' function.
>
> Hence we can get the %(align) atom's parameters directly from the
> 'used_atom' therefore removing the necessity of passing %(align) atom's
> parameters to 'atom_value'.
>
> This also acts as a preparatory patch for the upcoming patch where we
> introduce %(if:equals=) and %(if:notequals=).
>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 41e73f0..12e646c 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -230,11 +230,9 @@ struct ref_formatting_state {
>  
>  struct atom_value {
>  	const char *s;
> -	union {
> -		struct align align;
> -	} u;
>  	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
>  	unsigned long ul; /* used for sorting when not FIELD_STR */
> +	struct used_atom *atom;
>  };

Makes sense, as this would make what 04/16 does clearer.
