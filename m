From: Petr Baudis <pasky@suse.cz>
Subject: Re: [BUG] gitweb on repo.or.cz shows buggy commitdiff
Date: Sat, 25 Aug 2007 22:25:30 +0200
Message-ID: <20070825202530.GB1219@pasky.or.cz>
References: <20070729094645.GU23229@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 25 22:25:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP2CQ-0006bn-Ur
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 22:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934351AbXHYUZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934186AbXHYUZf
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 16:25:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53978 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934349AbXHYUZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 16:25:35 -0400
Received: (qmail 21981 invoked by uid 2001); 25 Aug 2007 22:25:30 +0200
Content-Disposition: inline
In-Reply-To: <20070729094645.GU23229@nan92-1-81-57-214-146.fbx.proxad.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56649>

On Sun, Jul 29, 2007 at 11:46:45AM CEST, Yann Dirson wrote:
> Looking at [1] one can see that the diff, instead of showing the
> changes to the various .gitignore files touched by the commit,
> displays again and again the data/.gitignore one, but even confuses a
> Makefile modified by the commit for the .gitignore file to diff.
> 
> 
> |diff --git a/data/pics/.gitignore b/data/pics/.gitignore
> |index c5ec666af7db2d53e7ed86090c88f62ab8ec25a4..912bca74cbee222936f08e421230fd9dde903ecb 100644 (file)
> |--- a/lua/Makefile
> |+++ b/data/pics/.gitignore
> 
> Also, despite "+++ b/data/pics/.gitignore" being displayed in the diff
> header, it is indeed showing the diffs to "b/lua/Makefile".
> 
> 
> [1] http://repo.or.cz/w/tagua/ydirson.git?a=commitdiff;h=1f285b312fa526293164548d88e8403dfb354eb4

Looks funny. This is because the target object id of all the patches is
the same as all the .gitignore files are identical, and this triggers
"split patch detection" - I guess that triggers when diff thinks that a
file was replaced, and injects full deletion and full creation diff
inside. Due to this trigger, file diffs and raw diff records get out of
sync and that results in Makefile diff misattribution.

Jakub, any idea how to fix this? Maybe to check if filename matches
either from_file or to_file? But that would probably need a bit of code
refactoring in git_patchset_body(), which is something I'm not really
into. :-)

-- 
				Petr "Pasky" Baudis
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
