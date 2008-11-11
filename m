From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] git push: Interpret $GIT_DIR/branches in a Cogito compatible way
Date: Tue, 11 Nov 2008 09:37:04 +0100
Message-ID: <20081111083704.GA4075@auto.tuwien.ac.at>
References: <1226353631-3716-1-git-send-email-mkoegler@auto.tuwien.ac.at> <7viqqv410q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 09:38:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzolS-0003I9-3l
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 09:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbYKKIhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2008 03:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbYKKIhH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 03:37:07 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37442 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYKKIhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 03:37:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C6D6D6804367;
	Tue, 11 Nov 2008 09:37:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Nr2WCiVjYCQ; Tue, 11 Nov 2008 09:37:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id A227E68018C8; Tue, 11 Nov 2008 09:37:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7viqqv410q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100630>

On Mon, Nov 10, 2008 at 03:25:09PM -0800, Junio C Hamano wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
> > Current git versions ignore everything after # (called <head> in th=
e
> > following) when pushing. Older versions (before cf818348f1ab57),
> > interpret #<head> as part of the URL, which make git bail out.
> >
> > Ignoring the <head> part for push (fetch respects them) is unlogica=
l.
> > As branches origin from Cogito, it is the best to correct this by
> > using the behaviour of cg-push:
> >
> > push HEAD to remote refs/heads/<head>
> >
> > Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
>=20
> This message was addressed to me, but is it meant for inclusion?
>=20
> I do not recall seeing an agreement on what the desired behaviour sho=
uld
> be from (ex-)Cogito users, if this change of behaviour hurts real wor=
ld
> usage of existing git users, andr if so how we ease this change in to=
 the
> release.

Nobody else seemd to be interessted in this topic, so its difficult to
start a discussion.

I would suggest to queue it in pu for some time and wait for other
feedback.

> While I'd personally agree matching with whatever cg-push used to do =
might
> make the most sense in the end, I am not sure changing of behaviour
> abruptly like this is a good idea.

I'm open for any suggestion, how to make this change smoothly. I
think, that doing such a behaviour change should be OK for 1.6.1 or
1.6.2:

Until v1.5.4 (9 month ago), git-push with # was totally broken. Daniel
Barkalow fixed the fetch case in v1.5.4. As a side effect, git-push no
longer fails, but ignores everything after #. So in my option, the
current behaviour was created by chance.

> I am also not so sure url#branch is illogical; I'd suggest dropping t=
hat
> line from the commit log message in any case.

OK, I'll drop it in the next version.

> > +git push uses:
> > =20
> >  ------------
> > -	refs/heads/<head>:<repository>
> > +	HEAD:refs/heads/<head>
> >  ------------
>=20
> Why isn't this "refs/heads/<head>:refs/heads/<head>", by the way?

1) It's Cogito behaviour (cg-push(2)):
|      It will push your commits on the current branch (or as specified
|      by the -r option) to the remote repository, provided that your
|      commits follow the last commit in the remote repository.

2) In my options, it's more flexible

If you want to push to <head>, you must create a local branch called
<head>. If you want to fetch from the remote too, you must choose a
name !=3D <head> for the branches file, as you normaly don't want to
fetch into a local branch. Pushing to <head> in multiple remote
repositories is also more difficult, if they are used for diffent
things, as they are based on one local branch.

=3D> It's a way to seperate the remote head names from the local ones.

mfg Martin K=F6gler
