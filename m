From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn dcommits messages not in UTF-8 charset to mod_dav_svn?
Date: Thu, 28 May 2009 01:08:41 -0700
Message-ID: <20090528080706.GA9239@dcvr.yhbt.net>
References: <op.uuljhmmg1e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, users@subversion.tigris.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 28 10:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9afY-0001Bd-A1
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 10:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbZE1IIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 04:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbZE1IIn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 04:08:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:32816 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780AbZE1IIl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 04:08:41 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id BFE0E1F586;
	Thu, 28 May 2009 08:08:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <op.uuljhmmg1e62zd@balu.cs.uni-paderborn.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120169>

Matthias Andree <matthias.andree@gmx.de> wrote:
> Greetings,
>
> I had tried to use git cvsimport and git svn to transfer a CVS repository 
> (I have access to it) to an SVN repository (where I don't have access to  
> the repo, so I cannot use cvs2svn or similar).
>
> The problem is that the CVS repo had non-UTF-8 commit log messages, and I 
> didn't bother to convert them to UTF-8. However, SVN insists on encoding  
> filenames and log messages in UTF-8.
>
> "git svn dcommit" (which uses the SVN Perl bindings under the hood)  
> happily committed such a non-UTF-8 message and br0ke the repo. The actual 
> reason is that the SVN server (https://...) is now wedged, as in:

> While mod_dav_svn arguably shouldn't accept b0rked messages, git-svn  
> shouldn't attempt to commit them either. It seems that the svn command  
> line utilities validate the message format by themselves, and apparently  
> the svn server module (likely mod_dav_svn - or are there others?) does 
> not.

This was partially fixed in commit
16fc08e2d86dad152194829d21bc55b2ef0c8fb1.  You just need to manually
specify the i18n.commitencoding in your .git/config

> So, could
> a) git-svn be modified to refuse dcommiting non-UTF-8 messages?

On the way is a patch that makes git-svn refuse to dcommit messages
that are malformed UTF-8 and tell the user about i18n.commitencoding.

Thanks for reminding me

-- 
Eric Wong
