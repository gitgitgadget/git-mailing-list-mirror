From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 23:08:43 +0200
Organization: Organization?!?
Message-ID: <85wswsf8o4.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707181004330.=04?=
	=?ISO-8859-1?Q?27353@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.070718=041710271.?=
	=?ISO-8859-1?Q?27353@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?=
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 23:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICilH-0004XP-NS
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbXGVVOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755945AbXGVVOj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:14:39 -0400
Received: from main.gmane.org ([80.91.229.2]:55457 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbXGVVOi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:14:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICiix-0006s3-KS
	for git@vger.kernel.org; Sun, 22 Jul 2007 23:12:19 +0200
Received: from dslb-084-061-022-107.pools.arcor-ip.net ([84.61.22.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 23:12:19 +0200
Received: from dak by dslb-084-061-022-107.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 23:12:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-022-107.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:T2jdVbryLAlcpbIfC7QDK4biVE0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53321>


Well, coming back to this posting in order to focus on some points
that were at a level more relevant to the implementation.  And I'll go
through the questions assuming my permissions-based proposal.

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 19 Jul 2007, David Kastrup wrote:
>> 
>> Well, kudos.  Together with the analysis from Junio, this seems like a
>> good start.  Would you have any recommendations about what stuff one
>> should really read in order to get up to scratch about git internals?
>
> Well, you do need to understand the index. That's where all the new 
> subtlety happens.
>
> The data structures themselves are trivial, and we've supported
> empty trees (at the top level) from the beginning, so that part is
> not anything new.
>
> However, now having a new entry type in the index (S_IFDIR) means
> that anything that interacts with the index needs to think
> twice. But a lot of that is just testing what happens, and so the
> first thing to do is to have a test-suite.

Yes.

> There's also the question about how to show an empty tree in a
> diff.

Well, there are two possibilities involved here, a more and a less
chatty one.  Assuming that we want to do as little work as possible,
the transition between a tracked and a non-tracked directory will be
given in one of the following manners:

Either:
a) xxx: old mode 000000
   xxx: new mode 040755

when a directory gets tracked and

   xxx: new mode 040755
   xxx: old mode 000000

when it gets untracked again.

or
b)
   xxx: new directory mode 040755

when a directory gets tracked and

   xxx: deleted directory mode 040755

when it gets untracked again.  Note that "new" does not mean that git
did not previously have had files that absolutely have required a
directory for placing.  It just means that it has now actively gained
knowledge about the directory.

In a similar vein, "deleted" means that git is just deleting its
knowledge about the directory, _scheduling_ it for a single deletion
attempt at the earliest (and actually also latest) opportunity: when
git happens to know about no more files that require keeping the
directory around.  So perhaps the following would be more readable:

   xxx: tracking directory mode 040755

   xxx: forgetting directory mode 040755

Now in order to cut down on the verbiage, it might be an option to
transmit those strings only when something happens that can't be
deduced from other data.  Because _if_ it can be deduced from other
data (like a directory being present when files in it are), then at
least the working copies are identical as long as both persons don't
start deleting files from the repository.  If they do so, when a
directory becomes empty, the other side needs to know whether the
directory is being tracked or not if it still wants to maintain the
same state in the working tree.  But if we really want to have not
just the working tree but also the repositories in SHA1-lockstep, we
can't delay transmitting this information.

> We've never had that: the only time we had empty trees was when we
> compared a totally empty "root" tree against another tree, and then
> it was obvious.  But what if the empty tree is a subdirectory of
> another tree - how do you express that in a diff? Do you care? Right
> now, since we always recurse into the tree (and then not find
> anything), empty trees will simply not show up _at_all_ in any
> diffs.

One would still recurse.

> And what about usability issues elsewhere? With my patch, doing something 
> like a
>
> 	git add directory/
>
> still won't do anything, because the behaviour of "git add" has always 
> been to recurse into directories.

This will remain the same, but the directory itself will be added if
and only if the corresponding preference variable is set, regardless
of whether the directory is empty.

> So to add a new empty directory, you'd have to do
>
> 	git update-index --add directory
>
> and that's not exactly user-friendly.

Presumably one could, if one really wanted an explicit way, have
git add --directory directory
in analogy to the --directory option of the ls command.  But I think
that in most cases one would not want to treat one directory different
from the whole tree, so the implicit behavior regulated by a
project-wide preference should be sufficient in general.

> So do you add a "-n" flag to "git add" to tell it to not recurse? Or
> do you always recurse, but then if you notice that the end result is
> empty, you add it as a directory?

I always recurse (unless there is a --directory option and I have some
strange desire to actually use it).  I add it as a directory,
regardless of whether it is empty or not, if my preference setting (or
gitignore or whatever) is set to tracking directories.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
