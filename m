From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 16 Mar 2012 14:53:42 -0700
Message-ID: <7v1uosfc0p.fsf@alter.siamese.dyndns.org>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr> <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org> <20120316091019.GB22273@ecki>
 <7v3998kb0x.fsf@alter.siamese.dyndns.org> <20120316214151.GA25092@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Tiwald <christiwald@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Mar 16 22:53:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8f5x-0005bU-W9
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 22:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161929Ab2CPVxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 17:53:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161898Ab2CPVxq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 17:53:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4481760CE;
	Fri, 16 Mar 2012 17:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LFF0OsKOPf9Mblw2vkK+oKRtzJE=; b=lRARas
	vF55zW2juRQ/CwAhzVs9OzYRbrbqMVGo3kjt25UZ1QhqrH9Mvvba4SA+3ncb28Xn
	zc9XnVPKEABs6jkAPKNt1QpXMqbzbmgBFTJMmuN0cuMauQCddKlHOKFrT38/fKMI
	BJAshlFij9N5KixTW6XQmszlomJ8rZTgcy9qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YA50Q59akx4kJU8gnLSqfszJS8iRi1J7
	cH8h7Et8kIVh0MTucQASDyW5zEmNdMh0yaTDXV3myYonwu+XCZ8CCw5a0jVegPN1
	NVmQdCr2c42NsnIaZwQ2eR6s8suXxYCV70bBEotlm7cwGqJiPMYhnIQgUyFyqv/f
	myxlPwSRvHY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B91860CD;
	Fri, 16 Mar 2012 17:53:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0D5B60CC; Fri, 16 Mar 2012
 17:53:43 -0400 (EDT)
In-Reply-To: <20120316214151.GA25092@ecki> (Clemens Buchacher's message of
 "Fri, 16 Mar 2012 22:41:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FDF2B66-6FB2-11E1-B8D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193285>

Clemens Buchacher <drizzd@aon.at> writes:

> On Fri, Mar 16, 2012 at 05:03:58AM -0700, Junio C Hamano wrote:
>> Clemens Buchacher <drizzd@aon.at> writes:
>> ...
>> >> +static const char message_advice_use_upstream[] =
>> >> +	N_("Some of your local branches were stale with respect to their\n"
>> >> +	   "remote counterparts. If you did not intend to push these branches,\n"
>> >> +	   "you may want to set the 'push.default' configuration variable to\n"
>> >> +	   "'current' or 'upstream' to push only the current branch.");
>> >> +
>> >> +static const char message_advice_checkout_pull_push[] =
>> >> +	N_("Updates were rejected because the tip of some of your branches are\n"
>> >> +	   "behind the remote. Check out the branch and merge the remote\n"
>> >> +	   "changes (e.g. 'git pull') before pushing again. See the\n"
>> >> +	   "'Note about fast-forwards' section of 'git push --help'\n"
>> >> +	   "for details.");
>> >
> ...
> Sorry if I did not express myself well. I should have deleted the first
> message. I was not talking about the case where the current branch is
> rejected. I mean the two cases where other branches are rejected.

Oh, I see.  My reply ended up being very similar, though ;-)

These two apply to two different situations.  In the code, you can see
we switch between them like this:

> +	case NON_FF_OTHER:
>  		if (default_matching_used)
>  			advise_use_upstream();
>  		else
>  			advise_checkout_pull_push();
> +		break;

This distinguishes the two cases _why_ you ended up pushing branches that
are not your current branch.  default_matching_used is set (eh, at least,
"designed to be set"; the patch is based on my oooold patch whose details
I do not recall offhand) only when the user said either "git push" or "git
push $there" without explicit pathspec (i.e. "git push $there other" does
not set it to true) and we end up using the "matching" semantics as it is
the current built-in default.

If you tried to push other branch because you weren't aware of the
matching default, you get the first advice, if you explicitly tried to
push other branch, you get the second one. The suggested solutions are
different.

Read each of them in isolation, imagining that you just saw your action
resulted in a corresponding error condition.  I think they are clear
enough (that is why I sent the pach), but the wording may still need to be
polished, and updates are welcome.
