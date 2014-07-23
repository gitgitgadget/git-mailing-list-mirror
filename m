From: Ross Boylan <ross@biostat.ucsf.edu>
Subject: Re: confused about remote branch management
Date: Wed, 23 Jul 2014 16:30:52 -0700
Message-ID: <1406158252.29001.223.camel@localhost>
References: <1406083743.29001.139.camel@localhost>
	 <53CF66D4.7060201@gmail.com> <1406143336.29001.185.camel@localhost>
	 <xmqqmwbzda80.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:31:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA608-0007tW-DJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 01:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205AbaGWXbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 19:31:07 -0400
Received: from [38.99.193.74] ([38.99.193.74]:49160 "EHLO biostat.ucsf.edu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756000AbaGWXbG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 19:31:06 -0400
Received: from ns204-a-650ts.psg.net ([10.0.2.3]:48462 helo=[192.168.40.102])
	by biostat.ucsf.edu with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <ross@biostat.ucsf.edu>)
	id 1XA5zk-0000VD-5j; Wed, 23 Jul 2014 16:30:48 -0700
In-Reply-To: <xmqqmwbzda80.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254140>

On Wed, 2014-07-23 at 14:41 -0700, Junio C Hamano wrote:
> Ross Boylan <ross@biostat.ucsf.edu> writes:
> 
> > I still don't know what I need to do to update origin/master in my local
> > repo.
> >
> > Regarding Kevin's suggestion, I just tried "git fetch origin master".
> 
> I think Kevin's suggestion was 'To older git, "git fetch origin
> master" tells it to fetch master without updating origin/master, so
> it is understandable that your origin/master was not molested'.
> 
> Either
> 
> 	git fetch origin master:refs/remotes/origin/master
Great; that works.
Is that procedure supposed to be the usual way I track upstream in this
(1.7) version of git?  It seems arcane.

I had thought the usual workflow was supposed to be one of 2
alternatives, either
git checkout remotes/origin/master
git pull origin master
git checkout master
git merge remotes/origin/master
But that failed on the first step.  Or

# assuming we are on the local master branch
git fetch origin master
# and everything is updated.

Is the problem that I called the local branch with my modifications
master instead of something else?
> 
> or if you want to be more explicit and unambiguous:
> 
> 	git fetch origin refs/heads/master:refs/remotes/origin/master
> 
> should work on all versions of git.

After studying man git-fetch's discussion of the refspec parameter,
especially the second note: 

	You never do your own development on branches that appear on the right
hand side of a <refspec> colon on Pull: lines; they are to be updated by
git fetch. If you intend to do development derived from a remote branch
B, have a Pull: line to track it (i.e. Pull: B:remote-B), and have a
separate branch my-B to do your development on top of it. The latter is
created by git branch my-B remote-B (or its equivalent git checkout -b
my-B remote-B). Run git fetch to keep track of the progress of the
remote side, and when you see something new on the remote branch, merge
it into your development branch with git pull . remote-B, while you are
on my-B branch.

I'm even more confused.  Is "Pull: lines" a reference to log messages
during the fetch, a configuration file, or something else?  The docs
refer to a pull: line in $GIT_DIR/remotes, but I have no such directory.
I do have .git/config, which includes
[remote "personal"]
	url = https://github.com/RossBoylan/ESS.git
	fetch = +refs/heads/*:refs/remotes/personal/*
[branch "master"]
	remote = personal
	merge = refs/heads/master
[remote "origin"]
	url = https://github.com/emacs-ess/ESS.git
	fetch = +refs/heads/*:refs/remotes/origin/*

Ah!  branch master is associated with the personal remote; is that why
updating it from origin's master branch has no effect on origin/master?

I also don't know what the "." in "git pull . remote-B" does; the
git-pull manpage doesn't indicate it's legal as far as I can see.

Ross
