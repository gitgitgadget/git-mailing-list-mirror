From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 14:06:24 +0200
Message-ID: <200707221406.25541.jnareb@gmail.com>
References: <85lkdezi08.fsf@lola.goethe.zz> <f7uap7$eo1$1@sea.gmane.org> <85myxpp67k.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 13:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICa6J-0001Pu-Cr
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 13:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757261AbXGVL7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 07:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756393AbXGVL7r
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 07:59:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:26350 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbXGVL7p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 07:59:45 -0400
Received: by ug-out-1314.google.com with SMTP id j3so945047ugf
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 04:59:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=b+PncvcWNfEaxmWvaH/01x57i7vLA9gTlyHpMDgnSklyI8xbkrHRFFtjtOZECdS+LNlo0a0PKyxdFSirbNG4tTxj+gSat2xqgW6j3xBkE4KHWRPf/3YbHXkgGLQUulzDtwo6T4tuKn9RQrSDHtn0eCIiYTxEr3NwPu28QNP9qMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=V3nEQeOCQCSH3L+hEARwAX/dSfb9V5KbViDA+n8sHIZnKDVGNXB/cxr6pYm23nUB/J64vojA2nA6J+2iVAd4CfSJyuV8vUhPjJkPUXAewpCTrMm6LUnc0h93TbeukzchQV8R46q47Lk+dFJqh+EAOe4h18bMk1Kua01RO5fgBUA=
Received: by 10.86.23.17 with SMTP id 17mr1692287fgw.1185105583759;
        Sun, 22 Jul 2007 04:59:43 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id a37sm11467045fkc.2007.07.22.04.59.40
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 04:59:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <85myxpp67k.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53253>

On Sun, 22 July 2007, David Kastrup wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> David Kastrup wrote:
>>
>>> I must be really bad at explaining things, or I am losing a fight
>>> against preconceptions fixed beyond my imagination.

Or you are wrong...

>> I don't understand you, or you don't understand git. "Tree" object
>> in object database (in repository) represents a directory in the
>> working area. There was never any problem with having empty trees in
>> object database, or having links to empty directory in the superdir.
>> We don't have to change anything about object database.
> 
> I disagree here.  The object database _can_ represent an _empty_
> directory that has been added explicitly, because up to now no
> operations existed that actually left an empty tree.  But it can't
> distinguish a _non_-empty directory that has been added explicitly
> from non-empty directory that has not been added explicitly.

True. I forgot about that.

Although I'd rather say that we want distinguish between automatically 
cleaned up directory (directory which will be deleted if all files in 
it would be deleted, and would be untracked if all tracked files in it 
would be deleted), and "sticky" directory, which is explicitely tracked 
and have to be explicitely deleted.

The fact that it was added explicitely or non explicitely is orthogonal 
to that.

IMHO it would be best to first provide plumbing infrastructure (as e.g. 
it was the case of submodule support), then add option to 
git-update-index to change the "stickiness"/"autoremoval" status of a 
directory (of a tree), and _last_ think about how to change the 
porcelain (git-add and git-rm).

[...]
> But in the second case, git must _not_ retain a.  So we need to record
> the information that in the first case, a was added explicitly.  And
> this can't be done with the current repository layout.  It doesn't buy
> us anything that we _have_ a representation available for an _empty_
> tree added explicitly.  We need this "added explicitly" information
> for _every_ tree, not just empty ones.
> 
> And a perfectly consistent way is to make those trees with an
> explicitly added directory _non-empty_, by virtue of putting a file
> "." in them.  This file, of course, exists in every physical
> directory, but we may or may not decide to let it be tracked by git,
> using the gitignore mechanism on the pattern ".".  Perfectly
> expedient.

Here we disagree. I think putting "." in a tree as marker of having it 
not be automatically deleted when empty, as opposed to marking tree 
using filemode in the parent, is not a good idea.

The only advantage to the "." idea is that it can use gitignore 
mechanism (both in-tree .gitignore, tracked or not, and info/exclude 
file). But I also think that the fact that gitignore mechanism is 
recursive is more of disadvantage than advantage.

First, it is _not_ consistent. Working directory trees _always_ have '.' 
in them, while trees would have or would have not it, depending if they 
would be "sticky" or "autoremoved".

Second, the "easy implementation" is anything but easy. "git add ." as
a way to mark directory as "sticky" is not backward compatibile: 
currently it mean to add _all contents_ of current directory. 
Implementation is tricky: as we have seen trying to unlink '.' or 
create '.' can unfortunately succeed on [some Sun OS, and UFS 
filesystem] (which follows POSIX stupidly to the letter) f**king
up the filesystem. The alternative proposal of adding "magic mode" to 
mark directory as "not remove when empty" is largely tested; it is very 
similar to the subproject support.

Third, is contrary to the git philosophy of tracking contents. 
"Stickiness" is an attribute; the fact that directory is explicitely 
tracked or not does not change contents of a directory. Compare to 
'blob' which contains only contents of a file: not a filename, not a 
pathname, not [subset of] filemode.

Fourth, is very artificial. What would you put for filemode for '.'?
040000 (i.e. directory)? What would you put for sha1? Sha1 of an empty 
directory? Of an empty blob? 0{40} (which is bad idea because 
git-diff-tree uses 0{40} to represent 'not existance')?

>> The problems with git problems with empty directories stems from the
>> fact that index didn't have directories.
> 
> That basically implies that no information about directories could be
> tracked in the repository.  And yes, we need appropriate information
> in the index.  Again, the information whether a directory was added
> explicitly.

Whether directory is automatically managed by git (automatically removed 
or untracked). But we need directory entry in index for git-diff, for 
example to recognize if there is or there is not empty directory, or if 
a directory is automanaged or not.
 
>> Index is flattened version of root tree, and before subproject
>> support it contained _only_ info about blobs (file contents).
> 
> And the repository is a versioned and hierarchically hashed version of
> the index, but its trees contain _no_ information that is not already
> inherently represented by the files alone. [...]

The above sentence is nonsensical. Index is helper for repository,
and can be derived from repository. Not vice versa.

Trees do contain information which is not inherently present by the 
blobs.
-- 
Jakub Narebski
Poland
