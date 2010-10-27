From: H Krishnan <hetchkay@gmail.com>
Subject: Re: svn repository URL and git
Date: Wed, 27 Oct 2010 16:15:22 +0000 (UTC)
Message-ID: <loom.20101027T180316-38@post.gmane.org>
References: <loom.20101027T170254-268@post.gmane.org> <4CC845EE.5040602@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 18:15:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB8f7-0003o8-To
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 18:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567Ab0J0QPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 12:15:34 -0400
Received: from lo.gmane.org ([80.91.229.12]:38404 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756330Ab0J0QPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 12:15:32 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PB8ex-0003kP-OS
	for git@vger.kernel.org; Wed, 27 Oct 2010 18:15:31 +0200
Received: from ABTS-mum-Dynamic-137.19.170.122.airtelbroadband.in ([ABTS-mum-Dynamic-137.19.170.122.airtelbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 18:15:31 +0200
Received: from hetchkay by ABTS-mum-Dynamic-137.19.170.122.airtelbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 18:15:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 122.170.19.137 (Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160096>


> 
> H Krishnan wrote:
> > Hi, 
> > We have started using git and git-svn. 
> > I was thrilled to see that two people cloning using "git svn clone" 
> > from the same repository got the same sha1 IDs for the commits which 
> > meant that each of us could sync with svn independently while still 
> > being able to share code among ourselves. 
> > But my excitement was shortlived as the sha1 IDs were different if we 
> > refer to the svn server using an alias. For example, using 
> > http://mysvnserver.mydomain.com/repos/myproject/trunk gave different 
> > sha1 IDs from using http://mysvnserver/repos/myproject/trunk even 
> > though both refer to the same repository. This also disallowed using 
> > mirrors of the repository for cloning. 
> > Apparently the sha1 ID is generated from the full path of the URL. 
> > Instead of this, could git-svn init be made to accept an optional 
> > "prefix" argument as well which is filtered out of the URL before 
> > building the sha1 ID. This will allow easy support for the oft 
> > requested support for "svn switch --relocate". How much of an effort 
> > is this? I don't know perl or git internals well enough for me to take 
> > a stab at it but I am willing to learn if someone can give me some 
> > pointers. 
> > Krishnan
> 
> The problem is the "git-svn-id" which is automatically appended to each
> commit done with git-svn. This ID consists of the URL and the UUID of
> the corresponding SVN repository. A different git-svn-id value results
> in a different commit SHA1 (i.e. a different commit to git).
> 
> I guess git-svn's --rewrite-root option might help here. Also, you have
> to make sure that your SVN repos have the same UUID (with svnadmin
> setuuid), of course.
> 
> -Mathias
> 

Thanks for your quick reply.

Could the git-svn-id also be based on only the suffix part of the URL? The 
prefix needs to be used only when connecting to the svn server and not 
otherwise. By default, the prefix is empty thereby getting back the current 
behavior.

I did try --rewrite-root but from what I understood of it, git-svn rebase will 
happen with the root I supply here and not from the local mirrors. We would like 
something like the following:

  users in place A  <--git-svn--> SVN mirror in place A
        ^                                 ^
        |                                 |
     git fetch/merge              some sort of rsync
        |                                 |
        v                                 v
  users in place B  <--git-svn--> SVN mirror in place B

Our corporate setup will not easily move to git but some sub-teams would like to 
use it for their work.

Regards,
Krishnan
