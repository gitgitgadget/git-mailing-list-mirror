From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 12:11:43 +0200
Message-ID: <86k5svwfj4.fsf@lola.quinscape.zz>
References: <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com> <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com> <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org> <85644fvdrn.fsf@lola.goe
 t he.zz> <46A08006.4020500@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 12:13:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBpTk-00037E-EV
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 12:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758486AbXGTKMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 06:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758459AbXGTKMF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 06:12:05 -0400
Received: from main.gmane.org ([80.91.229.2]:58601 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758362AbXGTKMB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 06:12:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBpSg-0000ma-N1
	for git@vger.kernel.org; Fri, 20 Jul 2007 12:11:50 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 12:11:50 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 12:11:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:6HTGy+ix3jcwA0hmvMQ1ZpgVTJA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53076>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> David Kastrup wrote:
>>> Otherwise you could have two very different trees that encode the
>>> same *content* (just with different ways of getting there -
>>> depending on whether you have a history with empty trees or not),
>>> and that's very much against the philosophy of git, and breaks some
>>> fundamental rules (like the fact that "same content == same SHA1").
>>
>> No, the content is _different_.  One tree contains a tracked
>> directory, the other does not.  That means that the trees behave
>> _differently_ when you manipulate them, and that means that they are
>> _not_ the same tree.
>
> You are mistaking things.

No, I am redefining them, or rather the view on them.  Subtle
difference.

> Like the executable bit on a file is not content, the fact that a
> directory should be kept despite being empty is also an *attribute*
> of the directory.  This is meta-data, not actual data (content).

We need to track it, anyway.  So there is little point in not using
the existing infrastructure for handling named entities.

> So no matter how elegant tracking the "." entry might be (and I
> think it is, because it covers a lot of corner cases already), it
> puts the information at the wrong place.

I don't see that the place is wrong: after all, that is where Unix
places "." too, and for good reason.  I was arguing for _separating_
the concept of "directory" and "tree" in the repository.  The tree is
a container entity defined exclusively by its contents (which
determine its hash).  That is how git already does things.  There is
_no_ connection with the physical existence of a directory: in the
work directory, git creates and deletes directories as a _side-effect_
of storing and removing trees.  But git itself does not track
directories as a physical entity at _all_.  If you had a flat
filesystem allowing slashes in filenames, git would get along better
than it does now, without ever creating or removing a directory.
Trees are just a convenient selection and pattern matching mechanism
for files as far as git is concerned.  The correspondence to physical
directories in the work directory is a nuisance rather than an asset
as far as git is concerned.

In a recent thread here, tags with slashes were supported by
essentially doing

    mkdir -p "`dirname $TAG`"
    touch $TAG

where directory creation is just a side effect of supporting slashes.
And that, if you look closely, is git's current relation with
directories altogether.  The directories in the work file system are
created by git just as a side effect for representing slashes, which
in turn facilitate a certain manner of pattern matching.

And "." seems perfectly well suited to bring across the point that
there actually is _physical_ existence associated with a directory,
existence that remains when the rest of the tree is gone and _makes_ a
difference to what the tree is, because it has a _different_
representation in the work file system.

Storing it as an _attribute_ of the tree is a bad idea, since then the
simple rule "a tree without contents is empty" needs an exception.
And a tree stops becoming just a container of its contents and all
sort of new exceptions creep up.

There are some systems where the difference between directory as a
file and directory as a structuring method are more apparent than
under Unix (some utilities like rsync differentiate between A/B and
A/B/ to bring across that difference).

Here is an example for some Emacs function concerned with the concept:

    directory-file-name is a built-in function in `C source code'.
    (directory-file-name DIRECTORY)

    Returns the file name of the directory named DIRECTORY.
    This is the name of the file that holds the data for the directory DIRECTORY.
    This operation exists because a directory is also a file, but its name as
    a directory is different from its name as a file.
    In Unix-syntax, this function just removes the final slash.
    On VMS, given a VMS-syntax directory name such as "[X.Y]",
    it returns a file name such as "[X]Y.DIR.1".

    [back]

> That's sad, because otherwise it would be really elegant.

If something is not elegant because of the angle of view, change the
view.  And it is not like the different angle has no predecessors or
no consistency.

-- 
David Kastrup
