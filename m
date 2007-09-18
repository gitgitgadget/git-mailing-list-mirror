From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 17:50:13 -0700
Message-ID: <20070918005013.GA6368@muzzle>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com> <11900461843997-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXRIE-00034V-OM
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbXIRAuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 20:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbXIRAuS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:50:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50344 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbXIRAuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:50:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 693BE7DC029;
	Mon, 17 Sep 2007 17:50:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <11900461843997-git-send-email-hjemli@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58514>

Lars Hjemli <hjemli@gmail.com> wrote:
> This option forces fast-forward merges to create a "true" merge commit,
> i.e. a commit with multiple parents.
> 
> Although a fast-forward merge would normally be the right thing to do with
> git branches, it is suboptimal when operating on git-svn branches since it
> makes 'git-svn dcommit' fail to recognize the correct upstream subversion
> branch. But performing such a merge with --no-ff specified will both make
> git-svn dcommit recognize the correct upstream and create the logically
> correct history in subversion (the merge performed in git will be recorded
> as a single revision in subversion, not as a series of revisions seemingly
> cherry-picked from the merged branch).
> 
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>

Would automatically enabling --no-ff when it detects merging of two (or
more) SVN branches be a good thing?  We can add scripting support to
git-svn for detecting if any given commit is really from SVN or not.
Then we could do something like this in git-merge

---------------------------- 8< --------------------------------
if git-svn test-svn-commits "$@"
then
	no_ff=t
	no_fast_forward_strategies=$all_strategies
fi
---------------------------- 8< --------------------------------

It'd probably prevent a lot of users from shooting themselves in the
foot if they forget to read or learn about the --no-ff option.

> ---
> 
> When updating git-svn.txt, I noticed that we might want to update the 
> section "DESIGN PHILOSOPHY". Eric?

Yeah.  That's very much out of date.  I'll update it in a bit.

-- 
Eric Wong
