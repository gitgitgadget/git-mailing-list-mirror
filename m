From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: git-checkout sometimes silently fails
Date: Tue, 6 May 2008 17:10:52 -0700
Message-ID: <20080506171052.340d643e.akpm@linux-foundation.org>
References: <20080506122256.04ca7d77.akpm@linux-foundation.org>
	<20080506215049.GC4647@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 02:12:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtXGa-0004gq-89
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 02:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYEGAL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 20:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752295AbYEGAL0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 20:11:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52355 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752079AbYEGALZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 20:11:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m470ArmE021428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 May 2008 17:10:54 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m470Aqpl002062;
	Tue, 6 May 2008 17:10:53 -0700
In-Reply-To: <20080506215049.GC4647@steel.home>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.778 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81389>

On Tue, 6 May 2008 23:50:49 +0200 Alex Riesen <raa.lkml@gmail.com> wrote:

> Andrew Morton, Tue, May 06, 2008 21:22:56 +0200:
> > 
> > I've had this happen before and I don't know what to do to make it stop. 
> > Usually sufficient fiddling will prevent it from happening.
> > 
> > 
> > y:/usr/src/git26> cat .git/branches/linux-next 
> > git+ssh://master.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
> > 
> > y:/usr/src/git26> git-checkout master
> > Switched to branch "master"
> > y:/usr/src/git26> cat kernel/*.c|sum
> > 34439  2057
> > y:/usr/src/git26> git-checkout linux-next
> > Switched to branch "linux-next"
> > y:/usr/src/git26> cat kernel/*.c|sum     
> > 34439  2057
> 
> This is not a good indication of a failed checkout (they could point
> to the same commit, for one).

How could they?  linux-next includes a directory called ./Next and a file
in that directory called ./Next/Trees, and that is not present after the
`git-checkout linux-next'.

> Try "gitk master...linux-next" (or "git
> log master..linux-next", "git diff master linux-next")

These come up empty.  But there is a 12.4MB diff between mainline and
linux-next.

> > y:/usr/src/git26> git-checkout origin 
> > Note: moving to "origin" which isn't a local branch
> > If you want to create a new branch from this checkout, you may do so
> > (now or later) by using -b with the checkout command again. Example:
> >   git checkout -b <new_branch_name>
> > HEAD is now at 5717922... Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb
> 
> This is not an error. The commit was checked out (and HEAD was
> "detached").
> 
> > y:/usr/src/git26> cat kernel/*.c|sum          
> > 34439  2057
> 
> Again, it is no indication nothing happened. "gitk HEAD...linux-next"
> 
> > y:/usr/src/git26> git --version
> > git version 1.5.5.rc1
> > 
> > help?
> 
> Look at "git branch -av" (it shows both local and remote branches and
> commits they point to).

y:/usr/src/git26> git-branch -av | grep '^\*'
* master               5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb
y:/usr/src/git26> git-checkout linux-next    
Switched to branch "linux-next"
y:/usr/src/git26> git-branch -av | grep '^\*'
* linux-next           5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb

y:/usr/src/git26> ls -l Next 
ls: cannot access Next: No such file or directory

> Maybe it will give you a hint. "gitk --all" is
> interesting too, seldom though (it becomes very confusing very fast if
> you have many branches with complicated history each).

hm, lots of stuff there.


Thing is, sometimes `git-checkout linux-next' works.  Sometimes it
inexplicably doesn't work and there is no indication from git that it
didn't work.

Usually my git problems are root-caused down to my lack of a PhD in
hermeneutic metaphysiology, but not this time, methinks
