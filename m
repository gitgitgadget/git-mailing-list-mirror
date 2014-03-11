From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] commit: fix patch hunk editing with "commit -p -m"
Date: Tue, 11 Mar 2014 14:02:28 -0700
Message-ID: <xmqqob1co3dm.fsf@gitster.dls.corp.google.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
	<1394477377-10994-5-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:02:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNTor-0000VH-MV
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 22:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbaCKVCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 17:02:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbaCKVCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 17:02:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77F4B70B6B;
	Tue, 11 Mar 2014 17:02:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/vn8860DJKYMxwYVE3rASR4TtoM=; b=RGmXC1
	JUdA4Xy8hMV1WPdsSDYsoCuVOgSvmhqRG3sA4EJjZwsy53Gich5nwgyEMwMZalLY
	TnAqi2UGugtJwhol6Mo5YMxXmv/3o4cGtBlFfbXP38Tw8WI0ei7psQx2bLU4VRdT
	VYWkPjgR4VgSleQnvD5RxP6agA0sJEPJTCjx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qOsBLcSTb9jUUVgCyOqAh/jijP9AzFcf
	H4JREDPrdwqa+SpptsFR5fuKfWE6/JZUx8FlS6H1cQltxPf9uZiOj78Z0XaSOuq4
	wmQ54Z03MW1yw/jFhwafgCfWu4YlVXiyRnwNgTbcdEjDtkZbLDX9RylAAb3U5jnh
	vpQ5lbrezU8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6440670B6A;
	Tue, 11 Mar 2014 17:02:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95ADA70B68;
	Tue, 11 Mar 2014 17:02:30 -0400 (EDT)
In-Reply-To: <1394477377-10994-5-git-send-email-benoit.pierre@gmail.com>
	(Benoit Pierre's message of "Mon, 10 Mar 2014 19:49:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7599D00E-A960-11E3-AFEE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243897>

Benoit Pierre <benoit.pierre@gmail.com> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5df3837..da423b2 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -53,10 +53,10 @@ struct checkout_opts {
>  static int post_checkout_hook(struct commit *old, struct commit *new,
>  			      int changed)
>  {
> -	return run_hook(NULL, "post-checkout",
> -			sha1_to_hex(old ? old->object.sha1 : null_sha1),
> -			sha1_to_hex(new ? new->object.sha1 : null_sha1),
> -			changed ? "1" : "0", NULL);
> +    return run_hook_le(NULL, "post-checkout",
> +		       sha1_to_hex(old ? old->object.sha1 : null_sha1),
> +		       sha1_to_hex(new ? new->object.sha1 : null_sha1),
> +		       changed ? "1" : "0", NULL);

Funny indentation.
