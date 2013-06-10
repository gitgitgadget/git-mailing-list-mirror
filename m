From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Mon, 10 Jun 2013 02:37:34 -0700
Message-ID: <7v4nd6l31d.fsf@alter.siamese.dyndns.org>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
	<1370798000-2358-3-git-send-email-artagnon@gmail.com>
	<7vip1moq3k.fsf@alter.siamese.dyndns.org>
	<CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 11:37:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlyXm-0000fP-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 11:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab3FJJhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 05:37:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284Ab3FJJhh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 05:37:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E56E268E2;
	Mon, 10 Jun 2013 09:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6xAFtozwe6HVK5HUkylvd5v39e8=; b=iTyVNo
	wHLVrMJCAFy5KLPJBaeRDPLu9gw16oYZy7Ss8aDUCHVvjVoXi5DMEjpwglRJLAbP
	3MgAK7xgF3DdHZCZCugl+vPfbh0lFUheXO7ilt1VhduYr9TWjWxC6HQ/3/mauBvw
	r1jkw/6LvXoaWQjdmQNto1bQzTWseF55gjUo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R3j4S3kx9KKn425ipFYevTXC2X2RPGbo
	V0K3zmjqK/ihkG2zi+VL7GQ+zUs5J1FDb28xVnBU9fFWHmoN0HtpAbAv82KK+5T4
	2nHTbRWvlc5AGDLNk5hIYh7nH/jF344vwLW6s4sPYJSTaEyEwebHBIbt4r8/1hJk
	Apmf5yL0NX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DF8268E1;
	Mon, 10 Jun 2013 09:37:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACF7E268DE;
	Mon, 10 Jun 2013 09:37:35 +0000 (UTC)
In-Reply-To: <CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 10 Jun 2013 14:13:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61F181BE-D1B1-11E2-82EA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227268>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I don't understand why upstream/ simple should _not_ push to a
> different destination from the one being merged from.  I'll repeat:
> push source/ destination is orthogonal to push refspec, and
> push.default modes dictate the refspec.

That is where we differ.  You keep repeating that without justifying
why reusing the branch upstream would have chosen in a non-triangular
workflow is a good idea in the first place.

Let's step back a bit and think.  In a workflow where we both agree
that "upstream" mode makes sense, i.e. central repository workflow,
we may have a "triangle" topic in our shared repository, and I may
have my own topic forked from it (i.e. set to fetch that "triangle"
and integrate my work with it).  The topic is to work on one aspect
of triangular workflow, e.g. "pushbranch" (i.e. I am not worried
about how we choose which remote to push to, but interested in what
branch at that remote is updated).

It makes sense for me to push the result back to the upstream,
i.e. "triangle" branch at the shared remote where I forked from, to
collaborate with other people (e.g. you) whose shared purpose is to
improve the triangular workflow.  You may be doing the same, and
your local branch may be called "triangle" (bag of various
triangular workflow improvements), or "pushremote" (a specific
subtopic).  In either case, you push to "upstream" to update
"triangle".

What should happen in a triangular workflow, where I may be fetching
and integrating from your repository to work on triangular workflow
in general (let's say that you are the owner of that topic) to
advance the support for that workflow.  The topic in your repository
may be called "triangle" to improve triangular workflow in general,
and again my branch would be "pushbranch" to improve one specific
aspect of it.

As we are using triangular workflow, the place *I* push to is under
my control, not the shared maintainer one or your repository, and
I'll be requesting you to pull that topic from me.

Now think _why_ I renamed the branch on my end, i.e. not calling
that branch in question "triangle" that is the blanket name for the
collective effort but calling it with a more specific name
"pushbranch", in the first place.

It is to clarify that my part of the effort is that particular
subarea of the topic.  Wouldn't it be a lot more sensible to use
that more specific name when publishing, rather than "triangle"
name, and ask you to pull that branch that describes what I
concentrated on?

Push destination and fetch source, when they are different, refer to
different repositories by definition, and they are in different
administration domains.  Why should the name used to publish my work
which is a specialization of what I built on (i.e. your "triangle")
lose the specialization from its name when I push it out?  We can
afford not to lose information in the branch name.

The difference between the shared repository case and triangular
workflow primarily comes from the fact that the final integration
happens at a different place.  In the shared repository case, the
integration happens in each participant's local repository and push
updates the shared history at the known name.  If my "pushbranch"
specialization diverted from the overall "triangle" effort, I would
first integrate others work and then update the remote, and at that
point, what I am pushing is no longer an isolated specialized effort,
but the result of its integration into a larger topic.

And once the more specialized topic is integrated into a more
generic branch it was forked from, it makes sense to update that
more generic branch at the shared repository.

In the triangular case, however, you as the "triangle" topic owner
has the choice to fetch and integrate from me or not to do so.  And
the integration happens when you decide to fetch and integrate.
There is no reason whatsoever to lose the more specific name until
that integration happens into your (meaning: the owner of the more
general "triangle" topic) "bag of various triangular improvements"
topic.

Imagine the case I forked two branches from your "triangle" topic
and pushing them to my publishing repository using the triangular
workflow.  Why should I attempt to update a single "triangle" branch
with both of these topics?

The name under which the local branch is published needs a sensible
default (when branch.$name.push is not specified), and I agree that
you would get the name of the branch my work was forked from if you
reuse the "upstream" code.  I am saying that it does not necessarily
give us a good default.
