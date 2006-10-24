From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: updating only changed files source directory?
Date: Tue, 24 Oct 2006 03:33:18 +0200
Message-ID: <ehjqgf$ggb$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 24 03:40:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcBHG-0003dk-EH
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 03:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWJXBkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 21:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWJXBkR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 21:40:17 -0400
Received: from main.gmane.org ([80.91.229.2]:51846 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964982AbWJXBkP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 21:40:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GcBGr-0003au-VL
	for git@vger.kernel.org; Tue, 24 Oct 2006 03:40:03 +0200
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 03:40:01 +0200
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 03:40:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29912>


Hello there,

I'm just starting out with GIT.  Initially, I want to use experiment 
with integrating it into our binary builder structure for LilyPond.

The binary builder roughly does this:

  1. get source code updates from a server to a single, local
     repository. This is currently a git repository that is that
     tracks our CVS server.

  2. copy latest commit from a branch to separate source directory.
     This copy should only update files that changed.

  3. Incrementally compile from that source directory

The binary builder does this for several branches and several
platforms of the project. Due to parallel compilation, it might even
be possible that different branches of are being checked out
concurrently from a single repository.

For a VCS, this is slightly nonstandard use, as we don't do any work
in the working dir, we just compile from it, but have many working
directories.


I have some questions and remarks

* Is there a command analogous to git-clone for updating a repository?
Right now, I'm using a combination of

   git-http-fetch -a <branch>  <url>
   wget <url>/refs/head/<branch>    ## dump to <myrepo>/refs/head/<branch>

for all branches I want to know about.  I was looking for a command
that would update the heads of all branches.


* Why is the order of args in git-http-fetch inconsistent with the
order in git-fetch? in fetch, the repository comes first, in
http-fetch, it comes last


* How do I update a source directory?

I can do the following

   git --git-dir <myrepo> read-tree <committish>

   cd <srcdir>
   git --git-dir <myrepo> checkout-index -a -f

Unfortunately, this touches all files, which messes up the timestamps
triggering needless recompilation. How can I make checkout-index only
touch files that have changed?  Or alternatively,  make checkout-index
remember timestamps on files that didn't change?

Of course, I can store the commitish of the last version of the
srcdir, and apply the diff between both to the source directory, but 
that seems somewhat convoluted. Is there a better way?


* As far as I can see, there is no reason to have only one index in a
git repository. Why isn't it possible to specify an alternate
index-file with an option similar to --git-dir ?


-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
