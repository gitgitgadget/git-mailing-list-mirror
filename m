From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Revamp git-cherry(1)
Date: Thu, 21 Nov 2013 11:26:08 -0800
Message-ID: <xmqqli0h4kvj.fsf@gitster.dls.corp.google.com>
References: <3af3069696e3a59d513f1fef0ca797d103f6d882.1385033403.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, a.huemer@commend.com,
	"Michael S. Tsirkin" <mst@kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 21 20:26:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjZtJ-0004oG-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 20:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab3KUT0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 14:26:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116Ab3KUT0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 14:26:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99BB852F9C;
	Thu, 21 Nov 2013 14:26:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SGdtQnrVIwjHNjUvIdpyom98dZ0=; b=IbwRTA
	whZYmAE74Bm9tFYvDbkYmllSv7NNAAOJ+Ek5D4nVcPHejuuhY7ALnhmTVWdqeW90
	pqrmrM28p1zJgzbYHRIFx46b1XafAJfXHUVqWIGrNvFR0+rBZugxtu2EOUktkZVp
	dfIwCZ0VgAT7Ag0pU1JtvDRK3j2aeAQsxjBGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aUjvc76aKtnSYisW09DGJboZ+tJVC09y
	RHFglrp/tIN5c6j4MtjxXUjfYcXJ7SjRGxMrhoZoVCYzbhePzmtkhtqZMWBwX4n8
	YhzlQPSZXu3deKpZR63nRqueMb5VoZXETv74urwzAcqYS6lCV/OQPVNlog35Pblx
	eF8cGcTaekg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A06152F9B;
	Thu, 21 Nov 2013 14:26:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAC3852F96;
	Thu, 21 Nov 2013 14:26:11 -0500 (EST)
In-Reply-To: <3af3069696e3a59d513f1fef0ca797d103f6d882.1385033403.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Thu, 21 Nov 2013 12:30:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C7B33666-52E2-11E3-A311-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238135>

Thomas Rast <tr@thomasrast.ch> writes:

>  NAME
>  ----
> -git-cherry - Find commits not merged upstream
> +git-cherry - Find commits not applied in upstream

Good.

> +Determine whether there are commits in `<head>..<upstream>` that are
> +equivalent to those in the range `<limit>..<head>`.
>  
> +The equivalence test is based on the diff, after removing whitespace
> +and line numbers.  git-cherry therefore detects when commits have been
> +"copied" by means of linkgit:git-cherry-pick[1], linkgit:git-am[1] or
> +linkgit:git-rebase[1].
>  
> +Outputs the SHA1 of every commit in `<limit>..<head>`, prefixed with
> +`-` for commits that have an equivalent in <upstream>, and `+` for
> +commits that do not.

Yeah, short-sweet-and-sufficient.

>  OPTIONS
>  -------
>  -v::
> -	Verbose.
> +	Verbose.  Currently shows the commit subjects next to their
> +	SHA1.

Whenever I see "Currently", it makes me wonder "why does it need to
say that? Is there a plan to change it soon, and if so where is the
plan described?".

> +EXAMPLES
> +--------
> +
> +git-cherry is frequently used in patch-based workflows (see
> +linkgit:gitworkflows[7]) to determine if a series of patches has been
> +applied by the upstream maintainer.  In such a workflow you might
> +create and send a topic branch like this (fill in appropriate
> +arguments for `...`):

I think the ASCII art commit graph that shows topology which we lost
by this patch gave a more intiutive sense of what "a topic branch
like this" looked like than an incomplete skeleton of a command
sequence that would be understood by those who already know how to
work with multiple branches.  Perhaps we want both?

Thanks.

> ++
> +------------
> +git checkout -b topic origin/master
> +# work and create some commits
> +git format-patch origin/master
> +git send-email ... 00*
> +------------

> +Later, you can whether your changes have been applied by saying (still
> +on `topic`):
> ++
> +------------
> +git fetch  # update your notion of origin/master
> +git cherry -v
> +------------
> ++
> +Note that this uses , and assumes that
> +`core.autosetupmerge` is enabled (the default).
> +
> +
>  SEE ALSO
>  --------
>  linkgit:git-patch-id[1]
