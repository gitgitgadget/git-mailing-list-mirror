From: David Aguilar <davvid@gmail.com>
Subject: Resurrecting an old git-stash discussion
Date: Sun, 3 May 2009 18:35:55 -0700
Message-ID: <20090504013554.GE50640@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, nanako3@lavabit.com, kevinlsk@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 03:38:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0n8p-0001av-V9
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 03:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbZEDBgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 21:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbZEDBgD
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 21:36:03 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:36285 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbZEDBgB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 21:36:01 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1939328wah.21
        for <git@vger.kernel.org>; Sun, 03 May 2009 18:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=KQT4Q60GGa9LQv3PUISupaH6vfml8SCZ+x+9gifc/lA=;
        b=tUEiqj4tsuTUZ3rQ91ng/iRdksGYrGRirBQXvMCqhAY3oVOUrsrSQOoL7gkvnkG6rl
         FnbDEcqJjlf+9qzXQVhk5JiE4S5W0RmO9XMol3TRhNjndmQ6YK1gSy3ZTtZncKKgksDd
         1mIolECCdCT/CSpADNQl7neWZRre1wLTCpykA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=S+gVV2Z2NRZ9+LD7jHiCTRhjtpeEZDZ1hCQd3z1SUt8RKuSLPEoO/leFlON0ICmkCe
         S10LchJkLxpnn6xfgjXU1WStlTC7zx3U5V/SSfietXCZxFiMwVH0WMaQ5fZnIXUB6cFR
         j+nK1+bt0P5bn5x+jUR00bTUevWePvFnCAEbw=
Received: by 10.114.211.17 with SMTP id j17mr4026475wag.61.1241400959789;
        Sun, 03 May 2009 18:35:59 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m30sm9089938wag.18.2009.05.03.18.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 18:35:59 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118200>

A long time ago there was a patch that made git-stash
configurable:

http://lists.zerezo.com/git/msg641406.html


Junio's conclusion at the time was:

"The decision here is that I am open to a change that
implements the one-time safety instruction."

http://lists.zerezo.com/git/msg641442.html

Would this be something worth implementing after this
release cycle?

If so, would this be the basic logic?:


If stash.quick is undefined:
- Alert the user to what's going on
- Ask them whether they'd like to enable the quick behavior,
  or exit (thus leaving stash.quick undefined).

Valid values for stash.quick are then either undefined
or 'save'.

Is it still a good idea to implement the one-time
safety instruction?

I just thought I'd ask.  Why?
A co-worker ran into this funny situation last week:

	git branch
	git stash  # oops, didn't mean that

	git stash help # prints usage, though only by luck
	git branch help # oops, didn't mean that

There's a limit to guarding against the uneducated and by no
means do I think the 2nd "oops"'s behavior should be changed.
With the proposed change we would've warned him at the first
"oops", and that's better than nothing.

The above is a silly example despite the fact that it
actually happened.  'rm help' happily removes your 'help'
file.  I just figured I'd mention it since maybe instead of
printing usage stash should also warn:

	Error: unknown command 'help'.
	Run 'git help stash' for more information.


Regarding the 'first time warning' thing:

  97bc00a: Emit helpful status for accidental "git stash" save

..seems like it already addressed the issue by telling
users how to apply the stash.  That makes the case for
the first-time-warning much less compelling.

Hmm.. maybe I just answered my own question ;)


The "unknown command 'help'" thing might be good nonetheless,
though.


-- 
		David
