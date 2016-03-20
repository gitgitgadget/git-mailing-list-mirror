From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Properties of trees referencing commit objects (mode 160000)?
Date: Sun, 20 Mar 2016 11:45:24 -0700
Message-ID: <20160320184524.GA16064@x>
References: <20160319221348.GA5247@x>
 <20160320041803.GC18312@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 19:45:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahiM8-0008R4-Gu
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 19:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbcCTSpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 14:45:35 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56148 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbcCTSpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 14:45:31 -0400
Received: from mfilter19-d.gandi.net (mfilter19-d.gandi.net [217.70.178.147])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 6CCDF41C084;
	Sun, 20 Mar 2016 19:45:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter19-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter19-d.gandi.net (mfilter19-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id sAniR_XxtO7i; Sun, 20 Mar 2016 19:45:28 +0100 (CET)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3646D41C051;
	Sun, 20 Mar 2016 19:45:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160320041803.GC18312@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289377>

On Sun, Mar 20, 2016 at 12:18:04AM -0400, Jeff King wrote:
> On Sat, Mar 19, 2016 at 03:13:48PM -0700, Josh Triplett wrote:
> 
> > I'm building some tools to track commit objects, and I'm thinking of
> > using submodule-style references to commit objects in tree objects (mode
> > 160000) to do so.  I'm trying to figure out some of the properties of
> > that.
> > 
> > Can a commit object referenced that way live in the same repository,
> > rather than some external repository?
> 
> Yes, it can be in the same repository, but...

Will git clone/checkout/etc handle it properly in that case, in the
absence of a .gitmodules file?  Or would it only work with custom tools?

> > Will git treat such a reference as keeping the commit object (and
> > everything recursively referenced by it) live and reachable?  If that
> > commit object is only reachable by the tree, and not by following the
> > parents of any commit directly referenced from refs/*, will git discard
> > it as unreachable?
> 
> No, we do not follow "gitlinks" like this for reachability. Neither for
> pruning, nor for object transfer via push/fetch. So you'd need to have a
> separate reference to it (or history containing it).

Argh.  If I have a pile of disconnected commits, is there anything git
*would* follow to see them, other than a pile of refs?

I suppose I could artificially generate a stack of merge commits with
those otherwise disconnect commits as parents, which would let me
reference them all from a single ref.  Still unsatisfying, though.

Also, thanks, "gitlink" was the term I was trying to think of.

(I'd also be tempted to ask whether a patch to teach git to follow
gitlinks for reachability and/or object transfer would be acceptable.)
