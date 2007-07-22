From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Mon, 23 Jul 2007 00:57:44 +0200
Message-ID: <85644cf3mf.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<200707221406.25541.jnareb@gmail.com> <857iosmto0.fsf@lola.goethe.zz>
	<200707222226.30788.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICkN8-0000on-Ax
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764881AbXGVW5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764820AbXGVW5u
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:57:50 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:47948 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759382AbXGVW5t (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 18:57:49 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 9865D12CF0;
	Mon, 23 Jul 2007 00:57:45 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 79681ABAEA;
	Mon, 23 Jul 2007 00:57:45 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-053-165.pools.arcor-ip.net [84.61.53.165])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 5194C376449;
	Mon, 23 Jul 2007 00:57:45 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D1CE91D1E182; Mon, 23 Jul 2007 00:57:44 +0200 (CEST)
In-Reply-To: <200707222226.30788.jnareb@gmail.com> (Jakub Narebski's message of "Sun\, 22 Jul 2007 22\:26\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53360>

Jakub Narebski <jnareb@gmail.com> writes:

> David Kastrup wrote:
>
>> So I pretty much can rule out that I am wrong on the factual side.
>
> Big words.

Sure.  It is not relevant, however.

> First, there is little matter of something like area of competence.
> You might be systems master, but your idea about snapshot based
> distributed revision control systems can be wrong because DSCM are
> outside the area you know most about.

Slicing the concept of directory and tree into two separate things and
thinking separately about them and their relation in working tree and
repository is not exactly concerned with the internals.  It obviously
was too artificial a concept to be understandable, and likely a worse
idea than necessary (whether one wants to call it too smart or too
stupid for its own good may be a matter of taste).

Anyway, it would be more productive if we managed to focus on the
technical aspects again.  I accept that my previous proposal was not
fit for inclusion.

> Second, even if you are a master at given topic, you can still be
> wrong.
>
> Mind you, I was not saying you are wrong. I was saying you could be.

We can leave that open since no code is going to come of the first
proposal.

> [...]
>> The recursiveness of the gitignore mechanism has the advantage that
>> when maintaining a large repository with actual or logical
>> subprojects, one does not need to pick a single policy for all
>> subprojects.
>
> I think it would be best implemented by repository config, e.g. 
> core.dirManagement or something like that, which could be set to
>  1. "autoremove" or something like that, which gives old behavior
>     of untracking directory if it doesn't have any tracked files
>     in it, and removing directory if it doesn't have any files
>     in it.

That's actually not _tracking_ a directory at all, but rather
maintaining an independent directory in the parallel repository
universe.  No information specific to directories passes the index.

>  2. "noremove" or something like that, which changes the behaviour
>     to _never_ untrack directory automatically. This can be done
>     without any changes to 'tree' object nor index. It could be useful
>     for git-svn repositories.

I don't see how this could occur.  Automatic _untracking_ would happen
when one untracks (aka removes) a parent directory.  But one would not
do this while keeping the child.

>  3. "marked" or something like that, for which you have to explicitely
>     mark directories which are not to be removed when empty.

Equivalent to 1 in my scheme.

>  4. "recursive" or something like that, which would automatically mark
>     as "sticky" all subdirectories added in a "sticky" repository.

If they are covered by the add and not just implied by childs.  That is,
git-add a/b
will not make "a" sticky while
git-add a
will make a/b sticky.

>     OR directory is not removed when empty if it is marked as such,
>     or one of its parents is marked as such.

I'd not throw too much inheritance into the equation, or things become
intractable too easily.

> The "magic mode" solution _should_ work also with older git, I
> think.

I think so, too, for the repository.  But of course what happens in
the index with old code when new data types get added is a case for
review, testing and praying.

>>> Fourth, is very artificial. What would you put for filemode for '.'?
>>> 040000 (i.e. directory)?
> [...]
>>> What would you put for sha1?  Sha1 of an empty directory?
>> 
>> Some fixed value.  Everywhere the same.  Not really relevant.
>
> Relevant because it has to work with legacy git on strange operating 
> systems. Because git has to fsck it (and adding special casing this 
> "some fixed value" to git-fsck is bad, bad idea).

I did not mean "arbitrary value", but the value would be computed in a
standard way from the node, and since the node would be the same
everywhere, the hash would be too.

> Note that sha1 cannot be sha1 of the tree. In working area '.' is
> self link. You cannot create self link in git repository object.

Certainly.  And the idea was to have "." be isolated from the contents
of the tree, basically treating it as a sibling of the other entries.
Which is, in a way, how "." shared one namespace in Unix with what
amounts to _children_ of the corresponding tree.

So that was some inspiration here, probably too much so.

> [...]
>>>> And the repository is a versioned and hierarchically hashed version
>>>> of the index, but its trees contain _no_ information that is not
>>>> already inherently represented by the files alone. [...]
> [...]
>>> Trees do contain information which is not inherently present by the 
>>> blobs.
>> 
>> Could you give examples for such information?  As long as we are not
>> talking about _history_, I am at a loss at what else you mean.  File
>> names and permissions?
>
> File names and permissions. And they bind blobs and trees together.

Trees bind blobs and trees together?  Anyway, I consider the names and
permissions properties of the files and their identity.  Stripping out
the blobs from under them does not actually add any information: the
trees still don't contain any information that would have necessitated
looking at directories rather than just files, their names,
permissions and content in the work space.

But you are right in that the tree can't be replaced by the blobs.  It
actually needs the files (namely their full names and permissions) to
reconstruct it.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
