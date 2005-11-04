From: Jon Loeliger <jdl@freescale.com>
Subject: Trying to Update All Heads of a Repository
Date: Thu, 03 Nov 2005 18:23:59 -0600
Message-ID: <E1EXpN9-00034x-7g@jdl.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 01:24:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXpNL-0000Wp-EB
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 01:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbVKDAYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 19:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbVKDAYH
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 19:24:07 -0500
Received: from colo.jdl.com ([66.118.10.122]:41388 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1030541AbVKDAYG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 19:24:06 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EXpN9-00034x-7g
	for git@vger.kernel.org; Thu, 03 Nov 2005 18:24:00 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11111>


Guys and Gals,

*sigh*

This is the sort of thing that mystifies me still.
I think there is (should be?) an easy command and
I just missed that day in class.  Feel free to
smack me with the obvious as needed...

I re-cloned (rsync) by git.git tree yesteday.
Today is a new day, and I want to start with
a fresh update of the entire git.git tree.
I have not changed anything in my copy yet.
My goal is a simple update of the entire repository.

    % git --version
    git version 0.99.9.GIT

Uh, foo.  That's a version from 02-Nov-2005.  I guess I could
dig out a SHA1 and we'd know exactly what version it is.

(Request:  Does it make sense to have a hard SHA1 as
           part of git's output version string?)

First, I have this, because it came with a git-clone:

    % cat .git/remotes/origin
    URL: rsync://rsync.kernel.org/pub/scm/git/git.git
    Pull: master:origin

I don't know how to say "Grab all the updates for
all the heads for which I have heads in my .git/refs".

So I hope "git pull --help" will tell me:

    % git pull --help
    usage: git-fetch-pack [-q] [-v] [--exec=upload-pack] [host:]directory <refs>...
    Fetch failure: --help

That would be no.  So I hit the man page, and I can't
quite decipher it.  I'm dense, so I have to re-read it
a few more times until I fully grok it.  Dinner interferes.

Like could I have just said?:

    % git fetch rsync://rsync.kernel.org/pub/scm/git/git.git
or
    % git fetch rsync://rsync.kernel.org/pub/scm/git/git.git master:origin
    % git fetch rsync://rsync.kernel.org/pub/scm/git/git.git pu:pu
    % git fetch rsync://rsync.kernel.org/pub/scm/git/git.git todo:todo

Dunno yet.


In the meantime, I figure I can effectively achieve my
goal by:

    for each head $h
        git checkout -f $h
        git pull rsync://rsync.kernel.org/pub/scm/git/git.git $h:$h

So I start with master.  I know I can cheat here and rely
on the "Pull: master:origin":

    % git pull origin
    receiving file list ... done

    sent 102 bytes  received 12339 bytes  8294.00 bytes/sec
    total size is 4708148  speedup is 378.44
    * committish: a3114b3428595710d4719dd668531210af5993c9
      branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git
    * refs/heads/origin: same as branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git
    Already up-to-date.

That worked fine:

    % git show-branch | head -15
    ! [maint] GIT 0.99.9b
     * [master] Document --since and --until options to rev-parse.
      ! [origin] Document --since and --until options to rev-parse.
       ! [pu] Merge branch 'master'
	! [todo] GIT 0.99.9
    -----
	+ [todo] GIT 0.99.9
	+ [todo^] 2005-10-26 (prepare for 0.99.9)
	+ [todo~2] Update 2005-10-19 afternoon.
	+ [todo~3] 2005-10-18 midnight
	+ [todo~4] 2005-10-16 early afternoon.
	+ [todo~5] 2005-10-16 midnight.
	+ [todo~6] Updates 2005-10-14 night
	+ [todo~7] Updates 2005-10-12 night.

On to the pu branch:

    % git checkout -f pu
    % git show-branch | head -10
    ! [maint] GIT 0.99.9b
     ! [master] Document --since and --until options to rev-parse.
      ! [origin] Document --since and --until options to rev-parse.
       * [pu] Merge branch 'master'
	! [todo] GIT 0.99.9
    -----
	+ [todo] GIT 0.99.9
	+ [todo^] 2005-10-26 (prepare for 0.99.9)
	+ [todo~2] Update 2005-10-19 afternoon.
	+ [todo~3] 2005-10-18 midnight

And pull it now:

    % git pull rsync://rsync.kernel.org/pub/scm/git/git.git pu:pu

    receiving file list ... done

    sent 102 bytes  received 12325 bytes  8284.67 bytes/sec
    total size is 4708148  speedup is 378.86
    * committish: 6c86914344ea64e3a7b287721bdeaa7d41f8a1c3
      branch 'pu' of rsync://rsync.kernel.org/pub/scm/git/git
    * refs/heads/pu: does not fast forward to branch 'pu' of rsync://rsync.kernel.org/pub/scm/git/git;
      not updating.
    Trying really trivial in-index merge...
    fatal: Merge requires file-level merging
    Nope.
    Trying simple merge.
    Simple merge failed, trying Automatic merge.
    Auto-merging Makefile.
    ERROR: git-merge-ours.sh: Not handling case  -> a64704f3e52be43b427792ef9c1bbe42af057c87 -> 4f3d053889de4a5ba8e6e5d519c014a51220accd
    fatal: merge program failed
    Automatic merge failed; fix up by hand

Rats.  But why did this fail?  I've changed nothing in my tree.
I'm pulling remote pu into local pu directly.  I think this
should Just Work...

Uh, now what?

    % git status

    # On branch refs/heads/pu
    #
    # Updated but not checked in:
    #   (will commit)
    #
    #       new file: Documentation/git-http-push.txt
    #       modified: Documentation/git-rev-parse.txt
    #       modified: Makefile
    #       modified: commit.c
    #       modified: config.c
    #       modified: fetch-pack.c
    #       modified: git-branch.sh
    #       modified: git-checkout.sh
    #       unmerged: git-merge-ours.sh
    #       modified: git-push.sh
    #       new file: git-shallow-pack.sh
    #       modified: git-svnimport.perl
    #       new file: http-push.c
    #       modified: ls-files.c
    #       modified: name-rev.c
    #       modified: send-pack.c
    #       modified: server-info.c
    #       modified: sha1_name.c
    #       modified: t/t3001-ls-files-others-exclude.sh
    #       modified: tag.c
    #       modified: tag.h
    #       modified: upload-pack.c
    #
    #
    # Changed but not updated:
    #   (use git-update-index to mark for commit)
    #
    #       unmerged: git-merge-ours.sh
    #
    #
    # Untracked files:
    #   (use "git add" to add to commit)
    #
    #       git-merge-ours.sh

    % git diff
    * Unmerged path git-merge-ours.sh

    % cat .git/HEAD
    0e6a92bd0b33b3461fb7b7f7eb34647ad93d451d

    % cat .git/FETCH_HEAD
    6c86914344ea64e3a7b287721bdeaa7d41f8a1c3                branch 'pu' of rsync://rsync.kernel.org/pub/scm/git/git

So.  Yes, I know I can "git-add git-merge-ours.sh" and then
do a "git-update-index git-merge-ours.sh" and get a spiffy
new index.  And then I can "git-commit" it all, and that
should be everything.

But I really thought that this should Just Work?
Shouldn't this be a fast forward, nice-n-clean-n-easy?

Do I need to add .git/remote entries for each head?
Can I place multiple "Pull: pu:pu" type refspecs into
the one .git/remote/origin?  Is that what people do?
Even if that I do that, I still have to manually iterate:

    for each head $h
        git checkout -f $h
        git pull origin $h

More tequilla.

Thanks,
jdl
