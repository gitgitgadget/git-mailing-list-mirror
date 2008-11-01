From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 18:19:10 -0700
Message-ID: <20081101011910.GH14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl> <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org> <20081101001300.GE14786@spearce.org> <alpine.LFD.2.00.0810312106310.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 02:20:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw5A8-0003Z5-3t
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbYKABTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbYKABTL
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:19:11 -0400
Received: from george.spearce.org ([209.20.77.23]:58434 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYKABTK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:19:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3AB4B3835F; Sat,  1 Nov 2008 01:19:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810312106310.13034@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99700>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
> 
> > I'm tempted to stick with int for the result type, but I don't
> > want readers to confuse our result type of 0 == success, <0 ==
> > failure with some case where we return a signed integral value as
> > a result of a computation.
> 
> Does this actually happen ?

Sometimes, but yea, its not that often.  I think we've already
settled that it shall be "int".

I'm updating some stuff like that (and dropping _t) as I write
this email.
 
> > I'm also debating the error handling.  Do we return the error
> > code as the return value from the function, or do we stick it into
> > some sort of thread-global like classic "errno", or do we ask the
> > application to pass in a structure to us?
> 
> Passing a structure pointer for errors is adding overhead to the API in 
> all cases, please don't do that.

Agreed.  Not going there.

> Both the negative code and errno style are lightweight in the common "no 
> error" case.  The errno style is probably more handy for those functions 
> returning a pointer which should be NULL in the error case.

I'm sticking with return a negative code for now, to the extent
that some functions which return a pointer but also have many
common failure modes (e.g. git_odb_open) use an output parameter
as their first arg, so the error code can be returned as the result
of the function.

-- 
Shawn.
