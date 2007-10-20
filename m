From: Ari Entlich <lmage11@twcny.rr.com>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 01:55:53 -0400
Message-ID: <1192859753.13347.147.camel@g4mdd.entnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@MIT.EDU>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 07:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7Jl-0007hi-Mk
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 07:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759605AbXJTF4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Oct 2007 01:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759304AbXJTF4F
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 01:56:05 -0400
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:63894 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbXJTF4C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 01:56:02 -0400
Received: from [192.168.123.196] (cpe-24-59-99-35.twcny.res.rr.com [24.59.99.35])
	by ms-smtp-05.nyroc.rr.com (8.13.6/8.13.6) with ESMTP id l9K5tuqq024998;
	Sat, 20 Oct 2007 01:55:56 -0400 (EDT)
X-Mailer: Evolution 2.10.3 
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61787>

On Fri, 2007-10-19 at 13:33 +0200, Wincent Colaiuta wrote:
> El 19/10/2007, a las 4:29, Michael Witten escribi=C3=B3:
> > Ah. Basically my 'pseudo-code' is correct, but redundant.
>=20
> If I understood the original poster's proposal then I don't think you=
r
> code does what he asked for:
>=20
> > What you want to happen is the following:
> >=20
> > git show HEAD:A.txt > path/B.txt
> > git add path/B.txt
> > mv A.txt B.txt
> > git rm A.txt
> >
> > Is this correct?
>=20
> Here you're copying the content of A.txt as it was in the last (HEAD)
> commit, but from what the poster said he wants the content of A.txt a=
s
> it is staged in the index (that is, there may be staged but uncomitte=
d
> changes).

You took the words right out of my mouth! :)

Yeah, I noticed the problem with using HEAD, but the other problem is
that this would change the contents of the file in the working director=
y
file, which I don't want. Thus, putting the contents of the file as it
is in the index into the working directory wouldn't be correct either.
In addition, I'm not quite sure where that "mv A.txt B.txt" came from,
since we're supposed to be moving A.txt to path/B.txt...

> > Better:
> >
> > > mv A.txt path/B.txt
> > > Point the index entry for A.txt to path/B.txt
>=20
> Yes, that is basically what he was asking for, as I read it.

Yep! I was going to respond to your (Michael's) original message saying
exactly that. :)

> El 19/10/2007, a las 5:47, Jeff King escribi=C3=B3:
> > Hrm. So you _do_ want to do an index-only move of A to B, in which=20
> > case the suggestion of a "git-mv --cached" seems sensible. Though=20
> > I'm curious why you want that.
>=20
> I agree that git-stash can be used in this workflow but I can also=20
> imagine cases where the proposed "git-mv --cached" might be a bit=20
> nicer.

As Shawn said, --cached wouldn't be entirely accurate as the file in th=
e
working directory is being moved as well.

git-stash has been suggested to me numerous times, but I really feel
that there's no need to use it in this case - if the git mv command gav=
e
adequate control to the user, it would be unnecessary.

> I'm thinking of occasions where you just want to do something=20
> like:
>=20
> git mv --cached foo bar
> git add --interactive bar

I think it would be the other way around, since the only time this
change would effect anything is when there are changes still waiting to
be staged.

Are you talking about REALLY only changing the index? I can't think of
why you'd want to do this either... After all, wouldn't there be no bar
file to do git add --interactive on? In addition, I don't think giving
--interactive a filename is meaningful...

> I'm not sure the proposed "--cached" switch should ever be the=20
> default -- would need to ponder that one -- but I do think the switch=
=20
> would be a nice addition.

Yeah, that is one thing I was wondering. It would break compatibility,
but would it be enough to put a note about that in the announcements fo=
r
a release? Could you make the change at a release when the interface
isn't guaranteed to be the same, or is this practice only done with
libraries?

It might be interesting to do some sort of survey of whether people
depend on this behavior. It seems pretty inconsistent with how git work=
s
otherwise, and I'd be surprised if a lot of people expect it (kinda lik=
e
the Spanish Inquisition :-P).

Thanks,
	Ari
