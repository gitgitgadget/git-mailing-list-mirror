From: David Madore <david.madore@ens.fr>
Subject: referencing a revision at a certain date
Date: Mon, 11 Feb 2008 19:04:24 +0100
Message-ID: <20080211180424.GA4905@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:18:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOdEP-0000OF-1T
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 19:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbYBKSRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 13:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754999AbYBKSRh
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 13:17:37 -0500
Received: from nef2.ens.fr ([129.199.96.40]:3852 "EHLO nef2.ens.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493AbYBKSRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 13:17:36 -0500
X-Greylist: delayed 790 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Feb 2008 13:17:36 EST
Received: from clipper.ens.fr (clipper-gw.ens.fr [129.199.1.22])
          by nef2.ens.fr (8.13.6/1.01.28121999) with ESMTP id m1BI4OP5008009
          for <git@vger.kernel.org>; Mon, 11 Feb 2008 19:04:25 +0100 (CET)
Received: from (madore@localhost) by clipper.ens.fr (8.13.1/jb-1.1)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.1.4 (nef2.ens.fr [129.199.96.32]); Mon, 11 Feb 2008 19:04:25 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73558>

Hi,

I'm left quite confused by the git-rev-parse(1) man page, I wonder if
someone can help me with this.

I understand that if "rev" denotes a certain revision, then "rev~42"
references the commit which is 42 generations back from rev.  What I'd
like to do is write something like "rev~@{2008-01-18}" (say) to get
the same thing but with the 42 being computed automatically so that
the commit in question is the latest possible (in commit date) before
2008-01-18.  Is this possible?  If so, how?  If not, might I suggest
this as an addition for consideration?

I thought "rev@{2008-01-18}" did this, but apparently it doesn't: it
requires a ref log of some kind, and I don't know how to make a ref
log (git-clone doesn't seem to copy them).

So, is there some way I can either generate a ref log by
systematically taking the first parent in each commit as per git-log
--first-parent, OR (better) specify a revision directly that way?

Typical problem I'm faced with:

mizar david /tmp $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Initialized empty Git repository in /tmp/linux-2.6/.git/
remote: Counting objects: 712898, done.
remote: Compressing objects: 100% (124199/124199), done.
Indexing 712898 objects...
remote: Total 712898 (delta 591709), reused 708828 (delta 587713)
 100% (712898/712898) done
Resolving 591709 deltas...
 100% (591709/591709) done
Checking 23757 files out...
 100% (23757/23757) done
mizar david /tmp $ cd linux-2.6
mizar david /tmp/linux-2.6 $ git rev-parse 'master@{2008-02-01}'
warning: Log for 'master' only goes back to Mon, 11 Feb 2008 18:34:33 +0100.
0000000000000000000000000000000000000000
mizar david /tmp/linux-2.6 $ git rev-parse 'origin@{2008-02-01}'
warning: Log for 'origin' only goes back to Mon, 11 Feb 2008 18:34:32 +0100.
0000000000000000000000000000000000000000
mizar david /tmp/linux-2.6 $ git cat-file -p 'master~1126' | head -5
tree a72dadd4a8b4957a4e21bf7ae38a763a71d6e274
parent e1a9c9872dd004617555dff079b357a6ffd945e9
parent c4772d99300a9fc13c86aaa370e630c5973664f6
author Linus Torvalds <torvalds@linux-foundation.org> 1201821909 +1100
committer Linus Torvalds <torvalds@linux-foundation.org> 1201821909 +1100

=> there must be some intelligent way of finding this revision, but
which is it?

Cheers,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
