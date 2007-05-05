From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Sat, 5 May 2007 02:52:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705050235210.28708@iabervon.org>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
 <7vtzuzg26l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704290152410.28708@iabervon.org>
 <7vejm3g0dg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705022330460.28708@iabervon.org>
 <7virba31wd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705030137520.28708@iabervon.org>
 <7vejly305u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705050115270.28708@iabervon.org>
 <7vr6pvn5k0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 08:53:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkE8e-0007bB-DP
	for gcvg-git@gmane.org; Sat, 05 May 2007 08:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbXEEGw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 02:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbXEEGw6
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 02:52:58 -0400
Received: from iabervon.org ([66.92.72.58]:2865 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbXEEGw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 02:52:57 -0400
Received: (qmail 28497 invoked by uid 1000); 5 May 2007 06:52:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 May 2007 06:52:55 -0000
In-Reply-To: <7vr6pvn5k0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46247>

On Fri, 4 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Is this actually supported in config files? At least for pulls, the "tag 
> > <tag>" notation is only available on the command line, afaict.
> 
> That is the only difference as far as I remember.  But you are
> right in that the set of refspecs allowed on the command line
> does not have to coincide with the ones in remotes file or the
> config (the latter two should match, though), and the latter may
> not be documented (the intention was to match all of them so the
> quoted documentation was enough, but having "tag <tag>" in
> config does not make sense).  Documentation/config.txt could use
> a bit of updates.  Hint, hint.

Once I've figured out what the intended behavior is, and have a canonical 
implementation so that it clearly does that, I'll document it. Until then, 
it's a bit tricky. :)

> > I think that having "<ref>:" or "<ref>" in a config file fetch 
> > line would be really bad; these refs would always be merged into any 
> > current head (without any remote tracking) when the remote is fetched 
> > from?
> 
> It's not bad at all.  Why people are so eager to _force_
> tracking on other people, I do not understand.
> 
> I had a moral equivalent of this in .git/remotes/origin (back
> then .git/config did not exist) when I was a contributor:
> 
> 	[remote "origin"]
>         	url = git.kernel.org:/pub/scm/git/git.git/
>                 fetch = refs/heads/master
> 
> If the user does not want to track, he does not have to.

Wouldn't it be better to to this as:

[remote "origin"]
	url = git.kernel.org:/pub/scm/git/git.git/
[branch "master"]
	remote = origin
	merge = refs/heads/master

If you're not tracking, the only thing you do with remote refs is merge 
them (after getting an anonymous temporary copy, of course), which should 
be the "merge" line, not the "fetch" line. Furthermore, you certainly 
don't want to merge refs/heads/master if you fetch (or pull) when you have 
todo (or a branch derived from it) checked out.

Merging without tracking is fine, in general; the "without tracking" was 
intentionally parenthetical. I just don't think always merging a 
particular remote head into the current branch, regardless of what branch 
is current, is a good idea.

	-Daniel
*This .sig left intentionally blank*
