From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Automerge fix
Date: Mon, 18 Apr 2005 22:26:24 -0700
Message-ID: <7voecbqqv3.fsf@assigned-by-dhcp.cox.net>
References: <20050419010242.GS5554@pasky.ji.cz>
	<Pine.LNX.4.58.0504181945400.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 07:22:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNlBv-0004sb-9Q
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 07:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVDSF0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 01:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVDSF0d
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 01:26:33 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42652 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261322AbVDSF0c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 01:26:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050419052626.QWFC13104.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 19 Apr 2005 01:26:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504181945400.15725@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 18 Apr 2005 19:48:09 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> What's the right way?

LT> Maybe

LT> 	if merge "$src2" "$orig" "$src1"
LT> 	then 
LT> 		cp "$src2" "$4" && update-cache --add -- "$4" && exit 0
LT> 	fi
LT> 	echo Leaving conflict merge in $src2
LT> 	exit 1

LT> would work?

Wouldn't this be more readable, short and sweet?

    merge "$src2" "$orig" "$src1" || {
        echo Leaving conflict merge in $src2 && exit 1
    }
    cp "$src2" "$4" && exec update-cache --add -- "$4"

You did not want subshell so I just changed the () pair to the
{} pair, and while I was at it I folded the "&& exit 0" into the
last command before it, which should be better.  You'd want to
know if update-cache --add failed for whatever reason.

