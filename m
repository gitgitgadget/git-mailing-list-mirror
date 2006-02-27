From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and working with tags
Date: Sun, 26 Feb 2006 16:07:37 -0800
Message-ID: <20060227000737.GA9518@hand.yhbt.net>
References: <4401933B.2070109@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 01:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDVvU-0000LO-Qe
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 01:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWB0AHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 19:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWB0AHl
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 19:07:41 -0500
Received: from hand.yhbt.net ([66.150.188.102]:5288 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751445AbWB0AHl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 19:07:41 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 114C07DC005; Sun, 26 Feb 2006 16:07:37 -0800 (PST)
To: Nicolas Vilz 'niv' <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <4401933B.2070109@iaglans.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16809>

Nicolas Vilz 'niv' <niv@iaglans.de> wrote:
> Hi guys,
> 
> I am about to use a git/svn construct for a project next week to track
> my work and the work of my co-workers.
> 
> Reason for this is, that all the others are working on windows-boxes and
> I am the lonesome gunman, who wants to work with git on a linux box
> contributing the others on svn side.
> 
> There is still a lot of work todo, preparing both backends, git and svn,
> for serving almost the same content structure.
> 
> I think, i can do a little scripting to switch my git-SVN-HEAD to
> another branch. But how am i intended to export tags to svn?
> 
> tags should simply go to <repos>/tags/<tagname>
> branches go to <repos>/branches/<branchname>
> master goes to <repos>/trunk
> 
> A svn-import should be no problem then. The re-exporting back to one
> branch or svn_path is described in git-svn howto. but how about tags?
> 
> do i have to consider the tags on svn-side manually?

You'll need to do tags on the svn-side manually.  git-svn (by-design)
has hardly any notion of SVN tags (they're really just branches
designated as read-only).  git-svn also fails to track directory copies
[1], so using git-svn to track a higher-level directory and performing a
copy in git and doing git-svn commit may not work so well.

You can make something that parses a git commit that was imported in
git-svn-HEAD.  These imported commits have a 'git-svn-id:' line at the
end that can be parsed for URL and revision number, so you could make it
frontend 'svn cp' pretty easily.

[1]: git-diff-* doesn't notice copied/renamed directories.  I'm
actually very thankful for this as it's very prone to bugs in my
experience.

-- 
Eric Wong
