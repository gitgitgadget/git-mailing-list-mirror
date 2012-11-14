From: Junio C Hamano <gitster@pobox.com>
Subject: Re: creation of empty branches
Date: Wed, 14 Nov 2012 13:27:33 -0800
Message-ID: <7vmwyjan96.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9CaBECT7c_M9HvCbB8mFYGvdsmq_jFW4DF4NCO8Narnmw@mail.gmail.com>
 <CAH5451mkcszgJxziKn3q3OwSDM-qQ71PtT5+UWb=PG7VYAcFyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 22:27:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYkV0-0007vP-JO
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 22:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423356Ab2KNV1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 16:27:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422641Ab2KNV1g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 16:27:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C26409724;
	Wed, 14 Nov 2012 16:27:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dDFYbzG+T2b9fO47dNifHF6NUWI=; b=YwR1Mm
	Hp+uxXnRyMkCsYkGWPLewFA5Mhllyqd817i8Lsebhuy7fGYCIk+VeEbOuc4Qbk3Q
	JQDHnlYId7bBMLz1f+0v10277d9KGnEjh+4RQZerpxZScVzczacAlMv0uj0pb0Vs
	r2ogfiz2OfbOzSlUbmB58mBBiAw+NTcDVE5GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WQnKkEAmBuYab5K5z1YS40n+Nn5SgS+n
	PKyX+nWlP1rGuZ8EthORdTmjWWeQkqfEGtK8+TL2UVyozRwIRn2nBTGoWzwKe9Cq
	nwDHLNgnpQSPJFbEep3SrAFk6UFHI7Q3h4WyvN45auCYEVV8A0eoJbqBbgtgMWrd
	IzYFkoEl0UU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B05F19723;
	Wed, 14 Nov 2012 16:27:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05AF89722; Wed, 14 Nov 2012
 16:27:34 -0500 (EST)
In-Reply-To: <CAH5451mkcszgJxziKn3q3OwSDM-qQ71PtT5+UWb=PG7VYAcFyQ@mail.gmail.com> (Andrew
 Ardill's message of "Wed, 14 Nov 2012 23:54:44 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B3108F6-2EA2-11E2-A8E6-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209754>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> Since git branch has the default behaviour to create a branch 'in the
> background' it makes sense to fail when trying to create a new branch
> this way from an empty branch. The error message should be improved to
> handle this edge case in a nicer way. If we allow for renaming empty
> branches (described below) then the message can be even more helpful.
> Instead of
>     fatal: Not a valid object name: 'master'.
> perhaps
>     fatal: Cannot create branch 'foo' from empty branch 'master'. To
> rename 'master' use 'git branch -m master foo'.

The first new sentence is a definite improvement, but I do not think
the advice in the second sentence is necessarily a good idea,
because it is dubious that the user is likely to have wanted to
rename 'master' to something else.  "git branch foo master" (or its
moral equivalent "git checkout -b foo" while on master) is a wish to
have a history that ends in 'foo' *forked* from history of 'master',
but because you do not even have anything on 'master' yet, you
cannot fork the history, as you explained earlier (snipped).  In
that sense, 'empty branch' is a slight misnomer---as far as "git
branch foo master" is concerned, the 'master' branch does not yet
exist (and that is why we often call it an "unborn branch", not
"empty").

    fatal: cannot fork master's history that does not exist yet.

would be more accurate description of the situation.

> So explicitly, I am proposing the following behaviour changes:
>
> When trying to create a new branch without specifying a start point,
> if HEAD points to an empty branch, error with a more useful message
> that assumes the user might want to rename the empty branch.

I do not think that is the right assumption in the first place.  It
is very likely that the user does not yet know how Git works when
she attempts to fork from a history that does not exist.  It is also
very likely that she is expecting, after "git branch foo master"
succeeds when 'master' is yet to be born, have two branches 'foo'
and 'master', so that "git checkout foo" and "git checkout master"
can be done subsequently.

But that expectation is wrong, and it would help the user in the
longer run to correct that expectation.  "We assume you wanted to
rename 'master' to 'foo'" is a logical consequence that changing
HEAD that points at an unborn 'master' to point at an unborn 'foo'
is the best (or closest) thing the user can do, *if* the user
understands that the current branch being unborn is a special state
and there can only be one such unborn branch (that is, the current
one).  The user who gets this error message, however, clearly does
not understand that, so it is not a logical consequence to her at
all.  The advice does not help her, but instead invites "No, I did
not want to rename it, I wanted to have 'foo' without losing
'master'", leading to even more confusion.

> When trying to create a new branch whilst specifying an empty branch
> as the start point,
>   if HEAD points to the same empty branch that is listed as the start
> point, error with a more useful message that assumes the user might
> want to rename the empty branch.
>   otherwise error due to invalid ref

See above (for all the other cases, too).
