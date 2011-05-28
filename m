From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: [PATCH] rebase: learn --discard subcommand
Date: Sun, 29 May 2011 06:26:26 +1000
Message-ID: <SNT124-W247D44D043F692CA06747EC4790@phx.gbl>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>,<7vpqn2psjv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, <artagnon@gmail.com>
To: <gitster@pobox.com>, <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 28 22:26:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQQ5k-0001bD-0v
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 22:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450Ab1E1U0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2011 16:26:30 -0400
Received: from snt0-omc2-s13.snt0.hotmail.com ([65.55.90.88]:51702 "EHLO
	snt0-omc2-s13.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751723Ab1E1U0a convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 16:26:30 -0400
Received: from SNT124-W24 ([65.55.90.73]) by snt0-omc2-s13.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sat, 28 May 2011 13:26:29 -0700
X-Originating-IP: [58.163.175.134]
Importance: Normal
In-Reply-To: <7vpqn2psjv.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 28 May 2011 20:26:29.0627 (UTC) FILETIME=[86C3F4B0:01CC1D75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174675>


> From: gitster@pobox.com
> Date: Sat, 28 May 2011 11:51:32 -0700
>
> Martin von Zweigbergk  writes:
>
> > ... I think Junio then
> > hinted that he sometimes wished that he could abort rebase without
> > moving to anywhere else at all, which is what this patch implements=
=2E
>
> I am not opposed to this particular patch, but thinking about a bigge=
r
> picture, I am not sure if we want to solve it this way.
>
> We have multiple "sequence" operations that want to do things in mult=
iple
> steps, each of which can stop and give control back to the user, whil=
e
> leaving some information in the .git directory for it to know where i=
t was
> when resuming. I think "am" knows about what "rebase" does (and
> vice-versa) so it can detect an attempt to run it while "rebase" is i=
n
> still progress and refuse to continue to limit the damage, but if we =
have
> N such "sequence" commands that want to refrain from interfering with=
 each
> other, and want to offer an advice to abort the in-progress operation
> initiated by other commands, that would mean we would need N * N piec=
es of
> logic to detect other's in-limbo state and offer advices, which would=
 not
> scale.
>
> A user who is given back the control from a "sequence" operation may =
be
> confused either (1) immediately after such an event (often some sort =
of
> merge conflict) or (2) much later after first abandoning the working =
tree
> altogether and taking a walk and then coming back to continue working
> while forgetting what he was doing. Such a user may want to say "I kn=
ow I
> am in a strange state, give me a state that I can work from, at this =
point
> I do not care about continuing what I was originally doing". The user=
 may
> probably not know if "git rebase" was in progress or "git cherry-pick=
"
> was.
>
> "git reset --hard" used to be such a command in simpler times. It rem=
oves
> MERGE_HEAD unconditionally, so that a confused user can start from sc=
ratch
> without having to worry about what was in progress. As a devil's advo=
cate,
> I am wondering if it is a good idea to simply teach "reset --hard" to=
 also
> remove any and all "sequence" cruft (.git/rebase-apply, .git/rebase-m=
erge,
> CHERRY_PICK_HEAD; we might have others I do not recall offhand) and b=
e
> done with it. It is a large hammer, but it is certainly the easiest t=
o
> explain and the simplest to understand way to get out of any troubles=
=2E

I'd just like to say that I sometime use "git reset --hard" in the midd=
le
of a "git rebase" when I want to get rid of some changes completely.
Now, I'm not saying that this is the best way of doing it ("git checkou=
t --"
is probably far superior?), but I daresay that there are some users out
there who will be surprised by the new behaviour of "git reset --hard".

Having said that, before I knew that "git reset --hard" could be used
in the middle of a rebase without aborting the reset, I did try to use =
it
to abort the rebase, because, as you said, it seems to be "uh oh" butto=
n
in git.

So it's a bit of a toss-up really.

Having said that, I would support making "reset --hard" abort rebases,
on the condition that there are some _big_ warnings somewhere about
the change in behaviour.


Tim.

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org=A0=A0=A0 - against proprietary attachments
 		 	   		  