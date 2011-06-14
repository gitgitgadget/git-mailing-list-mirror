From: Jeff King <peff@github.com>
Subject: Re: [PATCH 2/2] archive: support gzipped tar files
Date: Tue, 14 Jun 2011 15:30:33 -0400
Message-ID: <20110614193033.GA1359@sigill.intra.peff.net>
References: <20110614181732.GA31635@sigill.intra.peff.net>
 <20110614181821.GA32685@sigill.intra.peff.net>
 <4DF7B59D.30306@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git-dev@github.com
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:37:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWZQd-0005PX-Fd
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 21:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab1FNThR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 15:37:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38741
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab1FNThQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 15:37:16 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jun 2011 15:37:15 EDT
Received: (qmail 29884 invoked by uid 107); 14 Jun 2011 19:30:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 15:30:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 15:30:33 -0400
Content-Disposition: inline
In-Reply-To: <4DF7B59D.30306@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175793>

On Tue, Jun 14, 2011 at 12:25:17PM -0700, J.H. wrote:

> On 06/14/2011 11:18 AM, Jeff King wrote:
> > git-archive already supports the creation of tar files. For
> > local cases, one can simply pipe the output to gzip, and
> > having git-archive do the gzip is a minor convenience.
> > 
> > However, when running git-archive against a remote site,
> > having the remote side do the compression can save
> > considerable bandwidth. Service providers could always wrap
> > git-archive to provide that functionality, but this makes it
> > much simpler.
> > 
> > Creating gzipped archives is of course more expensive than
> > regular tar archives; however, the amount of work should be
> > comparable to that of creating a zip file, which is already
> > possible. So there should be no new security implications
> > with respect to creating load on a remote server.
> 
> Would it make sense to make this a little more generic and support bz2
> and xz as well?

I think it's a great idea if somebody wants to do it on top of my patch.
They should be able to hook into the tar code just like I did in 2/2.
But they will need library support that we don't already have in git.
Doing gz was easy because we already require zlib.

We could also support them by piping to an external compressor, which
wouldn't be too hard (you could do it for gzip, too, but given that we
have zlib, this was much simpler). There is a slight hitch with the
"--list" command, though. Should git-archive advertise these formats,
and if so, how should it know that they are available?

-Peff
