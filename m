From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 22:59:06 -0800
Message-ID: <7vehhkuwg5.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <7vsj61xez2.fsf@alter.siamese.dyndns.org>
 <7vobgpxeel.fsf@alter.siamese.dyndns.org>
 <CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 07:59:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvjRo-0001kF-0u
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 07:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101Ab3AQG7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 01:59:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57228 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab3AQG7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 01:59:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE92173E9;
	Thu, 17 Jan 2013 01:59:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8eipJY3gOWcRq4lTq7IU+W37p6k=; b=F2QHbl
	zw2TkH8hAlxPNPIJVv3qG9npa057/VsjfHKVvrfbWYTfo5Lm9JOPsFFwC8dYQVK5
	DjzePxSse/r8clGVlONPqLc0Lms8Y7icfS3XM9DkKNsaW5N5xAbnpKF6ZPRybvEe
	zyX9tTTxzeTnJgGqsUDSnoMnEUp67+JnLrWok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aSl0sVAGqmcaqO630umKg9ZSAxoK2L3u
	xNAY+Vdv7jbkXssZCMjyeHUHdTkLvja73G2mxmpvIles7adAlwxGcOoel2z6eFLg
	H5DjvKXr8xZJh/i4uB7U0/7Ey/6X9OU9bB/oGytTVBtvx0wKIIT8EiXMZvhLJUeu
	ugUxJgtwu7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41C2E73E6;
	Thu, 17 Jan 2013 01:59:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A71373E1; Thu, 17 Jan 2013
 01:59:09 -0500 (EST)
In-Reply-To: <CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com> (Chris
 Rorvick's message of "Thu, 17 Jan 2013 00:20:13 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64541B4C-6073-11E2-AE2E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213845>

Chris Rorvick <chris@rorvick.com> writes:

> On Wed, Jan 16, 2013 at 10:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> It is fine when pushing into "refs/tags/" hierarchy.  It is *NOT*
>> OK if the type check does not satisfy this function.  In that case,
>> we do not actually see the existence of the destination as a
>> problem, but it is reported as such.  We are blocking because we do
>> not like the type of the new object or the type of the old object.
>> If the destination points at a commit, the push can succeed if the
>> user changes what object to push, so saying "you cannot push because
>> the destination already exists" is just wrong in such a case.
>
> So the solution is to revert back to recommending a merge?

Of course not, because at that point you may not even have what you
were attempting to overwrite.  Nobody says it is even something you
could merge.

The recommended solution certainly will involve a "fetch" (not
"pull" or "pull --rebase").  You fetch from over there to check what
you were about to overwrite, examine the situation to decide what
the appropriate action is.

The point is that Git in general, and the codepath that was touched
by the patch in particular, does not have enough information to
decide what the appropriate action is for the user, especially when
the ref is outside the ones we know what the conventional uses of
them are.  We can make policy decisions like "tags are meant to be
unmoving anchor points, so it is unusual to overwrite any old with
any new", "heads are meant to be branch tips, and because rewinding
them while more than one repositories are working with them will
cause issues to other repositories, it is unusual to push a
non-fast-forward" and enforcement mechanism for such policy
decisions will help users, but that is only because we know what
their uses are.

The immediate action we should take is to get closer to the original
behaviour of not complaining with "ref already exists", which is
nonsensical.  That does not mean that we will forbid improving the
codepath by giving different advices depending on the case.

One of the new advices could tell them to "fetch it and inspect the
situation", if old is not something we do not even have (hence we
cannot check its type, let alone the ancestry relationship of it
with new), for example.
