From: Ben Jackson <ben@ben.com>
Subject: Re: "git svn reset" only resets current branch ?
Date: Tue, 7 Jul 2009 11:21:11 -0700
Message-ID: <20090707182109.GA3158@kronos.home.ben.com>
References: <46974.10.0.0.1.1246953668.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, Ben Jackson <ben@ben.com>,
	git@vger.kernel.org
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 20:21:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOFIC-0008Rm-13
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 20:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbZGGSVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755638AbZGGSVQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 14:21:16 -0400
Received: from kronos.home.ben.com ([71.117.242.19]:50777 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbZGGSVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 14:21:16 -0400
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id n67ILBhN003638;
	Tue, 7 Jul 2009 11:21:11 -0700 (PDT)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id n67ILBRD003637;
	Tue, 7 Jul 2009 11:21:11 -0700 (PDT)
	(envelope-from bjj)
Content-Disposition: inline
In-Reply-To: <46974.10.0.0.1.1246953668.squirrel@intranet.linagora.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122856>

On Tue, Jul 07, 2009 at 10:01:08AM +0200, Yann Dirson wrote:
> 
> As an alternative, we could also allow "git svn reset" to take us back
> into the future to undo any such mistake without refetching.

You can't do that directly, since data is destroyed (specifically, the
rev_map is truncated back to the selected revision).  However, you can
"git reset" the branch back to where it was using the reflog, and then
the next git-svn command you run will rebuild the rev_map from the
comment metadata (obviously you're out of luck if you set "no_metadata").

It's possible that "git-svn reset" should be saving something like
ORIG_HEAD (comments welcome) but that does conflict with the idea of
adding "--all" or defaulting to "--all" behavior.

> I'm not sure it would be the best to keep reset act on a single branch,
> where eg. fetch acts on all branches, and already has a --all flag, which
> is not yet documented, and seems to have a different meaning (if that
> wasn't obvious, I have still not had a look at what it really does ;)

Right, I don't really grok the branch thing on the fetch side either.
I was hoping for guidance from people who use it on what the expected
behavior is.  I see even branch users are fuzzy.  ;-)

The one area where I can definitely see a potential problem is if you
reset/refetched one branch (and the revs actually changed, eg due to
permissions changes or --ignore-paths changes) and then did a merge.
On the other hand, the documentation already suggests you not try to
do SVN branch merges with git-svn.

-- 
Ben Jackson AD7GD
<ben@ben.com>
http://www.ben.com/
