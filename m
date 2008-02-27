From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn messing with timezones
Date: Tue, 26 Feb 2008 23:32:44 -0800
Message-ID: <20080227073244.GB24316@soma>
References: <20080226124748.GH31792@mail.stoakes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Stoakes <tim@stoakes.net>
X-From: git-owner@vger.kernel.org Wed Feb 27 08:33:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUGnK-0003P3-Uh
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 08:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbYB0Hcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 02:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbYB0Hcr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 02:32:47 -0500
Received: from hand.yhbt.net ([66.150.188.102]:53270 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbYB0Hcq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 02:32:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E532D7F4153;
	Tue, 26 Feb 2008 23:32:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080226124748.GH31792@mail.stoakes.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75207>

Tim Stoakes <tim@stoakes.net> wrote:
> Hi all,
> 
> When I commit to git, the log shows the correct timezone:
>   Date:   Tue Feb 26 23:10:24 2008 +1030
> 
> However, when I then dcommit this to SVN with git-svn, the timezone gets
> mangled. If I now 'git log', the same commit shows
>   Date:   Tue Feb 26 12:40:24 2008 +0000
> 
> The 'svn log' of that same revision shows the correct timezone:
> r151 | foo | 2008-02-26 23:10:24 +1030 (Tue, 26 Feb 2008) | 2 lines
> so, I know it's git-svn doing it, not svn itself.
> 
> The same mangling has happened to commits that came through the original
> git-svn import, and subsequent 'git-svn rebase's.
> 
> I've tried things like:
> $ TZ=Australia/Adelaide git svn dcommit
> all end in the same result - UTC appears in the logs.
> 
> I'm using:
> git version 1.5.4.3
> 
> Can anyone help?

Hi Tim,

This is actually the intended behavior of git-svn.

SVN itself only stores times in UTC and nothing else.  The SVN
repository itself has no timezone information (unless the server it was
on is misconfigured :)

The regular svn client converts the UTC time to the local time (or
based on the TZ= environment).  Using "git svn log" should mimic the
timezone behavior of the regular svn client.

git-svn will only import times as UTC because that's what SVN
gives it.

As a side effect, this also makes it easier for multiple users to
independently create repositories that result in the same commit SHA1s
(and one of the reasons for using dcommit over git svn set-tree).

-- 
Eric Wong
