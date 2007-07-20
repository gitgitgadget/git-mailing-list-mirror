From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 15:23:47 +0200
Message-ID: <86k5svus2k.fsf@lola.quinscape.zz>
References: <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com> <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com> <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org> <85644fvdrn.fsf@lola.goe
 t he.zz> <46A08006.4020500@fs.ei.tum.de> <7vk5svxt1f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 15:26:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBsUZ-0004et-6n
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 15:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837AbXGTNZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 09:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755605AbXGTNZe
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 09:25:34 -0400
Received: from main.gmane.org ([80.91.229.2]:60840 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822AbXGTNZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 09:25:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBsTY-0003em-Dn
	for git@vger.kernel.org; Fri, 20 Jul 2007 15:24:56 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 15:24:56 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 15:24:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:tv2Vj6BY3nHmoMn+JsepkLOEf6Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53092>

Junio C Hamano <gitster@pobox.com> writes:

> Actually, I do not think there is absolute right or wrong here.  The
> difference is not that the information is at the "right" or "wrong"
> place, but one approach places the information at more
> efficient-to-use place than the other.

Agreed.

> In that sense, the attribute approach _is_ a more elegant solution
> between the two.

Disagreed.  See below.

> Making it an attribute has a huge practical advantage.
>
> By treating executable bit as a piece metadata, we can compare the
> "contents" quickly.  If you "chmod +x" a blob without changing
> anything else, we can detect that fact, because blob object names
> are equal.  At the philosophical level, you _could_ argue that the
> executable-ness is one bit of content and include that in the object
> name computation for the blob.  There is nothing fundamentally wrong
> about that approach, but that destroys the nice "cheap
> comparability" between blobs that differ only by executable-ness.
>
> David's "." in tree is essentially the same argument as treating the
> executable-ness as one extra bit of content.  The fact that a
> particular tree wants to stay even after emptied can be treated as
> part of contents (thereby reflected in its object name).

Small nit here: the tree does not want to stay after emptied, since it
is not empty as long as it contains ".".

> There is nothing fundamentally wrong there, either.  But that means
> two trees that contain otherwise identical set of blobs and
> subtrees, but differ only in the behaviour of when they are emptied,
> would get different object names, hence you need to descend into
> them to see if they are different.

And here we disagree in our assessment, and where I find the example
of the execute bit unfitting.  We are talking about _trees_ here, not
files.  So this is only relevant if we have a _huge_, _flat_ tree with
_lots_ of entries at _bottom_ level.

How often does it occur in practice that a _large_ tree has "."  added
or removed and nothing else changes?  Never, because the normal use
case is that a directory is either tracked from the start, or not
tracked at all.  And even if you change the tracking for a whole
project at once (which is a one-time job): the cost difference is
looking at all _tree_ leaf entries, not at all the involved files.

> Using attribute that is detached from the content itself allows you
> to hoist that one bit one level up.  By treating executable-ness not
> as part of content, we can compare two blobs with different
> executable bits cheaply.  You can avoid descending into such a tree
> when comparing it with another tree that is different only by the
> "will-stay-when-emptied"-ness the same way.

But changing the executable bit of a file will happen often during
development.  Adding or removing "." will never usually be done _ever_
except when the tree is first created or removed, and then the cost is
negligible.

So "performance" is not an issue for making this an attribute or a
flat entry.  While the user level abstraction need not match the
actual representation, I think that it will make for lot less special
cases and problematic behavior to pull through with "." as a directory
entry that mostly behaves like other files and, like other files,
requires git to create a directory to contain it.  All the logic for
creating and deleting directories and creating and adding and ignoring
files can _perfectly_ stay the same.

There are just two differences:

a) git always sees "." as a file in every directory in the work tree
   and considers it a file.
b) when it comes to actually creating or modifying or reading the
   actual file in the work directory, it silently skips the
   operation.

It would not even be necessary to give the directory entry any special
attributes or permissions to make this scheme work: declaring it a
normal file and just special-casing the name "." on those operations
would lead to consistent and working behavior, with no change of
format in index and repository at all.

Possibly even a) alone would suffice, at the cost of letting git
complain and continue at every operation (or making a _really_ royal
mess for Solaris root users).

I might be tempted to make a proof-of-concept patch for that.

But for backward-compatibility, it will be better to use an entry type
which old versions of git will be able to ignore when checking out or
in.  And for user-friendliness, one does not really want to list such
entries as regular files.

-- 
David Kastrup
