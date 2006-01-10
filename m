From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 11:47:22 -0800
Message-ID: <7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	<1136849810.11717.518.camel@brick.watson.ibm.com>
	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	<1136900174.11717.537.camel@brick.watson.ibm.com>
	<43C3CC4A.4030805@op5.se>
	<1136910406.11717.579.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 20:47:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwPSp-0008Fa-V5
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 20:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWAJTrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 14:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWAJTrZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 14:47:25 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:18936 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbWAJTrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 14:47:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110194533.EFVO17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 14:45:33 -0500
To: Michal Ostrowski <mostrows@watson.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14442>

Michal Ostrowski <mostrows@watson.ibm.com> writes:

> One could make all the scripts depend on GIT_EXEC_PATH instead of PATH.
> At build time one could generate wrapper functions in git-sh-setup:
>
> function git-foo () {
> 	$(GIT_EXEC_PATH)/git-foo $*;
> }
>
> Presuming that all scripts include git-sh-setup, no other shell script
> changes would be needed.

Is "git-foo" a valid name to define shell function as?

> My shell's rc-file doesn't get invoked when using ssh as a transport;
> that's part of the problem.

Not any rc, or are you bitten by bash/ssh misfeature that
noninteractive sessions do not start with .bash_profile?

>> > Once you have that implemented, we can have a separate discussion of how
>> > the executable is to be found; 
>> >  - should we use PATH?
>> >  - should we change PATH?
>> >  - should we always exec using an absolute file name? (my preference)

The goal here is to make sure we exec the program from the same
release (unless user overrides it with GIT_EXEC_PATH to say "I
want to try 0.99.9k, not the latest one"), but how?  The last
one feels the most correct way if done right.

> git programs exec other git programs, but they also exec non-git
> programs.  I think it is not appropriate to change PATH (via
> prepend_to_path) because this may result in unexpected behavior when
> exec'ing non-git programs:

This is a valid concern.
