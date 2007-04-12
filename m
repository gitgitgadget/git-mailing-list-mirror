From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Thu, 12 Apr 2007 11:32:57 -0700
Message-ID: <56b7f5510704121132g3961060amb394978bb49093e6@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0704111628240.28394@qynat.qvtvafvgr.pbz>
	 <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David Lang" <david.lang@digitalinsight.com>,
	"Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>, danahow@gmail.com
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 20:33:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc46T-0002ei-CS
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 20:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030673AbXDLSdA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 14:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030684AbXDLSdA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 14:33:00 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:62939 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030673AbXDLSc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 14:32:59 -0400
Received: by nz-out-0506.google.com with SMTP id s1so521617nze
        for <git@vger.kernel.org>; Thu, 12 Apr 2007 11:32:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EqjpKz/L7v05aEeooCPupMVEwwmFvrwfBkC9Vkh1YGMT8YkOuPB3cj8+87IicVnf0zqWO0dVEQpNCbn/ADWrf4UKj/IJ5pJJ+xcMpSi3Eb8z8hUaCrn/4/qtcJbDtUFh7+/WIjZshJmdpqf5coCcxsoSOnMTwSoGlRsg5N43yjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fto+Da3ZOqrZECYrausjUJ/gVjlxX9LMkNcKooxBmqEaC68MIVKHX6uCNp95Gzhxy8T1H4hfuYiqJXwXx30/zO811e5PsJuUuwjjJ712twNlZSXHf5VAIYGx5TU4GFhD36wPJgAYXTkOQ9c18kv75JYcOxn3rrm8O3uQg3LfiKg=
Received: by 10.114.12.9 with SMTP id 9mr833576wal.1176402777217;
        Thu, 12 Apr 2007 11:32:57 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 12 Apr 2007 11:32:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44346>

On 4/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 11 Apr 2007, David Lang wrote:
> > this is why I was suggesting a --multiple-project option to let you tell fsck
> > about all of the repositories that it needs to look for refs in.
>
> Well, just from a personal observation:
>  - I would *personally* actually refuse to share objects with anybody
>    else.
>
> I just find the idea too scary. Somebody doing something bad to their
> object store by mistake (running "git prune" without realizing that there
> are *my* objects there too, or just deciding that they want to play with
> the object directory by hand, or running a new fancy experimental importer
> that has a subtle bug wrt object handling or anything like that).
>
> I'll endorse use "alternates" files, but partly because I know the main
> project is safe (any alternates usage is in the "satellite" clones anyway,
> and they will never write to the alternate object directory), and partly
> because at least for the kernel, we don't have branches that get reset in
> the main project, so there's no reason to fear that a "git repack -a -d"
> will ever screw up any of the satellite repositories even by mistake.
>
> But for git projects, even alternates isn't safe, in case somebody bases
> their own work on a version of "pu" that eventually goes away (even with
> reflogs, pruning *eventually* takes place).
>
> So I tend to think that alternates and shared object directories are
> really for "temporary" stuff, or for *managed* repositories that are at
> git *hosting* sites (eg repo.or.cz), and where there is some other safety
> involved, ie users don't actually access the object directories directly
> in any way.
>
> So I've at least personally come to the conclusion that for a *developer*
> (as opposed to a hosting site!), shared object directories just never make
> sense. The downsides are just too big. Even alternates is something where
> you just need to be fairly careful!

These arguments all seem pretty convincing to me --
maybe the problem is that I'm not a "*developer*" right now.
Instead I'm part of a multi-developer *site*.
Below I talk about a possible way we could use git
without changing it (since I recognize this would be a minority usage pattern).

