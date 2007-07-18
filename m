From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Wed, 18 Jul 2007 11:09:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181056370.14781@racer.site>
References: <Pine.LNX.4.64.0707172346450.14781@racer.site>
 <Pine.LNX.4.64.0707172216420.14596@iabervon.org> <Pine.LNX.4.64.0707172302560.14596@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 12:10:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB6Ts-0000tA-Jy
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 12:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbXGRKJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 06:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753472AbXGRKJe
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 06:09:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:57747 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754798AbXGRKJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 06:09:33 -0400
Received: (qmail invoked by alias); 18 Jul 2007 10:09:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 18 Jul 2007 12:09:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gV0BftjQgwz4Rn20o3wVSF0G9UxPclggipYn+t8
	taD/fNiT6ioCKy
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707172302560.14596@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52846>

Hi,

On Tue, 17 Jul 2007, Daniel Barkalow wrote:

> On Tue, 17 Jul 2007, Daniel Barkalow wrote:
> 
> > On Tue, 17 Jul 2007, Johannes Schindelin wrote:
> > 
> > > The transport specific stuff was moved into libgit.a, and the bundle 
> > > specific stuff will not be left behind.
> > > 
> > > This is a big code move, with one exception: the function unbundle() 
> > > no longer outputs the list of refs.  You have to call 
> > > list_bundle_refs() yourself for that.
> > 
> > You should use -C on this sort of thing, so that the interesting 
> > aspects of the patch are easier to see. (It actually comes out longer 
> > in this case, but it's far easier to tell that the code in the new 
> > file is the same as the old code.) Can you tell I've been rearranging 
> > a lot of code lately and trying to make the patches not look really 
> > scary?
> 
> Actually, I ended up touching this up a tiny bit, too: I ordered the 
> functions in bundle.c the way they were in builtin-bundle.c (so that the 
> patch is more trivial) and removed the blank lines at the end of the file. 
> This makes the "git diff -C" output really obvious. 

Makes sense.  Thanks.

> (Someday, I'd like to have a diff that can show that a substantial block 
> of '+' lines matches a block of lines from somewhere in the "before" 
> content, so reviewers can verify that the patch reorders code but 
> doesn't change it, or changes it in certain ways. But, of course, that's 
> both hard to generate and hard to display usefully.)

AFAIR from the thread after

http://thread.gmane.org/gmane.linux.kernel/484924/focus=37498

the problem was not so much the displaying as the applying.  You have a 
diff for builtin-bundle.c.  You want to move code to bundle.c.  git-diff 
has to rearrange the diff so that bundle.c can copy the code from 
builtin-bundle.c, and then it is deleted from builtin-bundle.c.  If you 
move code criss-cross, it is not possible.

However, if you do something like

diff --git a/builtin-bundle.c:10--20 b/bundle.c:0--30
code move
--- a/builtin-bundle.c:10--20
+++ b/bundle.c:1--11
diff --git ...

it should be possible.  We could allow generation of such a diff with 
--code-moves, which would detect if there is substantial evidence for a 
code move, and produce such a diff.

Note: this kind of code movement diff has to come before _both_ the diffs 
for builtin-bundle.c and bundle.c, since chances are that the code had to 
be touched a little here and there.  And probably you would want a little 
context, just to make sure it is the correct code when applying the patch.

Ciao,
Dscho
