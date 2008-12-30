From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 05:34:38 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngljcne.n7q.sitaramc@sitaramc.homelinux.net>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org>
 <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com>
 <gjc7qa$jdj$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 06:36:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHXH5-00004x-Ek
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 06:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbYL3Fez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 00:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbYL3Fey
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 00:34:54 -0500
Received: from main.gmane.org ([80.91.229.2]:44805 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbYL3Fex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 00:34:53 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHXFj-0004Vd-9r
	for git@vger.kernel.org; Tue, 30 Dec 2008 05:34:51 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 05:34:51 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 05:34:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104162>

Hi Conor,

On 2008-12-30, Zorba <cr@altmore.co.uk> wrote:
> so when I reset to A, I've still got the ability to get to B or C again

if this is true...  (call this case 1)

> Now I appreciate that if I commit a new change from versionA (lets call it 
> B1), then HEAD is now at B1, and B, C etc are lost, correct ?

...then this (call this case 2) is not true.

In case 1, *how* do you get back to B and C?  However you do
it, the same action will get you to B and C *after* you
created B1 as well.

It might help to think of these things loosely using a
malloc/linked-list analogy.  Imagine a singly-linked list,
and a variable in your program called "head" pointing to the
top element.  Each element contains a back-pointer to its
parent.  You can start from head and walk the list backward,
but you can't walk forward -- there are no forward pointers.

A "git commit" is analogous to:
    newblkptr = malloc(...);
    ... store whatever you want in the new block ...
    newblkptr.backptr = head;
    head = newblkptr;

i.e., a classic linked list add.

A "git reset --hard HEAD^" essentially pops the topmost
element off the list:
    head = head.backptr

A "git checkout -f HEAD^" is like walking a linked list
backward in a loop, and stopping at some intermediate block
to do something -- other the temporary loop-variable,
nothing else (no global variable perhaps) points to this
block, so this is like a detached head.

Of course, nothing prevents you from permanently saving this
temporary loop variable because you suddenly realise *this*
link in the chain is very important for the rest of your
program:
    some_global_var = temp_blk_ptr;

This is like "git checkout -b newbranch" does.

> Its pertinent to where I am right now, as I've goofed a commit, and want to 
> reset, and commit again but I'm worried about leaveing garbage lying around 
> (the commits for version B and C in the example above).

(1) never worry about leaving garbage around; there are many
operations that do that; it's part of the design.  Don't
sweat it.

(2) when in doubt, try "gitk --all".  That's a good GUI.
I'm normally a CLI freak, but when something needs to be
understood/learnt, a well-designed GUI really helps.

Run "gitk --all" on the side and hit F5 on it after each
operation on the command line -- helped me when I was trying
to figure out what's happening.

PS: although it doesn't mention detached heads,
http://eagain.net/articles/git-for-computer-scientists/
helped me a lot...
