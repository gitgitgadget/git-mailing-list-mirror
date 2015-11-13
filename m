From: Jeff King <peff@peff.net>
Subject: Re: git clean performance issues
Date: Fri, 13 Nov 2015 18:53:34 -0500
Message-ID: <20151113235334.GA18260@sigill.intra.peff.net>
References: <CAMpP7NY++BwV+UygRj1C6Zsf=jE-z1AQuN3On0HeEqQpKGQtqw@mail.gmail.com>
 <20150404195507.GA31763@peff.net>
 <20151113141907.GB16219@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>,
	git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:53:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxOA1-0000n9-0L
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 00:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbbKMXxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 18:53:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:57351 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752110AbbKMXxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 18:53:37 -0500
Received: (qmail 19282 invoked by uid 102); 13 Nov 2015 23:53:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 17:53:36 -0600
Received: (qmail 29965 invoked by uid 107); 13 Nov 2015 23:54:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 18:54:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 18:53:34 -0500
Content-Disposition: inline
In-Reply-To: <20151113141907.GB16219@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281276>

On Fri, Nov 13, 2015 at 03:19:07PM +0100, Andreas Krey wrote:

> On Sat, 04 Apr 2015 15:55:07 +0000, Jeff King wrote:
> ...
> > I think this is the same issue that was discussed here:
> > 
> >   http://thread.gmane.org/gmane.comp.version-control.git/265560/focus&5585
> > 
> > There is some discussion of a possible fix in that thread. I was hoping
> > that Andreas was going to look further and produce a patch, but I
> > imagine he got busy with other things.
> 
> That about sums it up. However I now have a similar issue;
> git ls-files shows the same behaviour (takes relatively
> forever at 100% CPU), and runs instantly with my patch
> from back then. Nothing seems to have changed, so I
> may have another chance to look into this.

Yeah, I think Erik's patch in 0179ca7 (clean: improve performance when
removing lots of directories, 2015-06-15) handles the git-clean case the
way we want to, but all of the other calls to resolve_gitlink_ref need
to be inspected and fixed similarly.

The one your are hitting with ls-files is probably in dir.c:treat_directory.

-Peff
