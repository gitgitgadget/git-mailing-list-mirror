From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix race and deadlock when sending pack
Date: Sun, 18 Dec 2005 21:36:25 -0800
Message-ID: <7vzmmxlkbq.fsf@assigned-by-dhcp.cox.net>
References: <43A628F6.1060807@serice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 06:37:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoDhG-0001fF-49
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 06:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVLSFg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 00:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbVLSFg1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 00:36:27 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59313 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030276AbVLSFg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 00:36:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051219053458.CKAN17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 00:34:58 -0500
To: Paul Serice <paul@serice.net>
In-Reply-To: <43A628F6.1060807@serice.net> (Paul Serice's message of "Sun, 18
	Dec 2005 21:28:54 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13814>

Paul Serice <paul@serice.net> writes:

> The best way to reproduce the problem is to locally clone your
> repository.  When you perform a push, git-send-pack will directly set
> up pipes connected to stdin and stdout of git-receive-pack.  You
> should then set up hook/post-update or hook/update to try to write
> lots of text to stdout.  (You want to use the local protocol because
> ssh is robust enough to mask the worst behavior.)

My immediate reaction was "do not do it then", but you are
right.  Hooks are run after all the protocol exchanges are done,
so they should be free to throw any garbage at the other end.

It appears cpfd() seems to mostly duplicate what is in copy.c;
is there any particular reason?
