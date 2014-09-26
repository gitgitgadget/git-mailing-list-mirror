From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: discuss --fork-point assumption of vanilla "git rebase" in DESCRIPTION.
Date: Fri, 26 Sep 2014 15:46:24 -0700
Message-ID: <xmqqvboa6lvj.fsf@gitster.dls.corp.google.com>
References: <87r3z72wiu.fsf@osv.gnss.ru>
	<xmqqzjdrjvnd.fsf@gitster.dls.corp.google.com>
	<87k34u9088.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 00:58:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXeTH-0000GT-AA
	for gcvg-git-2@plane.gmane.org; Sat, 27 Sep 2014 00:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779AbaIZW6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 18:58:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57404 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819AbaIZW6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2014 18:58:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA13D3EEA9;
	Fri, 26 Sep 2014 18:58:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k3zZrDrmiq0wO+ZV+ktcNRY60/k=; b=MBRQUS
	zgQmdekisfrJ3+iWOAiGGYO2Je/qL7J255pmgEC4JaroNq1pVooIwhB+Ocd42J4s
	HWqNvyg0mDpLEcVY76pea0TqeUYaoQ7ISuU09hYtXg5mgWuOWEb3lc0Tz5mkwpYb
	6kAvKTAQsHck6G4DHXpkFaDSNYDc4QsZuI45Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jwbczXkJKyw5dsfyIbpdIbOFHNJSH5OG
	jh7Yi1DLHvoBt0rFdJfjROivZpFda78/GYNRkF0B9+w17gWe/32VuThLLeAy9wUB
	tKyS+V4banetbL0Pbbo7a6yHyYQRQHljeaPPvfwJcQh7xDRU002BQ/sRtslYO5Md
	JkHwOAW6Ytc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0A1D3EEA8;
	Fri, 26 Sep 2014 18:58:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9F7F13E96A;
	Fri, 26 Sep 2014 18:46:25 -0400 (EDT)
In-Reply-To: <87k34u9088.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
	23 Sep 2014 13:04:23 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F22DCC1E-45CE-11E4-B319-F248C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257554>

Sergey Organov <sorganov@gmail.com> writes:

> I think you meant to say that we may find a better source to calculate
> the exact set of commits to rebase,...

Yes.

>> It is debatable if we should do the same when the user tells us to
>> rebase with respect to a specific _branch_ by giving the 'upstream'
>> argument, but that is an entirely separate issue.  We might want to
>> do a similar command line heuristics to tell between the branch
>> switching "git checkout master" (which is an operation about a
>> branch) and head detaching "git checkout refs/heads/master^0" (which
>> is an operation about a commit) if we want to help the users by
>> auto-enabling fork-point mode.
>
> Well, IMHO "git rebase" and "git rebase @{u}" must do exactly the same
> thing.

"That is not part of the current discussion" is what I meant by "It
is debatable... We might want to".  There is no such patch to "git
rebase" itself in this topic ;-).

With the "We might want to", I mean "git rebase", "git rebase @{u}"
and "git rebase origin/master" (if your @{u} happens to be that
branch) may want to do exactly the same thing.  The last one however
is very questionable, as sometimes you would want the --fork-point
heuristics, and some other times you would want no digging of the
reflogs involved (i.e. "I want everything not in this _exact_ commit
to be rebased").

> On the other hand, I'm afraid different defaults were chosen for
> backward compatibility?

There is no backward compatibility issue involved with the current
behaviour.  Changing it _will_ break compatibility, of course.

It is more like the command used not to guess with fork-point at
all, i.e. we liked its exactness, but "git rebase" (no argument)
case is so obviously not about an exact commit but is about branch
that it is safe to use --fork-point guess without being confusing.
Once you start giving the commit/branch with respect to which you
conduct your rebase, it no longer is so cut-and-dried obvious that
by "git rebase @{u}" if the user wants us to guess by digging the
reflog of @{u} to find a better fork point, or if the user wants to
do an exact rebase with respect to the commit at the tip of that
branch.
