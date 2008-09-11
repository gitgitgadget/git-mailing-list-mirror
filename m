From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 21:03:35 +0200
Message-ID: <20080911190335.GB1451@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:04:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdrTA-0005iU-Tm
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 21:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbYIKTDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 15:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbYIKTDh
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 15:03:37 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59567 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbYIKTDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 15:03:36 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 1E9A55465; Thu, 11 Sep 2008 21:03:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080911180037.GH5082@mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95628>

Theodore Tso wrote:
>On Thu, Sep 11, 2008 at 05:32:02PM +0200, Stephen R. van den Berg wrote:
>> gc will preserve the commits the origin links point to once they are
>> reachable.  I.e. if the developer doesn't care about the commits the
>> origin links point to (i.e. if the branches are not reachable) then gc
>> just skips them, if the developer *does* care, the origin links are used
>> to keep those objects alive (and, of course, all their parenthood).

>This seems wrong.  OK, suppose you have branches A, B, C, and D, while
>you are on branch C, you cherry pick commit 'p' from branch B, so that
>there is a new commit q on branch C which has an origin link
>containing the commit ID's p^ and 'p.    

Ok.

>Now suppose branch B gets deleted, and you do a "git gc".  All of the
>commits that were part of branch B will vanish except for p^ and p,

Not quite.  Obviously all parents of p and p^ will continue to exist.
I.e. deleting branch B will cause all commits from p till the tip of B
(except p itself) to vanish.  Keeping p implies that the whole chain of
parents below p will continue to exist and be reachable.  That's the way
a git repository works.

>which in your model will stick around because they are origin links
>commit q on branch C.  But what good is are these two commits?  They
>represent two snapshots in time, with no context now that branch B has

The context are all their ancestors, which continue to exist, and that
is all you need.

>been deleted.  99% of the time, the diff between p^ and p will result
>in the equivalent of the diff between q^ and q.  But even if they
>aren't, what use are these isolated, disconnected commits?  So having
>"git gc" retain them commits that are pointed to be this proposed
>origin link doesn't seem to make any sense, and doesn't seem to be
>well thought through.

I beg to differ, but I presume you agree with me now?

>Oh, BTW, suppose you then further do a "git cherry-pick -o" of commit
>q while you are on branch D.  Presumably this will create a new
>commit, r.  But will the origin-link of commit r be p^ and p, or q^
>and q?

It will be q^..q, and specifically not p^..p, using ^p..p would be
lying.  We aim to document the evolvement of the patch in time.
Cherry-pick itself will always ignore the origin links present on the
old commit, it simply creates new ones as if the old ones didn't exist.

>  And will this change depending on whether or not -o is
>specified?

No.  Actually, cherry-pick will never generate origin links unless -o is
specified.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
