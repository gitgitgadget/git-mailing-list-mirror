From: Junio C Hamano <junkio@cox.net>
Subject: Re: http protocol, cloning git.git, fails (too many open files)
Date: Sat, 12 Nov 2005 15:21:45 -0800
Message-ID: <7vmzk9e9km.fsf@assigned-by-dhcp.cox.net>
References: <86acg9ijwa.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 00:21:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb4gw-0001Ej-TC
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 00:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVKLXVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 18:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVKLXVs
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 18:21:48 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64952 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964857AbVKLXVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 18:21:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051112232115.UZKM9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Nov 2005 18:21:15 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86acg9ijwa.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "12 Nov 2005 14:25:09 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11720>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>     $ mkdir foo
>     $ cd foo
>     $ cg-clone http://www.kernel.org/pub/scm/git/git.git git.new
>     Fetching head...
>     Fetching objects...
>     progress: 1 objects, 191 bytes
> progress: 2 objects, 519 bytes
> progress: 3 objects, 5851 bytes
> progress: 4 objects, 7671 bytes
>...
>
>     progress: 66 objects, 187452 bytes
>
> And at this point, it hung.  I had to ^C.

This sounds like the problem the patch Pasky posted last night
addresses.

However, one thing puzzles me.  I just tried to reproduce it by
doing this:

	$ rm -fr git-http
        $ ulimit -n 16
        $ git clone http://www.kernel.org/pub/scm/git/git.git git-http

and it did not fail on my Linux box.  This is from the tip of
the master tree (essentially the same as 0.99.9h aka 1.0rc1),
built without Pasky's patch.  Maybe the number of in-transit
requests in your case is much higher with your connection while
waiting for a packfile to arrive than my setup.

Could you please try with the patch Nick posted (which covers
less) and then with Pasky's patch?
