From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Thu, 9 Jun 2016 13:23:52 -0400
Message-ID: <20160609172352.GC9016@sigill.intra.peff.net>
References: <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
 <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
 <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
 <xmqqinxkpzur.fsf@gitster.mtv.corp.google.com>
 <20160607202351.GA5726@sigill.intra.peff.net>
 <CACsJy8CtsFFJPssDDBuL8TLoxi1f=734mjAjCUOr8Y63aD3xUA@mail.gmail.com>
 <20160608161958.GA30876@sigill.intra.peff.net>
 <CACsJy8BGV-AWwap9c2hOjXWMYxBLUirX8i20rS_=Vmci_SG_rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:24:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB3gZ-0000ws-Ro
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 19:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbcFIRYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 13:24:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:52004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932077AbcFIRXz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 13:23:55 -0400
Received: (qmail 23942 invoked by uid 102); 9 Jun 2016 17:23:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 13:23:54 -0400
Received: (qmail 25337 invoked by uid 107); 9 Jun 2016 17:24:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 13:24:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2016 13:23:52 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BGV-AWwap9c2hOjXWMYxBLUirX8i20rS_=Vmci_SG_rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296908>

On Thu, Jun 09, 2016 at 03:53:26PM +0700, Duy Nguyen wrote:

> > Yes. To me, this was always about punting large blobs from the clones.
> > Basically the way git-lfs and other tools work, but without munging your
> > history permanently.
> 
> Makes sense. If we keep all trees and commits locally, pack v4 still
> has a chance to rise!

Yeah, I don't think anything here precludes pack v4.

> > I don't know if Christian had other cases in mind (like the many-files
> > case, which I think is better served by something like narrow clones).
> 
> Although for git-gc or git-fsck, I guess we need special support
> anyway not to download large blobs unnecessarily. Not sure if git-gc
> can already do that now. All I remember is git-repack can still be
> used to make a repo independent from odb alternates. We probably want
> to avoid that. git-fsck definitely should verify that large remote
> blobs are good without downloading them (a new "fsck" command to
> external odb, maybe).

I think git-gc should work out of the box; you'd want to use "repack
-l", which git-gc passes already.

Fsck would be OK as long as you didn't actually load blobs. We have
--connectivity-only for that, but of course it isn't the default. You'd
probably want the default mode to fsck local blobs, but _not_ to fault
in external blobs (but have an option to fault them all in if you really
wanted to be sure you have everything).

-Peff
