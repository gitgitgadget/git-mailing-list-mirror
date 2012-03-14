From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Tue, 13 Mar 2012 21:27:08 -0700
Message-ID: <7vobrzst7n.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 05:27:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7fnz-0002NN-1v
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 05:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090Ab2CNE1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 00:27:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab2CNE1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 00:27:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E189879DA;
	Wed, 14 Mar 2012 00:27:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nDQQMu5Qx60HAcDcSvl7QR3zV6k=; b=VA7ptt
	oK9paOaw3zhpMav7muyI9P7y+Z8UvFXo7Y9//A8oMyBm3tGW8fZTlSXaP9/MHd7V
	5Ycvr494dLox2EMkWDmFLVrLaRyQMSkG7xxSKJ3lNanYLo95tmBMk/cnc2n8Ft1X
	KRfW0dOIUXyy8pHyK//p+WeOlMdaZSSgEONcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QVh2Ya4bmKjC/CptjDY/bmqS03J9yogD
	jZd7Kef1x33qqndfmI1sAOMhyc5HCUxLliV3hwR1aXHDD5vKQhcvWfP7QtGakJBE
	J6mDybQK6nat1CRwH8nERRcwGwf6HtAsYF81yXTML1F2WY5rC1LPTTCIQqtJI244
	/vyoAkB6ru4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D778779D9;
	Wed, 14 Mar 2012 00:27:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B85979D8; Wed, 14 Mar 2012
 00:27:09 -0400 (EDT)
In-Reply-To: <20120313232256.GA49626@democracyinaction.org> (Christopher
 Tiwald's message of "Tue, 13 Mar 2012 19:22:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F70ED276-6D8D-11E1-B5A6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193081>

An off-topic administrivia. Please do not try to deflect responses meant
for you by setting Mail-Followup-To.

Christopher Tiwald <christiwald@gmail.com> writes:

> Pushing a non-fast-forward update to a remote repository will result in
> an error, but the hint text doesn't provide the correct resolution in
> every case. Three scenarios may arise depending on your workflow, each
> with a different resolution:

Are we sure there are only three, or is this just "we do not say anything
concrete, but at least we know common three cases, and there may be more"?

I am mostly interested in making sure that we do not give a bad advice.
Giving an advice that is mostly accurate and relevant for 95% of the time
is perfectly fine, as long as following the advice in the remaining 5%
does not result in a disaster.

> 1) If you push a non-fast-forward update to HEAD, you should merge
> remote changes with 'git pull' before pushing again.

You said "to HEAD", but I think you meant the case you push your current
branch (i.e. HEAD) to update any ref on the other side.  In other words,
the push does not have to be "*to*" HEAD over there.  Am I mistaken?

> 2) If you push to a shared repository others push to, and your local
> tracking branches are not kept up to date, the 'matching refs' default
> will generate non-fast-forward errors on outdated branches. If this is
> your workflow, the 'matching refs' default is not for you. Consider
> setting the 'push.default' configuration variable to 'upstream' to
> ensure only your checked-out branch is pushed.

OK.

> 3) If you push with explicit ref matching (e.g. 'git push ... topic:topic')
> while checked out on another branch (e.g. 'master'), the correct
> resolution is checking out the local branch, issuing git pull, and
> merging remote changes before pushing again.

Or you may have misspelled the source side of the refspec and tried to
push a wrong branch.

> Make nonfastforward an enum and teach transport.c to detect the
> scenarios described above. Give situation-specific resolution advice
> when pushes are rejected due to non-fast-forward updates. Finally,
> update other instances of nonfastforward to use the proper enum option.

I think the overall direction of the implemention is good, modulo minor
design nits.

 * I do not particularly find NONFASTFORWARD_NONE that is defined to be 0
   a useful readability measure. Plain vanilla constant 0 says that there
   is nothing magical going on to the readers clearly already.

 * Also NONFASTFORWARD_FROTZ is way too long.  Wouldn't NONFF_FROTZ be
   sufficient and clear?

 * I can see there are three kinds of advices, but I do not see why users
   need to acknowledge that they understand them one by one with separate
   advice configuration.  Isn't it better to have only one variable, "OK,
   I know how to deal with a failed push due to non-fast-forward"?

