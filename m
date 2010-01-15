From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Fri, 15 Jan 2010 15:40:17 -0800
Message-ID: <7vzl4frl7i.fsf@alter.siamese.dyndns.org>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:40:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvmR-0004zq-1e
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403Ab0AOXk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 18:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401Ab0AOXk1
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:40:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384Ab0AOXk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 18:40:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 745D0918CE;
	Fri, 15 Jan 2010 18:40:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OkyDln48TS0O/BhDpQ6diJyKo3g=; b=OTTFNl
	TF53stYQ/ly1qh1fOmj9EzaBnv7dGY6r0ZrtSohjBOCHwGjqj/Jrmww1hM4ME77U
	e1qddiXInNd4wHJzhPYg1IDHYgRTCm7GwxuJm1dNqp/siXrKr8bEfO6lhJP9bZsr
	Da8mEXmTJBBs1ls/2cyt+36MAZAyl6tQ/ct0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xhvIqT1mMspq9lbfiOq9PkWVQJRvz1EE
	iHH8aGR5yBgXfNidzjU8hEx/oYsapP9XJksUi7BAEbtnGKkq7tkxYF0WRsDyUbRq
	IOGLrAuWLF/fp2EKglaIMwJ1ptbq2QsCRdoAbad/JK0jFeViHH/QbQqCbOX1GHny
	tJOBNyFa798=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5254D918CC;
	Fri, 15 Jan 2010 18:40:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1451918CB; Fri, 15 Jan
 2010 18:40:18 -0500 (EST)
In-Reply-To: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Sat\, 16 Jan 2010 00\:47\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58544358-022F-11DF-B788-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137162>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> @@ -974,6 +1016,10 @@ int transport_push(struct transport *transport,
>  	verify_remote_names(refspec_nr, refspec);
>  
>  	if (transport->push) {
> +		/* Maybe FIXME. But no important transport uses this case. */
> +		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
> +			die("This transport does not support using --set-upstream");
> +

Would it be better to just warn() and continue instead of dying?  I think
it can be argued both ways, and I personally think die() is better by
making it more visible that the user does not have the config s/he wanted
to add, but I am pointing it out just in case somebody thinks of a better
solution (of course, doing an extra ls-remote and doing the configuration
is such a "better solution" but that is not what I mean---I am not that
greedy).

> @@ -1002,6 +1048,9 @@ int transport_push(struct transport *transport,
>  					verbose | porcelain, porcelain,
>  					nonfastforward);
>  
> +		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
> +			set_upstreams(transport, remote_refs);
> +
>  		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
>  			struct ref *ref;
>  			for (ref = remote_refs; ref; ref = ref->next)

Shouldn't this honor TRANSPORT_PUSH_DRY_RUN?  IOW, when should it touch
the configuration if you do this sequence?

	# I am paranoid and want to check what happens first
	git push -n --track there this
        # Ok let's do it for real.
        git push    --track there this
