From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: discuss --fork-point assumption of vanilla "git rebase" in DESCRIPTION.
Date: Mon, 29 Sep 2014 14:05:37 +0400
Message-ID: <87k34mvj0u.fsf@osv.gnss.ru>
References: <87r3z72wiu.fsf@osv.gnss.ru>
	<xmqqzjdrjvnd.fsf@gitster.dls.corp.google.com>
	<87k34u9088.fsf@osv.gnss.ru>
	<xmqqvboa6lvj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 12:05:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYXpw-0007cY-Ux
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 12:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbaI2KFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 06:05:41 -0400
Received: from mail.javad.com ([54.86.164.124]:53045 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428AbaI2KFk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 06:05:40 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 2562161865;
	Mon, 29 Sep 2014 10:05:39 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XYXpp-0004ps-Ho; Mon, 29 Sep 2014 14:05:37 +0400
In-Reply-To: <xmqqvboa6lvj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 26 Sep 2014 15:46:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257619>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I think you meant to say that we may find a better source to calculate
>> the exact set of commits to rebase,...
>
> Yes.
>
>>> It is debatable if we should do the same when the user tells us to
>>> rebase with respect to a specific _branch_ by giving the 'upstream'
>>> argument, but that is an entirely separate issue.  We might want to
>>> do a similar command line heuristics to tell between the branch
>>> switching "git checkout master" (which is an operation about a
>>> branch) and head detaching "git checkout refs/heads/master^0" (which
>>> is an operation about a commit) if we want to help the users by
>>> auto-enabling fork-point mode.
>>
>> Well, IMHO "git rebase" and "git rebase @{u}" must do exactly the same
>> thing.
>
> "That is not part of the current discussion" is what I meant by "It
> is debatable... We might want to".  There is no such patch to "git
> rebase" itself in this topic ;-).

Yes, but to suggest better documentation I figure I need to understand
all the related issues, so it is still somewhat relevant.

> With the "We might want to", I mean "git rebase", "git rebase @{u}"
> and "git rebase origin/master" (if your @{u} happens to be that
> branch) may want to do exactly the same thing.  The last one however
> is very questionable, as sometimes you would want the --fork-point
> heuristics, and some other times you would want no digging of the
> reflogs involved (i.e. "I want everything not in this _exact_ commit
> to be rebased").
>
>> On the other hand, I'm afraid different defaults were chosen for
>> backward compatibility?
>
> There is no backward compatibility issue involved with the current
> behaviour.  Changing it _will_ break compatibility, of course.
>
> It is more like the command used not to guess with fork-point at
> all, i.e. we liked its exactness, but "git rebase" (no argument)
> case is so obviously not about an exact commit but is about branch
> that it is safe to use --fork-point guess without being confusing.

Well, that's exactly what ended-up being /extremely/ confusing in my
case.

> Once you start giving the commit/branch with respect to which you
> conduct your rebase, it no longer is so cut-and-dried obvious that
> by "git rebase @{u}" if the user wants us to guess by digging the
> reflog of @{u} to find a better fork point, or if the user wants to
> do an exact rebase with respect to the commit at the tip of that
> branch.

Whatever excuses are, to me it still looks entirely unnatural that 'git
rebase' and 'git rebase @{u}' mean almost the same /except/ the default
value of --fork-point is different, sorry.

P.S. I'll prepare improved patch for the documentation shortly.

-- 
Segey.
