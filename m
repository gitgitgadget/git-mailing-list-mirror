From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git SVN Rebranching Issue
Date: Tue, 4 Nov 2008 00:41:11 -0800
Message-ID: <20081104084111.GB14405@untitled>
References: <20081103140746.GA5969@mars.cyantechnology.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kern <matt.kern@undue.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:42:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxHUZ-0000Ry-15
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbYKDIlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYKDIlM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:41:12 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35020 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbYKDIlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:41:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 638332DC01B;
	Tue,  4 Nov 2008 08:41:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081103140746.GA5969@mars.cyantechnology.local>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100058>

Matt Kern <matt.kern@undue.org> wrote:
> I have a git-svn issue which keeps biting me.
> 
> My company uses svn as its primary version control system.  We
> frequently create branches, e.g. /branches/somebranch, by forking the
> trunk to ensure stability over the "somebranch" code.  The problem is
> that we also frequently blow away /branches/somebranch and refork it
> from the trunk.
> 
> git-svn does a good job for most work, but I notice that if you delete
> the "somebranch" branch in svn and then refork it, also in svn, then
> when you git-svn fetch, the git commit at the head of remotes/somebranch
> will have two parents: the first is the previous head of
> remotes/somebranch, and the second is the head of remotes/trunk.  Surely
> only the remotes/trunk parent should be listed?  Any connection with the
> previous remotes/somebranch is an accident of naming.  The real problem
> then comes when you come to look at the history in gitk.  If
> "somebranch" is rebranched many times, the git history starts looking
> pretty complicated, when in fact it should simply be the linear history
> of remotes/trunk up to the branch point followed by a few,
> branch-specific commits.  Is there any way to prevent (or modify) the
> git history to remove the errant parent?

Hi Matt,

Short answer: you can use grafts to remove parents.


It was actually an intentional design decision on my part preserve
parents based on branch name.  We would eventually otherwise lose
history of the now-deleted branches, as reflogs can expire.

To me, it's easier to drop history connections you don't want with
grafts than to recover it by refetching.

-- 
Eric Wong
