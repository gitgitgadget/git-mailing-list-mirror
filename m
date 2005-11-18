From: Junio C Hamano <junkio@cox.net>
Subject: Re: master has some toys
Date: Fri, 18 Nov 2005 12:09:27 -0800
Message-ID: <7vu0e9hg5k.fsf@assigned-by-dhcp.cox.net>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	<b0943d9e0511160311k725526d8v@mail.gmail.com>
	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	<Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vsltvwmlr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511171249550.737@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vveyrt6ms.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 18 21:09:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdCY9-00046m-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVKRUJa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVKRUJa
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:09:30 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35505 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932428AbVKRUJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 15:09:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118200902.XQBP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 15:09:02 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12253>

Junio C Hamano <junkio@cox.net> writes:

I just had a small excitement finding out I did something right
and felt an urge to brag ;-).

> I am not so sure about forcing people upgrade, but we may end up
> deciding it is better not to have NO_MMAP as the default.  If
> that turns out to be the case, I'd prefer to have something like
> this instead:
>
> diff --git a/Makefile b/Makefile
> index 7ce62e8..215abf0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -213,6 +213,10 @@ endif
>  ifeq ($(uname_O),Cygwin)
>  	NO_STRCASESTR = YesPlease
>  	NEEDS_LIBICONV = YesPlease
> +	# There are conflicting reports about this.
> +	# On some boxes NO_MMAP is needed, and not so elsewhere.
> +	# Try uncommenting this if you see things break -- YMMV.
> +	# NO_MMAP = YesPlease
>  	NO_IPV6 = YesPlease
>  	X = .exe
>  endif

I did the above patch on top of "pu", which contained the patch
from Pavel Roskin and sent it out.  Later I saved the message
from my mbox, went back to the "master" branch, whose Makefile
had the releveant part like this:

        ifeq ($(uname_O),Cygwin)
                NO_STRCASESTR = YesPlease
                NEEDS_LIBICONV = YesPlease
                NO_IPV6 = YesPlease
                X = .exe
                ALL_CFLAGS += -DUSE_SYMLINK_HEAD=0
        endif

Notice ALL_CFLAGS line?  The patch does not apply cleanly and
usual e-mail patch application tool would have barfed; git-apply
would not allow any fuzz, and patch would have dropped a .rej
file.

However, I usually run "git-am" with --3way option enabled when
applying the e-mailed patches.  After git-apply failed, it
noticed I am applying on top of a different blob, namely, the
Makefile from somewhere else (it reads the "index 7ce62e8"),
then fell back on 3-way merge and made a clean commit.  Happy.

Back to day-job.
