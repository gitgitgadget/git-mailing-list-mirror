From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/17] Remove assumptions about refname lifetimes
Date: Mon, 20 May 2013 14:15:45 +0200
Message-ID: <519A13F1.9070900@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu> <CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 20 14:15:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeP0O-0004BK-0Y
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 14:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999Ab3ETMPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 08:15:52 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:64291 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755845Ab3ETMPu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 May 2013 08:15:50 -0400
X-AuditID: 1207440d-b7fd06d000000905-15-519a13f59da9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E2.B9.02309.5F31A915; Mon, 20 May 2013 08:15:49 -0400 (EDT)
Received: from [192.168.69.140] (p57A25AF2.dip0.t-ipconnect.de [87.162.90.242])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4KCFkR7031561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 May 2013 08:15:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqPtVeFagwbTrxhZdV7qZLBp6rzBb
	zLu7i8niR0sPswOLx6WX39k8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujPN/TzMW
	XDCo+PJ6EmMD4wu1LkZODgkBE4lDW9eyQdhiEhfurQeyuTiEBC4zStz8/4UZwjnPJHGj7wAT
	SBWvgLbEt75mdhCbRUBV4sz9H8wgNpuArsSinmawGlGBMIlV65cxQ9QLSpyc+YQFxBYBqt/x
	+BfYNmaBeIkZjR9YQWxhAVeJzkOLweqFBDoZJd7MkwaxOQUCJQ6+OsrYxcgBVK8usX6eEESr
	vMT2t3OYJzAKzEKyYRZC1SwkVQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWm
	lG5ihAQz7w7G/+tkDjEKcDAq8fD+bJ0ZKMSaWFZcmXuIUZKDSUmUd6vQrEAhvqT8lMqMxOKM
	+KLSnNTiQ4wSHMxKIrzRv4HKeVMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIc
	HEoSvPtBhgoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSD4jS+GBipICkeoL2LQdp5
	iwsSc4GiEK2nGI05Np+f/I6RY8YPICnEkpeflyolztsCUioAUppRmge3CJbGXjGKA/0tzLsC
	pIoHmALh5r0CWsUEtGq7JciLxSWJCCmpBsaKaW1sj4p5Kr9OVD7+/Pyf+aw7GPa9908ovPmk
	/dDX8MXsq/a3H/YQ+d2wwSszs17LeJ9f/+TzkzbMmuSvqOuTxCq4qm+hfZXR1Rr2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224956>

This is a very interesting idea.  "It's turtles all the way down."

On 05/20/2013 12:28 PM, Johan Herland wrote:
> (Sorry for going slightly off-topic and returning to the general
> discussion on how to resolve the race conditions...)
> 
> For server-class installations we need ref storage that can be read
> (and updated?) atomically, and the current system of loose + packed
> files won't work since reading (and updating) more than a single file
> is not an atomic operation. Trivially, one could resolve this by
> dropping loose refs, and always using a single packed-refs file, but
> that would make it prohibitively expensive to update refs (the entire
> packed-refs file must be rewritten for every update).

Correct, or the "packed-refs" file would have to be updated in place
using some database-style approach for locking/transactions/whatever.

> Now, observe that we don't have these race conditions in the object
> database, because it is an add-only immutable data store.

Except for prune, of course, which can cause race conditions WRT to writers.

> What if we stored the refs as a tree object in the object database,
> referenced by a single (loose) ref? There would be a _single_ (albeit
> highly contentious) file outside the object database that represent
> the current state of the refs, but hopefully we can guarantee
> atomicity when reading (and updating?) that one file. Transactions can
> be done by:
>  1. Recording the tree id holding the refs before starting manipulation.
>  2. Creating a new tree object holding the manipulated state.
>  3. Re-checking the tree id before replacing the loose ref. If
> unchanged: commit, else: rollback/error out.

There are two closely related possibilities and I'm not sure which one
you mean:

* Effectively treat all of the refs as loose refs, but stored not in the
filesystem but rather in a hierarchical tree structure in the object
database.  E.g., all of the refs directly under "refs/heads" would be in
one tree object, those in refs/remotes/foo in a second, those for
refs/remotes/bar in another etc. and all of them linked up together in a
tree object representing "refs".

* Effectively treat all of the refs as packed refs, but store the single
"packed-refs" file as a single object in the object database.

(The first alternative sounds more practical to me.  I also guess that's
what you mean, since down below you say that each change would require
producing "a few objects".)

Of course in either case we couldn't use a tree object directly, because
these new "reference tree" objects would refer not only to blobs and
other trees but also to commits and tags.

> All readers would trivially have access to a consistent refs view,
> since the state of the entire refs hierarchy is held in the tree id
> read from that single loose ref.
> 
> It seems to me this should be somewhat less prohibitively expensive
> than maintaining all refs in a single packed-refs file. That said, we
> do end up producing a few new objects for every single ref update,
> most of which would be thrown away by a future "gc". This might bog
> things down, but I'm not sure how much.
> 
> I'm sure someone must have had this idea before (although I don't
> remember this alternative being raised at the Git Merge conference),
> so please enlighten me as to why this won't work... ;)

[I know this is not what you are suggesting, but I am reminded of
Subversion, which stores trunk, branches, and tags in the same "tree"
space as the contents of the working trees.  A Subversion commit
references a gigantic tree encompassing all branches of development and
all files on all of those branches (with cheap copies to reduce the
redundancy):

    /
    /trunk/
    /trunk/Makefile
    /trunk/src/
    /trunk/src/foo.c
    /branches/
    /branches/next/
    /branches/next/Makefile
    /branches/next/src/
    /branches/next/src/foo.c
    /branches/pu/
    /branches/pu/Makefile
    /branches/pu/src/
    /branches/pu/src/foo.c
    /tags/
    /tags/v1.8.2/
    /tags/v1.8.2/Makefile
    /tags/v1.8.2/src/
    /tags/v1.8.2/src/foo.c
    etc...

A Subversion commit thus describes the state of *every* branch and tag
at that moment in time.  The model is conceptually very simple (in fact,
too simple, and I believe the Subversion developers regret not having
distinguished between the branch namespace and the file namespace).]

The main difficulty with this idea will be the extreme contention on
that "last loose reference file" pointing at the root of the reference
tree.  Essentially *every* change to the repository will have to create
a new reference tree and point this file at the new version.  I doubt
that would be a problem for short-lived operations, but I fear that a
long-lived operation would *never* get done.  By the time it had
finished constructing its new reference tree, some other short-lived
operation will have changed it, and the long-lived process will have to
choose between

* Restart from the beginning.

* Die with a kind of "concurrent modification error".

* Resolve the difference between the reference tree at the start of its
operation and the reference tree as it exists when it is done with the
changes that they want to make.  In some cases this might be able to be
done automatically as a kind of "reference tree merge" but the logic
might have to vary from case to case.

> PS: Keeping reflogs is just a matter of wrapping the ref tree in a
> commit object using the previous state of the ref tree as its parent.

Yes, there are a lot of nice aspects to this idea in that it reuses
concepts with which we are already familiar.  For example, fetching from
a remote would approximately hook the remote's entire reference tree
into a subtree of the local "refs/remotes" reference subtree.  But with
things like reflogs we would have to be careful not to keep obsolete
objects around *forever*--there would have to be some mechanism to prune
the old reference history.

Altogether a very interesting idea.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