We use perforce to manage a mixed hardware/software project
(I'm the 55GB check-out guy, remember?).  We have at least 3 different
kinds of data with different usage patterns, and using perforce for
everything in one centralized server was not the best solution.

Each user ("client") has their own worktree and the perforce
repository is on a shared central server.  You can consider perforce
to have the equivalent of git's index, but it is stored on the server,
in one file ("db.have") covering all clients.  Obviously that becomes a
bottleneck -- and recently db.have got larger than the total cache RAM on
the server, which really slowed things down until we moved to a larger
server.  But repository architecture aside,  the real problem has been
perforce's usability.  Frequently one contributor,  having gotten ahead
of the team,  needs to share this more recent work with only a few
people.  This could be done with p4 branching,  but this is really clunky.
So instead the work is pushed out (submitted) to everyone, causing
instability; this is partially remedied by doing it in smaller chunks.
Another perforce problem is that tagging consumes a lot of server
space (and may slow things down as well).

Some of this data will stay in perforce, some will move into revision
control built-in to some of our other tools, and I'd like to try to move some
of it into git.  The main attraction for the last group is the lightweight
branching that would allow early/tentative work to be easily shared.
I think the subproject work currently being discussed is going to
be very helpful as well -- the perforce equivalent is chaotic.

We could give each user a work tree and an object repository,
and then have a "release" repository.  Unfortunately,  this would be
slower to use than the current perforce "solution": users would check
in to their local repository, at the speed of gzip, anyone checking
it out would do so at the speed of gzip, and all work would need
to be resubmitted (using perforce jargon here) to the central repo,
again at the speed of gzip.  Currently, people either submit or
check out from the central repo, and it's all done at the speed of
a network copy.  This speed issue is important because of
the size of a commit we'd like to share (but not yet release):
about 40 files, half of them control files of several KB each, 1/4 of them
design files of several MB each, and the last 1/4 detailed design
files 100X larger.  These 40 files will reference (include) 50 others
of several KB each sprinkled through-out the hierarchy, a few of which
might have changed.  And yes, almost all of these are generated files,
but the generation time, and the instability of the tool and script environment,
preclude forcing the other users to regenerate them, like you would
with a .o file.

So, there are 2 alternative set-ups. In one, everyone uses a shared
object repository (everyone's .git/objects is a symlink to it). In this
repository, objects/. , objects/?? , objects/pack , and objects/info all
have "sticky" set, and we do the appropriate machinations to make
all files read-only. There would be an additional phantom user "git"
who owns the shared object repository (the only user whose .git/objects
is not a symlink).  Users would commit to their own repositories,
which would write data to the shared object repository and
update their refs (e.g. HEAD). To "release", push to the ~git repository.
This push would be like a current push -- fast-forward only, figure out the list
of objects that need to be transmitted -- but instead of transmitting the
objects, change their ownership to ~git and then update ~git's refs.
Since users can share local commits, maybe the ~git ownership
change should happen at commit time.  This all seems do-able
without change in git; instead I'd add a few bash wrapper scripts
(and see below for fsck and pack/prune).

Another setup is like the previous, but make the central repo have
its own hidden object repository. You would push to it using the
standard git command.

Finally, users could run git-fsck [with misleading output];
they could run git-prune{,-packed}, but these commands wouldn't
be able to delete anything.  If we don't want users to pack,
then ~git/.git/objects/pack would be writable only by ~git.
So basically, normal people wouldn't do the things in this paragraph.

To do meaningful and safe fsck/prune on the shared repository
as ~git,  I'd add some scripting.  If you require all users'
GIT_DIR's to look like /home/USER/*/.git , then you can get all
their refs and do a meaningful fsck.  If not, you could do a fsck
--unreachable as ~git and filter the result by date and/or type.
(This sort of corresponds to abandoned changesets in perforce.)
Once you have an fsck method you like, its filtered output (i.e.,
--unreachable objects you want to keep) can be fed to git-prune.

Care would also be required with git-repack/git-prune-packed,
but it seems mostly addressable with scheduling.

If I proceed down this path,  I'd like to implement this procedure
without any change in git's .c or .sh files.  It's clear this is a
minority use and should not depend on anything being maintained
for it inside git.  I would write a few bash scripts and a README/HOWTO
for possible inclusion in contrib.

BTW,
has anyone ever thought of writing an "Administrator's Manual" for git?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
