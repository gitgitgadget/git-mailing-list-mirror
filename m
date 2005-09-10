From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-ancestor read-tree notes
Date: Sat, 10 Sep 2005 15:56:32 -0700
Message-ID: <7vacik7crj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
	<7virxeycod.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509061228090.23242@iabervon.org>
	<7virx87d2b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 00:57:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEEGz-00086c-Qp
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 00:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVIJW4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 18:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVIJW4f
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 18:56:35 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56778 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932319AbVIJW4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2005 18:56:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050910225634.EHGN18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Sep 2005 18:56:34 -0400
To: Russell King <rmk+kernel@arm.linux.org.uk>
In-Reply-To: <7virx87d2b.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 10 Sep 2005 15:50:04 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8266>

While I was doing merge experiments, I found two commits whose
parents are actually fast forwards.  This does not mean you made
mistakes when you made these commits, but it suggests that the
tool that made these commits may have screwed up.  Do you use
'git commit' to make your commits, or do you use something else?


commit b129a8ccd53f74c43e4c83c8e0031a4990040830
Merge: 6b39374a27eb4be7e9d82145ae270ba02ea90dc8 194d0710e1a7fe92dcf860ddd31fded8c3103b7a
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Wed Aug 31 10:12:14 2005 +0100

    [SERIAL] Clean up and fix tty transmission start/stoping
    
    The start_tx and stop_tx methods were passed a flag to indicate
    whether the start/stop was from the tty start/stop callbacks, and
    some drivers used this flag to decide whether to ask the UART to
    immediately stop transmission (where the UART supports such a
    feature.)
    
    There are other cases when we wish this to occur - when CTS is
    lowered, or if we change from soft to hard flow control and CTS
    is inactive.  In these cases, this flag was false, and we would
    allow the transmitter to drain before stopping.
    
    There is really only one case where we want to let the transmitter
    drain before disabling, and that's when we run out of characters
    to send.
    
    Hence, re-jig the start_tx and stop_tx methods to eliminate this
    flag, and introduce new functions for the special "disable and
    allow transmitter to drain" case.
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

commit 603fff54420a0ccc4c3b48bfef43896fb4e33161
Merge: 99f95e5286df2f69edab8a04c7080d986ee4233b 8b22c249e7de453961e4d253b19fc2a0bdd65d53
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Tue Jun 28 13:40:39 2005 +0100

    [PATCH] ARM SMP: TLB implementations only affect local CPU
    
    The existing TLB flush implementations only have an effect on
    the local CPU.  Prefix them with local_.
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
