From: Bill Priest <priestwilliaml@yahoo.com>
Subject: Re: can't commit files that have been git add'ed because "fatal: you need to resolve your current index first"
Date: Wed, 28 Nov 2007 20:10:46 -0800 (PST)
Message-ID: <88849.40139.qm@web55011.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 05:11:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixak0-0008M6-B2
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 05:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757112AbXK2EKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 23:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757124AbXK2EKs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 23:10:48 -0500
Received: from web55011.mail.re4.yahoo.com ([206.190.58.145]:20920 "HELO
	web55011.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756957AbXK2EKr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 23:10:47 -0500
Received: (qmail 40771 invoked by uid 60001); 29 Nov 2007 04:10:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Tar0sEcmNQyVKuAkuOManCWFHTvAf6F0w3Cy3w2Jk9lzo22NLmrgZ+wGvOk71ICjNv7A2MZKRdLGxy3MsccutUxijQgC3c757NZTK6PVM/WzrhFW3k3ix5xBLVEfnm6g9yriJmvUtowGTlgRc+fyWuQguP10VNpUC1F3jf8zFKQ=;
X-YMail-OSG: gsbBh7wVM1nn_Z_9R9JhxjgxTr19x8ijk50oyG4rNN_2HrzOUOvsq6BWfE6wiR90MA--
Received: from [64.243.89.222] by web55011.mail.re4.yahoo.com via HTTP; Wed, 28 Nov 2007 20:10:46 PST
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66501>

On Wed, 28 Nov 2007 12:08:40 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Bill Priest <priestwilliaml@yahoo.com> writes:
> 
> >   I merged from one branch to another and had lots
of
> > conflicts.  I've resolved a set of files from the
> > conflicts (in a directory) and did a git-add on
this
> > set of files.  I wasn't able to commit these
files. 
> > On IRC I was told that all files must be resolved
> > before I can commit any of them.  This seems
pretty
> > limiting.
> 
> You have two parallel development lines that lead to
A and B and trying
> to come up with a "merge" M:
> 
>          o---o---A
>         /         \
>     ---o---o---B---M
> 
> What property should the merge commit "M" have?  It
must keep the
> changes made on the upper line to make it better
than B, and it must
> keep the changes made on the lower line to make it
better than A.

Ok.  One thing I probably wasn't clear on is these are
two distinct
product lines that share a great amount of code;
however, much of the
code is "incompatible".  The two branches will never
be "merged" into
one "mainline" as the underlying hardware is by
definition
incompatible.  In theory I could use a bunch of
conditional compilation
to unify the two lines; however, this means that every
time I make a
change to one branch I have to make sure that it
doesn't break the
other one.  It would have been better if the code was
modularized
better to just include different files for the two
versions;
unfortunately this is easier said than done.  I guess
you could think
of it line a 2.4 kernel vs. a 2.6 kernel; but in the
same repository.
So to sum it up there are changes in branch A that
will never go into
branch B (and vice versa); however, there are a number
of changes that
need to go into both.  Unfortunately the rest of my
team uses
subversion and isn't even aware that I am using git
(we recently switch
to subversion from cvs, so it is a hard sell to
management to switch
again).  I'm responsible for keeping bug fixes and new
features in both
product lines and I found subversion's merging to be
utterly useless. 
> Let's say both upper and lower lines of development
touched files frotz
> and xyzzy in overlapping, different ways.  You try
to merge A while you
> are at B and see conflicts in these two files.
> 
> Let's say you resolved frotz; the contents in frotz
is in a desired
> shape, i.e you have the changes you want from the
line led to A and the
> other line led to B.  But you haven't resolved xyzzy
yet.
> 
> You seem to want to make this half-resolved state as
a commit.  First
> question: what contents would you want to commit for
xyzzy?

As an example there is a directory in the tree that is
a program that
runs on a PC (vs. the other stuff that runs on
embedded processors) it
shares a handful of include files w/ the embedded side
for packet
definition but it is otherwise completely separate
from the programs
that run on the embedded processors.  Once I complete
merging of this
directory and it builds it is ready to go.  The
remaining merges have
no effect on this PC based program.  I'm not sure if
it is possible or
not but if I could merge this directory and below
(does git support
this??) it might be one way of handling it or if I
cherry-pick'ed it
that could also work.  This isn't always feasible as
the other users
often check in wholesale changes into subversion as
one change set
(remember that these are former cvs users that have
lots of bad habits
to lose).  It would be great if branches were created
for each
"logical" change and checked in in one changeset; this
seems to be what
git is expecting (in a perfect world this would always
be the case).

> 
> If you commit the contents from B (because you
started from it), then it
> should not be recorded as a proper merge.  If you
did so, merging that
> back to A would obliterate all the work done up to A
to file xyzzy:
> 
>          o---o---A...X
>         /         \ .
>     ---o---o---B---*
>  
> because merge base of A and * (I am marking it
differently because such
> an incomplete merge should not be made) is A, so the
result (X) will be
> the half-merge * itself (fast forward).  That's not
a merge as it is not
> better than A -- you discarded improvements made to
xyzzy by people who
> built up to A.
> 
> This is inherent to what a merge is.  With proper
understanding of what
> a merge is, you would not feel this limiting at all.

I've used clearcase in the past and although there
were many things I
didn't like about it (big, slow, costs $$$$, network
pig, needs a super
server, etc.) it did allow commits of files at any
time and tracked the
files that were merged independently.  I know that git
tracks changes
and not files; but in the end you have to pick file(s)
or pieces of
them to be committed; having the tool restrict me from
committing files
because of the way it tracks merges IS limiting IMHO. 
I guess the big
difference is that in kernel land you can reject
patches until they are
broken up into "atomic" pieces (I don't really have
the option of
reversing the subversion commit and turning it into
"atomic" commits).

