From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Merge seems to get confused by (reverted) cherry-picks
Date: Wed, 3 Sep 2008 10:37:39 +0200
Message-ID: <20080903083739.GA18653@atjola.homenet>
References: <20080903072011.GA14252@atjola.homenet> <7vprnld5ws.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 10:38:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kant5-0001LY-Jt
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 10:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYICIhp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 04:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbYICIhp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 04:37:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:44161 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751457AbYICIhn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 04:37:43 -0400
Received: (qmail invoked by alias); 03 Sep 2008 08:37:41 -0000
Received: from i577B853E.versanet.de (EHLO atjola.local) [87.123.133.62]
  by mail.gmx.net (mp023) with SMTP; 03 Sep 2008 10:37:41 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/9rdNieOb92dli2lnHj0t4Wot7TjhFBq9R0mhHrn
	AfTggSJO9v1Otw
Content-Disposition: inline
In-Reply-To: <7vprnld5ws.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94763>

On 2008.09.03 00:50:43 -0700, Junio C Hamano wrote:
> But in 3-way merge context, you do not interpret the fact that someth=
ing
> is identical between 0..2 as "they MUST STAY THE SAME".  Instead, you=
 read
> it as "My history does not care what happens to that path -- if the o=
ther
> guy wants to change it, I'll happily take it."
>=20
>     Note.  I am not claiming that the above interpretation will alway=
s
>     match what you would expect.  I am just explaining how the underl=
ying
>     concept of 3-way merge works in general.  If you think about it i=
n a
>     realistic context, such as the "extern in xyzzy.h you did not nee=
d to
>     add but the other guy needed to have", you'll realize that more o=
ften
>     than not, "I do not care and let the other guy decide" interpreta=
tion
>     results in a more useful result.
>=20
> That essentially boils down to three rules:
>=20
>  (0) If both of you did not change anything, the final result won't h=
ave
>      any change (obvious);
>=20
>  (1) If you decided you do not have a need to change a path, but the =
other
>      one saw a need, you take the change;
>=20
>  (2) If you and the other one both wanted to change a path but in a
>      different way, you need to merge at the contents level.
>=20
> And you are seeing rule (1) in action.

OK, so that basically means "if you cherry-pick, you better make sure
that you don't have to revert or just get your fine-toothed comb ready
when you merge later", right? Any advice on how to deal with such a
situation?

The actual use case I had was somewhat like this:
Some new code got added in commit A on the master branch as it was
intended for the next major release. Then it became obvious that it
needs to go into a minor release, so it got cherry-picked into the
maintainance branch. For some reason that new code then got moved into =
a
different file. That move happened on the maintainance branch (ie.
immediate bugfix). And then came the regular merge of the maintainance
branch into the master branch, which ended up with the code being
duplicated.

(Well, actually, it's a two-level maintainance branch setup, but you ge=
t
the idea...)

Of course, in a perfect world the first commit would never have been
cherry-picked and would've been originally made on the maintainance
branch, and the problem would have never shown up. But that's not the
case and I'm not omniscient, so I would have surely missed the problem,
if it wasn't for that two-level setup, which for this merge meant that
the merge result should have been equal to the branch being merged, so
it was easy to spot.

Bj=F6rn
