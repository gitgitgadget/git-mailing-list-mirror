From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix handling of not_for_merge '.' flag in refspec.
Date: Thu, 29 Sep 2005 17:47:39 -0700
Message-ID: <7vk6gzcrf8.fsf@assigned-by-dhcp.cox.net>
References: <11280379894186-git-send-email-tom.prince@ualberta.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 02:48:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL93z-00033v-G3
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 02:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVI3Arm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 20:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVI3Arm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 20:47:42 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64453 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932454AbVI3Arl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 20:47:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930004737.UTX19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 20:47:37 -0400
To: Tom Prince <tom.prince@ualberta.net>
In-Reply-To: <11280379894186-git-send-email-tom.prince@ualberta.net> (Tom
	Prince's message of "Thu, 29 Sep 2005 17:53:09 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9530>

Tom Prince <tom.prince@ualberta.net> writes:

> canon_refs_list_for_fetch did not know about '.', so it mangled any
> reference with it. Further, it added '.' to any refspec on the command
> line other than the first.

The dot trick was supposed to be internal.  If you have the
following three lines in a remotes/xyzzy file:

	URL: http://xyzzy.xz/balances.git
        Pull: frotz nitfol
        Pull: rezrov

    $ git pull xyzzy

    - fetch frotz, nitfol, and rezrov; merge frotz into the
      current branch

    $ git pull xyzzy nitfol

    - fetch nitfol only; merge nitfol into the current branch.

    $ git pull xyzzy nitfol rezrov

    - fetch nitfol and rezrov; merge them into the current
      branch (an Octopus).

The '.' is in no way part of the <refspec> format.  It may not
be a bad idea to explicitly forbid it, but currently we don't.
