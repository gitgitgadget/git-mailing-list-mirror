From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: Fri, 24 Feb 2006 03:38:17 -0800
Message-ID: <7vvev5aswm.fsf@assigned-by-dhcp.cox.net>
References: <43F20532.5000609@iaglans.de>
	<Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
	<87k6bxvmj6.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
	<87fymlvgzv.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0602141224110.3691@g5.osdl.org>
	<87d5hpvc8p.wl%cworth@cworth.org>
	<7vu0b1pntl.fsf@assigned-by-dhcp.cox.net>
	<87zmkhrf4y.wl%cworth@cworth.org> <43FED93D.1000601@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 12:38:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCbHJ-0002DV-2y
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 12:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWBXLiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 06:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWBXLiV
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 06:38:21 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49884 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932168AbWBXLiV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 06:38:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224113442.WOAV20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 06:34:42 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43FED93D.1000601@op5.se> (Andreas Ericsson's message of "Fri, 24
	Feb 2006 11:00:29 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16695>

Andreas Ericsson <ae@op5.se> writes:

> I've said it before, and I'll say it again. This tool provides less
> flexibility and much less power than "git checkout -b branch
> <commit-ish>" (although it would be nice to have '-o' for 'overwrite
> existing branch' as an argument to git checkout)

True, but assembly provides more flexibility than higher level
languages and you need to strike a balance between power and
usability.

The real question is if the structure the tool enforces to your
workflow is simply being a straight-jacket or helping an average
user to avoid common mistakes.

One occasion I've felt the need for "seek" like feature was when
starting to bisect.  You usually notice breakage, so you can
start with "git bisect bad HEAD", but then what next?  You
usually are not absolutely sure which one _was_ working the last
time.

If I had a seek, then I could go back to some randomly chosen
version to try it out, going back until I find a good one.

Maybe "git bisect try $committish" would be a good addition.  We
could live without it (we can just say "git reset --hard
$committish"), but it can be a bit more than just that.  If
given committish is known to be good or bad, we could remind the
user what she said the last time, and offer a chance to take it
back.  That is, (1) if the given $committish is an ancestor of
existing good one, list those good ones and ask "do you mean you
are not sure if they are good anymore, and retry the
bisection?"  If yes, delete those good-* refs; (2) if the given
$committish is a descendant of a bad one, show it and ask "do
you mean you are not sure if they are good anymore, and retry
the bisection?"  If yes, remove the existing bad ref.  In any
case, "reset --hard" to it after user responds.

Other than that, I haven't felt a need for seek-like feature;
instead, I make liberal use of throw-away branches.
