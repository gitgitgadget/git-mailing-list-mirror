From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git / Subversion Interoperability
Date: Sat, 24 Mar 2007 02:41:30 -0400
Message-ID: <20070324064130.GC25863@spearce.org>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org> <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk> <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk> <20070323103426.GA15923@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 07:42:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUzws-0002b1-Gs
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 07:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbXCXGln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 02:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbXCXGln
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 02:41:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36574 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbXCXGll (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 02:41:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HUzwR-00054b-AV; Sat, 24 Mar 2007 02:41:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A266920FBAE; Sat, 24 Mar 2007 02:41:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070323103426.GA15923@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42984>

Karl Hasselstr??m <kha@treskal.com> wrote:
> On 2007-03-23 01:36:11 +0000, Julian Phillips wrote:
> > Indeed. That's what I was aiming at with the the last sentence (not
> > very clearly unfortunately). It would be nice if the server could
> > tell the client that properties are not supported ... but I doubt
> > that it can, since they are fundamental part of Subversion.
> >
> > In particular it's how the client finds out about things like
> > symlinks and line ending conversion. It may be necessary to provide
> > some basic support for some of the properties in the svn:...
> > namespace in order for the Subversion repo access library not to
> > refuse to talk to the git server.
> 
> Maybe the pragmatic solution would be to have built-in handling of a
> few properties such as svn:executable and svn:ignore that have git
> equivalents, and just emulate all other properties with files.

That is not a bad idea at all.  We could easily do

  svn:executable -> (mode & 0111);
  svn:ignore -> .gitignore;

I'm sure there are others, but they are the only two Karl mentioned,
and that I know of off the top of my head.  ;-)

Additional random properties could just be written out to .gitsvnprop
in the parent directory.

Here's another SVN feature that we might have to actually emulate:
locks.  Apparently clients can "lock" a file, preventing others
from editing that same file.  This is good for say artwork where
the file format is a binary thing that just cannot be merged.
Some users may actually be using SVN for exactly this reason.
Replacing it for some users may require that feature.

Heck, the F!@&@#*!@&@!*! POS (not SVN) that I have to use at my day
job can *only* work in this mode (exclusive lock file) and people
there still don't know how two different developers can safely edit
the same Java file at the same time without that exclusive lock
system in place.  They are absolutely terrified of auto-merges like
what Git does.  ;-)

Then they same users go off and incorrectly hand-merge stuff anyway.
Stuff that xdiff's 3-way file merge would have done correctly
without any problems.  Argh!

-- 
Shawn.
