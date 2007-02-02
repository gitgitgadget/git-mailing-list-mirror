From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 10:02:12 -0500
Message-ID: <20070202150212.GA14691@spearce.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702021055.49428.jnareb@gmail.com> <45C341CD.7020301@fs.ei.tum.de> <200702021523.38169.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 16:02:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCzvw-0007al-KS
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 16:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945925AbXBBPC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 10:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945921AbXBBPC1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 10:02:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60850 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945925AbXBBPC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 10:02:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCzvV-0008JN-Jv; Fri, 02 Feb 2007 10:02:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 65CD120FBAE; Fri,  2 Feb 2007 10:02:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702021523.38169.jnareb@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38503>

Jakub Narebski <jnareb@gmail.com> wrote:
> Simon 'corecode' Schubert wrote:
> > Jakub Narebski wrote:
> >> 
> >> By the way, RCS / CVS rewrote relevant data (to have diff from the top
> >> structure) on each commit.
> >> 
> >> I wonder if git could generate pack on the fly fastimport like...
> > 
> > What do you mean with that?  generate the pack on which occasion?
> > CVS import?  I do this already. 
> 
> On commit.

I've thought about doing this.  Except there are three independent
processes occuring during commit that generate objects:

	update-index
	write-tree
	commit-tree

and the update-index portion is also git-add, which we have now
started to encourage users to do ahead of time as often as needed,
prior to running git-commit.  Its also the one that generates the
largest set of new objects for most projects.

One problem comes that we have a rule: "don't delta an object
which is already in a pack, unless -f is given".  This is one of
the reasons `git repack -a -d -l` is so dang fast.  Its assuming
all new stuff is loose, and therefore should be delta'd, but the
old stuff which we have already delta'd is kept as-is.


Basically I've thought about doing this (after my work in gfi)
and decided its not worth the level of effort involved at this time.
So I'm not going to do it.  Someone else can try.  ;-)

-- 
Shawn.
