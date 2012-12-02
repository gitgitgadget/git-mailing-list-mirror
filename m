From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sun, 02 Dec 2012 16:11:59 -0500
Message-ID: <20121202211159.GA12429@odin.tremily.us>
References: <20121202190929.GG9401@odin.tremily.us> <50BBBA29.2000106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:12:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfGq0-0004rE-Hd
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 22:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab2LBVMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 16:12:14 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:11808 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab2LBVMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 16:12:13 -0500
Received: from odin.tremily.us ([unknown] [72.68.90.212])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEF008CF9K0YO90@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 02 Dec 2012 15:12:02 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 04CFC6E4DEE; Sun,
 02 Dec 2012 16:11:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354482720; bh=g4zZlisBSPjfsxuOsk6FaMnDJMXVjiSCxhVB3D1b9yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mrcEf403Y/MKNjxlD+YXQqkeW+PkJbVOba6e8aqwGbFDhV6TQ1a5rgIElmezeWJaz
 rtRslAmSnxyytfzJ24zt2B3e4xLuQhPVXWrliKNr+vTq/XNH8CdKBtv46QGlsYwnle
 b3UZm11R0qAOL/qjACwXreBPux44KrFGun4Krsq0=
Content-disposition: inline
In-reply-to: <50BBBA29.2000106@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211019>

From: "W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>, Junio C Hamano <gitster@pobox.com>
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>, Nahor <nahor.j+gmane@gmail.com>
Bcc: 
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Reply-To: 
In-Reply-To: <50BBBA29.2000106@web.de>
 <50BBB22A.7050901@web.de>
 <20121202190929.GG9401@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt

On Sun, Dec 02, 2012 at 09:29:29PM +0100, Jens Lehmann wrote:
> Am 02.12.2012 20:09, schrieb W. Trevor King:
> > Before I get into the details, I'd like to point out that I actually
> > understand the purpose of `submodule init` now ;).  To avoid further
> > confusion, my current one-line command summaries would be:
> > 
> >   init:   mark a submodule as active for future submodule operation
> >   deinit: mark a submodule as inactive for future submodule operation
> >   sync:   update remote.<name>.origin in submodules to reflect changes
> >           in .gitmodules or the superproject's remote URL.
> > 
> > I don't think we disagree on that, we just don't agree on how to
> > implement it.
> 
> Nope, it is already implemented and you are arguing to change the
> current implementation.

Agreed.

> To quote from another mail:
> 
> Am 01.12.2012 18:49, schrieb W. Trevor King:
> > On Sat, Dec 01, 2012 at 06:25:17PM +0100, Jens Lehmann wrote:
> >> What real world problems do we have with the current init/sync that
> >> this approach would solve?
> >
> > I don't have any, ...
> 
> We don't want to change working code and cause compatibility issues
> just because we /could/ do things differently, no?

In principle, yes, but in this case I think changing the
implementation does not risk much in the way of compatibility issues
(it only hurts users who rely on `submodule init` setting
submodule.<name>.url for reasons of their own.  A few of the existing
tests explictly check the url setting, so perhaps there are a number
of users who do require this side effect?

I think this risk is outweighed by the benefits of having a clearer
activation option.  For example:

On Sun, Dec 02, 2012 at 08:55:22PM +0100, Jens Lehmann wrote:
> Sure. I was worried about throwing away other settings the user
> might have set in the submodule.$name section and the first reflex
> was to protect them. But thinking about that again I noticed we are
> already throwing away a possibly user customized "url" setting, so
> we already remove a possibly customized setting.

With submodule.<name>.active, there's nothing customized that you'd
have to nuke on deinit (except 'active' iteself, which the user is
explicitly asking for).

Cheers,
Trevor

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
