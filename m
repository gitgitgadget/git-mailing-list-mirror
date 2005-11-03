From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now What?
Date: Thu, 03 Nov 2005 02:00:05 -0800
Message-ID: <7v4q6uhx0a.fsf@assigned-by-dhcp.cox.net>
References: <E1EXTw5-00063o-Gt@jdl.com>
	<20051103083840.GA28300@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 11:01:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXbuB-000569-HO
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 11:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVKCKAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 05:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVKCKAJ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 05:00:09 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20171 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932463AbVKCKAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 05:00:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103095919.LKKS11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 04:59:19 -0500
To: "Peter Eriksen" <s022018@student.dtu.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11072>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

> Here's one I've done too many times:
>
> ~/git/git-core]cat .git/remotes/origin
> URL: git://git.kernel.org/pub/scm/git/git.git
> Pull: master:origin
>
> ~/git/git-core]git-checkout maint
> ~/git/git-core]git pull

You are merging my master into your "maint", probably a copy of
my (previous) maint.

What now?  Depends on what you wanted to do.  If what you wanted
to do was to merge my "master" to your "maint", then you would
resolve the conflicts by hand, but probably that was not what
you wanted to do.

After that pull, your repository is in this state:

. the index file and working tree is somewhere between your
  "maint" and my "master".  "somewhere between" is because the
  merge obviously failed.

. the "maint" head has not moved.  Your .git/HEAD points at the
  "maint" branch.

. the "origin" head points at my latest "master" head.

If you keep a copy of my "master" plus zero or more of your own
development in your "master" branch, and what you wanted to do
was to build my "master" plus those developments of your own,
then:

	$ git checkout -f master
        $ git pull . origin

If your "master" is just a vanilla copy of my "master", then
this pull would result in a fast forward, and "master" and
"origin" will point at the same commit after this pull
operation.  Otherwise, you would merge your changes and my
"master" updates into your "master" branch.

If what you wanted to do was to build my "master" vanilla, then:

	$ git checkout -f origin

because your remotes/origin says "origin" is meant to be a
straight copy of my "master".

A good habit to get into is, before pulling, make sure:

. your index matches your HEAD.

. the local modification (i.e. what git-diff-files would report)
  is something you do not mind losing.

. you are on the right branch you want to pull into (check with
  "git branch").
