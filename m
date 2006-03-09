From: Junio C Hamano <junkio@cox.net>
Subject: Re: fsck-object --standalone got errors
Date: Wed, 08 Mar 2006 19:17:18 -0800
Message-ID: <7v7j74fgsh.fsf@assigned-by-dhcp.cox.net>
References: <440F945C.2010401@brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 04:20:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHBeh-0007Rk-Lh
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 04:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWCIDRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 22:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWCIDRU
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 22:17:20 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:28873 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932334AbWCIDRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 22:17:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309031726.DRUU25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Mar 2006 22:17:26 -0500
To: Ming Lei <mlei@brocade.com>
In-Reply-To: <440F945C.2010401@brocade.com> (Ming Lei's message of "Wed, 08
	Mar 2006 18:35:08 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17396>

Ming Lei <mlei@brocade.com> writes:

> I have a repository created by GIT itself(not cognito, etc). It has
> branches called base, master and origin. When I did git-fsck-objects
> --full there is nothing shown, but when I did git-fsck-objects
> --standalone, it displayed following:

That is really an artifact from a distant past.  Please do not
worry about that error -- as long as --full does not see
anything long, there is nothing wrong with your repository.

The fsck-object command (back then it was called fsck-cache)
complained if objects referred to by files in .git/refs/ or
objects stored in files under .git/objects/??/ are not found as
stand-alone SHA1 files (i.e.  found in alternate object pools or
packed archives stored under .git/objects/pack).  Back then,
packs and alternates were curiosity and having everything as
loose objects were the norm.

When we adjusted the behaviour of fsck-cache to consider objects
found in packs are OK, we introduced the --standalone flag as a
backward compatibility measure.

It still correctly checks if your repository is complete and
consists only of loose objects, so in that sense it is doing the
"right" thing, but checking that is pointless these days.  We
probably should remove that flag.
