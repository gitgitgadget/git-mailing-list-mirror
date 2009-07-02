From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn's performance on cloning mono's branches/tags...
Date: Thu, 2 Jul 2009 01:16:15 -0700
Message-ID: <20090702081615.GB11119@dcvr.yhbt.net>
References: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com> <4A445959.6090403@op5.se> <3ace41890906260259o3be005fq6be9d0e2c3f9af66@mail.gmail.com> <4A44A9A9.6030008@op5.se> <3ace41890906260644t3eddb2d2sb4ddbcb6499801@mail.gmail.com> <3ace41890906261817y523c9321xd621fb3130941d91@mail.gmail.com> <3ace41890906272008t96bfb04q7218e95055897900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 10:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMHT2-0005zw-IM
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 10:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbZGBIQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 04:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbZGBIQP
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 04:16:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54862 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbZGBIQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 04:16:13 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id B5F471F78F;
	Thu,  2 Jul 2009 08:16:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <3ace41890906272008t96bfb04q7218e95055897900@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122628>

Hin-Tak Leung <hintak.leung@gmail.com> wrote:
> On Sat, Jun 27, 2009 at 2:17 AM, Hin-Tak Leung<hintak.leung@gmail.com> wrote:
> 
> > the tags, branches, url entries are effectively the same, I think - so
> > the main difference is using trunk instead of fetch.
> > Why does it make any difference? The example at the bottom of
> > git-svn's man page uses the trunk notation. Maybe it should be
> > changed?
> 
> To answer my question - I think the man page should be updated.

Somebody actually fixed it a while back:

commit 0e5e69a355b7bdd1af6ca33ac7ee35299bda368e
Author: Wesley J. Landaker <wjl@icecavern.net>
Date:   Wed Apr 1 16:05:01 2009 -0600

    Documentation: git-svn: fix trunk/fetch svn-remote key typo


As far as performance goes, SVN's flexibility of tagging and having
multiple subprojects interacts quite badly with git svn's --stdlayout
behavior.

With --stdoulayout, git svn supports tags/branches that are directly
descended from the top-level of trunk:

	svn cp $root/trunk $root/tags/0.1.0

However, it looks like mono does things like this:

	svn cp $root/trunk/mono $root/tags/mono-0.1.0

And when git svn sees that $root/tags/mono-0.1.0's parent is
$root/trunk/mono and not $root/trunk (which it's actually following),
it will try to fetch the complete history of $root/trunk/mono
($root/trunk may not contain all the history $root/trunk/mono contained,
either).

-- 
Eric Wong
