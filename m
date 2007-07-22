From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 03:16:47 +0200
Organization: At home
Message-ID: <f7uap7$eo1$1@sea.gmane.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <851wf2bcqy.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org> <85odi69vgt.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org> <85tzrxslms.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org> <85644dqoig.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 03:10:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICPxo-00085l-G3
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 03:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbXGVBKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 21:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXGVBKV
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 21:10:21 -0400
Received: from main.gmane.org ([80.91.229.2]:52214 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbXGVBKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 21:10:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICPxe-0004QS-Ad
	for git@vger.kernel.org; Sun, 22 Jul 2007 03:10:14 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 03:10:14 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 03:10:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53209>

David Kastrup wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Sat, 21 Jul 2007, David Kastrup wrote:

>>> Linus, a directory is simply non-existent inside of git.
>>
>> You need to learn git first.
>>
>> A directory doesn't exist IN THE INDEX (until my patches). But you
>> need to learn about the object database and the SHA1's. That's the
>> real meat of git, and it sure as hell knows about directories.
> 
> I have written up a complete explanation about the underlying concept
> in a separate thread, maybe it would make sense reading that before
> investing too much time meddling over details that don't fit the large
> picture.  The point is that the object database and the SHA1 values
> track _trees_, not _directories_.  And a _tree_ is just a hashing
> mechanism in the repository for files.  Its existence is solely
> dependent on the existence of its contents.  The only synchronization
> with directories is that when a tree becomes empty, git attempts to do
> an rmdir on the corresponding directory.  And of course, if git needs
> to check out a file, it creates the necessary parent directories.
> 
> Now since the physical _contents_ of a directory are already tracked
> in _trees_ by git, the only missing part is the _existence_ of the
> directory itself: a directory must exist as long as there is a tree
> (and thus content) connected with it, but the reverse does not hold:
> without a tree, the directory can still exist.  Which we can represent
> by a repository entry named "." without content (the content is
> already catered for by the _tree_).  This must _not_ be represented by
> a _tree_ node since there is no content, and a tree without content by
> _definition_ does not exist.
> 
> I must be really bad at explaining things, or I am losing a fight
> against preconceptions fixed beyond my imagination.

I don't understand you, or you don't understand git. "Tree" object
in object database (in repository) represents a directory in the
working area. There was never any problem with having empty trees
in object database, or having links to empty directory in the superdir.
We don't have to change anything about object database.

The problems with git problems with empty directories stems from the
fact that index didn't have directories. Index is flattened version
of root tree, and before subproject support it contained _only_ info
about blobs (file contents). At least till Linus patch...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
