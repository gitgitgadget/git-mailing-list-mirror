From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing vs. alternates
Date: Tue, 24 Oct 2006 10:12:17 -0700
Message-ID: <7vzmblhc3y.fsf@assigned-by-dhcp.cox.net>
References: <20061024035335.GW20017@pasky.or.cz>
	<7vmz7muvqu.fsf@assigned-by-dhcp.cox.net>
	<20061024112028.GY20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 19:12:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcPp9-0005D5-Cd
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 19:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWJXRMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 13:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWJXRMT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 13:12:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:14540 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965159AbWJXRMS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 13:12:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024171218.LTFM22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Oct 2006 13:12:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id eHC11V00Y1kojtg0000000
	Tue, 24 Oct 2006 13:12:02 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061024112028.GY20017@pasky.or.cz> (Petr Baudis's message of
	"Tue, 24 Oct 2006 13:20:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29990>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Tue, Oct 24, 2006 at 07:29:45AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> Petr Baudis <pasky@ucw.cz> writes:
>> 
>> >   I don't have time to code that myself right now, so I'm just tossing
>> > an idea around - pushing to a directory with alternates set up should
>> > avoid sending objects that are already in the alternate object database.
>> 
>> That is probably only relevant for the first time, since
>> subsequent pushes have refs from its own repository that tracks
>> the tips of branches that was pushed for the last time.
>
> Well, I would send haves for the alternate repository anyway,...

While I agree it would be an optimization if it worked, there is
one conceptual problem here though, coming from old warts.  It's
not alternate "repository" but it is alternate object store.
There is no guarantee that refs/ directory that is next to the
objects/ alternate points at is related to that object store,
for historical reasons (i.e. we have separate GIT_DIR and
GIT_OBJECT_DIRECTORIES).  So unless we declare that objects that
are reachable from the refs/ *must* be fully connected in
objects/ when objects/ has refs/ next to it, sending HAVEs from
that refs/ can break the push, since that refs/ you are looking
at may not be related to the alternate objects/ at all.  I do
not think it is a big restriction at all, but it is a new
restriction you are adding to the repository layout.

> ... You can only push if your login access is reduced to
> git-shell, and something external could've set up your alternates.

Ok, I was not thinking about "something external".
