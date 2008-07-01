From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: error out when given any good rev that is not an ancestor of the bad rev
Date: Tue, 1 Jul 2008 02:20:44 +0200
Message-ID: <200807010220.44657.chriscool@tuxfamily.org>
References: <20080701004211.ba9b89c9.chriscool@tuxfamily.org> <200807010146.09206.chriscool@tuxfamily.org> <7vej6etra7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 02:17:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDTZ5-0001AA-7b
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 02:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbYGAAQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 20:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbYGAAQt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 20:16:49 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36120 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbYGAAQt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 20:16:49 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0F43E1AB2C0;
	Tue,  1 Jul 2008 02:16:48 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9B3681AB2B2;
	Tue,  1 Jul 2008 02:16:47 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vej6etra7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86975>

Le mardi 1 juillet 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Yes, but the fact is that the user may wrongly think that F is an
> > ancestor of D or he may not remember/know about the rule that sayin=
g "F
> > is good" means "everything from A to F is good". That's why this pa=
tch
> > adds a safety net by detecting end erroring out in this case.
>
> Yeah, sorry about the confusion earlier.
>
> But I do not think forbidding forked topology very early in bisection
> process is a very good idea.  The user would be at loss when told:
>
> 	echo >&2 "Maybe you mistake good and bad revs?"

Yeah, perhaps we should then check that it can be a mistake by testing =
if=20
bad is an ancestor of good. If bad is indeed an ancestor of good, it's=20
probably a mistake and we may even ask if the user wants good and bad t=
o be=20
swaped (assuming he gave only one good rev of course).

> Aside from the "test a trial merge" idea I floated in the other messa=
ge,
> when we detect such a fork, perhaps we can suggest testing the merge =
base
> version (B in your picture) first?  We would immediately know as the =
user
> would say "B is bad" if the topology is problematic.

Yes this can be a good idea, if the user gave only one good rev. It may=
be=20
more tricky if he gave many good revs, but in this case we may perhaps =
drop=20
siblings good revs as long as one good rev is an ancestor of the bad re=
v.

> Then, we can suggest the user that breakage at D may not be a regress=
ion
> but a longstanding bug that was recently fixed somewhere between B an=
d F.
>
> The user then can decide to bisect to find the fix (so that it can be
> cherry picked on top of D) or merge F into D to propagate the fix for=
ward
> if it is not important to find out which exact commit fixed the issue=
=2E
>
> Hmm?

Yeah that might be a plan.

Another option is to introduce a switch to "git bisect start",=20
perhaps --strict, to please people who always want to use good revs tha=
t=20
are ancestor of the bad revs, so they get a nice error when this is not=
 the=20
case.

Thanks,
Christian.
