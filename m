From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn breakage on repository rename
Date: Sat, 5 Dec 2009 14:22:51 -0800
Message-ID: <20091205222251.GA2120@dcvr.yhbt.net>
References: <4B197078.6050203@cosent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, George Kuk <George.Kuk@nottingham.ac.uk>
To: Guido Stevens <guido.stevens@cosent.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 23:22:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH31l-0004iE-Bn
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 23:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbZLEWWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 17:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbZLEWWp
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 17:22:45 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58546 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591AbZLEWWo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 17:22:44 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A58296845;
	Sat,  5 Dec 2009 22:22:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4B197078.6050203@cosent.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134629>

Guido Stevens <guido.stevens@cosent.net> wrote:
> Hi Eric e.a.,
>
> I have a weird git-svn corner case that might interest you (or not at  
> all). I'd appreciate any help or hints for moving beyond this problem.
>
> I'm using git-svn to do a full commit history analysis of the Zope +  
> Plone CMS code bases as part of a research project with the University  
> of Nottingham into open source knowledge dynamics.
>
> One of the repositories I'm importing breaks with a "Checksum mismatch",  
> indicating a corruption. However, this error message occurs exactly at  
> the point where the repository was renamed: from "Products.CMFPlone" to  
> "Plone" (22715->22716). (Yes, it's the Plone core itself that resists  
> analysis :-()
>
> The git-svn url for the later commits would be:
>   http://svn-mirror.plone.org/svn/plone/Plone/trunk
>
> Whereas an older part of the code base lives at:
>   http://svn-mirror.plone.org/svn/plone/Products.CMFPlone/trunk
>
> Funny thing is, git-svn detects this rename upfront but then breaks
> anyway. Which raises the questions:
>
> - is this breakage caused by the rename?

Hi Guido,

Yes.  By default, git svn without --stdlayout does not attempt
to determine a repository root so parent following can be done.
On the other hand, Plone does appear to use a standard SVN layout.

> - or does git-svn handle the rename, and there is an actual corruption?

It should, let me know if the example I give below doesn't work

It looks like a big repo and they're worried about bandwidth:
"Do not make a checkout of the entire repository! This is likely to
  get you blacklisted."
(ref: http://dev.plone.org/plone/wiki/RepoInfo)

> - is there any way I can work around this and get a valid or semi-valid
> git history for this project?
>
> I don't mind missing a few commits, since I'm not doing code development
> on this repository, only statistical analysis.

I would mind very much if git svn missed commits :>

> Solving this would also be helpful for anyone who wants to work on Plone  
> development through git rather than through raw svn.
>
> :*CU#
>
> ----------------------------------------------------
> To reconstruct this error:
> ----------------------------------------------------
>
> $ git svn init https://svn-mirror.plone.org/svn/plone/Plone/trunk Plone
> $ cd Plone
> $ git svn fetch

Since Plone appears to use a standard trunk/branches/tags layout
recommended by SVN developers, can you try this instead?:

  git svn clone -s http://svn-mirror.plone.org/svn/plone/Plone

If you don't care about branches/tags at all, you can also try

  git svn clone --no-follow-parent \
    https://svn-mirror.plone.org/svn/plone/Plone/trunk Plone


Also, in the future it'd be nice to know which version of git svn
you're using since bugs may be fixed in a newer version.  Thanks!

-- 
Eric Wong
