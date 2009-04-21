From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Howto request: going home in the middle of something? v2009
Date: Tue, 21 Apr 2009 13:05:15 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0904211232550.10753@iabervon.org>
References: <e2a1d0aa0904210639t2ca73364pff26c85a0224182e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:09:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwJQr-0005U6-GQ
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 19:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZDURFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZDURFR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 13:05:17 -0400
Received: from iabervon.org ([66.92.72.58]:35042 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbZDURFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 13:05:16 -0400
Received: (qmail 1967 invoked by uid 1000); 21 Apr 2009 17:05:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Apr 2009 17:05:15 -0000
In-Reply-To: <e2a1d0aa0904210639t2ca73364pff26c85a0224182e@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117136>

On Tue, 21 Apr 2009, Patrick Doyle wrote:

> Hello,
> I've developed a work habit of keeping my source code repository on a
> USB stick and carrying that back and forth with me between work and
> home.  (I typically have small, branchless, single-developer
> projects.)  When I arrive at the other machine, I do
> 
> $ git pull
> (code, commit, code, commit, etc...)
> $ git push
> 
> Occasionally at the end of the day (if I'm at work) or at the end of
> the night (if I'm at home), I'm in the middle of something that I want
> to continue, and I end up making a "work-in-progress" commit
> 
> $ git commit -a "WIP"
> 
> just so I can pull that in the next day/evening and continue where I
> left off.  But that leaves a bunch of "WIP" commits in my history.

In general, it can be useful to make a sequence of WIP commits which you 
don't share with anyone else, and, when you've completed something, make 
a sequence of nice clean commits.

One way to do that:

$ git checkout -b wip # have a separate branch for the WIP
$ git commit -m "junk" # this commit is total junk, but good hints
$ git commit -m "stuff" # corrected a few things
$ git commit -m "going home" # need to commit to have sometime to pull
$ git commit -m "finally working!" # this is the first good state
$ git checkout master # back on the real branch
$ git diff master wip | git apply # get the good directory state
$ git add -i # add only those changes that are a good first step
$ git checkout . # get the working directory to match the first step
$ make test # did you do it right?
$ git commit # first production-quality commit
$ git diff master wip | git apply # now get more changes
...
$ git diff master wip | git apply # get remaining changes
$ git add -i # notice that the remainder are noise, debugging, etc.
$ git branch -D wip # throw out the bad changes

In general, it's helpful to be able to commit any time you're about to 
make a change to something you've already changed (because your second 
change might not be as good as your first change), but then you want the 
public history to come from a later pass where you already know what 
you're doing and only make correct changes, so far as you can tell from 
having a working final result. It's like a painter doing a study before 
starting to paint the real painting.

	-Daniel
*This .sig left intentionally blank*
