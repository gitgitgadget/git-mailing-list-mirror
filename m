From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to determine oldest supported version of git
Date: Tue, 14 Feb 2012 22:36:32 -0800
Message-ID: <7vaa4k38nj.fsf@alter.siamese.dyndns.org>
References: <jgeekn$of2$1@dough.gmane.org>
 <7v8vkktt6y.fsf@alter.siamese.dyndns.org>
 <7vwr7upj9m.fsf@alter.siamese.dyndns.org>
 <20120215053607.GC29902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 15 07:36:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxYTq-000416-OQ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 07:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab2BOGgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 01:36:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab2BOGgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 01:36:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C216258F;
	Wed, 15 Feb 2012 01:36:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UmCxPoogJLZmqJnnEVDBPRX7tT0=; b=WIk9SY
	RUuRs/y5zaXurZgD49aRls4sWOEcqAwD9Ozh6sm8rGyPvY+HPxHsyZuOdqLBNZix
	jrtY0+U8BZ0EWZUQyJIZ7CbZMEx5r/8XGxaxnawYLikVS55uuIBoFisOM0Tp7Kca
	ce1M5pSmknDCPTJ7RnU5+9CsocZ+rp8rARjKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=umg3eYErEgeNdQc3A2M+ieI43RX4sYoQ
	1+AlcFYF3/JniOQd0HqjgpRrWm9MOSuY2+VCH/WJaJ4hfJe7IWyQv0K233qYI3lg
	i7vpyQxcx1sgeuMvjBE+NkHGos8+k2Svn4+mrHcsKON3HpkxWzf5hI3QLx92m8p1
	u61IF/Voavo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1352E258E;
	Wed, 15 Feb 2012 01:36:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69AD1258C; Wed, 15 Feb 2012
 01:36:34 -0500 (EST)
In-Reply-To: <20120215053607.GC29902@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 15 Feb 2012 00:36:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 676CED78-579F-11E1-9C8A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190814>

Jeff King <peff@peff.net> writes:

> If you are running v1.7.8.1 now, even if v1.7.9 is out, it is less risky
> to move to v1.7.8.2 than to move to v1.7.9.

That has been the illusion I have been feeding the users.  Unfortunately,
of all people even you started to believe it, because I have been doing
such a good job in giving the illusion, not necessarily in actually
keeping the promise.

But think again, with the intimate knowledge of how these bugfix topics
are merged down to older maintenance tracks.

Typically, a new patch that looks reasonable lives in 'pu' only for a day
or two, cook in 'next' for a couple of days to a few weeks, merged to
'master' and then after several days to a week or two, further merged down
to 'maint' and older maintenance tracks.

I typically run 'next' and I presume so do many other Git people, so this
procedure has proven to be a reasonably robust way to ensure that by the
time the change hits 'master', it has been used in a context that is
reasonably close to the surrounding code (by this word, I do not mean
"textually surrounding" code here; what I mean are the things like the
internal state of the process prepared by existing code before it calls
the updated code, and the way the existing code uses data returned by the
new code) in its final destination that is 'master' for at least a week,
preferrably longer. That gives us a stable 'master'.

But nobody in the development community rebuilds 'maint' every time it is
updated and runs the result as his or her primary production version. Even
I do not do that (remember, I run 'next'). I only build and run full test
suite. Older maintenance tracks are worse. I do not think anybody runs
them before they are tagged and released.

And because 'maint' is deliberately kept behind to exclude all the new
features, and occasional code restructuring associated with some of the
new features only happens in 'master' but never merged down to 'maint',
the surrounding code between 'master' and 'maint' can become vastly
different, making the risk of potential breakage coming from impedance
mismatch higher. I would be very surprised if moving from 1.7.8.3 to
1.7.8.4 were less risky than moving from 1.7.8.3 to 1.7.9.1.  You simply
do not really know what you are getting if you moved from 1.7.6.1 (which
has fixes proven in early 'master' of post 1.7.6 cycle, that was similar
to 1.7.6) to 1.7.6.6 (which merges down fixes that were primarily tested
only in the context of post 1.7.8 cycle), so such a move is even riskier,
simply the base code has diverged too much.

> moving to v1.7.9 is small, which I think is what you are arguing, it is
> still greater than moving to a branch on which a release engineer (read:
> you) has cherry-picked only ultra-safe bugfixes.

The key thing to realize is that they are ultra-safe in the context it has
been cooking in.

> I think you are perhaps arguing that we are so safe that the difference
> in risk is negligible.

Quite the contrary, I am saying that older and untested down-merges are
much riskier, and the difference in risk should not be ignored.

> Which implies to me that in an ideal world, there would be maint
> releases for the current series (i.e., v1.7.9.x now) and the previous
> one (v1.7.8.x now). Somewhere around v1.7.9.3 (or after 3 months, or
> whatever), stop bothering with v1.7.8.x releases.

Actually what I was thinking was to restructure the release schedule
slightly so that

 * We do not merge to 'master' anything but bugfix patches to regressions
   introduced by 1.7.10 or to new features introduced by 1.7.10, for two
   weeks after it ships;

 * During that time, if an urgent fix is needed, 'maint' is directly
   patched to produce 1.7.9.X, and it is merged upward to 'next';

 * After finishing applying the early fixes to 1.7.10 to 'master', we tag
   the tip of 'master' as 1.7.10.1 and fork 'maint' from there;

 * At that point, old 'maint' and 1.7.9.X track cease to receive updates,
   as there is no point maintaining them. It only encourages distros to
   stay behind, adding unnecesary maintenance burden to us.

> In some ways, that's a good thing; they can deal with the release
> management work. OTOH, it's duplicated effort, and done by people who
> are not as intimately familiar with git.

Yes, that's the crucial observation to make.  Cherry-picking or down
merging fixes tested in a new context to older codebase that is not
actively used by the person who is cherry-picking does not produce a
stable end product. It only produces stale end product.  It makes it
slightly scarier to imagine that the cherry-pick is done by people who
may not be as familiar with the codebase as us, but on the other hand,
they might be using that old codebase for their day-to-day work, and may
have better luck hitting issues that did not manifest themselves in the
context of 'master' and 'next.
