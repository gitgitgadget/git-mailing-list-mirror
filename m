From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 30 Apr 2005 19:22:57 -0700
Message-ID: <7vis231y7y.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 04:17:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS41J-000411-II
	for gcvg-git@gmane.org; Sun, 01 May 2005 04:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVEACXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 22:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVEACXF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 22:23:05 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57340 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261450AbVEACW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 22:22:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501022256.ESMI7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Apr 2005 22:22:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 30 Apr 2005 18:09:53 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Talking about the diffs, I'm beginning to hate those "mode" things.

Likewise.

LT> Not only do they screw up diffstat (big deal), but they are pointless, 
LT> since 99.9% of the time the mode stays the same.

Pointless, yes.  mode is not what screwing up diffstat but
comparing against /dev/null is, so it is not a reason to hate
mode, and my fingers learned to say diffstat -p1 already so it
is not a big deal anymore.

LT> Normal "patch" will just ignore the extra lines before the
LT> diff anyway, so it won't matter there.

LT> Comments?

I am 100% in agreement with you here.  The only reason I added
it was to match what Pasky does so that his cg-patch can eat its
output.  To me, pleasing cg-patch is far lower priority than
pleasing l-k developers, so your veto counts.

My JIT tools do not use that mode thing in the patch.  I apply a
patch between two commits (or trees) to the work tree by doing
something like this:

    GIT_EXTERNAL_DIFF=jit-diff-extract \
    jit-diff "$@" | {
        cd "${GIT_PROJECT_TOP}"
        sh
    }

Here jit-diff-extract is the gem that creates a small shell
script that patches the file and runs "chmod +x" or "chmod -x"
when necessary, and does git-update-cache for added or removed
files.  Its output would look something like this:

    patch -p1 <<\EOF
    --- /dev/null
    +++ fs/ext9/Makefile
    @@ ....
    EOF
    chmod -x 'fs/ext9/Makefile'
    git-update-cache --add --remove -- 'fs/ext9/Makefile'

Maybe I can make the default diff output just like the above?
As you say, normal patch would not look at those shell script
part at all anyway.

