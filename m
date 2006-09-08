From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add git-archive [take #2]
Date: Fri, 08 Sep 2006 14:42:03 -0700
Message-ID: <7vzmdaf32s.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
	<44FED12E.7010409@innova-card.com>
	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>
	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>
	<44FFD00E.5040305@innova-card.com>
	<7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>
	<450019C3.4030001@innova-card.com>
	<7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net>
	<45012752.4070300@innova-card.com>
	<7v64fyivk0.fsf@assigned-by-dhcp.cox.net>
	<45013B5A.8000301@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 23:41:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLo6Y-0000AO-BQ
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 23:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWIHVlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 17:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWIHVlj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 17:41:39 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:237 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751180AbWIHVlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 17:41:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908214137.VXWY18458.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Sep 2006 17:41:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Kxhd1V00q1kojtg0000000
	Fri, 08 Sep 2006 17:41:38 -0400
To: Franck <vagabon.xyz@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26717>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

> Sorry I was speaking about the git protocol. It has been included
> in master branch.

I do not think so.  The recent "master" history is like this
(look at "gitk --full-history v1.4.2..master -- daemon.c"):

d819e4e daemon: prepare for multiple services

This introduced the daemon_service[] table and run_service
facility.  The service table contained upload-pack only.

This was merged into "master" and pushed out with 

1efca00 Merge early part of branch 'jc/daemon'

At this point, 'jc/daemon' topic branch contained the d819e4e
above and this one, which added upload-tar to the service table:

74c0cc2 daemon: add upload-tar service.

this was part of "next" but was not in "master".  This made
"tar-tree --remote" against git-daemon usable in "next".  But
before I pushed this out to "master", upload-archive design you
and Rene were working on became a lot more promising and
attractive.  Especially, discussion with Rene made me realize
that redoing upload-xxx protocol for each archiver was not a
good design.  So I did:

d9edcbd Revert "daemon: add upload-tar service."

on 'jc/daemon' branch.  And then that topic was merged into
"master" and pushed out, because that will allow you and Rene to
work your patch against "master" which would be nicer to not
just you but to everybody -- other people can test your patches
before they hit my tree on any branch.

In other words,

> 	git tar-tree --remote=git://anything/repo.git

never worked in "master".  At least that is how I wanted the
commit ancestry graph to look like and why the above merges and
reverts were done in the order described above.

Once git archive hits "master", we should announce that "git
tar-tree" and "git zip-tree" are deprecated, and we will remove
them sometime later.  As part of the same announcement we could
say that "git tar-tree --remote" works with transports other
than git-daemon, but we do not plan to add git native transport
support to it before its removal, because "git archive" is
preferred method both on local and remote archiving from then
on.
