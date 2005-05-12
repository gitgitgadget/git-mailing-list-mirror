From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Adapting scripts to work in current (not top) directory
Date: Thu, 12 May 2005 22:12:15 +0200
Message-ID: <20050512201215.GI324@pasky.ji.cz>
References: <200505121758.10971.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 22:06:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJvl-0003bl-Sp
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVELUMl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVELUMl
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 16:12:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25306 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262076AbVELUMS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 16:12:18 -0400
Received: (qmail 16444 invoked by uid 2001); 12 May 2005 20:12:15 -0000
To: Alexey Nezhdanov <snake@penza-gsm.ru>
Content-Disposition: inline
In-Reply-To: <200505121758.10971.snake@penza-gsm.ru>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 03:58:10PM CEST, I got a letter
where Alexey Nezhdanov <snake@penza-gsm.ru> told me that...
> All git and cogito scripts wants .git subdirectory. If I'm in a subdirectory 
> that have no .git direcory in it I'm out of luck.

This is fine for Cogito, but Git itself shouldn't care - unless you mean
the bundled mini-plumbing scripts. I don't know if anyone (and who) uses
them except Linus, but I'm not likely to make much effort to maintain
them, or even to actually accept any non-trivial changes to them.

> I have wrote an example script that determines the lowest possible .git 
> directory position and changes to it to satisfy user request.
> 
> Problems with script:
> 1) May be I misunderstood the git ideology and it needs not this at all.

Cogito really needs it.

> if point (1) is false then there are couple of other problems:
> 2) Script is extremelly ugly. I'm a week bash programmer so please criticize.
> 3) This logic shold be somehow embedded to all git- and cg- scripts. I can not 
> figure how to do it non-intruisively.

Add it to cg-Xlib. You can just update $_git appropriately. (Except when
you were explicitly passed GIT_DIR.)

> gitpath=
> subpath=
> curpath=`pwd`
> for ((i=2;i<9999;i=i+1)) ; do {
>         path1=`echo $curpath | cut -d / -f 0-$i`
>         path2=`echo $curpath | cut -d / -f $((i+1))-`
>         [ -d "$path1"/.git ] && gitpath=$path1 && subpath=$path2
>         [ "$path1" == "$curpath" ] && break
> }; done

I would gradually trim the $curpath by $(dirname) until I hit
$curpath/.git or the root directory.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
