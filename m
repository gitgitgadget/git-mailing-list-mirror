From: Jeff King <peff@peff.net>
Subject: Re: git merge commits are non-deterministic? what changed?
Date: Fri, 9 Nov 2012 11:16:47 -0500
Message-ID: <20121109161647.GB19725@sigill.intra.peff.net>
References: <20121109133132.GK69724@acme.spoerlein.net>
 <m2y5iarf5s.fsf@igel.home>
 <20121109154245.GP69724@acme.spoerlein.net>
 <vpq390idb8v.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:17:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWrGU-00042U-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 17:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab2KIQQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2012 11:16:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40129 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab2KIQQw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 11:16:52 -0500
Received: (qmail 7984 invoked by uid 107); 9 Nov 2012 16:17:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 11:17:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 11:16:47 -0500
Content-Disposition: inline
In-Reply-To: <vpq390idb8v.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209226>

On Fri, Nov 09, 2012 at 04:52:48PM +0100, Matthieu Moy wrote:

> Ulrich Sp=C3=B6rlein <uqs@spoerlein.net> writes:
>=20
> >> > 2. Why the hell is the commit hash dependent on the ordering of =
the
> >> > parent commits? IMHO it should sort the set of parents before
> >> > calculating the hash ...
> >>=20
> >> What would be the sort key?
> >
> > Trivially, the hash of the parents itself. So you'd always get
> >
> > ...
> > parent 0000
> > parent 1111
> > parent aaaa
> > parent ffff
>=20
> That would change the behavior of --first-parent. Or you'd need to
> compute the sha1 of the sorted list, but keep the unsorted one in the
> commit. Possible, but weird ;-).

Right. The reason that merge parents are stored in the order given on
the command line is not random or because it was not considered. It
encodes a valuable piece of information: did the user merge "foo" into
"bar", or did they merge "bar" into "foo"?

So I think this discussion is going in the wrong direction; git should
never sort the parents, because the order is meaningful. The original
complaint was that a run of svn2git produced different results on two
different git versions. The important question to me is: did svn2git
feed the parents to git in the same order?

If it did, and git produced different results, then that is a serious
bug.

If it did not, then the issue needs to be resolved in svn2git (which
_may_ want to sort the parents that it feeds to git, but it would depen=
d
on whether the order it is currently presenting is meaningful).

-Peff
