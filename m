From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bad merging with stgit or git
Date: Tue, 21 Mar 2006 11:42:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603211138020.3622@g5.osdl.org>
References: <1142969653.4749.109.camel@praia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 21 20:42:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLmkG-0005g9-Ix
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 20:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWCUTmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 14:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWCUTmR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 14:42:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965096AbWCUTmQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Mar 2006 14:42:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2LJgBDZ019798
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Mar 2006 11:42:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2LJg8Sd028947;
	Tue, 21 Mar 2006 11:42:10 -0800
To: Mauro Carvalho Chehab <mchehab@infradead.org>
In-Reply-To: <1142969653.4749.109.camel@praia>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17784>



On Tue, 21 Mar 2006, Mauro Carvalho Chehab wrote:
>
> I have a -git tree that generated a really bad result when committed by
> Linus, generating a really bad history log. My tree is located at:
> kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git.

Here's a mail that went to linux-kernel to explain some more..

Basically, the problem is that the DVB tree has a perfectly normal commit 
(_not_ a merge commit), which has the commit message

	"Merging Linus tree"

and is just a patch that apparently merged the changes in my tree at some 
random state (don't know which, since the commit isn't a merge commit, and 
doesn't point to the parent it merged from).

I thought it might be a cherry-pick of a merge, or something like that, 
but the author/committer dates are the same, so that sounds unlikely. 
However, I could imagine that "stgit" would do something like this if/when 
it is used to cherry-pick a merge. 

Apparently the DVB people also use Mercurial somewhere, so who knows..

		Linus

---
Date: Tue, 21 Mar 2006 11:32:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1

On Tue, 21 Mar 2006, Mauro Carvalho Chehab wrote:
> 
> Weird, I can't see all those stuff here. It shows something like
> (running from master copy at kernel.org):

I just did the raw output, so my output was from

	git show --pretty=fuller -r e338b7

which isn't the default, but it's useful if you want to see both committer 
and author information (and the raw format is just because I wasn't 
interested in the diff itself, just looking at how many files where 
changed).

> So, after the merging message, I have a normal diff with:
> 
>  179 files changed, 1274 insertions(+), 785 deletions(-)

Yeah, we're talking about the same commit.

> Seeming all perfect from my knowledge about git.

It's a perfectly good commit. BUT IT IS NOT A MERGE, AND IT IS NOT A DIFF 
THAT I WANT TO SEE COMING IN FROM AN OUTSIDE TREE!

Basically, in the DVB tree you have absolutely _no_ business in "merging" 
work from my tree as a patch, especially when the patch you merge has 
absolutely zero to do with DVB. You just applied a 5000-line patch to the 
tree, with no merge message other than "Merge from Linus tree", and no 
attribution about what the f*ck was merged, and why.

THAT is the part I'm unhappy with. The git tree is not "corrupt" from a 
technical standpoint (it passes fsck). It's "corrupt" because it contains 
a patch that shouldn't be there, that is mis-attributed, and that 
incorrectly claims to be a merge when it isn't - it's just a random patch 
generated against my tree.

		Linus
