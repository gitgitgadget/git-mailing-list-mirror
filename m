From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Mon, 13 Feb 2012 02:23:59 -0800
Message-ID: <7v4nuvghfk.fsf@alter.siamese.dyndns.org>
References: <20120210185516.GA4903@tgrennan-laptop>
 <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <7vaa4qnk4u.fsf@alter.siamese.dyndns.org> <4F361DD4.9020108@alum.mit.edu>
 <7vlio9n5ym.fsf@alter.siamese.dyndns.org> <4F389FB1.2070706@alum.mit.edu>
 <7vsjifgrwl.fsf@alter.siamese.dyndns.org> <4F38D9D4.5000203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 13 11:24:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwt5V-0001wg-Gl
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 11:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503Ab2BMKYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 05:24:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504Ab2BMKYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 05:24:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD4172FD;
	Mon, 13 Feb 2012 05:24:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bewyUSqKWMk6dCStcvTRBZXQaHo=; b=O1tLzk
	jXMmCiE6GcVaUHGE1mU62pdtAcU9qhb+mBA443s/jPmzKTGJr7IF/t9PU9WjVQLE
	+zBCpABiZrLlDJJHouWLdTJ1bnSDVgNsFnV4EtQP0Iyjfokl5PrppAAIL2+DIXBz
	I4tY8TwyiRYJ13WHJO3R0MVFXpds0Snao00HA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iz+j3CLM3iGJC1DpEMePb/EzML3p29dQ
	RKk7uuUDPWhxKJVWjMGDvm49ZAnnX17g0V6pc9zAjffwpnp9FUiCjy56mxGPVjBw
	qVWbd8eNqyE6XAjLdM76FlVhlQpaVd2DCjAgYGcLXlLzZSQokNlIC9qNV9SLJBb5
	ZNVb8dwtKo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5742B72FC;
	Mon, 13 Feb 2012 05:24:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4794772F8; Mon, 13 Feb 2012
 05:24:01 -0500 (EST)
In-Reply-To: <4F38D9D4.5000203@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 13 Feb 2012 10:37:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8E4F2BC-562C-11E1-8E3E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190623>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/13/2012 07:37 AM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> Of *course* they operate on different namespaces.  But part of the way
>>> that revisions are selected using rev-list is by *selecting or excluding
>>> refnames* from which it should crawl.
>> 
>> I am appalled if that is truly the understanding of yours, after having
>> taken more than a few patches from you to fairly core parts of Git.
>> 
>> "rev-list A ^B" does not say "include A and exclude B from which rev-list
>> should crawl" AT ALL.  We _actively_ crawl from both A and B.  It is that
>> what are reachable from B is painted in a color different from the color
>> in which we paint what are reachable from A.
>
> Please read my emails more carefully before insulting me.
> ...
> o---o---o---*  A
>      \   \
>       \   o---o  C
>        \
>         *---*  B
>
> ... vs ...
>
> *---*---*---*  A
>      \   \
>       \   o---o  C
>        \
>         *---*  B
>
> I argue that this is a useful selection.

Then why were you so against the addition of "negation" to for-each-ref?

If you want "I want histories reaching A and B", just say "rev-list A B",
without adding useless "er, I do not want histories reaching C in the
output, but I do not want commits reachable from C to be excluded from the
output either" by mentioning C. Learn to shut your mouth and not talk
about irrelevant "C" in such a case, and you will do just fine.

Especially, re-read your first message where you said that between

    git rev-list A B ^C

and

    git rev-list $(git for-each-ref A B ^C)

"consistency suggests should do the same".  Should the consistency also
suggest that

    git rev-list $(git rev-parse A B ^C)

do the same?  That is a total bullshit that can only come from somebody
who does not understand the distinction between pattern matching in
refnames vs set operation over commit DAG.

Having said all that, if your argument against using "^" as negation for
for-each-ref *were* with something like this from the beginning:

    git rev-list --all --exclude-refs=refs/tags/v\*

it would have been very different. I would wholeheartedly buy the
consistency argument that says

    git for-each-ref --exclude-refs=refs/tags/v\*

ought to give all refs (only because for-each-ref "all" is implied) except
for the tagged tips, and

    git log --all --exclude-refs=refs/tags/v\*

should be the notation to produce consistently the same result as

    git log $(git for-each-ref --format='%(objectname)' --exclude-refs=refs/tags/v\*)

but if we used "^" as negated match in for-each-ref argument, we would
close the door to give such consistency to log family of commands later.

But that wasn't what you said.  Why should I get accused of not guessing
what you meant to say but you clearly didn't, and in addition blamed for
insulting merely for pointing out the idiocy in what you said?

No. *YOU* go back and re-read your message more carefully.
