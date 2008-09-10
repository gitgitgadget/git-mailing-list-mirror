From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 23:50:45 +0200
Message-ID: <20080910215045.GA22739@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910151015.GA8869@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 23:51:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdXbS-0006hp-BA
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 23:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbYIJVur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 17:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYIJVur
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 17:50:47 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42783 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYIJVur (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 17:50:47 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id D6D2D5465; Wed, 10 Sep 2008 23:50:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080910151015.GA8869@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95558>

Jeff King wrote:
>On Wed, Sep 10, 2008 at 04:16:30PM +0200, Stephen R. van den Berg wrote:
>> This is nice, I admit, but it has the following downsides:
>> - It is nontrivial to automate this on execution of "git cherry-pick".

>Maybe a cherry-picking hook?

Yes, that works, but it is non-trivial, especially since it needs to
work for gitk, log --graph, blame and revert as well.

>> - In a distributed environment this requires a network-reachable bug
>>   database.

>Use a distributed bug tracking system (DBTS).

If it were part of git-core, that would work.

>But maybe Ted is on to something here. Rather than adding the
>information to the commit object itself, why not maintain a separate
>mapping, but keep it _within git_. That is how most of the DBTS's work
>that I have seen. Maybe it is possible to implement some subset of the
>features in a tool that could become part of core git.

Interesting thought.

>There was a proposal at some point for a "notes" feature which would
>allow after-the-fact annotation of commits. I don't recall the exact
>details, but I think it stored its information as a git tree of blobs.
>You could choose whether or not to transfer the notes based on
>transferring a ref pointing to the notes tree.

The idea is nice, but if we were to use it to store the origin link
information, the following happens:
- Origin link information is rare.
- Yet during a log/gitk/blame run the information might need to
  be queried for at every commit.
- Since in most cases the origin information does not exist, this
  will cause misses to fill the dentry cache for directory lookups, and
  thus killing performance.
- In order to make this efficient, a different database lookup system is
  needed that is fast for misses.

Whereas if the information is part of the commit, it costs nothing in
the typical case (no origin information present).
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
