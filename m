From: Jeff King <peff@peff.net>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 06:38:37 -0400
Message-ID: <20121029103837.GA14614@sigill.intra.peff.net>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
 <508D7628.10509@kdbg.org>
 <CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
 <4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
 <CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
 <CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
 <508E532F.2010109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 29 11:38:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSmkA-0006PL-JL
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 11:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab2J2Kil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 06:38:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42029 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab2J2Kik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 06:38:40 -0400
Received: (qmail 18868 invoked by uid 107); 29 Oct 2012 10:39:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 06:39:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 06:38:37 -0400
Content-Disposition: inline
In-Reply-To: <508E532F.2010109@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208613>

On Mon, Oct 29, 2012 at 10:58:07AM +0100, Michael Haggerty wrote:

> I agree with you that it is too easy to create chaos by changing tags in
> a published repository and that git should do more to prevent this from
> happening without explicit user forcing.  The fact that git internally
> handles tags similarly to other references is IMO an excuse for the
> current behavior, but not a justification.

I would have expected git to at least complain about updating an
annotated tag with another annotated tag. But it actually uses the same
fast-forward rule, just on the pointed-to commits. So a fast-forward
annotated re-tag will throw away the old tag object completely. Which
seems a bit crazy to me.

It seems like a no-brainer to me that annotated tags should not replace
each other without a force, no matter where in the refs hierarchy they
go.

For lightweight tags, I think it's more gray. They are just pointers
into history. Some projects may use them to tag immutable official
versions, but I also see them used as shared bookmarks. Requiring "-f"
may make the latter use more annoying. On the other hand, bookmark tags
tend not to be pushed, or if they are, it is part of a mirror-like
backup which should be forcing all updates anyway.

-Peff
