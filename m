From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Wed, 25 Jun 2008 09:51:00 -0400
Message-ID: <20080625135100.GF20361@mit.edu>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 25 15:53:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBVQh-0001Jm-17
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 15:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995AbYFYNv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbYFYNv7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 09:51:59 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:54919 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755932AbYFYNv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 09:51:58 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBVOo-0001w8-5W; Wed, 25 Jun 2008 09:51:02 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBVOm-00072h-EA; Wed, 25 Jun 2008 09:51:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806251334060.9925@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86279>

On Wed, Jun 25, 2008 at 01:38:30PM +0100, Johannes Schindelin wrote:
> > $ git config alias.switch checkout
> > $ git switch topic
> > 
> > Hm? Notice that the command even reports back:
> > 
> > Switched to branch "topic"
> > ^^^^^^^^
> 
> Nice.  And now my friend says "why does this braindamaged Git not have 
> that command by _default_?  Hmm?  It is _just as braindamaged_ as CVS!"

I agree that "git switch" would be a great alias to have for "git
checkout".  It is much more intuitive; traditionally, the issue has
always been that it's not so intuitive for existing git users, who
have gotten used to the existing quirks, and it people won't want to
break things for the existing users.  (There are analogues to this is
the English language --- why is it that "though", "through", "plough",
"cough", "hough", or "tough" don't rhyme[1]?)

[1]  http://www.mipmip.org/tidbits/pronunciation.shtml

> And I would not have anything reasonable for my defense.

Neither does the English language; but just try changing it!
"Historical reasons" is for better or for worse a very strong
argument.

> Because Git _should_ have an intuitive command to switch branches by 
> default.  "git checkout" just does not fly, especially given that it can 
> be used to revert single files (which "git revert" should know how to, but 
> does not, see 
> http://mid.gmane.org/7vlk8wshii.fsf@gitster.siamese.dyndns.org).

I used to argue for this, but gave up, because no one seemed to agree
with me.  So now I just have the following in
/home/tytso/bin/git-revert-file and I am very happy:

#!/bin/sh
#
prefix=$(git rev-parse --show-prefix)

for i in $*
do
        git show HEAD:$prefix$i > $i
done

It makes "git revert-file <file1> <file2> <file3>" do the right thing.
Yeah, it doesn't do enough error checking, and it doesn't handle
filenames with spaces, and there are probably other corner cases it
doesn't get right, but it's been enough to keep me happy.  :-)

If someone wants to take the above and turn it into git-rename.sh and
try to submit it to the git tree --- they are welcome to do it.  Or
heck, if Junio is willing to commit that it that with the appropriate
cleanups it would be accepted, I'd be willing to do the work.  I just
got tired of arguing that the concept of "git revert-file" was in fact
useful, and so its existence could be justified, which IIRC was
disputed the last time we went around this topic.  I know I wanted it,
though, so I implemented it for myself.

> I _do_ see a cause of confusion here, _even_ if I know Git pretty well.

As do I....  I think the expert git users have just leared how to work
around it, either by learning the non-linearities in the UI, or by our
own private hacks or aliases.

						- Ted
