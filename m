From: Junio C Hamano <junkio@cox.net>
Subject: Re: dangling commits
Date: Sun, 15 Jan 2006 14:55:39 -0800
Message-ID: <7v8xth14pg.fsf@assigned-by-dhcp.cox.net>
References: <20060115221108.3ED2E352659@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 15 23:55:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyGmn-00015C-Ga
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 23:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWAOWzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 17:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWAOWzm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 17:55:42 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31944 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750957AbWAOWzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 17:55:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060115225332.YJLO26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 Jan 2006 17:53:32 -0500
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060115221108.3ED2E352659@atlas.denx.de> (Wolfgang Denk's
	message of "Sun, 15 Jan 2006 23:11:08 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14714>

Wolfgang Denk <wd@denx.de> writes:

> Is ther eany way to clean up such a situation and really get  rid  of
> the  dangling  commits?  I understand that I'd first need some way to
> "unpack" the packs, but how to do this? 

The easiest is to repack into a single big ball of wax:

	$ git repack -a -d

If you know the pack the stale object is in, you can move it out
of objects/pack/ and repack only that one.

	$ mv .git/objects/packs/pack-$badone.{idx,pack} .
	$ git unpack-objects <pack-$badone.pack
        $ git repack

After you are done:

	$ git prune
