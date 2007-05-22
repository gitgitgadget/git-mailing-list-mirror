From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn or git problem...
Date: Tue, 22 May 2007 02:16:19 -0700
Message-ID: <20070522091619.GA17099@muzzle>
References: <86abvylihb.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 22 11:16:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqQTk-0000fv-Ex
	for gcvg-git@gmane.org; Tue, 22 May 2007 11:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbXEVJQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 05:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558AbXEVJQV
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 05:16:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38497 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001AbXEVJQU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 05:16:20 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 49D167DC0A5;
	Tue, 22 May 2007 02:16:19 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 22 May 2007 02:16:19 -0700
Content-Disposition: inline
In-Reply-To: <86abvylihb.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48087>

David Kastrup <dak@gnu.org> wrote:
> 
> Hi,
> 
> I have used git-svn for checking out the trunk of a large Subversion
> archive.  The .git subdirectory now sits in the /rep/texlive/trunk
> directory.
> 
> But I actually would now want to have the branches (which are pretty
> small in comparison) available in git as well, without checking the
> whole trunk out again.
 
> Is there a way to move the .git tracking one directory level upwards
> and get the branches into it as well, without checking out the trunk
> again (the trunk is several Gigabytes of size)?

If you're using a 1.5.1 or later version of git-svn, you can do so
pretty easily by editing your .git/config:

If you already have something like:

[svn-remote "svn"]
	# url here is the repository root, and 'mpc/trunk' in fetch
	# is the relative path within the repository
        url = https://svn.musicpd.org
        fetch = mpc/trunk:refs/remotes/git-svn

You can just add the following lines to the config in the above section:

        branches = mpc/branches/*:refs/remotes/*
        tags = mpc/tags/*:refs/remotes/tags/*


If you have something like:

[svn-remote "svn"]
	# url here is the full path of what you're tracking,
        url = https://svn.musicpd.org/mpc/trunk
        fetch = :refs/remotes/git-svn

Change it to something like in the first example (assuming you
have read permissions to the repository root).


If recompiling SVN is feasible for you and the branches (as a fresh
checkout) are as big as trunk, I highly recommend the do_switch patch
for SVN which lets you transfer only a delta between the branch/tag
point of trunk:

http://svn.haxx.se/dev/archive-2007-01/0936.shtml

-- 
Eric Wong
