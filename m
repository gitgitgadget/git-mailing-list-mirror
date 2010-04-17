From: Sebastian Bober <sbober@servercare.de>
Subject: Re: Git import of the recent full enwiki dump
Date: Sat, 17 Apr 2010 03:01:47 +0200
Message-ID: <20100417010147.GB32053@post.servercare.de>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com> <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com> <20100417004852.GA32053@post.servercare.de> <20100417005342.GA8475@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, Sam Vilain <sam@vilain.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 17 03:01:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2wPz-0001eZ-A0
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 03:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682Ab0DQBBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 21:01:49 -0400
Received: from tix64.net ([81.169.172.224]:34178 "EHLO
	h4945.serverkompetenz.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758595Ab0DQBBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 21:01:48 -0400
X-Greylist: delayed 771 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2010 21:01:48 EDT
Received: from bob by h4945.serverkompetenz.net with local (Exim 4.69)
	(envelope-from <sbober@servercare.de>)
	id 1O2wPr-0007a3-Cj; Sat, 17 Apr 2010 03:01:47 +0200
Mail-Followup-To: Sebastian Bober <sbober@servercare.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, Sam Vilain <sam@vilain.net>
Content-Disposition: inline
In-Reply-To: <20100417005342.GA8475@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-bounce-key: tix64.net-1;sbober@servercare.de;1271466108;a216844c;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145101>

On Fri, Apr 16, 2010 at 05:53:42PM -0700, Shawn O. Pearce wrote:
> Sebastian Bober <sbober@servercare.de> wrote:
> > The question would be, how the commits and the trees are laid out.
> > If every wiki revision shall be a git commit, then we'd need to handle
> > 300M commits. And we have 19M wiki pages (that would be files). The tree
> > objects would be very large and git-fast-import would crawl.
> > 
> > Some tests with the german wikipedia have shown that importing the blobs
> > is doable on normal hardware. Getting the trees and commits into git
> > was not possible up to now, as fast-import was just to slow (and getting
> > slower after 1M commits).
> 
> Well, to be fair to fast-import, its tree handling code is linear
> scan based, because that's how any other part of Git handles trees.
> 
> If you just toss all 19M wiki pages into a single top level tree,
> that's going to take a very long time to locate the wiki page
> talking about Zoos.
> 

I'm not dissing fast-import, it's fantastic. We tried with 2-10 level
deep trees (the best depth being 3), but after some million commits it
just got unbearably slow, with the ETA constantly rising.

That was because of tree creation, and SHA1 computing of these tree
objects.

> > I had the idea of having an importer that would just handle this special
> > case (1 file change per commit), but didn't get around to try that yet.
> 
> Really, fast-import should be able to handle this well, assuming you
> aren't just tossing all 19M files into a single massive directory
> and hoping for the best.  Because *any* program working on that
> sort of layout will need to spit out the 19M entry tree object on
> each and every commit, just so it can compute the SHA-1 checksum
> to get the tree name for the commit.
> 
> -- 
> Shawn.
> 
