X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 23:32:18 -0800
Message-ID: <7v64dev88t.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0611161508530.3349@woody.osdl.org>
	<455CFCBD.8040901@xs4all.nl>
	<f2b55d220611161734m49136e6fneda5b002eb67618b@mail.gmail.com>
	<f2b55d220611162242s48dc42d6g4cbfd9173e712ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 07:32:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <f2b55d220611162242s48dc42d6g4cbfd9173e712ff8@mail.gmail.com>
	(Michael K. Edwards's message of "Thu, 16 Nov 2006 22:42:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31672>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkyD4-000433-AL for gcvg-git@gmane.org; Fri, 17 Nov
 2006 08:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755538AbWKQHcU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 02:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755539AbWKQHcU
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 02:32:20 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25266 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1755538AbWKQHcT
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 02:32:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117073219.XQEA9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 02:32:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id njYR1V00l1kojtg0000000; Fri, 17 Nov 2006
 02:32:26 -0500
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

"Michael K. Edwards" <medwards.linux@gmail.com> writes:

> Presumably "git branch -D" should inspect everything under
> .git/remotes to see whether one or more Pull: lines need to be
> deleted along with the branch.

I am not sure what you mean.  .git/remotes files do not describe
any relationship between local branches (and that is where one
of the problem raised in recent thread -- pull does not notice
on which branch you are on and change its behaviour depending on
it), so I do not think there is anything gained for "git branch
-D" by going through them.

> Currently, it looks like "remotes" entries are
> created only by "git clone" or by hand.  Junio, are there any plans to
> manage the contents of "remotes" through the tool instead of by hand?

I muttered something in a near-by thread

	Message-ID: <7vr6w78b4x.fsf@assigned-by-dhcp.cox.net>

I am reasonably sure a separate tool (what I tentatively called
"maint-remote" in the message) is necessary, because, while it
would be relatively easy to make "git fetch" and friends to add
new mappings in the default way under a new option, people with
different workflows would want differnt "default mappings", and
adding new mappings for _all_ remote branches is useful only for
people who work in one particular way (namely, the CVS-style
"the central distribution point is where everybody meet" model).

The tool, under "interactive" mode, would probably take one
parameter, the short name of a remote ($name), and would give
you a form to update its URL:, shows ls-remote output against
that repository and would let you:

 - update the URL: which would probably cause the ls-remote to
   be re-run;

 - remove existing mappings;

 - add mappings for a remote branch for which you do not have a
   corresponding tracking branch, with a straightforward default
   mapping:

   	refs/heads/$branch:refs/remotes/$name/$branch

But I haven't thought things through yet.

