From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 18:52:17 -0700
Message-ID: <20081101015217.GJ14786@spearce.org>
References: <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl> <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org> <20081101001300.GE14786@spearce.org> <alpine.LFD.2.00.0810312106310.13034@xanadu.home> <20081101011910.GH14786@spearce.org> <alpine.LFD.2.00.0810312135190.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 02:53:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw5gB-0001h3-L7
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbYKABwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYKABwS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:52:18 -0400
Received: from george.spearce.org ([209.20.77.23]:36985 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYKABwS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:52:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 93ADB38360; Sat,  1 Nov 2008 01:52:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810312135190.13034@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99707>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
> 
> > > Both the negative code and errno style are lightweight in the common "no 
> > > error" case.  The errno style is probably more handy for those functions 
> > > returning a pointer which should be NULL in the error case.
> > 
> > I'm sticking with return a negative code for now, to the extent
> > that some functions which return a pointer but also have many
> > common failure modes (e.g. git_odb_open) use an output parameter
> > as their first arg, so the error code can be returned as the result
> > of the function.
> 
> Actually, the pointer-returning functions can encode error cases into a 
> "negative" pointer. See include/linux/err.h for example.
> 
> 	void *ptr = git_alloc_foo(...);
> 	if (IS_ERR(ptr))
> 		die("git_alloc_foo failed: %s", git_strerr(PTR_ERR(ptr)));

Oh, good point.  We could also stagger the errors so they are
always odd, and never return an odd-alignment pointer from a
successful function.  Thus IS_ERR can be written as:

  #define IS_ERR(ptr) (((intptr_t)(ptr)) & 1)

which is quite cheap, and given the (probably required anyway)
aligned allocation policy means we still have 2^31 possible
error codes available.

-- 
Shawn.
