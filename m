From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Fri, 7 Mar 2008 20:22:01 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803072006550.19665@iabervon.org>
References: <200803061735.47674.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
X-From: git-owner@vger.kernel.org Sat Mar 08 02:23:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXnmH-0006Ts-FP
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 02:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758191AbYCHBWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 20:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757717AbYCHBWF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 20:22:05 -0500
Received: from iabervon.org ([66.92.72.58]:56148 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757425AbYCHBWD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 20:22:03 -0500
Received: (qmail 23867 invoked by uid 1000); 8 Mar 2008 01:22:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 01:22:01 -0000
In-Reply-To: <200803061735.47674.david-b@pacbell.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76535>

On Thu, 6 Mar 2008, David Brownell wrote:

> Any progress on fixing this?
> 
> I'll report that with git version 1.5.4.3.447.gc95b3.dirty
> (just a couple days old) I've observed this when updating
> a clone by pulling from
> 
>  (a) a parent on the same disk partition
>  (b) a parent on a non-mirrored network server
> 
> So that would seem to trash the assumptions that this is
> related to version mismatch between mirrors, and that the
> fix can (or should!) wait till 1.6.0 ...
> 
> I was glad to see the "^C" workaround, that seems to work.
> 
> When I "git pull" it first fetches a bunch of files, then
> concludes (wrongly) "no common commits", then starts a
> second fetch of a *HUGE* number of files ... 400 MB is too
> much to pay when updating from rc3-last-week to rc4.  But
> if I interrupt that second one with ^C, it seems that the
> first one fetched enough to make the next "git pull" go
> pretty quickly.
> 
> 
> This does seem appear to show up more often lately because
> of RC4 having been tagged ... but I don't know for sure.
> 
> I've got a couple kernel workspaces still on last Friday's
> version, which -- if this holds true to form! -- will show
> this bug when I "git pull".  So if there are experiments
> that would help nail down what's going on here, please
> spell them out to me ("this command, then this ... send
> this output...").

Actually, if you can make a tarball of the .git directory of one of those 
workspaces, and see if the bug is reproducable with that .git directory 
every time (particularly when pulling a local repository), it would be 
really helpful to have a reliable test case.

There's a debugging thing that would help, but it's not in your version. 
It's in next as

49aaddd102aff Teach upload-pack to log the received need lines to an fd

With that commit, you should be able to do:

GIT_DEBUG_SEND_PACK=3 git pull 3>UPLOAD_LOG

and get a file UPLOAD_LOG that will show what it's doing, although there's 
a reasonable chance that it'll only demonstrate that it's doing nothing 
helpful, which we already pretty much know.

	-Daniel
*This .sig left intentionally blank*
