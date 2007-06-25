From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: DWIM ref names for push/fetch
Date: Sun, 24 Jun 2007 23:12:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706242234250.4740@iabervon.org>
References: <Pine.LNX.4.64.0706241808550.4740@iabervon.org>
 <7v3b0gq4id.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 05:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2f0N-0004Cj-Rt
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 05:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbXFYDMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 23:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbXFYDMk
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 23:12:40 -0400
Received: from iabervon.org ([66.92.72.58]:2846 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783AbXFYDMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 23:12:39 -0400
Received: (qmail 10603 invoked by uid 1000); 25 Jun 2007 03:12:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jun 2007 03:12:38 -0000
In-Reply-To: <7v3b0gq4id.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50855>

On Sun, 24 Jun 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Is this difference simply due to the different languages the matching 
> > portions of these were originally written in?
> 
> If anything, the semantics on the fetch side is _very_ much
> intentional and is done deliberately that way to be usable.  
> 
> On the other hand, push started as "matching only", and then
> "match tail part of the name" as an afterthought.  It was so
> afterthought that it had an idiotic behaviour of independently
> match the source and destination side even when there is no
> colon, which was fixed only recently.
> 
> So if you would want to match fetch and push, you should not
> change the semantics on fetch to match what push does, as the
> latter was done pretty much without design.
> 
> Having said that, I think fetch and push DWIMmery are
> fundamentally different, especially when you do not have a
> colon.  push without storing anything on the receiving end would
> not make any sense whatsoever, but fetch without using tracking
> branches does make perfect sense, so push does pretend dst side
> has what matched with src side pattern, while fetch treats no
> colon pattern as not storing.  IOW, even if we wanted to reuse
> the code on both sides as much as possible, I suspect we would
> need to have details different between them.

The no-colon handling is right as it is, as well as the semantics of 
fetching without tracking refs.

I was actually thinking exclusively of the matching of strings like "HEAD" 
or "origin/next" or "master" to refs from the list of available refs. It 
seems to me like the push code does a better job of handling the same 
sorts of things that get_sha1() handles.

In particular, the handling of "refs/my/funny/thing" is really wrong: it 
gets treated as refs/heads/refs/my/funny/thing. I think that "origin/next" 
should also be assumed to be refs/remotes/origin/next instead of 
refs/heads/origin/next, at least if you have refs/remotes/origin/ and not 
refs/heads/origin/.

	-Daniel
*This .sig left intentionally blank*
