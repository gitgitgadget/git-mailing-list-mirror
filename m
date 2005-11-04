From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fixing Commit And Author
Date: Fri, 4 Nov 2005 09:30:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511040924400.27915@g5.osdl.org>
References: <1131122325.5446.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 18:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY5Oz-00070c-W6
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 18:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVKDRa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 12:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVKDRa4
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 12:30:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbVKDRa4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 12:30:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA4HUqnO032329
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 4 Nov 2005 09:30:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA4HUoZc012579;
	Fri, 4 Nov 2005 09:30:51 -0800
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1131122325.5446.14.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11146>



On Fri, 4 Nov 2005, Darrin Thompson wrote:

> I've got a small project in git where I made a dumb error. All my
> commits have author/committer information like this:
> 
> Author: Darrin Thompson <darrint@dhcp-1-211.(none)>  2005-10-20 16:50:38
> Committer: Darrin Thompson <darrint@dhcp-1-211.(none)>  2005-10-20
> 16:50:38
> Tags: svn-5099
> 
> I'd like to replace the commits (yes, I know that means all of them)
> with new ones with corrected email addresses and also manage to migrate
> my tags. A push in the right direction would be appreciated.

There's a program in the git sources called "git-convert-objects.c".

It basically knows how to walk the git object chains, and rewrite each 
object according to a few rules.

The rules currently do _not_ include changing the author/committer info, 
but it does know how to parse the really old-style dates, for example, 
which are on those same lines, so adding some code there to also re-write 
the author/committer name and email wouldn't be impossible.

The code isn't necessarily all that easy to understand, and usage-wise you 
also have to convert each head separately (you tell it which branch head 
you want to convert, it trawls every reachable object from that head, and 
will create the new objects and return the new head value).

What I'm trying to say is that it might not be _pleasant_, but it's 
certainly something you can automate and do in a timely manner (ie a small 
project will take just a few seconds - or minutes - to convert).

> Next I'd like to do the same with the kernel sources... :-)

The same program will work, but it will take some time.

Actually, as long as you only rewrite commits, it should even be 
reasonably efficient. It's when you start rewriting every single object 
(like I did when I switched the compression scheme around) that it gets 
_really_ expensive, and a project like the kernel would take a long long 
time.

Hint to the wise: don't do the conversion on the only copy of the 
repository you have. It's always worked for me, but hey, maybe I'm just 
lucky and never write buggy conversion software.

			Linus
