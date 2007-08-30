From: Bart Trojanowski <bart@jukie.net>
Subject: Re: publishing a forked^W cloned directory with ancestry
Date: Thu, 30 Aug 2007 16:27:47 -0400
Message-ID: <20070830202747.GT10772@jukie.net>
References: <20070830192533.GA18751@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	mdadm development team 
	<pkg-mdadm-devel@lists.alioth.debian.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 22:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQqcg-0003jE-KU
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 22:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbXH3U2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 16:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbXH3U2K
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 16:28:10 -0400
Received: from tachyon.jukie.net ([205.150.199.214]:57549 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751603AbXH3U2J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 16:28:09 -0400
Received: from tau.jukie.net ([10.10.10.211]:57356)
	by jukie.net with esmtp (Exim 4.50)
	id 1IQqcK-0002b7-F4; Thu, 30 Aug 2007 16:27:52 -0400
Received: by tau.jukie.net (Postfix, from userid 1000)
	id C425BA74ABF; Thu, 30 Aug 2007 16:27:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070830192533.GA18751@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57066>

* martin f krafft <madduck@madduck.net> [070830 15:25]:
> [1] I tried cloning B from A, then cloning C from B. Within C, there
>     is no reference to A's master branch, so unless B pulled changes
>     from A and C pulled changes from B, C could not be updated.

I think a .git/config like this will do what you want:

[remote "upstream"]
        url = git://mdadm-upstream-repo
        fetch = +refs/heads/*:refs/remotes/upstream/*

[remote "debian"]
        url = git://debian-repo-you-want-to-publish-to
        fetch = +refs/heads/*:refs/remotes/debian/*
        push = refs/remotes/upstream/master:refs/heads/upstream
        push = refs/heads/master:refs/heads/master

Now when you 'git push debian' it will populate the 'upstream' and
'master' branches properly.

When someone clones your repo, they will get origin/master (your branch)
and origin/upstream (the official mdadm branch).

Did I understand the problem correctly?

-Bart

-- 
				WebSig: http://www.jukie.net/~bart/sig/
