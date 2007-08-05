From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Some ideas for StGIT
Date: Sun, 5 Aug 2007 10:57:12 -0400
Message-ID: <20070805145712.GB4570@filer.fsl.cs.sunysb.edu>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com> <1186206085.28481.33.camel@dv> <20070804055110.GP20052@spearce.org> <f934ve$3oi$1@sea.gmane.org> <20070805023130.GV20052@spearce.org> <20070805133940.GA18835@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.64.0708051452280.14781@racer.site> <20070805140658.GA4570@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.64.0708051513310.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 05 16:57:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHhXm-0006gM-1p
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 16:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbXHEO5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 10:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbXHEO5T
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 10:57:19 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:51592 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbXHEO5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 10:57:18 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l75EvCcv008224;
	Sun, 5 Aug 2007 10:57:12 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l75EvCve008222;
	Sun, 5 Aug 2007 10:57:12 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708051513310.14781@racer.site>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55029>

On Sun, Aug 05, 2007 at 03:15:29PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 5 Aug 2007, Josef Sipek wrote:
> 
> > On Sun, Aug 05, 2007 at 02:56:23PM +0100, Johannes Schindelin wrote:
> > > 
> > > On Sun, 5 Aug 2007, Josef Sipek wrote:
> > > 
> > > > Sure, if you can take 2 commits and collapse them into one you could 
> > > > fake it by creating a dummy commit with the new changes, and then 
> > > > collapsing, but that's nasty - and reflog might not like that much 
> > > > :)
> > > 
> > > IIUC you want to edit/amend a patch in the middle of a series?  Two ways 
> > > to go about it:
> > > 
> > > 	1) (preferred)
> > > 
> > > 		* start rebase -i
> > > 		* mark the commit as "edit"
> > > 		* wait until rebase stops to let you edit it
> > > 		* edit, test, commit --amend
> > > 		* rebase --continue
> > 
> > Ewww...that doesn't seem to scale (read: far too much to type) :) Here's a
> > quilt/guilt/stgit equivalent:
> > 
> > 	$APP push <patchname>
> > 
> > or (depending on where you are in the patch stack)
> > 
> > 	$APP pop <patchname>
> > 
> > 	<edit>
> > 
> > 	$APP refresh # this is the commit --amend part
> 
> Yeah.  Sounds like you'd just need a "--edit-this $commit" flag to rebase 
> -i.

Still, very inconvenient (IMO) when you are working _on_ lots of patches.

> Out of curiousity, what happens if you say "push" several times, 
> _without_ popping the patch?  And what happens if you "push" several times 
> with the _same_ patchname?

In addition to the patches, there's also ordering information for those
patches (the series file) - in the simplest case it is a stack in the
traditinal Comp Sci meaning. IOW, if you have patches {foo,bar,baz} and you
want to push "bar", the patch "foo" will also get pushed. When you push a
patch, the software makes note of the fact (status file in Guilt).

If you try to push the same patch twice, it'll tell you that the patch is
already applied. The Mercurial Book has a section about Mercurial Queues
(Mercurial's implementation of something similar to Guilt/stgit) which
describes the concepts rather well [1]. I think that figure 12.10 [2] really
explains the whole thing pretty well. Of course, there is always the quilt
doc (big PDF which has the whole history, etc., etc.).

Hrm, it just occured to me that the quilt-way of managing patches is the
basic concept of a turing machine - infinite tape which is seekable and you
can read/write to the "current" position (topmost applied patch). :)

Josef 'Jeff' Sipek.

[1] http://hgbook.red-bean.com/hgbookch12.html#x16-27200012.5
[2] http://hgbook.red-bean.com/hgbookch12.html#x16-27600310

-- 
Computer Science is no more about computers than astronomy is about
telescopes.
		- Edsger Dijkstra
