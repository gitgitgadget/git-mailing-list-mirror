From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Mon, 17 Oct 2005 18:56:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510171830030.23242@iabervon.org>
References: <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
 <435264B1.2010204@de.bosch.com> <Pine.LNX.4.63.0510161122570.23242@iabervon.org>
 <20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org>
 <7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net> <20051016213341.GF5509@reactrix.com>
 <7vwtkd6rik.fsf@assigned-by-dhcp.cox.net> <20051017060659.GH5509@reactrix.com>
 <7voe5o366d.fsf@assigned-by-dhcp.cox.net> <20051017174123.GI5509@reactrix.com>
 <7v3bmzzz30.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 00:53:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERdpX-0005tn-Hq
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 00:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVJQWve (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 18:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVJQWve
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 18:51:34 -0400
Received: from iabervon.org ([66.92.72.58]:15890 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932359AbVJQWve (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2005 18:51:34 -0400
Received: (qmail 18152 invoked by uid 1000); 17 Oct 2005 18:56:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Oct 2005 18:56:38 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bmzzz30.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10195>

On Mon, 17 Oct 2005, Junio C Hamano wrote:

> Nick Hengeveld <nickh@reactrix.com> writes:
> 
> > Gotcha - I'm still thinking in terms of content distribution, where
> > you only need a specific version of a tree to be available locally
> > and explicitly don't want to transfer history.
> 
> In other words, you'd want to also support CVS-like "working
> tree has the specific version, and history is not kept here, but
> available on demand, possibly over the network" mode of
> operation.  I'd say why not.  We could aim to have "working tree
> has the specific version and partial history of recent versions,
> and the ancient history is available on demand, possibly over
> the network" mode of operation.
> 
> It is somewhat different from the primary focus of what we have
> been doing, but I think it is a natural extension.  The
> invariant is that once you have a ref pointing at a specific
> commit, everything reachable from it ought to be available to
> you.

Wouldn't "git fetch http://.../foo.git/ master^{tree}" do the right thing?

You get only the current tree, and write a ref to the tree instead of the 
commit, maintaining the invariant. Of course, fetch.c needs a bit of work 
so that it can fetch objects in the process of figuring out what the 
refspec that it's really trying to fetch, but that should be simple 
enough.

Of course, this really isolates you from the history, since you don't even 
remember what the commit was that you've got the tree from, but that may 
not be an issue in a pure content distribution setup. Also, a pack file of 
a single tree isn't going to be terribly efficient, because pack files 
mostly exploit the high similarity between different versions of the same 
file.

My other idea is to have a file of things that you expect to be missing, 
even though they are referenced, and where to expect to find them if 
necessary. Then you could download the latest commit, mark its parents 
(unless you have them) as known-missing, and write the ref.

	-Daniel
*This .sig left intentionally blank*