> Signed-off-by: Christopher Tiwald <christiwald@gmail.com>
> Based-on-patch-by: Junio C Hamano <gitster@pobox.com>

These two lines are chronologically swapped.

> ---
> This is a reroll of jc/advise-push-default (2011-12-18).

I lost track of this topic during the last round.  Thanks for picking it
up.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c081657..50d9249 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -158,6 +158,21 @@ advice.*::
>  		Advice shown when you used linkgit:git-checkout[1] to
>  		move to the detach HEAD state, to instruct how to create
>  		a local branch after the fact.
> +	pullBeforePush::
> +		Advice shown when you ran linkgit:git-push[1] and pushed
> +		a non-fast-forward update to HEAD, instructing you to
> +		linkgit:git-pull[1] before pushing again.
> +	useUpstream::
> +		Advice to set 'push.default' to 'upstream' when you ran
> +		linkgit:git-push[1] and pushed 'matching refs' by default
> +		(i.e. you did not have any explicit refspec on the command
> +		line, and no 'push.default' configuration was set) and it
> +		resulted in a non-fast-forward error.
> +	checkoutPullPush::
> +		Advice shown when you ran linkgit:git-push[1] and pushed
> +		a non-fast-forward update to a non-HEAD branch, instructing
> +		you to checkout the branch and run linkgit:git-pull[1]
> +		before pushing again.

I would prefer to see these consolidated into a single advice.pushNonFF
variable, but I may be missing why it could be a good idea to allow them
turned off selectively.

> diff --git a/builtin/push.c b/builtin/push.c
> index d315475..0fecf06 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
>  	}
>  }
>  
> +static const char *message_advice_pull_before_push[] = {
> +	"To prevent you from losing history, non-fast-forward updates to HEAD",
> +	"were rejected. Merge the remote changes (e.g. 'git pull') before",
> +	"pushing again. See the 'Note about fast-forwards' section of",
> +	"'git push --help' for details."
> +};

This again says "*to* HEAD".  If this should be "a non-fast-forward update
to send the current branch was rejected" as I suspected above, the message
needs to be rephrased accordingly.

> +static const char *message_advice_use_upstream[] = {
> +	"By default, git pushes all branches that have a matching counterpart",
> +	"on the remote. In this case, some of your local branches were stale",
> +	"with respect to their remote counterparts. If you did not intend to",
> +	"push these branches, you may want to set the 'push.default'",
> +	"configuration variable to 'upstream' to push only the current branch."
> +};

If you drop everything up to and including "In this case, ", the advice
message still teaches exactly what the user needs to learn.

> +static const char *message_advice_checkout_pull_push[] = {
> +	"To prevent you from losing history, your non-fast-forward branch",
> +	"updates were rejected. Checkout the branch and merge the remote",
> +	"changes (e.g. 'git pull') before pushing again. See the",
> +	"'Note about fast-forwards' section of 'git push --help' for",
> +	"details."
> +};

OK.

> @@ -136,15 +193,18 @@ static int push_with_options(struct transport *transport, int flags)
>  
>  	err |= transport_disconnect(transport);
>  
> +	if (nonfastforward == NONFASTFORWARD_HEAD) {
> +		advise_pull_before_push();
> +	} else if (nonfastforward == NONFASTFORWARD_OTHER) {
> +		if (default_matching_used)
> +			advise_use_upstream();
> +		else
> +			advise_checkout_pull_push();
> +	}
		
I suspect that we may find more cases not just three, so

	switch (nonfastforward) {
	default:
        	break;
	case NONFF_HEAD:
        	advice_pull_before_push();
		break;
	case NONFF_OTHER:
		...
	}

would be a more forward-looking way to write it.

Also, shouldn't we be doing this only when err is true, or is it too
defensive?

>  	if (!err)
>  		return 0;
>  
> -	if (nonfastforward && advice_push_nonfastforward) {
> -		fprintf(stderr, _("To prevent you from losing history,...

That is, I am wondering why your "more detailed diag & advice" code is not
here, i.e. after "if (!err) return 0".
