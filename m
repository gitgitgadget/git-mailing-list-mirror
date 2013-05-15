From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 15:50:08 -0700
Message-ID: <7vvc6jame7.fsf@alter.siamese.dyndns.org>
References: <5193efe6.c42ab60a.0319.5f2c@mx.google.com>
	<7vzjvvanro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 00:50:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UckWY-0003yZ-9c
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 00:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab3EOWuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 18:50:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35842 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab3EOWuL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 18:50:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69E181F7B2;
	Wed, 15 May 2013 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cRx69yixiT1/VgYxwPYMbCbAGRw=; b=HD1UH1
	qdjBN3eTU0EaJZAtUdYv21dy3XI3OgPKk5U3Y8BVvSA5SX5MJp8MAe//5j9sTubg
	zGmChAcEa8YBnlcbY0cIqJNbp2UlxSJA3aYc96g06E9AUg8hEUAe5hxFw+L0bKXC
	fjzb6oE1MCnrq7sIpBZKAa7ghzUJj59r9Lp90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eV/gcxJkQmLCSMsJMvot9WaAvcFci64s
	Gp5CmsWFo5tqRqw0ye2xek+OYy0W7n5iciAQI7hjnosp5Jrw0IVZi96E1nlmM/ZS
	nKROyQIjMfIs6VUWUyJ5X4+S7fxHnlSo8yXxov4e+6mlLpkgjNmpD3X5nBfjh8nI
	7L0RAAA91Vw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61F791F7B1;
	Wed, 15 May 2013 22:50:10 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0C651F7B0;
	Wed, 15 May 2013 22:50:09 +0000 (UTC)
In-Reply-To: <7vzjvvanro.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 May 2013 15:20:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB90F6E0-BDB1-11E2-836D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224453>

Junio C Hamano <gitster@pobox.com> writes:

> I however am not yet convinced if that direction is what you really
> want go in, though.  What should your 'git pull' on that branch do,
> for example?
>
> When you are on foobar and want to integrate with the branch you
> based your work on (i.e. local 'master'), you can do one of these:
>
>     $ git pull
>     $ git pull --rebase
>
> to "fetch the upstream branch and integrate with it", without having
> to even care if that upstream branch is from the remote, or happens
> to be truly local.  By making 'git fetch' to go to the remote origin
> site, what will you be merging (or rebasing on) when you do the
> above two?
>
> Incidentally, I suspect you can do exactly the same thing without
> introducing a new concept "base" and instead special casing a remote
> whose URL is "."; you essentially declare that "The upstream of this
> branch whose branch.$name.remote is set to '.' lives locally", which
> is not all that different from saying "The upstream of this branch
> whose branch.$name.base exists lives locally", which is what you
> seem to be proposing.  One of the things this alternative approach
> would "special case" such remote is probably to cause "git fetch" to
> ignore such a branch.$name.remote setting and instead go fetch from
> 'origin', just like your "if there is branch.$name.base, but no
> branch.$name.remote, fetch will go to 'origin'" does.
>
> But it has exactly the same "what happens when you do 'git pull'"
> problem, so even though it is conceptually a lot simpler, it has the
> same brokenness.

I do not think of a good way to fix the 'git pull' confusion; the
desire to 'fetch from the overall upstream repository regardless of
which branch I am on' is a valid and understandable one, but that
does not mesh well with "'git pull' is 'git fetch' followed by
either merge or rebase to integrate the result" and "git merge or
git rebase pays attention to the other branch that is specified to
integrate with".  The best we could do might be to simply forbid
"git pull" if your current branch is marked with branch.$name.base
but still allow "git fetch".

The changes that are involved are:

 * Do not change anything to @{upstream}'s definition, that is,
   "checkout -t -b A localbranch" will set branch.A.remote to '.',
   and "git log A@{u}..A" will stand for "git log localbranch..A".

 * Current 'git fetch' pays attention to branch.A.remote when you
   are on branch A, and tries to fetch from there.  Stop doing that
   when branch.A.remote is set to '.' (the current repository) and
   let other rules in the current implementation decide what remote
   to fetch from. Also teach it to error out when branch.A.remote is
   set to '.' when a new --forbid-local option is passed.

 * Teach 'git pull' to pass --forbid-local option to 'git fetch',
   and let an error return fail the whole thing.

Ah, alternatively, instead of adding --forbid-local, we could modify
the changes for 'git fetch' and 'git pull' to read like this:

 * Current 'git fetch' pays attention to branch.A.remote when you
   are on branch A, and tries to fetch from there.  Stop doing that
   when branch.A.remote is set to '.' (the current repository) and
   let other rules in the current implementation decide what remote
   to fetch from, unless a new --allow-fetch-from-local option is
   passed.

 * Teach 'git pull' to pass --allow-fetch-from-local to 'git fetch'.

If we did this, we can keep the "git pull [--rebase]" as a way to
integrate with what you specified as your upstream, which is a
common expectation, without forcing you to say "git fetch origin".
