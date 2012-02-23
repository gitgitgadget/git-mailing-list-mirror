From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] push: add 'prune' option
Date: Wed, 22 Feb 2012 16:42:33 -0800
Message-ID: <7v1upm8jnq.fsf@alter.siamese.dyndns.org>
References: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
 <1329950621-21165-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 01:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Mld-0003d0-7M
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 01:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab2BWAmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 19:42:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab2BWAmf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 19:42:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3DAD640F;
	Wed, 22 Feb 2012 19:42:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58gWlUeCdZpSwUPISf6BROpyxkw=; b=b7wlCe
	Eilz2G1pKfqwI1IoNEW/xpxTGCpuBoTfBtdB2br67Lb9bbgfhme1V29hz0jBHKXo
	f/bprK/wFqNqNLS2IW2NUQf1/FcoCoS3VKlz1D5DevsWkwvtNwAMWsKUAcHW0eSM
	V8O3p3HJV7aKtSXghzl51tTedLoEdt9GSLniQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rwDGZNaOciQDTJHRArmuYraHAKfcMDRO
	Aar1kpTjGN0SvYIKdN3lYKzEkXJPkZQlk8oy8p3Pd/vZ3jgRZ5w4t+tAGqsm1ezI
	gdQpJ2Mrv2Cz3CAaciw0ejXY4uRF4i7OfjbDyr/WQx67qXip9p0eDPrOAWPX2LZo
	XrO6O5mIf/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB38A640E;
	Wed, 22 Feb 2012 19:42:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70821640D; Wed, 22 Feb 2012
 19:42:34 -0500 (EST)
In-Reply-To: <1329950621-21165-5-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Thu, 23 Feb 2012 00:43:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46B87CBE-5DB7-11E1-B552-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191315>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +--prune::
> +	Remove remote branches that don't have a local counterpart. For example
> +	a remote branch `tmp` will be removed if a local branch with the same
> +	name doesn't exist any more. This also respects refspecs, e.g.
> +	`refs/heads/*:refs/tmp/*` would make sure that remote `refs/tmp/foo`
> +	will be removed if `refs/heads/foo` doesn't exist.

I do not think it adds much useful information to mention `tmp` only once
over what is already said by the first sentence.  Also, the first sentence
of the example does not make it clear that it is assuming a same-for-same
mapping.

Coming up with a precise technical description is easy, but it is hard to
explain to the end user in easy terms, and I commend you for attempting to
add an example in a short single sentence, though.

Perhaps spelling out the underlying assumption the example makes is the
best we could do here without going too technical.

        ... For example, if you are pushing all your local branches to
        update the local branches of the remote, `tmp` branch will be
        removed from the remote if you removed your `tmp` branch locally.

        If you are pushing all your local branches on your laptop to a
        repository on your desktop machine under `refs/remotes/laptop/`
        hierarchy to back them up, `refs/remotes/laptop/tmp` is removed
        from the remote if you no longer have the branch `tmp` on your
        laptop.


Will queue with a slight fix-ups, including this bit:

> diff --git a/remote.h b/remote.h
> index b395598..341142c 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -145,7 +145,8 @@ int branch_merge_matches(struct branch *, int n, const char *);
>  enum match_refs_flags {
>  	MATCH_REFS_NONE		= 0,
>  	MATCH_REFS_ALL 		= (1 << 0),
> -	MATCH_REFS_MIRROR	= (1 << 1)
> +	MATCH_REFS_MIRROR	= (1 << 1),
> +	MATCH_REFS_PRUNE	= (1 << 2),
>  };

Lose the ',' at the end, for the same reason why deleted line did not have
one.

Thanks.
