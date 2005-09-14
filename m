From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 11:51:48 -0700
Message-ID: <7v3bo7jxdn.fsf@assigned-by-dhcp.cox.net>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 20:52:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFcML-0007Ms-P8
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 20:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVINSvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVINSvv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 14:51:51 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6554 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932090AbVINSvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 14:51:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914185148.JNNE7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 14:51:48 -0400
To: wsc9tt@gmail.com
In-Reply-To: <59a6e583050914094777c4fe96@mail.gmail.com> (Wayne Scott's
	message of "Wed, 14 Sep 2005 11:47:56 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8553>

Wayne Scott <wsc9tt@gmail.com> writes:

> Look at the diffs between ad6571a78ac74e9fa27e581834709067dba459af and
> it's parent with and without rename detection enabled.  (In linux-2.6
> git tree)

> $ git-diff-tree -r  -M $REV^1 $REV | grep termios.h
> :000000 100644 0000000000000000000000000000000000000000
>    237533bb0e9f1a3e640c4906d8b350deafd315b9 A      include/asm-powerpc/termios.h
> :100644 000000 97c6287a6cbaa5903ee1a5934a5553e9e485d8e7
>    0000000000000000000000000000000000000000 D      include/asm-ppc/termios.h
>
> Notice how the the fact that include/asm-ppc64/termios.h is deleted gets lost?
> Looks broken to me.

It looks broken to me, too.  I rebuilt from a reasonably ancient
source (v0.99) and re-run the test but I could not get it to
produce 'A' for include/asm-powerpc/termios.h.  So I rewound it
further to 4d235c8044a638108b67e22f94b2876657130fc8 commit,
which is really ancient version, but it still says it is renamed
from asm-ppc64 directory.  FWIW, all the v0.99* tagged versions
seem to detect that rename correctly and not lose anything in my
tests.

Which version of git do you run and on what platform?  It might
be that something in the diffcore chain is broken in non-i386
and/or non-GNU/Linux and/or non-GCC environment.

Shoot, I thought it would be a good practice-case for me to use
'git bisect' in reverse to find the commit that fixed a bug ;-).
My copy of linux-2.6 repository for testing is fully packed so I
could not try the commit that introduced diffcore-rename.c, but
that is what I really wanted to try.
