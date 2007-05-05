From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Initial support for cloning submodules
Date: Sat, 05 May 2007 10:14:04 +0200
Message-ID: <20070505081404.GR955MdfPADPa@greensroom.kotnet.org>
References: <11782762032207-git-send-email-skimo@liacs.nl>
 <7vfy6cqk0w.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 10:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkFPC-0000iw-7p
	for gcvg-git@gmane.org; Sat, 05 May 2007 10:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbXEEIOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 04:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbXEEIOJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 04:14:09 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:42449 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541AbXEEIOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 04:14:06 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JHK0061Q6VHXS@smtp15.wxs.nl> for git@vger.kernel.org; Sat,
 05 May 2007 10:14:05 +0200 (CEST)
Received: (qmail 20967 invoked by uid 500); Sat, 05 May 2007 08:14:04 +0000
In-reply-to: <7vfy6cqk0w.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46252>

On Fri, May 04, 2007 at 03:52:15PM -0700, Junio C Hamano wrote:
> I do not like the Porcelain part very much, though.  I do not
> think we would want to add anything new to git-clone.  We should
> lose as much code from git-clone that is common with git-fetch
> as we can first, and add new features to git-fetch, with
> possibly passthru options added to git-clone as needed (e.g. a
> new --submodule option).

So what would you want to keep in git-clone ?

> If you --submodule cloned a remote repository when it had two
> submodules, and then later the remote adds another submodule,
> you would need to have a way to fetch that can discover the
> presense of the new submodule and add it for you, and at that
> point, having the code that knows much about submodules in clone
> would not help you much.

True.

>  (3) "git-fetch --submodules", after finishing what it would do
>      without "--submodules" option, would inspect the fetched
>      tree (or the index derived from it), find the tree entries
>      with mode 160000 (i.e. submodule graft points), and _then_
>      uses the pathnames of these tree entries to consult the
>      config mechanism to see which URL(s) can be used to
>      retrieve them, probably only for new submodules.

Would git-fetch then call git-clone for these new submodules?

> Having a generic program and protocol to
> dump the whole configuration file is certainly simpler, easier
> to debug, and easier to repurpose, it makes me somewhat worried
> about security implications (if it is open to http then worrying
> about it is not very useful, though).

We could easily have dump-config only dump a predefined "known safe"
set of config options, although that would mean you have to upgrade
the server side each time you add a new dumpable config option.
Or we could do the preselection only when called from git-daemon.

skimo