> Having said that, I think something like the
following _could_ be done,
> although I do not know if it makes much sense.
> 
> (1) Try merge, see it conflict, resolve only a part
of it, and record
>     the result as "WIP to merge in A".  Do not
record it as a merge, as
>     it is not.  diff between B and M will contain a
squash merge of A on
>     top of B minus the changes to the path xyzzy.
> 
>          o---o---A
>         /         
>     ---o---o---B---M
> 
> (2) Fix up the conflicts in xyzzy to resolve the
conflicts fully, and
>     record the result as "Final merge of A into B". 
This should be
>     recorded as a merge, as the result is "keeping
changes done on both
>     branches to come up with something better than
either of them."
> 
>          o---o---A---,
>         /             \
>     ---o---o---B---M---N
> 
> If you look at the topology a bit differently, the
above actually makes
> some sense:
> 
>          .---o---o---A
>         /             \
>     ---o---o---B---M---N
> 
> That is, instead of merging A into B, you made
"preparatory changes" to
> branch B in order to make it easier to merge A. 
That's what the commit
> M is about.
> 
> Then you merge A on top of M.  In reality, because
the difference
> between B to M contains most of the squash merge of
A into B, such a
> merge N will contain many accidental clean merges. 
But in git,
> accidental clean merges are not a problem (people
can apply the same
> patch to their trees and later their branches can be
merged).
> 
> But "git commit" after a conflicted merge will
always create a merge,
> and there is no canned option to do multi-step merge
like the above.
> 
> You can still do that by hand, by doing something
like:
> 
> 	$ git merge --squash A
>         $ resolve only partly
>         $ git commit -m 'Prepare to merge A'
>         $ git reset --hard
>         $ git merge A
> 	$ resolve the rest
>         $ git commit -m 'Fully merged A'

Ok.  I did a git merge --squash.  So I should be able
to try this.
After I resolve only partly; I'm assuming that I git
checkout HEAD any
files that I don't want yet and then do the commit? 
Assuming that I
commit the partial after throwing away any merges that
I wasn't ready
to do (via git checkout HEAD); what does the "git
reset --hard" do? 
> For such a multi-step merge to make sense, the
change between B---M
> should make sense by itself for people who have to
read such a history
> later.  Such a half-a-squash-merge may probably not
make sense by itself
> in most cases, so I suspect the above workflow would
not be useful in
> general.

I would agree for the case where in the end you really
only have one
product; but again think like you have a 2.4 kernel
and a 2.6 kernel in
the same repository.  For most embedded development
(I've been doing it
for 20+ years) there is always newer hardware that
changes processors,
add features, gets all the new development while the
"old" production
board is still shipping and in customers hands and
needs bug fixes and
the occassional new feature.  It doesn't make sense to
have two
separate repositories when much of the code is the
same and is likely
to need the same fixes.

Junio,
	Thanks for your time and insight; git has already
saved me
countless hours and has certainly come a long way in a
very short
time.  I'll give your multi-step merge a shot and see
how well it works
for my code base.  I'm sure there are better ways to
structure my code
base to get what I am looking for; but as is usually
the case the rules
of the game have changed as I have been playing it
(the old hardware
was supposed to die and never be touched again; HA
HA).

Regards,

Bill




      ____________________________________________________________________________________
Be a better pen pal. 
Text or chat with friends inside Yahoo! Mail. See how.  http://overview.mail.yahoo.com/
