From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 01:00:12 +0200
Message-ID: <200703270100.12920.Josef.Weidendorfer@gmx.de>
References: <1174825838.12540.5.camel@localhost> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Lesh <eclesh@ucla.edu>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 00:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVxz4-0001Vu-P0
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 00:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347AbXCZWsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 18:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933763AbXCZWsL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 18:48:11 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:53402 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933347AbXCZWsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2007 18:48:09 -0400
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de [131.159.35.49])
	by mail.in.tum.de (Postfix) with ESMTP id 2847428E6;
	Tue, 27 Mar 2007 00:48:08 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070326220302.GH22773@admingilde.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43197>

On Tuesday 27 March 2007, Martin Waitz wrote:
> On Mon, Mar 26, 2007 at 09:33:44PM +0200, Josef Weidendorfer wrote:
> > The idea was to make this a possible building block for submodules.
> > A simple symlink does not work there when you want the checkout to
> > work even after moving the whole checkout directory around (e.g. to move the
> > submodule around inside of the superproject).
> 
> Well the submodule use case is a bit different than the lightweight
> checkout.
> When you store the submodule object database inside the supermodule then
> you only need to store the position of the submodule relative to its
> supermodule.  As you wrote this is neccessary in order to find the part
> of the object database which belongs to this one submodule.

Where do you store this in your module3 branch?

> Finding the supermodule repository is obviously not difficult, only
> finding the right part of it.
> But for lightweight checkouts you need something which is closer to a
> symlink.

Yes, of course.

> > > So having an almost empty .git directory 
> > > and reusing parts from another .git directory makes a lot of sense to
> > > me.
> > 
> > This would work. However, you can not clone from an almost empty .git
> > directory with current git.
> 
> You can't clone from a .gitlink with current git, eighter ;-).
> But if you e.g. set git_dir according to your link then everything
> should work quite easily.

Yes.

> > The original proposal was to have a standard .git directory for every
> > light-weight checkout inside of the base .git directory, e.g.
> > in <base>/.git/ext/<name>.git where <name> is some identifier for the
> > lightweight checkout, either provided in the .gitlink file or
> > automatically determined.
> 
> What would you store in these per-checkout directories?
> The index and HEAD?  Anything more?

To make it easy to implement, I thought about a standard .git layout,
with most directories being symlinks.

> For submodules I currently use <parent>/.git/objects/module/<submodule>/
> to store the objects belonging to the submodule.
> Perhaps it makes sense to extend this to a full .git directory per
> submodule, I'm not yet decided on that.

IMHO this would be a nice property. As the submodule could exist independently
with its own remote heads/tags, you probably would want to at least track these,
even if it is a submodule in your superproject.
And then it makes sense to move it directly to .git/module/...

There also was a use case where one library project is used in >10
superprojects. It would be nice to be able to make the submodule git dir
be outside of the supermodules git dir. However, this also can be done
with symlinks without any special support (aside from sharing the
head namespace).

Josef

> For submodules the object store has to be different, but for normal
> lightweight checkout this should of course be shared.
