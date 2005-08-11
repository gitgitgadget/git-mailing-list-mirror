From: Petr Baudis <pasky@suse.cz>
Subject: Re: A simple script to do the reverse of git-push
Date: Fri, 12 Aug 2005 00:18:12 +0200
Message-ID: <20050811221812.GG25280@pasky.ji.cz>
References: <Pine.LNX.4.63.0508082318400.2911@wgmdd8.biozentrum.uni-wuerzburg.de> <7vslxk125f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 00:19:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3LNP-0001nb-PO
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVHKWSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 18:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVHKWSN
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 18:18:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16650 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932490AbVHKWSN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 18:18:13 -0400
Received: (qmail 20617 invoked by uid 2001); 11 Aug 2005 22:18:12 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslxk125f.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Aug 09, 2005 at 12:42:36AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > BTW, if you are lazy, like me, you just pull from Junio once in a while 
> > and do a "make test". Turns out there is a missing dependency though:
> >
> > peek-remote.o: cache.h
> >
> > which in my case lead to a git-peek-remote program which was unable to 
> > peek any ref.
> 
> You are right.  Thanks for noticing.
> 
>     $ (make clean ; make ) >/dev/null 2>/dev/null
>     $ touch cache.h
>     $ make 2>&1 | grep peek-remote
>     cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' -o git-peek-remote peek-remote.o libgit.a -lz -lcrypto
> 
> I think recent "depend on object files" Makefile patch broke
> some things.

Indeed. I took care to make the new dependencies a superset of previous
situation when removing the explicit dependencies list, but before,
rebuilding of libgit.a caused rebuilt from source of all the commands,
which wouldn't happen anymore after adding the object files, which this
way sneakily removed an implicit dependency of the command sources on
$(LIB_H). Eek.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
