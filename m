From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] status: show the ref that is checked out, even if
 it's detached
Date: Sun, 03 Mar 2013 14:25:53 -0800
Message-ID: <7vy5e49l3i.fsf@alter.siamese.dyndns.org>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362303681-6585-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 03 23:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCHMN-0003xz-Df
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 23:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab3CCWZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 17:25:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667Ab3CCWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 17:25:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1798BAB07;
	Sun,  3 Mar 2013 17:25:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WJ9+GMoGwLCYsD7sBYVK7EvwMxY=; b=Nht1nb
	/aVI0vufx8UGWZwvJT9G52ZpeJ4yLFEWL7mCgZW+65ad/7R3Y/dYeQ3fYD3XW7ev
	EjbuFWWvKrk5N5tMcZwzBycb9C1Tt7ZACb4tmzF1URt+H+TQeBUGT2Rh5K2zhQVH
	tHVn1gV5jJR1U8JBUE/IrzFqSW8127AgyB4nM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ihbMZFbtxNnP2GF/c8C6VcikcB9jmw8H
	YUy/PfYXBElN8vklLUCLLwh8DUBWd2HYElZ0jKMaFwdLeMmJAUULjTmVjmZ/hzIH
	zuDgcd9efNaPzy5zkMk7S9ESmgKmEt/XEQNK+iSztHH+YfnRIUOEbFvmwIXconZx
	Z8AEHEJ2ll4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C952AB06;
	Sun,  3 Mar 2013 17:25:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59F5AAB03; Sun,  3 Mar 2013
 17:25:55 -0500 (EST)
In-Reply-To: <1362303681-6585-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 3 Mar
 2013 16:41:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5096088E-8451-11E2-885E-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217363>

> When a remote ref or a tag is checked out, HEAD is automatically
> detached. There is no user friendly way to find out what ref is
> checked out in this case. This patch digs in reflog for this
> information and shows "Detached from origin/master" or "Detached from
> v1.8.0" instead of "Currently not on any branch".

"Detached from" is a nice attempt to compromise in the phrasing.

We usually say you detach HEAD at v1.8.0, but what is shown is what
started from such a state but then the user may have built more
history on top of it and may no longer be at v1.8.0, so obviously we
do not want to say "Detached at".  We are in a "detached at v1.8.0
and then possibly built one or more commits on top" state (would it
be helpful to differentiate the "nothing built on top" and "some
commits have been built on top" cases, I wonder).

Also I wonder if you could do a bit more to help the users who do:

    $ git checkout $(git merge-base HEAD nd/branch-show-rebase-bisect-state)

aka

    $ git checkout ...nd/branch-show-rebase-bisect-state

and then do one or more commits on top.

Instead of punting to "Currently not on any branch", would it help
to show the place you first detached at, so that the user can then
grab that commit object name and run

    $ git log --oneline $that_commit..

or something?

> +static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
> +			   const char *email, unsigned long timestamp, int tz,
> +			   const char *message, void *cb_data)
> +{
> +	struct grab_1st_switch_cbdata *cb = cb_data;
> +	const char *target = NULL;
> +
> +	if (prefixcmp(message, "checkout: moving from "))
> +		return 0;
> +	message += strlen("checkout: moving from ");
> +	target = strstr(message, " to ");
> +	if (!target)
> +		return 0;
> +	target += strlen(" to ");
> +	strbuf_reset(&cb->buf);
> +	hashcpy(cb->sha1, nsha1);
> +	if (!prefixcmp(target, "refs/")) {
> +		const char *end = target;
> +		while (*end && *end != '\n')
> +			end++;
> +		strbuf_add(&cb->buf, target, end - target);
> +	}
> +	return 0;
> +}

Can't this be done by generalizing grab_nth_branch_switch() and then
exposing it as part of the general API?  

I also feel uneasy about two issues this and the previous change
introduces:

 1) It is somewhat unnerving that this step reads what comes after
    "to", while nth_branch_switch() reads what comes between "from"
    and "to", but it probably cannot be avoided because this series
    wants to know what we switched "to" earlier, while "checkout -"
    wants to know what we switched "from"

 2) The previous one records this sequence in a funny way:

        : start from branch A
        git checkout B
        git checkout C

    The resulting reflog entries result in

        checkout: moving from A to refs/heads/B
        checkout: moving from B to refs/heads/C

    even though existing code and tools are expecting to read

        checkout: moving from A to B
        checkout: moving from B to C

By the way, even though the title of this patch is "status: show the
ref that is checked out, even if it's detached", a quick check with

        $ cd ../linux-3.0
        $ git describe
        v3.8-rc7
        $ ../git.git/git-checkout v3.8-rc7
        $ tail -n 1 .git/logs/HEAD | sed -e 's/.*checkout/checkout/'
        checkout: moving from master to refs/tags/v3.8-rc7
        $ ../git.git/git-status | head -n 1
        # Not currently on any branch.
        $ ../git.git/git-branch -v
        * (no branch) 836dc9e Linux 3.8-rc7
          master      836dc9e Linux 3.8-rc7

does not seem to give me anything more helpful.
