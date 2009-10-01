From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn's performance on cloning mono's branches/tags...
Date: Thu, 1 Oct 2009 00:17:26 -0700
Message-ID: <20091001071726.GA11370@dcvr.yhbt.net>
References: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com> <4A445959.6090403@op5.se> <3ace41890906260259o3be005fq6be9d0e2c3f9af66@mail.gmail.com> <4A44A9A9.6030008@op5.se> <3ace41890906260644t3eddb2d2sb4ddbcb6499801@mail.gmail.com> <3ace41890906261817y523c9321xd621fb3130941d91@mail.gmail.com> <3ace41890906272008t96bfb04q7218e95055897900@mail.gmail.com> <20090702081615.GB11119@dcvr.yhbt.net> <3ace41890909301504w633323b9ybec1f42c1c169225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Hin-Tak Leung <hintak.leung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 09:17:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtFuy-0008Te-4u
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 09:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbZJAHR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 03:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbZJAHRZ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 03:17:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52386 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbZJAHRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 03:17:25 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id A05541F78F;
	Thu,  1 Oct 2009 07:17:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <3ace41890909301504w633323b9ybec1f42c1c169225@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129377>

Hin-Tak Leung <hintak.leung@gmail.com> wrote:
> Hmm, I am having another problem with git-svn going back and download
> everything over and over with this:
> 
> git svn clone -s https://ndiswrapper.svn.sourceforge.net/svnroot/ndiswrapper
> 
> I am going to do two-step init -s then fetch --all now to see if it helps.
> 
> (it is probably not entirely standard layout with the extra CVSROOT?)

Hi,

The ndiswrapper layout looks to be *almost* standard, the CVSROOT can
probably safely be ignored, and you should be able to _mostly_ track it
with the following config:

[svn-remote "svn"]
        url = https://ndiswrapper.svn.sourceforge.net/svnroot/ndiswrapper
        fetch = trunk/ndiswrapper:refs/remotes/trunk
        branches = branches/*/ndiswrapper:refs/remotes/*
        tags = tags/*/ndiswrapper:refs/remotes/tags/*

Notice how the glob can appear in the middle of the branches and tags
configs on the remote side: foo/*/bar

Unfortunately, some of the tags seem to be inconsistently tagged and
some had tags/TAGNAME/README whereas others had
tags/TAGNAME/ndiswrapper/README (I'm using "README" to designate where
the logical top-level working directory would be).

"svn log -v https://ndiswrapper.svn.sourceforge.net/svnroot/ndiswrapper/tags"
should help find the ones that are tagged at the wrong depth:

VERSION_1_24 for example:

	fetch = tags/VERSION_1_24:refs/remotes/tags/VERSION_1_24

-- 
Eric Wong
