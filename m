From: Junio C Hamano <junkio@cox.net>
Subject: Re: new file leaked onto release branch
Date: Wed, 14 Dec 2005 16:37:15 -0800
Message-ID: <7v7ja7ures.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056B8748@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.63.0512150034120.8992@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 01:39:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emh7o-0003JT-Tg
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 01:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVLOAhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 19:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVLOAhU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 19:37:20 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:54671 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030260AbVLOAhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 19:37:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215003630.SPBC20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 19:36:30 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13664>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So, it could have been
>
> 	git pull . 5165
>
> which mistakes 5165 for a short SHA1?

I do not think git-pull would work on arbitrary SHA1
expressions, so you should be safe.

Interestingly...

        $ git rev-parse 5165
        error: short SHA1 5165 is ambiguous.
        5165

that short SHA1 is ambiguous.  But a branch name immediately
under .git/refs/heads takes precedence:

        $ git branch 5165 master
        $ git rev-parse 5165 master
        acd9b7b4e08a3f0f48afa922d8e371414cf2d3b2
        acd9b7b4e08a3f0f48afa922d8e371414cf2d3b2

And this makes it safer and unambiguous:

        $ git branch -d 5165
        Deleted branch 5165.
        $ git branch bug/5165 master
        $ git rev-parse bug/5165
        acd9b7b4e08a3f0f48afa922d8e371414cf2d3b2

We might want to detect collisions between SHA1 prefix and
branch names, but I am not sure if it is worth it in practice.
