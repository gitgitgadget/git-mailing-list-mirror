From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn of both trunk and tags while having no access to the
	'parent' of those
Date: Fri, 20 Nov 2009 12:47:23 -0800
Message-ID: <20091120204723.GB30423@dcvr.yhbt.net>
References: <20091117025945.GE17964@onerussian.com> <4B03B7D3.8050905@drmicha.warpmail.net> <20091118133205.GB17964@onerussian.com> <4B03FD29.3090001@drmicha.warpmail.net> <20091118142332.GC17964@onerussian.com> <4B040D95.9040901@drmicha.warpmail.net> <20091119095307.GA30423@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:47:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBaOB-0000Ff-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 21:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbZKTUrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 15:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbZKTUrR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 15:47:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36681 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002AbZKTUrR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 15:47:17 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657EF1F681;
	Fri, 20 Nov 2009 20:47:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091119095307.GA30423@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133376>

Eric Wong <normalperson@yhbt.net> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
> > I tried also with two svn sections to circumvent this:
> > 
> > [svn-remote "svn"]
> >         url = http://domain.com:/project/trunk
> >         fetch = :refs/remotes/trunk
> > [svn-remote "svnr"]
> >         url = http://domain.com:/project/releases
> >         tags = /*:refs/remotes/tags/*

Hi Yaroslav,

Weird, I'm a bit confused by this myself but I'm out of time
at the moment, but swapping '[svn-remote "svn"]' and "[svn-remote "svnr"]"
seems to work, so there's apparently a bug in our handling of
svn-remote != "svn" somewhere...

So the following config should work:

[svn-remote "svnt"]
        url = http://domain.com:/project/trunk
        fetch = :refs/remotes/trunk
[svn-remote "svn"]
        url = http://domain.com:/project/releases
        tags = /*:refs/remotes/tags/*

You should probably run "git svn fetch -R svnt" before running
"git svn fetch" to pick up the tagged releases.

-- 
Eric Wong
