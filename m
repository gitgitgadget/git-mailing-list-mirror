From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 21:33:44 +0200
Message-ID: <200703262133.44520.Josef.Weidendorfer@gmx.de>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost> <20070326183523.GG22773@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Lesh <eclesh@ucla.edu>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:21:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVulI-0001OC-1r
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 21:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbXCZTVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 15:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbXCZTVn
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 15:21:43 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:51931 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932065AbXCZTVm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2007 15:21:42 -0400
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de [131.159.35.49])
	by mail.in.tum.de (Postfix) with ESMTP id 7261528EC;
	Mon, 26 Mar 2007 21:21:40 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070326183523.GG22773@admingilde.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43178>

On Monday 26 March 2007, Martin Waitz wrote:
> hoi :)
> 
> On Mon, Mar 26, 2007 at 10:38:08AM -0700, Eric Lesh wrote:
> > > Light checkouts would have an almost empty .git (it still needs an
> > > index, and its own head anyway) and use the .git of the main repo for
> > > everything else.
> > > 
> > 
> > Josef Weidendorfer tried to implement this before, and he concluded that
> > having a _text file_ .git, instead of a directory, would be a good way
> > to distinguish .gitlinked checkouts from normal checkouts.
> 
> but that does not allow for per-checkout HEAD and index.
> I don't see any reason for providing any sort for "gitlink" which
> also uses HEAD and index from the linked location -- then you could
> use a simple symlink, too.

The idea was to make this a possible building block for submodules.
A simple symlink does not work there when you want the checkout to
work even after moving the whole checkout directory around (e.g. to move the
submodule around inside of the superproject).

> So having an almost empty .git directory 
> and reusing parts from another .git directory makes a lot of sense to
> me.

This would work. However, you can not clone from an almost empty .git
directory with current git.

The original proposal was to have a standard .git directory for every
light-weight checkout inside of the base .git directory, e.g.
in <base>/.git/ext/<name>.git where <name> is some identifier for the
lightweight checkout, either provided in the .gitlink file or
automatically determined.

Hmm... the "almost empty .git directory" has its merits.
You can override config options, and of course, the "base" for the
lightweight checkout still can be a full .git dir, as would be needed
for submodule support. In fact, you have more freedom to choose the
path to the base gitdir.
I like it ;-)

So this changes the .gitlink proposal to:
* smartly reset GIT_DIR when a core.link option is set in .git/config
  (and set GIT_WORK_DIR accordingly)
* fake a core.name if not set (this comes from the original proposal
  to get an automatic identifier of a submodule checkout by its
  relative path to the supermodule)
* git-checkout to allow to create a fresh light-weight checkout

Josef
