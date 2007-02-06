From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 12:43:36 -0500
Message-ID: <20070206174336.GB5135@spearce.org>
References: <20070206023111.GB9222@spearce.org> <81b0412b0702060550u3d4064dal43e37593b013f82e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 18:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEUM3-0007tL-LA
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 18:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025AbXBFRnk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 12:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933018AbXBFRnk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 12:43:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43926 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933025AbXBFRnj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 12:43:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEULr-0005bX-Ad; Tue, 06 Feb 2007 12:43:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 91EA120FBAE; Tue,  6 Feb 2007 12:43:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0702060550u3d4064dal43e37593b013f82e@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38865>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 2/6/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> >I'm mainly worried about breaking compliation on odd architectures.
> >gfi builds, runs and has been used for production level imports
> >on Mac OS X, Linux and Dragonfly BSD, using both 32 bit and 64 bit
> >architectures, but some of Git's other targets (e.g. AIX) haven't
> >seen any testing.
> 
> Compilation errors are the simplest to fix, just send it in.

True.

But it really is annoying when you download the latest-and-greatest
release of a package only to find out it doesn't compile on your
OS of choice, and even worse when you find out it is because of
new code that you will never use which was added in just before
the release went final!

> I have to import lots of data from perforce spaghetti, so I'm very
> likely to try it out.

I can't help you with spaghetti, but the Qt folks did make their
Perforce importer available.  Chris Lee put it in the fast-export
project on repo.or.cz.  Its a relatively short Python program.
Might help you get started.

They created annotated tags (with no message) for every p4 changeset.
I think its just because they didn't realize you can use (abuse?) the
`reset` command in gfi to create lightweight tags instead.


I actually implemented a "data <path" command in gfi to tell gfi
to load data from a file, for this type of case where the foreign
system has dropped the files in your working directory and you just
want Git to read them.

But there's no synchronization between gfi and the frontend (aside
from the pipe buffer throttling the frontend), so there is no way
for the frontend to know that gfi has finished a batch of files
and its safe to ask p4 for the next revision.

So I threw it away.  It was only a 10 line patch anyway.  :)

-- 
Shawn.
