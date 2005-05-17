From: Junio C Hamano <junio@siamese.dyndns.org>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Tue, 17 May 2005 14:18:18 -0700
Message-ID: <7v4qd1tuud.fsf@assigned-by-dhcp.cox.net>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net>
	<20050517190355.GA7136@pasky.ji.cz>
	<7vk6lxfybc.fsf@assigned-by-dhcp.cox.net>
	<20050517203500.GH7136@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue May 17 23:22:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9SA-0000a7-Ek
	for gcvg-git@gmane.org; Tue, 17 May 2005 23:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVEQVS3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 17:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVEQVS3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 17:18:29 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:35022 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261953AbVEQVSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 17:18:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517211818.BEFH23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 May 2005 17:18:18 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050517203500.GH7136@pasky.ji.cz> (Petr Baudis's message of
 "Tue, 17 May 2005 22:35:00 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Actually, my doubts about general usefulness of this wrapper are
PB> growing. Cogito is unlikely to ever make use of it since it has to
PB> figure out the .git location anyway for own use (it keeps plenty of own
PB> files there).

I think "having to figure out .git anyway" is backwards, if your
plan is to make Cogito take filesystem paths as opposed to GIT
paths.  If the plan for Cogito is to take always GIT paths,
which is a sensible way as well, then it is irrelevant for the
implementation of Cogito, but then it becomes useful for users
of Cogito).

If your plan is to make Cogito take filesystem paths, then you
can move bulk of the code currently in cg-blah, except the part
that picks up non-path parameters, to cg-Xblah, and reduce
cg-blah implementation down to just:

    ... parse options by shifting "$@" out.
    ... then
    git-run-with-user-path cg-Xblah $non-path-opts -- "$@"

and you can rip "the code to figure out .git" out from cg-Xblah.
There is nothing to figure out at that point; it always is
${GIT_DIR-.git}/.

