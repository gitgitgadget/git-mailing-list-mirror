From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm build: Fix quoting and missing GIT-CFLAGS dependency
Date: Sun, 25 Jun 2006 17:21:57 +0200
Message-ID: <20060625152157.GG21864@pasky.or.cz>
References: <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net> <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org> <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241338370.6483@g5.osdl.org> <7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net> <20060625010202.GX21864@pasky.or.cz> <20060625014009.GA21864@pasky.or.cz> <7vac82q6mb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 17:22:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuWR1-0007WV-7a
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 17:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWFYPWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWFYPWA
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 11:22:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38285 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751437AbWFYPV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 11:21:59 -0400
Received: (qmail 16138 invoked by uid 2001); 25 Jun 2006 17:21:57 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac82q6mb.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22631>

Dear diary, on Sun, Jun 25, 2006 at 05:03:24AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> During our a handful piecemeal patch exchange back-and-forth on
> the list, most of the patches did not apply mechanically, so I
> rolled them up and have pushed out the result in "pu" and it
> will mirror out shortly.  I am reasonably sure it is in much
> better shape than 24 hours ago; could you double check the
> result for me please?

It looks good; I don't like the makefile changes a lot but more on that
below.

Could you please also throw in these two?

[PATCH 3/7] Git.pm: Swap hash_object() parameters
[PATCH 4/7] Git.pm: Fix Git->repository("/somewhere/totally/elsewhere")

..snip..
>      - RPM target -- we probably acquired a new build-dependency in
>        which case the .spec file needs to be updated;
..snip..
> I think we have cleared SITELIBARCH, and Git.xs building is in
> testable state for wider audience.  The remaining hurdles are to
> make sure the RPM target is still sensible, and fix the test
> scheme.
> 
> Now, I am clueless about RPM, so help is very much appreciated.

Chris, could you help, please? Do we need to insert anything special
to builddeps if we build own Perl module?

> About the testsuite, I think with the way git-fmt-merge-msg (and
> other Perl scripts that will use Git.pm) is munged on the
> initial line "#!/usr/bin/perl -I$(installedpath)", the test
> scheme is seriously broken.  To see how yourself, have a good
> working version of Git.pm and friends in the path your
> git-fmt-merge-msg's first line points at, apply the following
> patch to perl/Git.pm in your source tree and run "make test".
> It will pass t5700-clone-reference.sh test, which does "git
> pull" (and uses git-fmt-merge-msg) without problems X-<.

Yes, -I is very broken. I have abandoned it in:

	Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
	Date:   Sat, 24 Jun 2006 13:52:27 +0200

The advantage to your approach is that it works properly without
requiring to make install even outside of the testsuite.

> The additional dependency to perl/Makefile is needed regardless
> of this tentative fix -- you cannot run make -C perl before
> building perl/Makefile.

Yes, that bit shall be Acked-by: Petr Baudis <pasky@suse.cz>

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
