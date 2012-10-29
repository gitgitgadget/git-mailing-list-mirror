From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 18:23:30 +0100
Message-ID: <20121029172330.GC8359@camk.edu.pl>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
 <508D7628.10509@kdbg.org>
 <CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
 <4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
 <CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
 <CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
 <508E532F.2010109@alum.mit.edu>
 <20121029103837.GA14614@sigill.intra.peff.net>
 <CAM9Z-nkf84cV2bYp=NL8an5DjvwP+jL7icb+jwizjHeaq40VhA@mail.gmail.com>
 <20121029113500.GA15597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 18:24:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSt4J-0002s7-Q5
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 18:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab2J2RXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 13:23:41 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:34028 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab2J2RXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 13:23:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 8ED375F004D;
	Mon, 29 Oct 2012 18:23:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id CJLFfVso8wJ4; Mon, 29 Oct 2012 18:23:31 +0100 (CET)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id C80C65F0046;
	Mon, 29 Oct 2012 18:23:31 +0100 (CET)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 1886E43CFD; Mon, 29 Oct 2012 18:23:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121029113500.GA15597@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208630>

On Mon, Oct 29, 2012 at 07:35:00AM -0400, Jeff King wrote:
> On Mon, Oct 29, 2012 at 07:21:52AM -0400, Drew Northup wrote:

> > > I would have expected git to at least complain about updating an
> > > annotated tag with another annotated tag. But it actually uses the same
> > > fast-forward rule, just on the pointed-to commits. So a fast-forward
> > > annotated re-tag will throw away the old tag object completely. Which
> > > seems a bit crazy to me.

> > > It seems like a no-brainer to me that annotated tags should not replace
> > > each other without a force, no matter where in the refs hierarchy they
> > > go.

> > > For lightweight tags, I think it's more gray. They are just pointers
> > > into history. Some projects may use them to tag immutable official
> > > versions, but I also see them used as shared bookmarks. Requiring "-f"
> > > may make the latter use more annoying. On the other hand, bookmark tags
> > > tend not to be pushed, or if they are, it is part of a mirror-like
> > > backup which should be forcing all updates anyway.

> > Would that be an endorsement of continuing to build a patch set
> > including the snippet that Kacper posted earlier (1) in response to my
> > comment about not being sure how complicated all of this would be or
> > not?

> That patch just blocks non-forced updates to refs/tags/. I think a saner
> start would be to disallow updating non-commit objects without a force.
> We already do so for blobs and trees because they are not (and cannot
> be) fast forwards. The fact that annotated tags are checked for
> fast-forward seems to me to be a case of "it happens to work that way"
> and not anything planned. Since such a push drops the reference to the
> old version of the tag, it should probably require a force.

I'm not sure. Looking at 37fde87 ("Fix send-pack for non-commitish
tags.") I have an impression that Junio allowed for fast-forward pushes
of annotated tags on purpose. 

> Then on top of that we can talk about what lightweight tags should do.
> I'm not sure. Following the regular fast-forward rules makes some sense
> to me, because you are never losing objects. But there may be
> complications with updating tags in general because of fetch's rules,
> and we would be better off preventing people from accidentally doing so.
> I think a careful review of fetch's tag rules would be in order before
> making any decision there.

The problem with the current behaviour is, that one can never be 100% sure
that his push will not overwrite someone else tag.

-- 
  Kacper
