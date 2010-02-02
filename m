From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and subversion revprops
Date: Tue, 2 Feb 2010 01:38:48 -0800
Message-ID: <20100202093848.GB28437@dcvr.yhbt.net>
References: <19301.27607.993690.703245@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 10:38:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcFDj-00078M-3Z
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 10:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722Ab0BBJit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 04:38:49 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53844 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508Ab0BBJis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 04:38:48 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECC81F488;
	Tue,  2 Feb 2010 09:38:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <19301.27607.993690.703245@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138706>

Eli Barzilay <eli@barzilay.org> wrote:
> [This is possible an RTFM -- but as much as I've been digging around,
> I couldn't find anything about it.]
> 
> I'm trying to play with git-svn in a project that uses subversion, and
> there's one feature that I'd like to have -- make git-svn specify some
> revision properties (eg, the `--with-revprop' to `svn commit') that
> will identify it as coming from git-svn.

Hi, there's currently no way to commit revprops to svn with git svn.

> The thing is that we have a continuous build server that runs a
> complete build (and runs all tests) for every revision -- and I'm
> trying to figure out a way to make it skip intermediate commits that
> come from a git-svn.  The simplest way to do that would be a way to
> mark all git-svn revisions somehow, and I can later unmark the last
> one in the chain so only that one will get built and tested.  It would
> be even more convenient if I have a way to control the revprops on the
> last commit separately, so there's no additional step involved.
> 
> The only other alternative that I see is some wrapper around git-svn
> that connects to some script that will run on the server before and
> after dcommitting changes, and that script will do the necessary work.
> Is there a way to specify hook scripts to run around a dcommit?

No, there are no hooks currently run directly by git svn.  dcommit uses
git-rebase internally, so git-rebase can run the pre-rebase hook (never
tried it myself, though).

> Actually, such hooks can also be used to lock the svn reposity while
> git-svn is working -- I couldn't figure out what happens when there's
> some commit that comes in while git-svn is running.  My guess is
> that it'll either get stuck and throw an error, or maybe try to
> continue if possible.  Such hooks could make that part more robust, as
> well as guarantee that each batch of svn-git commits are always
> together.

Could be useful in some cases.  I've never actually seen any project use
SVN locks, though, and had completely forgotten about them until now...

-- 
Eric Wong
