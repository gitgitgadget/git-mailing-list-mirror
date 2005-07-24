From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Deb Packaging fixes: Build against Mozilla libs for Debian, conflict with "git"
Date: Sat, 23 Jul 2005 23:12:22 -0700
Message-ID: <7vwtngg2bd.fsf@assigned-by-dhcp.cox.net>
References: <20050723073707.GA3255@mythryan2.michonline.com>
	<20050723192335.GA24071@mythryan2.michonline.com>
	<20050723192632.GB24071@mythryan2.michonline.com>
	<200507240728.40158.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 08:13:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwZje-0003S3-Ev
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 08:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVGXGMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 02:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVGXGMm
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 02:12:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28556 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261919AbVGXGM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2005 02:12:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724061221.NMBZ17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 24 Jul 2005 02:12:21 -0400
To: Alexey Nezhdanov <snake@penza-gsm.ru>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alexey Nezhdanov <snake@penza-gsm.ru> writes:

> Satturday, 23 July 2005 23:26 Ryan Anderson wrote:
>> -Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
>> +Depends: ${misc:Depends}, patch, diff, rsync, rcs, ssh
> Did I missed something or you forgot about libcurl3 dependency?

I think you are right.  In the build process, dh_shlibdeps is
used and shlib:Depends is created to include the libcurl3 (among
other things) in debian/git-core.substvars, but it is not
actually used in the resulting binary package because the line
misses ${shlibs:Depends} there.

Ryan, would this change be enough?  I do not know what I am
doing (${misc:Depends} is new to me), but this patch seems to
fix it on my box.

------------
Make sure binary debian package depends on shlibs it uses.

The "Depends:" line in debian/control lacked ${shlibs:Depends},
which caused the resulting binary package not to depend on
libcurl3 nor even libc6 ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

# - linus: Fix up applymbox script for the addition of "git-" prefix
# + (working tree)
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -7,7 +7,7 @@ Standards-Version: 3.6.1
 
 Package: git-core
 Architecture: any
-Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
+Depends: ${shlibs:Depends} ${misc:Depends}, shellutils, diff, rsync, rcs
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
  and flexible filesystem-based database designed to store directory trees
