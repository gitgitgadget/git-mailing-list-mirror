From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 18:40:45 +0200
Message-ID: <20080910164045.GL10360@machine.or.cz>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 18:42:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdSlQ-0007S2-6d
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 18:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbYIJQks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 12:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYIJQkr
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 12:40:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48211 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbYIJQkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 12:40:47 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 222CF3939B3E; Wed, 10 Sep 2008 18:40:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080910141630.GB7397@cuci.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95540>

On Wed, Sep 10, 2008 at 04:16:30PM +0200, Stephen R. van den Berg wrote:
> Theodore Tso wrote:
> >  And the maintenance of this database
> >is purely optional; you only need it if you care about efficiently
> >looking up UUID's, and given "time git log > /dev/null" on the kernel
> >tree only takes six seconds on my laptop, and "git log > /dev/null"
> >only takes 0.148 seconds for e2fsprogs, for many projects you might
> >not even need the database to accelerate lookups via UUID.
> 
> The database needs to be available to anyone doing a clone of the
> repository, which implies that:
> - It needs to be network based.
> - It needs controlled write access (which is a mess).
> - It is slow during blame/gitk operations.
> - It is rather nontrivial to get things setup such that someone (after
>   cloning the repository) is able to run cherry-pick/gitk/blame/revert
>   and have those commands use the database transparently.

The database can just live in a special branch, with trees organized the
same way the object database is, possibly in a more optimized way
(having the HEAD trees cached around inside Git, etc.).  This should be
no rocked science if the design is given a little thought, and should be
fairly fast afterwards.

I'm not endorsing assigning UUIDs to commits now at all (but I don't
have time to formulate a comprehensive argument against that either).

However, having a commit -> nonessential_volatile_metadata database
would be useful for many other things as well! For example amending
commit messages later, maintaining general linkage between related
commits, tracking explicit rename hints for Git (like the Samba guys
would appreciate right now, and me many times in the past - note that
this is NOT the same as directly tricking renames within Git history)
or caching expensive computations with mostly static results (like the
rename detection or maybe pickaxe indexes - that could be quite large,
so we might want to actually separate different kinds of data to
separate branches).

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
