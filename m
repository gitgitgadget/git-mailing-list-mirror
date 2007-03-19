From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 15:15:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703191425560.6485@iabervon.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 20:15:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTNK8-0004kN-U8
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 20:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbXCSTPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 15:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbXCSTPO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 15:15:14 -0400
Received: from iabervon.org ([66.92.72.58]:3935 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbXCSTPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 15:15:12 -0400
Received: (qmail 7407 invoked by uid 1000); 19 Mar 2007 15:15:11 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Mar 2007 15:15:11 -0400
In-Reply-To: <45FED31B.8070307@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42654>

On Mon, 19 Mar 2007, Steven Grimm wrote:

> John Goerzen wrote:
> > 2) For me, a rename is a logical change to the source tree that I want
> >    to be recorded with absolute certainty, not guessed about later.
> >    Sometimes I may make API changes and it is useful to see how module
> >    names changed, with complete precision, later.  I do not want to be
> >    victim to an incorrect guess, which could be possible.
> >   
> 
> If you commit your renames separately from your content changes, it'll be
> unambiguous and you won't have to worry about it. That's what I usually do
> when this is a concern and it has yet to break for me.
> 
> On the other hand, I agree with your general point; I really don't like being
> uncertain about whether renames are going to come out correctly or not ("it
> has always worked before" and "it is by design unable to fail" are two very
> different things.) In particular, I strongly disagree with the "names are just
> syntactic sugar, it's the content we're tracking" philosophy.

We are tracking the names as part of the content. They're right there in 
the tree objects. It's not like, when you check out an older revision, you 
could get the right content under the wrong name. The philosophy is 
actually that we're tracking a series of states, and we're somewhat 
agnostic on the description of the difference between two states. And it 
often makes sense to postpone trying to describe this difference until you 
know why you want to know, because it's certainly possible that there are 
multiple reasonable interpretations, and some may give better results than 
others.

If you're trying to merge a rename-and-refactor change (often something 
like splitting a source or header file into two files) with a 
modification, and it's arguable what happened in the refactor, the 
interpretation which gives the state that's easiest to resolve correctly 
may depend on what the modification is. So you really want to leave it up 
to the merge code to choose the best guess at the result, without using a 
fixed description of what the changes are.

As for whether names or contents "matter more", we have both answers. "git 
log <names>" gives you the history of what has happened to change what 
appears with those names. "git blame <name>", on the other hand, gives you 
the history of the content which now appears at that name. You just need 
to ask the question you want the answer to.

	-Daniel
*This .sig left intentionally blank*
