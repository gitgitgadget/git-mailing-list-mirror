From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Deb Packaging fixes: Build against Mozilla libs for Debian, conflict with "git"
Date: Mon, 25 Jul 2005 00:27:45 -0400
Message-ID: <20050725042745.GA6098@mythryan2.michonline.com>
References: <20050723073707.GA3255@mythryan2.michonline.com> <20050723192335.GA24071@mythryan2.michonline.com> <20050723192632.GB24071@mythryan2.michonline.com> <200507240728.40158.snake@penza-gsm.ru> <7vwtngg2bd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexey Nezhdanov <snake@penza-gsm.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 06:28:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwuZK-0004h7-GJ
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 06:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVGYE1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 00:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVGYE1x
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 00:27:53 -0400
Received: from mail.autoweb.net ([198.172.237.26]:48331 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261670AbVGYE1w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 00:27:52 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwuZ7-0001TN-TW; Mon, 25 Jul 2005 00:27:45 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dwuhn-00058n-00; Mon, 25 Jul 2005 00:36:43 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwuZ7-0006Gb-5r; Mon, 25 Jul 2005 00:27:45 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtngg2bd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2005 at 11:12:22PM -0700, Junio C Hamano wrote:
> Alexey Nezhdanov <snake@penza-gsm.ru> writes:
> 
> > Satturday, 23 July 2005 23:26 Ryan Anderson wrote:
> >> -Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
> >> +Depends: ${misc:Depends}, patch, diff, rsync, rcs, ssh
> > Did I missed something or you forgot about libcurl3 dependency?
> 
> I think you are right.  In the build process, dh_shlibdeps is
> used and shlib:Depends is created to include the libcurl3 (among
> other things) in debian/git-core.substvars, but it is not
> actually used in the resulting binary package because the line
> misses ${shlibs:Depends} there.
> 
> Ryan, would this change be enough?  I do not know what I am
> doing (${misc:Depends} is new to me), but this patch seems to
> fix it on my box.

Yes - this looks like the right idea - but you're missing a comma
between the two variables.  (That will cause the *entire* depends line
to get dropped, btw.)

I changed it from shlibs:Depends to misc:Depends because I saw something
when I was tracking down exactly what I needed to put into debian/compat
(in fact, man debhelper, then search for "compat" and look under V4),
but I misread "supplements" to be something else. 

So, Acked-By: me, if you put the comma in. :)



> ------------
> Make sure binary debian package depends on shlibs it uses.
> 
> The "Depends:" line in debian/control lacked ${shlibs:Depends},
> which caused the resulting binary package not to depend on
> libcurl3 nor even libc6 ;-).
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
> # - linus: Fix up applymbox script for the addition of "git-" prefix
> # + (working tree)
> diff --git a/debian/control b/debian/control
> --- a/debian/control
> +++ b/debian/control
> @@ -7,7 +7,7 @@ Standards-Version: 3.6.1
>  
>  Package: git-core
>  Architecture: any
> -Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
> +Depends: ${shlibs:Depends} ${misc:Depends}, shellutils, diff, rsync, rcs
>  Description: The git content addressable filesystem
>   GIT comes in two layers. The bottom layer is merely an extremely fast
>   and flexible filesystem-based database designed to store directory trees
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Ryan Anderson
  sometimes Pug Majere
