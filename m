From: David Greaves <david@dgreaves.com>
Subject: Re: Git hangs while executing commit-tree
Date: Wed, 20 Apr 2005 23:08:16 +0100
Message-ID: <4266D2D0.5000503@dgreaves.com>
References: <200504202228.35652.rhys@rhyshardwick.co.uk> <Pine.LNX.4.58.0504201446510.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rhys Hardwick <rhys@rhyshardwick.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 00:06:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONJ5-0005l7-2g
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 00:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVDTWIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVDTWIq
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:08:46 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:33951 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261723AbVDTWIm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 18:08:42 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 24FBEE6D53; Wed, 20 Apr 2005 23:06:55 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01953-05; Wed, 20 Apr 2005 23:06:55 +0100 (BST)
Received: from oak.dgreaves.com (modem-1485.lemur.dialup.pol.co.uk [217.135.133.205])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 7EE81E6D73; Wed, 20 Apr 2005 23:06:50 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DONMm-0000zc-RL; Wed, 20 Apr 2005 23:08:16 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201446510.6467@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 20 Apr 2005, Rhys Hardwick wrote:
> 
>>rhys@metatron:~/repo/tmp.repo$ commit-tree  c80156fafbac377ab35beb076090c8320f874f91
>>Committing initial tree c80156fafbac377ab35beb076090c8320f874f91
>> 
>>At this point, the command seems to be just waiting.
> 
> 
> That's _exactly_ what it's doing. It's waiting for you to write a commit 
> message.
> 
> Something like
> 
> 	This is my initial commit of Hello World!
> 	^D
> 
> will make it happy.
> 
> Alternatively, you can certainly just write your message beforehand with 
> an editor and just pipe it into commit-tree.
> 
> 			Linus

When someone commits the docs I'll submit the next patch for the README:

commit-tree
	commit-tree <sha1> [-p <parent sha1>...] < changelog

Creates a new commit object based on the provided tree object and
emits the new commit object id on stdout. If no parent is given then
it is considered to be an initial tree.

A commit comment is read from stdin (max 999 chars)

A commit object usually has 1 parent (a commit after a change) or 2
parents (a merge) although there is no reason it cannot have more than
2 parents.

While a tree represents a particular directory state of a working
directory, a commit represents that state in "time", and explains how
to get there.

Normally a commit would identify a new "HEAD" state, and while git
doesn't care where you save the note about that state, in practice we
tend to just write the result to the file ".git/HEAD", so that we can
always see what the last committed state was.

Options

<sha1>
	An existing tree object

-p <parent sha1>
	Each -p indicates a the id of a parent commit object.
	

Commit Information

A commit encapsulates:
	all parent object ids
	author name, email and date
	committer name and email and the commit time.

If not provided, commit-tree uses your name, hostname and domain to
provide author and committer info. This can be overridden using the
following environment variables.
	AUTHOR_NAME
	AUTHOR_EMAIL
	AUTHOR_DATE
	COMMIT_AUTHOR_NAME
	COMMIT_AUTHOR_EMAIL
(nb <,> and CRs are stripped)

see also: write-tree

David
-- 
