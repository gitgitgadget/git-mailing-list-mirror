From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/9] Add flag to make unpack_trees() not print errors.
Date: Tue, 5 Feb 2008 15:38:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802051439200.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041335390.13593@iabervon.org> <alpine.LSU.1.00.0802050112380.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:39:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMUZU-0003vl-FB
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757835AbYBEUil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757756AbYBEUik
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:38:40 -0500
Received: from iabervon.org ([66.92.72.58]:48614 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756644AbYBEUij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:38:39 -0500
Received: (qmail 9429 invoked by uid 1000); 5 Feb 2008 20:38:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 20:38:30 -0000
In-Reply-To: <alpine.LSU.1.00.0802050112380.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72691>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> 
> > This will allow builtin-checkout to suppress merge errors if it's going 
> > to try more merging methods.
> 
> I saw one error() in twoway_merge(), one in bind_merge(), and one in 
> onway_merge() that were not guarded by o->gently.
> 
> Also, I'd call it "silent", not "gently".
> 
> > Additionally, if unpack_trees() returns with an error, but without 
> > printing anything, it will roll back any changes to the index (by 
> > rereading the index, currently). This obviously could be done by the 
> > caller, but chances are that the caller would forget and debugging this 
> > is difficult.
> 
> Granted, it is easy to forget.  But maybe the caller does not need the 
> index?  Or maybe it wants a different one?  I'd prefer the caller to clean 
> up, if necessary.

That's what makes it "gently" instead of just "silent"; it has no effect 
if it doesn't succeed. Longer term, I'd like to have unpack_trees() unpack 
into a separate index, which should actually be faster (since it doesn't 
have to keep shifting the entries in the index it's working on) and make 
this moot. In any case, it only rolls it back with the option that's only 
used by a caller that wants the index unchanged on failure, currently. If 
a caller turns out to just want a return code and not care about the index 
or the error message, and the code hasn't been reworked, we can add a 
separate flag then.

I'd done some analysis at the time that suggested that, if you didn't want 
to give a message on failure, you must want to do something else to the 
index to replace what hadn't worked, so you must want the index reset, but 
I've forgotten why I was so sure at the time, aside from that nobody's 
wanted it before now.

	-Daniel
*This .sig left intentionally blank*
