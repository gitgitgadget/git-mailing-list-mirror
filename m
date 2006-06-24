From: Junio C Hamano <junkio@cox.net>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sat, 24 Jun 2006 13:21:30 -0700
Message-ID: <7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jun 24 22:21:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuEdT-0005ja-TK
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 22:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWFXUVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 16:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWFXUVd
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 16:21:33 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:947 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751085AbWFXUVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 16:21:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624202131.TZGA11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 16:21:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 24 Jun 2006 11:55:46 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22544>

Linus Torvalds <torvalds@osdl.org> writes:

> Also, "pu" in general is totally unusable. It doesn't even compile.

Care to share problems with Pasky and I to take a look at,
please?

> I think that "Git.xs" thing is fine for random hacks, but please please 
> PLEASE don't make any central program depend on it.

I agree.  I got really disgusted when I tentatively pulled the
current Git.xs into "next" and installed it for my own use to
notice that it broke git-fmt-merge-msg hence git-pull workflow.

Pasky, can we first iron out kinks in the build procedure and
installation before converting existing programs further?  The
things I worry about currently are:

 - the SITELIBARCH gotcha I sent you a message about (and you
   responded to it already -- was that an Acked-by?);

 - RPM target -- we probably acquired a new build-dependency in
   which case the .spec file needs to be updated;

 - Make sure Git.xs builds and installed result works fine on
   all platforms we care about, including Cygwin and other
   non-Linux boxes.

I'd even suggest we revert the changes to git-fmt-merge-msg to
keep it working for now, until the above worries are resolved.
Otherwise we cannot have it in "next" safely (and I REALLY _do_
want to have Git.pm infrastructure in "next" soonish).

We can start using Git.xs and friends in some _new_ ancillary
programs, once we solve building and installing problems for
everybody.  That way it would help us gain portability and
confidence without disrupting existing users.
