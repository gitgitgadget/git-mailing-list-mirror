From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: Re: git merge commits are non-deterministic? what changed?
Date: Tue, 20 Nov 2012 17:22:26 +0100
Message-ID: <20121120162226.GK69724@acme.spoerlein.net>
References: <20121109133132.GK69724@acme.spoerlein.net>
 <m2y5iarf5s.fsf@igel.home>
 <20121109154245.GP69724@acme.spoerlein.net>
 <vpq390idb8v.fsf@grenoble-inp.fr>
 <20121109161647.GB19725@sigill.intra.peff.net>
 <20121109182753.GQ69724@acme.spoerlein.net>
 <50A0DD23.4040800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 17:23:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Taqba-0005bt-9q
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 17:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab2KTQXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 11:23:06 -0500
Received: from acme.spoerlein.net ([88.198.49.12]:15061 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab2KTQXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 11:23:04 -0500
Received: from localhost (acme.spoerlein.net [IPv6:2a01:4f8:131:23c2::1])
	by acme.spoerlein.net (8.14.5/8.14.5) with ESMTP id qAKGMQUk079959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 20 Nov 2012 17:22:27 +0100 (CET)
	(envelope-from uqs@spoerlein.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1353428548;
	bh=DAnpTiWU39d9JUiWKLdFpB1lblnz0bljJewt9qFTV5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ppIP74iUiIVpEXob5IYfZdK67uoueDP0RL163pmVmDHm1ZIULQXsdLmGay+b0fEPY
	 XGjgMMD04AQgjnUQRiyB+3ISSgWj3eng6fnDl6eIfvF4tAFbFJPIeNICogFLkwXqrc
	 1wqB7gpq9+qvrt54d+BBvL5jzjLANr3F8AN6lFiA=
Content-Disposition: inline
In-Reply-To: <50A0DD23.4040800@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210103>

On Mon, 2012-11-12 at 12:27:31 +0100, Michael J Gruber wrote:
> Ulrich Sp=C3=B6rlein venit, vidit, dixit 09.11.2012 19:27:
> > On Fri, 2012-11-09 at 11:16:47 -0500, Jeff King wrote:
> >> On Fri, Nov 09, 2012 at 04:52:48PM +0100, Matthieu Moy wrote:
> >>
> >>> Ulrich Sp=C3=B6rlein <uqs@spoerlein.net> writes:
> >>>
> >>>>>> 2. Why the hell is the commit hash dependent on the ordering o=
f the
> >>>>>> parent commits? IMHO it should sort the set of parents before
> >>>>>> calculating the hash ...
> >>>>>
> >>>>> What would be the sort key?
> >>>>
> >>>> Trivially, the hash of the parents itself. So you'd always get
> >>>>
> >>>> ...
> >>>> parent 0000
> >>>> parent 1111
> >>>> parent aaaa
> >>>> parent ffff
> >>>
> >>> That would change the behavior of --first-parent. Or you'd need t=
o
> >>> compute the sha1 of the sorted list, but keep the unsorted one in=
 the
> >>> commit. Possible, but weird ;-).
> >>
> >> Right. The reason that merge parents are stored in the order given=
 on
> >> the command line is not random or because it was not considered. I=
t
> >> encodes a valuable piece of information: did the user merge "foo" =
into
> >> "bar", or did they merge "bar" into "foo"?
> >>
> >> So I think this discussion is going in the wrong direction; git sh=
ould
> >> never sort the parents, because the order is meaningful. The origi=
nal
> >> complaint was that a run of svn2git produced different results on =
two
> >> different git versions. The important question to me is: did svn2g=
it
> >> feed the parents to git in the same order?
> >>
> >> If it did, and git produced different results, then that is a seri=
ous
> >> bug.
> >>
> >> If it did not, then the issue needs to be resolved in svn2git (whi=
ch
> >> _may_ want to sort the parents that it feeds to git, but it would =
depend
> >> on whether the order it is currently presenting is meaningful).
> >=20
> > Yeah, thanks, looks like I have some more work to do. I don't quite=
 get
> > how it could come up with a different order, seeing that it is usin=
g svn
> > as the base.
> >=20
> > Will run some more experiments, thanks for the info so far.
>=20
> There was a change in the order in which "git cherry-pick A B C" appl=
ies
> the commits. It's the only odering affecting change in 1.8.0 that I c=
an
> think of right now.

Just to wrap this up, it was of course a "feature" of the converter,
that resulted in this unrepeatable behavior. The SVN API makes use of
apr_hashes, which were traversed in arbitrary order, hence SVN commits
spanning multiple git-branches would be handled in a non-deterministic
order, leading to randomly ordered parent objects for later git merge
commits.

It it still debatable, whether a merge commit should have a
list-of-parents or a set-of-parents. Changing it to a set-of-parents
(with a well-defined hash function), would have made this problem go
away.

But this will never be changed, it would break the fundamental git
storage model as it is in place now.

Cheers,
Uli
