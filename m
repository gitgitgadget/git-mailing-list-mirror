From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 10:21:04 -0800
Message-ID: <7vy83plqlr.fsf@assigned-by-dhcp.cox.net>
References: <1132034390.22207.18.camel@dv>
	<7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
	<1132042427.3512.50.camel@dv>
	<7vpsp2qpx4.fsf@assigned-by-dhcp.cox.net>
	<7vd5l2mco1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511151207070.21671@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051115121854.GV30496@pasky.or.cz> <1132074375.25640.47.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 20:32:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec6VJ-0000o2-HQ
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 20:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVKOT36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 14:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVKOT36
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 14:29:58 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:2962 "EHLO
	fed1rmmtai17.cox.net") by vger.kernel.org with ESMTP
	id S965022AbVKOT35 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 14:29:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115182008.LLPU26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 13:20:08 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1132074375.25640.47.camel@dv> (Pavel Roskin's message of "Tue,
	15 Nov 2005 12:06:15 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11937>

Pavel Roskin <proski@gnu.org> writes:

> On Tue, 2005-11-15 at 13:18 +0100, Petr Baudis wrote:
>>
>> I'm ambivalent here. I would like to have just a single behaviour here,
>> since the symbolic ref otherwise really does not get much testing. But I
>> can also understand that we are breaking tools here.
>> 
>> Still, for the reason above, I think we should aim at the symbolic refs
>> being the canonical format in the next major release after 1.0, giving
>> users time to fix their tools. I can see no advantage in symlinks except
>> the backwards compatibility...

The voice of reason comes from Pasky; I agree with this.

> I planned to write about symrefs long ago, and probably I waited for too
> long.  I still hope it will be the default for 1.0 release, but if not,
> I hope the next release won't be too far away.

I think it is a bit too late for that, but please keep that
patch; I'll hold on to it too.

>> > On the other hand, I think it would be useful to be able to configure the 
>> > behaviour via .git/config.
>> 
>> Yes, I would very much like to have this.

I am in favor of that.  Something like this, perhaps:

	core.filemode = 1 # trustworthy
        core.usesymlink = 0 # new style 

> Agreed.  By the way, the symref doesn't need to be called HEAD - it
> could be "trunk" or "main" or "default-branch".

Actually, I was thinking about changing get_sha1_basic() in
sha1_name.c so that refs immediately under ${GIT_DIR-.git} are
restricted to uppercase only.  The other day I did

	$ git-update-ref linus blah

which created .git/linus in addition to .git/refs/heads/linus;
this gives you considerable confusion.
