From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-pull and tag objects
Date: Tue, 13 Feb 2007 22:38:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702132230490.3604@woody.linux-foundation.org>
References: <1170933407.15431.38.camel@okra.transitives.com>
 <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
 <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org>
 <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
 <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net> <20070212162745.GB2741@thunk.org>
 <7vr6su1szp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 07:38:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHDn3-0000Ns-Uh
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 07:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXBNGiq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 01:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXBNGiq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 01:38:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43429 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbXBNGip (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 01:38:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1E6cchB020848
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 22:38:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1E6cbLC023422;
	Tue, 13 Feb 2007 22:38:37 -0800
In-Reply-To: <7vr6su1szp.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.413 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39621>



On Mon, 12 Feb 2007, Junio C Hamano wrote:
> 
> "fsck --full" should report "dangling tag".

Well, except if
 - you've pruned
 - the importer never imported anything but the most recent one.

One thing that _might_ be a good idea for tags (if people _really_ want to 
actually update tags under the same name) is to have a "parent" pointer 
for tag objects, the same way we have for commits. That way you could - if 
you really wanted to - create a chain of tags, and show the history of 
them.

Now, I personally think you'd be better off just having separate names, 
but for something like a "passed testing" tag, it might be valid to (a) 
have the last one and (b) have a history chain. And it's not like it would 
be technically "hard" to do.

I dunno. Personally I'd rather try to just tell people to not re-use 
tag-names, because it kind of destroys the whole point of a tag ("I 
checked out tag X!" just leadsto "_Which_ X?").

And you could certainly do the "passed testing" thing with commits in a 
separate branch instead: you'd create the "testing" branch, which is 
always a set of commits that have as their primary parent the commit that 
got tested, and as the second parent the previous commit in the "testing" 
series).

So _generally_ I think we're better off keeping things the way they are, 
but on the other hand, if only to work well with idiotic systems that 
mis-use tags in ways that tags shouldn't be used, we *could* just extend 
on what tyou can do with a git tag too..

		Linus
