From: Jeff King <peff@peff.net>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 17:35:08 -0400
Message-ID: <20121029213508.GB20513@sigill.intra.peff.net>
References: <508D7628.10509@kdbg.org>
 <CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
 <4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
 <CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
 <CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
 <508E532F.2010109@alum.mit.edu>
 <20121029103837.GA14614@sigill.intra.peff.net>
 <CAM9Z-nkf84cV2bYp=NL8an5DjvwP+jL7icb+jwizjHeaq40VhA@mail.gmail.com>
 <20121029113500.GA15597@sigill.intra.peff.net>
 <20121029172330.GC8359@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 22:35:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSwzV-0005Bk-OS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 22:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760509Ab2J2VfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 17:35:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43039 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757413Ab2J2VfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 17:35:10 -0400
Received: (qmail 23736 invoked by uid 107); 29 Oct 2012 21:35:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 17:35:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 17:35:08 -0400
Content-Disposition: inline
In-Reply-To: <20121029172330.GC8359@camk.edu.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208640>

On Mon, Oct 29, 2012 at 06:23:30PM +0100, Kacper Kornet wrote:

> > That patch just blocks non-forced updates to refs/tags/. I think a saner
> > start would be to disallow updating non-commit objects without a force.
> > We already do so for blobs and trees because they are not (and cannot
> > be) fast forwards. The fact that annotated tags are checked for
> > fast-forward seems to me to be a case of "it happens to work that way"
> > and not anything planned. Since such a push drops the reference to the
> > old version of the tag, it should probably require a force.
> 
> I'm not sure. Looking at 37fde87 ("Fix send-pack for non-commitish
> tags.") I have an impression that Junio allowed for fast-forward pushes
> of annotated tags on purpose.

Hmm. You're right, though I'm not sure I agree with the reasoning of
that commit. I'd certainly like to get Junio's input on the subject.

> > Then on top of that we can talk about what lightweight tags should do.
> > I'm not sure. Following the regular fast-forward rules makes some sense
> > to me, because you are never losing objects. But there may be
> > complications with updating tags in general because of fetch's rules,
> > and we would be better off preventing people from accidentally doing so.
> > I think a careful review of fetch's tag rules would be in order before
> > making any decision there.
> 
> The problem with the current behaviour is, that one can never be 100% sure
> that his push will not overwrite someone else tag.

Yes, although you do know that you are not throwing away history if you
do (because it must be a fast forward). Whereas if you have to use "-f"
to update a tag, then you have turned off all safety checks. So it is an
improvement for one case (creating a tag), but a regression for another
(updating an existing tag). I agree that the latter is probably less
common, but how much? If virtually nobody is doing it because git-fetch
makes the fetching side too difficult, then the regression is probably
not a big deal.

-Peff
