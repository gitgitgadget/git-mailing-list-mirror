From: Junio C Hamano <junkio@cox.net>
Subject: Re: shared GIT repos
Date: Tue, 27 Sep 2005 00:13:43 -0700
Message-ID: <7vu0g70yqg.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050925163201.GA29198@tumblerings.org>
	<4d4586301dca616f42880612fae01492@cream.org>
	<20050926133204.GB21019@pasky.or.cz>
	<pan.2005.09.27.06.35.35.834134@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 09:15:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK9eu-0007GY-Em
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 09:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVI0HNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 03:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbVI0HNq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 03:13:46 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62098 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964844AbVI0HNp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 03:13:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927071344.TIGY16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 03:13:44 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.09.27.06.35.35.834134@smurf.noris.de> (Matthias
	Urlichs's message of "Tue, 27 Sep 2005 08:35:37 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9376>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> Speaking of which -- is anybody working on that one?
>
> I find myself in need of a multiuser shared repository that cannot
> be corrupted (i.e. I want to prevent the users from removing objects,
> and replacing a ref with something that is not a child of the sha1 that's
> already there should also be prevented).

Do you want to guard the repository from malicious users?  Or is
it enough to guard a casual/careless user from making mistakes?

If one has commit privileges, then one can already do enough
harm to the project without being able to remove objects nor
updating a ref with non-fast-forward ref.  So let's assume for
now that malicious users are not something we worry about.  In
that case, "working on" might be too scary a word.  I think most
of the pieces are already there and you only need to assemble
them and write a howto ;-).

 - Place the users that has write access to the repository in
   the same Unix group, and have the repository owned by that
   group;

 - Give the users ssh access, perhaps with authorized_keys set
   up to only allow running git-receive-pack and nothing else
   (like normal shell access);

 - Set up hooks/update to make sure the ref updates are fast
   forward.  Additionally, you could set up a mapping that says
   which user can/cannot update which refs if you wanted to.

-jc
