From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 10:24:15 -0800
Message-ID: <7vwtgwdqk0.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	<cda58cb80601170932o6f955469y@mail.gmail.com>
	<7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80601190251v5251c8bdh@mail.gmail.com>
	<20060119130940.GC28365@pasky.or.cz>
	<Pine.LNX.4.64.0601190842270.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Franck <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 19:28:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzeSW-0001bx-7v
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 19:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWASSYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 13:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWASSYW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 13:24:22 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:12493 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030264AbWASSYU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 13:24:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119182257.FERE20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 13:22:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14920>

Linus Torvalds <torvalds@osdl.org> writes:

>  - a full clone takes a long time. Git _could_ fairly easily have an 
>    extension to add a date specifier to clone too:
>
> 	git clone --since=1.month.ago <source> <dst>
>
>    and just leave any older stuff (you could always fetch it later), but 
>    we've just never done it. Maybe we should. It _should_ be pretty simple 
>    to do from a conceptual standpoint.

True, except some implementation details you forgot to mention
in your other message that you talked about upload-version.
Both commit walkers and git native transfer fundamentally
operate by trusting that our current refs are complete, which
makes "could always fetch it later" part a bit involved.

It fortunately would not be a rocket science.  We would need to
have a mode "do not trust our current refs are complete" with an
explicit command line option, or automatically fall back to that
mode when seeing the $GIT_DIR/info/grafts file has changed, and
revalidate the commit ancestry chain we have in a repository
cloned that way.
