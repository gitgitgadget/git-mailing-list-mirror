From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 p2 3/9] transport-helper: trivial code shuffle
Date: Tue, 27 Nov 2012 09:00:02 -0800
Message-ID: <7vk3t7nfql.fsf@alter.siamese.dyndns.org>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
 <1353727520-26039-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:00:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdOWK-0000bS-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377Ab2K0RAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:00:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296Ab2K0RAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:00:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 549249D93;
	Tue, 27 Nov 2012 12:00:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A6mxeysqUGtkU84D8XxcLg6JV/g=; b=Kg4dsy
	s52z5S/DyGDDpwBn0ZxHYipG0u3xTXf58XwvxZALlMNVic9EfMq8l32M0N+z8dIq
	KxCnT5giWd1NMyRMeCrAKlcARmMA7PFiMO2kyX96iZBZT1JFwyxqVdI99zj5eTHk
	TqGPfrP0l5Lj/5u4At5vUBpP/5EjhSEPkhJ+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=epJlXPyV81dbuaUWO07VwbPZ4n6M8qPO
	taeVD4I9qn9YbVujDOC/2Z39ub3xBqsKKkQSH33/BT24yezfj8oESsHuwX8zr0uc
	fhJwrrVc763uur9DQT/67sU+Bgf4GDox1UkWw1LbIHkw1JXyYX3aNZF1NjyidB0n
	OA1gjNOGep0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E84579D92;
	Tue, 27 Nov 2012 12:00:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB63E9D8F; Tue, 27 Nov 2012
 12:00:04 -0500 (EST)
In-Reply-To: <1353727520-26039-4-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sat, 24 Nov 2012 04:25:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E454D936-38B3-11E2-B9F1-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210563>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Just shuffle the die() part to make it more explicit, and cleanup the
> code-style.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  transport-helper.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 32ad877..0c95101 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -775,6 +775,9 @@ static int push_refs_with_export(struct transport *transport,
>  		char *private;
>  		unsigned char sha1[20];
>  
> +		if (ref->deletion)
> +			die("remote-helpers do not support ref deletion");
> +
>  		if (!data->refspecs)
>  			continue;

This is not just "just shuffle the die to make it explicit" but it
does change the semantics; earlier ref->deletion was perfectly fine
as long as data->refspecs is not given, but the new code always
dies.

If this semantic change is a good thing, please explain why it is so
in the log message.  If the change is "it does not matter because
when data->refspecs is not given and ref->deletion is set, we die
later elsewhere in the code anyway", then it needs to be described.


Thanks.

> @@ -784,10 +787,6 @@ static int push_refs_with_export(struct transport *transport,
>  		}
>  		free(private);
>  
> -		if (ref->deletion) {
> -			die("remote-helpers do not support ref deletion");
> -		}
> -
>  		if (ref->peer_ref)
>  			string_list_append(&revlist_args, ref->peer_ref->name);
