From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: [spf:guess,iffy] Re: [spf:guess,iffy] [PATCH] git-svn: teach
 git-svn to populate svn:mergeinfo
Date: Fri, 2 Sep 2011 15:42:06 -0400
Organization: White Oak Technologies
Message-ID: <20110902154206.331b80e9@robyn.woti.com>
References: <20110902140702.066a4668@robyn.woti.com>
	<4E612319.7030006@vilain.net>
	<20110902144922.383ed0f1@robyn.woti.com>
	<4E6127F5.5070009@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 21:42:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzZd8-0004T8-JG
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 21:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab1IBTmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 15:42:12 -0400
Received: from mail02.woti.us ([66.92.158.6]:59838 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755032Ab1IBTmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 15:42:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id D74FA504D37F0;
	Fri,  2 Sep 2011 15:42:07 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tkvBBxys7R66; Fri,  2 Sep 2011 15:42:07 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 6A676504D37EA;
	Fri,  2 Sep 2011 15:42:07 -0400 (EDT)
In-Reply-To: <4E6127F5.5070009@vilain.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180634>

On Fri, 02 Sep 2011 12:01:09 -0700
Sam Vilain <sam@vilain.net> wrote:

> That's one way to do it; in fact, if the trees match you don't need
> to do anything complicated like cherry-pick.
> 
> ie, say you're committing
> 
>     r1---A---B---C---D
> 
> and it blows up at
> 
>     r1--r2--r3--C---D
> 
> So long as the tree from the fetched r3 == the tree from B, then you
> can just go ahead and write out new commits for C and D without doing
> any merging (ie cherry-pick or rebase).  You could also put merge
> commits back the way they were, too.

When you say "write out new commits" you mean create a commit object
with the same contents, but a different parent? Does git-svn do this
somewhere already?

> If they don't match, then something went wrong with the push really,
> or there is something weird going on.  I'd try to avoid using cherry
> pick automatically in situations like this.  There are too many error
> modes, and if it only happens when you don't know what's going on,
> it's not a good idea to try to fix that.  If it /is/ a sufficiently
> unlikely error (ie, the trees not matching as above), then it would
> be better to simply bomb out and provide two commands:
> 
> * a 'git reset' command to restore to previous state (ie, before the 
> dcommit)
> * a 'git rebase' command to attempt to put the new history on top of
> the new upstream.  Rebase doesn't work with merges of course but it
> still should help the user figure out what to do.
> 
> Another benefit of this approach is that you don't need to muck with
> the WC + index at all, no matter what happens.

All of the above sounds good to me. I haven't taken the time to
understand how git-svn sends changesets upstream (I only know it mucks
with the WC from empirical experience) so I don't know how easy it would
be to change the methodology, though.

Would this also mean we could dcommit from a dirty checkout? Having to
stash/unstash is a nuisance.

> Sam
> 
