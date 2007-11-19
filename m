From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Mon, 19 Nov 2007 09:17:06 +0100
Message-ID: <53F12F4D-73C5-446E-9A97-9D2D4CA9DF9F@zib.de>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site> <11954023881802-git-send-email-prohaska@zib.de> <119540238994-git-send-email-prohaska@zib.de> <7vwssfqb0w.fsf@gitster.siamese.dyndns.org> <EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de> <7vejempudf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 09:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu1nl-0002Pd-A2
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 09:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbXKSIP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 03:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXKSIP5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 03:15:57 -0500
Received: from mailer.zib.de ([130.73.108.11]:39678 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbXKSIPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 03:15:55 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAJ8FpUB008945;
	Mon, 19 Nov 2007 09:15:51 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83cdd.pool.einsundeins.de [77.184.60.221])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAJ8Fo02021769
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 19 Nov 2007 09:15:50 +0100 (MET)
In-Reply-To: <7vejempudf.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65413>


On Nov 19, 2007, at 8:27 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>>> Together with your [PATCH 1/2], I like the general direction
>>> these patckes are taking us, but it feels a bit too hasty.  I
>>> personally am not convinced that switching to --current for
>>> everybody is a good move.
>>>
>>>> ...
>>>
>> I think 3) is the interesting case.  "git push" should do
>> nothing by default.
>
> NO WAY.
>
> Making things cumbersome to everybody does not achieve anything
> useful except for a false sense of equality, does it?

If forces people to make a decision.  And it will hopefully reduce
the amount of questions
"What does '! [rejected] master -> master (non-fast forward)' mean"?
At least I am pretty sure that it will reduce the number of
times I'll be asked this question.  Because I'll ask people to
set a reasonable default.  But if they forget to do so, they'll be
reminded by "git push", before calling me.

And with "push.defaultRefs = matching" it's easy to tell push
once and forever which decision you made.


> Drop that step (3).  That is not useful to anybody.


 From you follow-up mail:

> Thinking about it a bit more, I think my wording was a bit too
> strong and needs clarifying explanations.
>
> In a case like this, a fix of a "misfeature" for somebody is a
> regression for somebody else.  Because there is no single right
> default that is appropriate for everybody.
>
> At least having _one_ default (and picking arbitrarily the
> historical default as that one default) is better than no
> default at all.  The former will not inconvenience anybody by
> forcing what has been necessary from before.  The latter will
> hurt the lucky ones whose preferred way happened to be the
> historical default.

Well, here we disagree.  My point is: if there's no single
right default, then it's better to force the user to make
the decision.


> Keeping the status quo, however, will inconvinience unfortunate
> people whose preferred way was not the historical default.
> That's where we start to tackle the problem, by introducing the
> configuration variable.
>
> If we can come up with a way to tell projects that use the
> workflow better served with --current, perhaps when a remote is
> added to the repository (either the initial clone or "git remote
> add") and/or when a new branch is created.  If we automatically
> set up the configuration "push.defaultRefs = current" in such a
> case, I suspect that we do not have to have the built-in default
> (at least, the value of the built-in default would not matter
> much).

That's beyond what I plan to implement.

Anyway, I'll not change the default behaviour.

But then, if I think a bit more, I don't see a point in
providing the push.defaultRefs configuration.  The default
_is_ and _will forever be_ '--matching'.  That's it.  If a
user wants to have something different, either he needs to
tell on the command line (e.g. '--all', '--current'); or he
can use the a remote.*.push configuration.

That's easier to explain than a configuration variable
"push.defaultRefs", which he can set to "current".  Or he is
allowed to set it to "matching" without triggering an error.  But
this wouldn't change anything, because it's the default anyway.
Then why should someone ever set it to "matching"?

And further, if we have no plans for changing the default, it's
useless to introduce a switch "--matching".  So if the plan is
to stick with the current default forever, then I'll withdraw
my patch that introduces "--matching".

What's left is a new switch "--current".  Less code, easy
to explain.

	Steffen
