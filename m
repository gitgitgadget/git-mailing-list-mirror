From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] branch: name detached HEAD analogous to status
Date: Sun, 22 Feb 2015 11:21:48 -0800
Message-ID: <xmqqa905wy43.fsf@gitster.dls.corp.google.com>
References: <71fc137d8015f6e81ab91cfcbcad4ec0fa0dc3e6.1424626271.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Feb 22 20:21:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPc6G-0004Tm-7Y
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 20:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbbBVTVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2015 14:21:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752028AbbBVTVv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2015 14:21:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B36839313;
	Sun, 22 Feb 2015 14:21:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jB3doI17894aRZa82VLZYwtFtcU=; b=pL7Ycl
	wtgCojh/ghVcp04MtxbcaisUu14fIRWD+cR/ONBjqCek4FgyHGRENt6dUX2L5qav
	N8EPW1qgHYSO9UphgMcjLb46dZFab0NlGyRt15WW43LIX0qy4H7gKl9ivesP3Wa/
	QrmUlGIHBVmb19WBuhAHQ2+rDxx7t8ITTUIwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b5Yu6Xm0tkOA0W4Bym6sOjlF80A2o+Ft
	sQ4d2Ei7o0+3Sov22Vy/4D8EGubu55Vf703iPl10j9PB2wvIqjlLpJACImzB68xo
	2/H1b6E55z2O/QLbKDSuOS6dcE5Sc23HuvGg62c30JGHXwJgPuBNKVers4hLmto1
	jmnfEIQZARY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 90E6139311;
	Sun, 22 Feb 2015 14:21:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1106C3930F;
	Sun, 22 Feb 2015 14:21:49 -0500 (EST)
In-Reply-To: <71fc137d8015f6e81ab91cfcbcad4ec0fa0dc3e6.1424626271.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Sun, 22 Feb 2015 18:38:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0CE98002-BAC8-11E4-A639-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264236>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "git status" carefully names a detached HEAD "at" resp. "from" a rev or
> ref depending on whether the detached HEAD has moved since. "git branch"
> always uses "from", which can be confusing, because a status-aware user
> would interpret this as moved detached HEAD.
>
> Make "git branch" use the same logic and wording.

Yeah, otherwise the user would wonder why sometimes the object name
after that "from" matches "git rev-parse HEAD" and sometimes does
not.

In order to make sure that it will be easy for us to maintain that
these two commands will keep using the same logic and wording after
this "fix" is applied, should this patch do a bit more?  Or is it
worth doing that for such a small piece of code to be shared?

The following is a tangent and I do not think it is likely we would
do anything about it, but I wonder what value we give the end users
by showing the "from" information, both in "status" and "branch" in
the first place.  When I am on a detached HEAD, I'd be doing one of
these three things:

 (1) I am on some kind of sequencing machinery (e.g. "rebase -i",
     "cherry-pick A..B", or "bisect").  It does not matter to me at
     all if I am at the same commit at which I started the sequenced
     operations or the sequencing machinery has moved me one or more
     commits along its planned course of action, or where the
     original point the sequencing machinery detached the HEAD at.
     I suspect that I would not use "git status" or "git branch" in
     this mode anyway.

 (2) I am sight-seeing, starting with e.g. "git checkout v2.0.0",
     and moving around with "git checkout $some_other_commit".  I'd
     always see that I am "at" the commit I last checked out, so the
     distinctions would not be even shown to me.

 (3) I am experimenting to fix or enhance an existing thing that is
     meant to eventually hit a concrete branch, but I do not know if
     the experiment would pan out. "git checkout $topic~$n" would be
     to start from near the tip of that $topic ($n may often be 0
     but not always) and then I would "git commit" my experiments.
     When I assess my progress, I'd be interested in what I have
     that is not in $topic and vice versa since I started that
     experiment, so

     $ git log ...$topic
     $ git show-branch HEAD $topic

     would be a lot more useful than having to learn "where did I
     detach" from either "status" or "branch" and then do something
     about that the abbreviated object name (like feeding it to
     "describe" or "log").

Of course, the decision to make the point the HEAD was originally
detached at is not an issue this patch introduces, but it makes me
wonder if that existing "at vs from" logic is an overall win or a
loss.
